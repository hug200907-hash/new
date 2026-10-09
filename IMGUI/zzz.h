
#import "IMGUI/stb_image.h"
#import "imgdo.h"
id<MTLTexture> ghm_texture; // Giáp hộ mệnh / Giáp hồi sinh
    id<MTLTexture> bs_texture;  // Băng sương
    id<MTLTexture> ldm_texture; // Liềm đoạt mệnh
    id<MTLTexture> nt_texture;  // Nham thuẫn
    id<MTLTexture> gt_texture;  // Găng tay (Hercules)
    id<MTLTexture> ctm_texture; // Cung tà ma
    id<MTLTexture> xnc_texture; // Xạ nhật cung
    id<MTLTexture> tkk_texture; // Thương khung kiếm

std::vector<unsigned char> Base64Decode(const std::string &in) {
    std::string base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::vector<unsigned char> out;
    std::vector<int> T(256, -1);
    for (int i = 0; i < 64; i++) T[base64_chars[i]] = i;

    int val = 0, valb = -8;
    for (unsigned char c : in) {
        if (T[c] == -1) break;
        val = (val << 6) + T[c];
        valb += 6;
        if (valb >= 0) {
            out.push_back(char((val >> valb) & 0xFF));
            valb -= 8;
        }
    }
    return out;
}
    

id<MTLTexture> LoadTextureFromBase64(id<MTLDevice> device, const std::string& base64_data) {
    std::vector<unsigned char> decoded_data = Base64Decode(base64_data);
    int width, height, channels;
    unsigned char* data = stbi_load_from_memory(decoded_data.data(), decoded_data.size(), &width, &height, &channels, 4);
    if (data == NULL) {
        NSLog(@"Failed to load image from base64 data");
        return nil;
    }

    MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
    textureDescriptor.pixelFormat = MTLPixelFormatRGBA8Unorm;
    textureDescriptor.width = width;
    textureDescriptor.height = height;
    textureDescriptor.usage = MTLTextureUsageShaderRead;

    id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
    MTLRegion region = {
        {0, 0, 0}, 
        {static_cast<NSUInteger>(width), static_cast<NSUInteger>(height), 1} 
    };
    [texture replaceRegion:region mipmapLevel:0 withBytes:data bytesPerRow:width * 4];

    stbi_image_free(data);
    return texture;
}


void Render(id<MTLDevice> device) {
    static id<MTLTexture> bg_texture = nil;
    if (bg_texture == nil) {
        NSString *base64String = ldm;
        std::string base64_std_string([base64String UTF8String]);
        bg_texture = LoadTextureFromBase64(device, base64_std_string);
    }


    ImGui::NewFrame();
    ImGui::Render();
    ImGui_ImplMetal_RenderDrawData(ImGui::GetDrawData(), NULL, NULL);
}

id<MTLTexture> unskin_texture = nil;

id<MTLTexture> unskin_texture_overlay = nil;

void imgture(id<MTLDevice> device) {


        if (ldm_texture == nil) {
    NSString *base64String = ldm;
    std::string s([base64String UTF8String]);
    ldm_texture = LoadTextureFromBase64(device, s);
    }

        if (tkk_texture == nil) {
    NSString *base64String = tkk;
    std::string s([base64String UTF8String]);
    tkk_texture = LoadTextureFromBase64(device, s);
    }

        if (xnc_texture == nil) {
    NSString *base64String = xnc;
    std::string s([base64String UTF8String]);
    xnc_texture = LoadTextureFromBase64(device, s);
    }

        if (ctm_texture == nil) {
    NSString *base64String = ctm;
    std::string s([base64String UTF8String]);
    ctm_texture = LoadTextureFromBase64(device, s);
    }

        if (nt_texture == nil) {
    NSString *base64String = nt;
    std::string s([base64String UTF8String]);
    nt_texture = LoadTextureFromBase64(device, s);
    }

        if (gt_texture == nil) {
    NSString *base64String = gt;
    std::string s([base64String UTF8String]);
    gt_texture = LoadTextureFromBase64(device, s);
    }

        if (bs_texture == nil) {
    NSString *base64String = bs;
    std::string s([base64String UTF8String]);
    bs_texture = LoadTextureFromBase64(device, s);
    }

        if (ghm_texture == nil) {
    NSString *base64String = ghm;
    std::string s([base64String UTF8String]);
    ghm_texture = LoadTextureFromBase64(device, s);
    }

}