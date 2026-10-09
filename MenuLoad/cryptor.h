#ifndef AY_CRYPT_DEFAULT_KEY
	#define AY_CRYPT_DEFAULT_KEY 0x766f31646c656363ull
#endif

#define CRYPT(a) std::string(AY_CRYPT_KEY(a, 0x766f69646c6963CC))
#define CHARCRYPT(a) std::string(AY_CRYPT_KEY(a, 0x766f69646c6963CC)).c_str()
#define INTCRYPT(a) atoi(CHARCRYPT(a))
#define FLOATCRYPT(a) atof(CHARCRYPT(a))
#define NSCRYPT(a) [NSString stringWithUTF8String:CHARCRYPT(a)]
#define OFFSETCRYPT(a) strtoull(CHARCRYPT(a), NULL, 0)
namespace crypter {
	using size_type = unsigned long long;
	using key_type = unsigned long long;
	constexpr void cipher(char* data, size_type size, key_type key) {
		for (size_type i = 0; i < size; i++)
		{
			data[i] ^= char(key >> ((i % 8) * 8));
		}
	}
	template <size_type N, key_type KEY>
	class crypter {
	public:
	    constexpr crypter(const char* data) {
			for (size_type i = 0; i < N; i++) {
				m_data[i] = data[i];
			}

			cipher(m_data, N, KEY);
		}
		constexpr const char* data() const {
			return &m_data[0];
		}
		constexpr size_type size() const {
			return N;
		}
		constexpr key_type key() const {
			return KEY;
		}
	private:
		char m_data[N]{};
	};
	template <size_type N, key_type KEY>
	class crypted_data {
	public:
		crypted_data(const crypter<N, KEY>& crypter) {
			for (size_type i = 0; i < N; i++) {
				m_data[i] = crypter.data()[i];
			}
		}
		~crypted_data() {
			for (size_type i = 0; i < N; i++) {
				m_data[i] = 0;
			}
		}
		operator char*() {
			decrypt();
			return m_data;
		}
		void decrypt() {
			if (m_encrypted) {
				cipher(m_data, N, KEY);
				m_encrypted = false;
			}
		}
		void encrypt() {
			if (!m_encrypted) {
				cipher(m_data, N, KEY);
				m_encrypted = true;
			}
		}
		bool is_encrypted() const {
			return m_encrypted;
		}

	private:
		char m_data[N];
		bool m_encrypted{ true };
	};
	template <size_type N, key_type KEY = AY_CRYPT_DEFAULT_KEY>
	constexpr auto make_cryptor(const char(&data)[N])
	{
		return crypter<N, KEY>(data);
	}
}


#define AY_CRYPT(data) AY_CRYPT_KEY(data, AY_CRYPT_DEFAULT_KEY)
#define AY_CRYPT_KEY(data, key) \
	[]() -> crypter::crypted_data<sizeof(data)/sizeof(data[0]), key>& { \
		static_assert(sizeof(decltype(key)) == sizeof(crypter::key_type), "FUCKFUCK"); \
		static_assert((key) >= (1ull << 56), "FUCKFUCK"); \
		constexpr auto n = sizeof(data)/sizeof(data[0]); \
		constexpr auto cryptor = crypter::make_cryptor<n, key>(data); \
		static auto crypted_data = crypter::crypted_data<n, key>(cryptor); \
		return crypted_data; \
	}()