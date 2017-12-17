// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//  一个最简单的顶点着色器
Shader "Study/Chapter 5/SimpleShader" {

    //  这里没有定义 Properties 语义块， 因为不是必需的
	SubShader {

        //  这里不进行任何渲染设置和标签设置，则SubShader会使用默认的渲染设置和标签设置

        Pass {
            CGPROGRAM
            //  声明顶点着色器的函数和片元着色器的函数
            #pragma vertex vert
            #pragma fragment frag

            //  使用一个结构体来定义顶点着色器的输入
            struct a2v {
                //  POSITION语义，用模型空间的顶点坐标填充 vertex 变量
                float4 vertex : POSITION;
                //  NORMAL语义，用模型空间的法线方向填充 normal 变量
                float3 normal : NORMAL;
                //  TEXCOORD0语义，用模型的第一套纹理坐标填充 texcoord 变量
                float4 texcoord : TEXCOORD0;
            };

            struct v2f {
                //  SV_POSITION语义，指明pos里包含了顶点在裁剪空间中的位置信息
                float4 pos : SV_POSITION;
                //  COLOR0语义，用于存储颜色信息
                fixed3 color : COLOR0;
            };


            v2f vert(a2v v) {
                //  声明输出结构
                v2f o;
                //  UNITY_MATRIX_MVP是Unity内置的模型观察投影矩阵，作用是将顶点坐标从模型空间转换到裁剪空间中
                o.pos = UnityObjectToClipPos(v.vertex);
                //  将顶点的法线方向的分量范围[-1.0, 1.0]映射到[0, 1.0]上
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            //  SV_Target也是HLSL的语义
            //  作用 : 告诉渲染器吧用户的输出颜色存储到一个渲染目标中， 这里是输出到默认的帧缓存中
            float4 frag(v2f i) : SV_Target {
                //  将插值后的 i.color 显示到屏幕上
                return fixed4(i.color, 1.0);
            }

            ENDCG

        }

    }
}
