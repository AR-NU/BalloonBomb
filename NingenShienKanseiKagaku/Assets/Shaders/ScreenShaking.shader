Shader "Custom/Camera/ShakeAuto" { 
    Properties {
        _MainTex ("Source", 2D) = "white" {}
        _X ("X",Float) = 0.01 //X座標の揺らしたい値
        _Y ("Y",Float) = 0.01 //Y座標の揺らしたい値
        _ShakeSpeed ("ShakeSpeed",Float) = 100 //揺らす速度の参照値
    }

    SubShader {

        ZTest Always
        Cull Off
        ZWrite Off
        Fog { Mode Off }

        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata_img v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, v.texcoord.xy);
                return o;
            }

            sampler2D _MainTex;
            float _X;
            float _Y;
            float _ShakeSpeed;

            fixed4 frag(v2f i) : SV_TARGET {

                float2 rand = fixed2(sin(_Time.y*_ShakeSpeed),cos(_Time.y*_ShakeSpeed));
                float2 uv = float2(i.uv.x + _X*rand.x,i.uv.y + _Y*rand.y);

                return tex2D(_MainTex, uv);
            }
            ENDCG
        }
    }
    FallBack Off
}
