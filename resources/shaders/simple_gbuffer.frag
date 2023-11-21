#version 450
#extension GL_ARB_separate_shader_objects : enable
#extension GL_GOOGLE_include_directive : require

#include "common.h"

layout (location = 0 ) in VS_OUT
{
    vec3 wPos;
    vec3 wNorm;
    vec3 wTangent;
    vec2 texCoord;
} surf;

layout (location = 0) out vec4 outNormal;
layout (location = 1) out vec4 outAlbedo;

layout (binding = 0, set = 0) uniform AppData
{
    UniformParams Params;
};

void main()
{
    outNormal = vec4(surf.wNorm, 1.0f);
    outAlbedo = vec4(1.0f, 1.0f, 1.0f, gl_FragCoord.z);
}