#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;

uniform float n = 4;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(N.z);
    vtexCoord = texCoord;
    vec4 vecPrima = (modelViewMatrixInverse * lightPosition) - vec4(vertex,1.0);
    float d = sqrt(pow(vecPrima.x,2)+pow(vecPrima.y,2)+pow(vecPrima.z,2));
    float w = clamp(1/(pow(d,n)),0,1);
    vec4 vertexPrima= (1.0 - w) * vec4(vertex,1.0) + w * (modelViewMatrixInverse * lightPosition);
    gl_Position = modelViewProjectionMatrix * vertexPrima;
}
