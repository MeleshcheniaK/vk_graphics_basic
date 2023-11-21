#version 450
#extension GL_ARB_separate_shader_objects : enable
#extension GL_GOOGLE_include_directive : require

layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 64) out;

layout(push_constant) uniform params_t
{
    mat4 mProjView;
    mat4 mModel;
    float mTimer;
} params;

layout (location = 0 ) in VS_IN
{
    vec3 wPos;
    vec3 wNorm;
    vec3 wTangent;
    vec2 texCoord;

} vin[];

layout (location = 0 ) out VS_OUT
{
    vec3 wPos;
    vec3 wNorm;
    vec3 wTangent;
    vec2 texCoord;

} vout;

void processVertex(int i, vec3 shift) {
    vout.wPos = vin[i].wPos;
    vout.wNorm = vin[i].wNorm;
    vout.wTangent = vin[i].wTangent;
    vout.texCoord = vin[i].texCoord;

    gl_Position = params.mProjView * vec4(vin[i].wPos - shift, 1.2);

    EmitVertex();
}

void main()
{
    float timer = params.mTimer;
    vec3 normal_ray = normalize(cross(vin[1].wPos - vin[0].wPos, vin[2].wPos - vin[1].wPos));
    normal_ray /= length(normal_ray);
    normal_ray *= abs(sin(timer)) / 6.0;

    if (cos(params.mTimer / 2) > 0) {
        processVertex(1, normal_ray);
        processVertex(0, vec3(0, 0, 0));
    } else {
        processVertex(0, normal_ray);
        processVertex(1, vec3(0, 0, 0));
    }
    processVertex(2, vec3(0, 0, 0));

    EndPrimitive();
}

