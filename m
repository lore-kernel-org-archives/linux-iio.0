Return-Path: <SRS0=6ezP=2K=gmail.com=narcisaanamaria12@kernel.org>
Date: Wed, 1 Mar 2017 09:12:24 -0800 (PST)
From: Narcisa Vasile <narcisaanamaria12@gmail.com>
To: outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, narcisaanamaria12@gmail.com
Message-Id: <c5b95296-f346-4e7e-9248-0d68d7a51339@googlegroups.com>
In-Reply-To: <1488216496-16969-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
 <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
 <1488216496-16969-1-git-send-email-narcisaanamaria12@gmail.com>
Subject: Re: [PATCH v3] staging: iio: ad9832: Moved contents of the header
 to the source file
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1878_1840619384.1488388344152"
List-ID: <linux-iio@vger.kernel.org>

------=_Part_1878_1840619384.1488388344152
Content-Type: multipart/alternative;
	boundary="----=_Part_1879_1243307067.1488388344153"

------=_Part_1879_1243307067.1488388344153
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
Is this patch correct now or should I improve it ?

Narcisa

On Monday, February 27, 2017 at 7:28:46 PM UTC+2, Narcisa Vasile wrote:
>
> Moved the contents of the header(ad9832.h) into the corresponding source 
> file 
> with the exception of the platform data struct which is supposed to be 
> used from somewhere else other than the driver. 
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> 
> --- 
> Changes in v3: 
>    -The changes are now made against the original code 
> --- 
>  drivers/staging/iio/frequency/ad9832.c | 92 
> ++++++++++++++++++++++++++++++++++ 
>  drivers/staging/iio/frequency/ad9832.h | 92 
> ---------------------------------- 
>  2 files changed, 92 insertions(+), 92 deletions(-) 
>
> diff --git a/drivers/staging/iio/frequency/ad9832.c 
> b/drivers/staging/iio/frequency/ad9832.c 
> index a5b2f06..8d40c8e 100644 
> --- a/drivers/staging/iio/frequency/ad9832.c 
> +++ b/drivers/staging/iio/frequency/ad9832.c 
> @@ -22,6 +22,98 @@ 
>   
>  #include "ad9832.h" 
>   
> +/* Registers */ 
> + 
> +#define AD9832_FREQ0LL                0x0 
> +#define AD9832_FREQ0HL                0x1 
> +#define AD9832_FREQ0LM                0x2 
> +#define AD9832_FREQ0HM                0x3 
> +#define AD9832_FREQ1LL                0x4 
> +#define AD9832_FREQ1HL                0x5 
> +#define AD9832_FREQ1LM                0x6 
> +#define AD9832_FREQ1HM                0x7 
> +#define AD9832_PHASE0L                0x8 
> +#define AD9832_PHASE0H                0x9 
> +#define AD9832_PHASE1L                0xA 
> +#define AD9832_PHASE1H                0xB 
> +#define AD9832_PHASE2L                0xC 
> +#define AD9832_PHASE2H                0xD 
> +#define AD9832_PHASE3L                0xE 
> +#define AD9832_PHASE3H                0xF 
> + 
> +#define AD9832_PHASE_SYM        0x10 
> +#define AD9832_FREQ_SYM                0x11 
> +#define AD9832_PINCTRL_EN        0x12 
> +#define AD9832_OUTPUT_EN        0x13 
> + 
> +/* Command Control Bits */ 
> + 
> +#define AD9832_CMD_PHA8BITSW        0x1 
> +#define AD9832_CMD_PHA16BITSW        0x0 
> +#define AD9832_CMD_FRE8BITSW        0x3 
> +#define AD9832_CMD_FRE16BITSW        0x2 
> +#define AD9832_CMD_FPSELECT        0x6 
> +#define AD9832_CMD_SYNCSELSRC        0x8 
> +#define AD9832_CMD_SLEEPRESCLR        0xC 
> + 
> +#define AD9832_FREQ                BIT(11) 
> +#define AD9832_PHASE(x)                (((x) & 3) << 9) 
> +#define AD9832_SYNC                BIT(13) 
> +#define AD9832_SELSRC                BIT(12) 
> +#define AD9832_SLEEP                BIT(13) 
> +#define AD9832_RESET                BIT(12) 
> +#define AD9832_CLR                BIT(11) 
> +#define CMD_SHIFT                12 
> +#define ADD_SHIFT                8 
> +#define AD9832_FREQ_BITS        32 
> +#define AD9832_PHASE_BITS        12 
> +#define RES_MASK(bits)                ((1 << (bits)) - 1) 
> + 
> +/** 
> + * struct ad9832_state - driver instance specific data 
> + * @spi:                spi_device 
> + * @avdd:                supply regulator for the analog section 
> + * @dvdd:                supply regulator for the digital section 
> + * @mclk:                external master clock 
> + * @ctrl_fp:                cached frequency/phase control word 
> + * @ctrl_ss:                cached sync/selsrc control word 
> + * @ctrl_src:                cached sleep/reset/clr word 
> + * @xfer:                default spi transfer 
> + * @msg:                default spi message 
> + * @freq_xfer:                tuning word spi transfer 
> + * @freq_msg:                tuning word spi message 
> + * @phase_xfer:                tuning word spi transfer 
> + * @phase_msg:                tuning word spi message 
> + * @data:                spi transmit buffer 
> + * @phase_data:                tuning word spi transmit buffer 
> + * @freq_data:                tuning word spi transmit buffer 
> + */ 
> + 
> +struct ad9832_state { 
> +        struct spi_device                *spi; 
> +        struct regulator                *avdd; 
> +        struct regulator                *dvdd; 
> +        unsigned long                        mclk; 
> +        unsigned short                        ctrl_fp; 
> +        unsigned short                        ctrl_ss; 
> +        unsigned short                        ctrl_src; 
> +        struct spi_transfer                xfer; 
> +        struct spi_message                msg; 
> +        struct spi_transfer                freq_xfer[4]; 
> +        struct spi_message                freq_msg; 
> +        struct spi_transfer                phase_xfer[2]; 
> +        struct spi_message                phase_msg; 
> +        /* 
> +         * DMA (thus cache coherency maintenance) requires the 
> +         * transfer buffers to live in their own cache lines. 
> +         */ 
> +        union { 
> +                __be16                        freq_data[4]____cacheline_aligned; 
>
> +                __be16                        phase_data[2]; 
> +                __be16                        data; 
> +        }; 
> +}; 
> + 
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned 
> long fout) 
>  { 
>          unsigned long long freqreg = (u64)fout * 
> diff --git a/drivers/staging/iio/frequency/ad9832.h 
> b/drivers/staging/iio/frequency/ad9832.h 
> index 1b08b04..39d326c 100644 
> --- a/drivers/staging/iio/frequency/ad9832.h 
> +++ b/drivers/staging/iio/frequency/ad9832.h 
> @@ -8,98 +8,6 @@ 
>  #ifndef IIO_DDS_AD9832_H_ 
>  #define IIO_DDS_AD9832_H_ 
>   
> -/* Registers */ 
> - 
> -#define AD9832_FREQ0LL                0x0 
> -#define AD9832_FREQ0HL                0x1 
> -#define AD9832_FREQ0LM                0x2 
> -#define AD9832_FREQ0HM                0x3 
> -#define AD9832_FREQ1LL                0x4 
> -#define AD9832_FREQ1HL                0x5 
> -#define AD9832_FREQ1LM                0x6 
> -#define AD9832_FREQ1HM                0x7 
> -#define AD9832_PHASE0L                0x8 
> -#define AD9832_PHASE0H                0x9 
> -#define AD9832_PHASE1L                0xA 
> -#define AD9832_PHASE1H                0xB 
> -#define AD9832_PHASE2L                0xC 
> -#define AD9832_PHASE2H                0xD 
> -#define AD9832_PHASE3L                0xE 
> -#define AD9832_PHASE3H                0xF 
> - 
> -#define AD9832_PHASE_SYM        0x10 
> -#define AD9832_FREQ_SYM                0x11 
> -#define AD9832_PINCTRL_EN        0x12 
> -#define AD9832_OUTPUT_EN        0x13 
> - 
> -/* Command Control Bits */ 
> - 
> -#define AD9832_CMD_PHA8BITSW        0x1 
> -#define AD9832_CMD_PHA16BITSW        0x0 
> -#define AD9832_CMD_FRE8BITSW        0x3 
> -#define AD9832_CMD_FRE16BITSW        0x2 
> -#define AD9832_CMD_FPSELECT        0x6 
> -#define AD9832_CMD_SYNCSELSRC        0x8 
> -#define AD9832_CMD_SLEEPRESCLR        0xC 
> - 
> -#define AD9832_FREQ                BIT(11) 
> -#define AD9832_PHASE(x)                (((x) & 3) << 9) 
> -#define AD9832_SYNC                BIT(13) 
> -#define AD9832_SELSRC                BIT(12) 
> -#define AD9832_SLEEP                BIT(13) 
> -#define AD9832_RESET                BIT(12) 
> -#define AD9832_CLR                BIT(11) 
> -#define CMD_SHIFT                12 
> -#define ADD_SHIFT                8 
> -#define AD9832_FREQ_BITS        32 
> -#define AD9832_PHASE_BITS        12 
> -#define RES_MASK(bits)                ((1 << (bits)) - 1) 
> - 
> -/** 
> - * struct ad9832_state - driver instance specific data 
> - * @spi:                spi_device 
> - * @avdd:                supply regulator for the analog section 
> - * @dvdd:                supply regulator for the digital section 
> - * @mclk:                external master clock 
> - * @ctrl_fp:                cached frequency/phase control word 
> - * @ctrl_ss:                cached sync/selsrc control word 
> - * @ctrl_src:                cached sleep/reset/clr word 
> - * @xfer:                default spi transfer 
> - * @msg:                default spi message 
> - * @freq_xfer:                tuning word spi transfer 
> - * @freq_msg:                tuning word spi message 
> - * @phase_xfer:                tuning word spi transfer 
> - * @phase_msg:                tuning word spi message 
> - * @data:                spi transmit buffer 
> - * @phase_data:                tuning word spi transmit buffer 
> - * @freq_data:                tuning word spi transmit buffer 
> - */ 
> - 
> -struct ad9832_state { 
> -        struct spi_device                *spi; 
> -        struct regulator                *avdd; 
> -        struct regulator                *dvdd; 
> -        unsigned long                        mclk; 
> -        unsigned short                        ctrl_fp; 
> -        unsigned short                        ctrl_ss; 
> -        unsigned short                        ctrl_src; 
> -        struct spi_transfer                xfer; 
> -        struct spi_message                msg; 
> -        struct spi_transfer                freq_xfer[4]; 
> -        struct spi_message                freq_msg; 
> -        struct spi_transfer                phase_xfer[2]; 
> -        struct spi_message                phase_msg; 
> -        /* 
> -         * DMA (thus cache coherency maintenance) requires the 
> -         * transfer buffers to live in their own cache lines. 
> -         */ 
> -        union { 
> -                __be16                        freq_data[4]____cacheline_aligned; 
>
> -                __be16                        phase_data[2]; 
> -                __be16                        data; 
> -        }; 
> -}; 
> - 
>  /* 
>   * TODO: struct ad9832_platform_data needs to go into include/linux/iio 
>   */ 
> -- 
> 1.9.1 
>
>
------=_Part_1879_1243307067.1488388344153
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>Is this patch correct now or should I improve it ?<=
br><br>Narcisa<br><br>On Monday, February 27, 2017 at 7:28:46 PM UTC+2, Nar=
cisa Vasile wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Moved the co=
ntents of the header(ad9832.h) into the corresponding source file
<br>with the exception of the platform data struct which is supposed to be
<br>used from somewhere else other than the driver.
<br>
<br>Signed-off-by: Narcisa Ana Maria Vasile &lt;<a href=3D"mailto:narcisaan=
amaria12@gmail.com" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.=
href=3D&#39;mailto:narcisaanamaria12@gmail.com&#39;;return true;" onclick=
=3D"this.href=3D&#39;mailto:narcisaanamaria12@gmail.com&#39;;return true;">=
narcisaanamaria12@gmail.com</a>&gt;
<br>---
<br>Changes in v3:
<br>=C2=A0 =C2=A0-The changes are now made against the original code
<br>---
<br>=C2=A0drivers/staging/iio/<wbr>frequency/ad9832.c | 92 ++++++++++++++++=
++++++++++++++<wbr>++++
<br>=C2=A0drivers/staging/iio/<wbr>frequency/ad9832.h | 92 ----------------=
--------------<wbr>----
<br>=C2=A02 files changed, 92 insertions(+), 92 deletions(-)
<br>
<br>diff --git a/drivers/staging/iio/<wbr>frequency/ad9832.c b/drivers/stag=
ing/iio/<wbr>frequency/ad9832.c
<br>index a5b2f06..8d40c8e 100644
<br>--- a/drivers/staging/iio/<wbr>frequency/ad9832.c
<br>+++ b/drivers/staging/iio/<wbr>frequency/ad9832.c
<br>@@ -22,6 +22,98 @@
<br>=C2=A0
<br>=C2=A0#include &quot;ad9832.h&quot;
<br>=C2=A0
<br>+/* Registers */
<br>+
<br>+#define AD9832_FREQ0LL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x0
<br>+#define AD9832_FREQ0HL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x1
<br>+#define AD9832_FREQ0LM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x2
<br>+#define AD9832_FREQ0HM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x3
<br>+#define AD9832_FREQ1LL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x4
<br>+#define AD9832_FREQ1HL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x5
<br>+#define AD9832_FREQ1LM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x6
<br>+#define AD9832_FREQ1HM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x7
<br>+#define AD9832_PHASE0L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x8
<br>+#define AD9832_PHASE0H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x9
<br>+#define AD9832_PHASE1L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xA
<br>+#define AD9832_PHASE1H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xB
<br>+#define AD9832_PHASE2L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xC
<br>+#define AD9832_PHASE2H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xD
<br>+#define AD9832_PHASE3L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xE
<br>+#define AD9832_PHASE3H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xF
<br>+
<br>+#define AD9832_PHASE_SYM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x10
<br>+#define AD9832_FREQ_SYM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A00x11
<br>+#define AD9832_PINCTRL_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x12
<br>+#define AD9832_OUTPUT_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x13
<br>+
<br>+/* Command Control Bits */
<br>+
<br>+#define AD9832_CMD_PHA8BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>0x1
<br>+#define AD9832_CMD_PHA16BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x0
<br>+#define AD9832_CMD_FRE8BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>0x3
<br>+#define AD9832_CMD_FRE16BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x2
<br>+#define AD9832_CMD_FPSELECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00x6
<br>+#define AD9832_CMD_SYNCSELSRC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x8
<br>+#define AD9832_CMD_SLEEPRESCLR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0xC
<br>+
<br>+#define AD9832_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(11)
<br>+#define AD9832_PHASE(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0(((x) &amp; 3) &lt;=
&lt; 9)
<br>+#define AD9832_SYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(13)
<br>+#define AD9832_SELSRC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(12)
<br>+#define AD9832_SLEEP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(13)
<br>+#define AD9832_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(12)
<br>+#define AD9832_CLR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(<wbr>11)
<br>+#define CMD_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A012
<br>+#define ADD_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08
<br>+#define AD9832_FREQ_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A032
<br>+#define AD9832_PHASE_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A012
<br>+#define RES_MASK(bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>((1 &lt;&lt; (bits)) -=
 1)
<br>+
<br>+/**
<br>+ * struct ad9832_state - driver instance specific data
<br>+ * @spi:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi_<wbr>device
<br>+ * @avdd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0supply regulator for the analog section
<br>+ * @dvdd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0supply regulator for the digital sectio=
n
<br>+ * @mclk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0external master clock
<br>+ * @ctrl_fp:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached frequency/phase control =
word
<br>+ * @ctrl_ss:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached sync/selsrc control word
<br>+ * @ctrl_src:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached sleep/reset/clr word
<br>+ * @xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default spi transfer
<br>+ * @msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default spi message
<br>+ * @freq_xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transfer
<br>+ * @freq_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi message
<br>+ * @phase_xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transfer
<br>+ * @phase_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi message
<br>+ * @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi transmit buffer
<br>+ * @phase_data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transmit buf=
fer
<br>+ * @freq_data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transmit buf=
fer
<br>+ */
<br>+
<br>+struct ad9832_state {
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_device=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*<wbr>spi;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regulator=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*<wbr>avdd;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regulator=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*<wbr>dvdd;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>mclk;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_fp=
;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_ss=
;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_sr=
c;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>xfer;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>msg;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>freq_xfer[4];
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>freq_msg;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>phase_xfer[2];
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>phase_msg;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DMA (thus cache coh=
erency maintenance) requires the
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * transfer buffers to=
 live in their own cache lines.
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union {
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0freq_data[4]_<wbr>___cacheline_aligned;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phase_data[2]<wbr>;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
<br>+};
<br>+
<br>=C2=A0static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsi=
gned long fout)
<br>=C2=A0{
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long lon=
g freqreg =3D (u64)fout *
<br>diff --git a/drivers/staging/iio/<wbr>frequency/ad9832.h b/drivers/stag=
ing/iio/<wbr>frequency/ad9832.h
<br>index 1b08b04..39d326c 100644
<br>--- a/drivers/staging/iio/<wbr>frequency/ad9832.h
<br>+++ b/drivers/staging/iio/<wbr>frequency/ad9832.h
<br>@@ -8,98 +8,6 @@
<br>=C2=A0#ifndef IIO_DDS_AD9832_H_
<br>=C2=A0#define IIO_DDS_AD9832_H_
<br>=C2=A0
<br>-/* Registers */
<br>-
<br>-#define AD9832_FREQ0LL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x0
<br>-#define AD9832_FREQ0HL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x1
<br>-#define AD9832_FREQ0LM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x2
<br>-#define AD9832_FREQ0HM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x3
<br>-#define AD9832_FREQ1LL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x4
<br>-#define AD9832_FREQ1HL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x5
<br>-#define AD9832_FREQ1LM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x6
<br>-#define AD9832_FREQ1HM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x7
<br>-#define AD9832_PHASE0L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x8
<br>-#define AD9832_PHASE0H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0x9
<br>-#define AD9832_PHASE1L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xA
<br>-#define AD9832_PHASE1H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xB
<br>-#define AD9832_PHASE2L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xC
<br>-#define AD9832_PHASE2H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xD
<br>-#define AD9832_PHASE3L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xE
<br>-#define AD9832_PHASE3H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>0xF
<br>-
<br>-#define AD9832_PHASE_SYM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x10
<br>-#define AD9832_FREQ_SYM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A00x11
<br>-#define AD9832_PINCTRL_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x12
<br>-#define AD9832_OUTPUT_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x13
<br>-
<br>-/* Command Control Bits */
<br>-
<br>-#define AD9832_CMD_PHA8BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>0x1
<br>-#define AD9832_CMD_PHA16BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x0
<br>-#define AD9832_CMD_FRE8BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>0x3
<br>-#define AD9832_CMD_FRE16BITSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x2
<br>-#define AD9832_CMD_FPSELECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00x6
<br>-#define AD9832_CMD_SYNCSELSRC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0x8
<br>-#define AD9832_CMD_SLEEPRESCLR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<wbr>0xC
<br>-
<br>-#define AD9832_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(11)
<br>-#define AD9832_PHASE(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0(((x) &amp; 3) &lt;=
&lt; 9)
<br>-#define AD9832_SYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(13)
<br>-#define AD9832_SELSRC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(12)
<br>-#define AD9832_SLEEP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(13)
<br>-#define AD9832_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>BIT(12)
<br>-#define AD9832_CLR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(<wbr>11)
<br>-#define CMD_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A012
<br>-#define ADD_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08
<br>-#define AD9832_FREQ_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A032
<br>-#define AD9832_PHASE_BITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A012
<br>-#define RES_MASK(bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>((1 &lt;&lt; (bits)) -=
 1)
<br>-
<br>-/**
<br>- * struct ad9832_state - driver instance specific data
<br>- * @spi:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi_<wbr>device
<br>- * @avdd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0supply regulator for the analog section
<br>- * @dvdd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0supply regulator for the digital sectio=
n
<br>- * @mclk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0external master clock
<br>- * @ctrl_fp:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached frequency/phase control =
word
<br>- * @ctrl_ss:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached sync/selsrc control word
<br>- * @ctrl_src:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>cached sleep/reset/clr word
<br>- * @xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default spi transfer
<br>- * @msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default spi message
<br>- * @freq_xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transfer
<br>- * @freq_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi message
<br>- * @phase_xfer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transfer
<br>- * @phase_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi message
<br>- * @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi transmit buffer
<br>- * @phase_data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transmit buf=
fer
<br>- * @freq_data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>tuning word spi transmit buf=
fer
<br>- */
<br>-
<br>-struct ad9832_state {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_device=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*<wbr>spi;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regulator=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*<wbr>avdd;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regulator=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*<wbr>dvdd;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>mclk;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_fp=
;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_ss=
;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned short=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>ctrl_sr=
c;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>xfer;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>msg;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>freq_xfer[4];
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>freq_msg;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_transfer=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>phase_xfer[2];
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_message=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<wbr>phase_msg;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DMA (thus cache coh=
erency maintenance) requires the
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * transfer buffers to=
 live in their own cache lines.
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0freq_data[4]_<wbr>___cacheline_aligned;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phase_data[2]<wbr>;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
<br>-};
<br>-
<br>=C2=A0/*
<br>=C2=A0 * TODO: struct ad9832_platform_data needs to go into include/lin=
ux/iio
<br>=C2=A0 */
<br>--=20
<br>1.9.1
<br>
<br></blockquote></div>
------=_Part_1879_1243307067.1488388344153--

------=_Part_1878_1840619384.1488388344152--
