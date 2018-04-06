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

    //VecPrima = Focus Llum (Object Space) - vertex (Object Space)
    vec4 vecPrima = (modelViewMatrixInverse * lightPosition) - vec4(vertex,1.0);

    float cX = vecPrima.x;
    float cY = vecPrima.y;
    float cZ = vecPrima.z;
    //d es la distancia, es a dir, el modul del vector vecPrima 
    float d = sqrt( pow(cX,2) + pow(cY,2) + pow(cZ,2) );
    //w = 
    float w = clamp(1/(pow(d,n)), 0, 1);

    vec4 vtxPrima= (1.0 - w) * vec4(vertex,1.0) + w * (modelViewMatrixInverse * lightPosition);

    gl_Position = modelViewProjectionMatrix * vtxPrima;
}
