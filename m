Return-Path: <SRS0=uLAF=2J=lip6.fr=julia.lawall@kernel.org>
Date: Tue, 28 Feb 2017 07:47:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Katie Dunne <kdunne@mail.ccsf.edu>
cc: outreachy-kernel@googlegroups.com, jic23@kernel.org, knaack.h@gmx.de,
    lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
    linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: iio: meter: Remove unused
 definitions
In-Reply-To: <972438f1c7bc46153df933c5861fac91f6793e92.1488250885.git.kdunne@mail.ccsf.edu>
Message-ID: <alpine.DEB.2.20.1702280746000.2078@hadrien>
References: <cover.1488250884.git.kdunne@mail.ccsf.edu> <972438f1c7bc46153df933c5861fac91f6793e92.1488250885.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Mon, 27 Feb 2017, Katie Dunne wrote:

> Remove definitions not used in kernel code.

Did Alison ask for this?  Normally these kinds of constant definitions are
kept, because they describe the device in some way.  If you see macros
that perform more complex computations that are not used, you can get rid
of those.

julia

>
> Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
> ---
>  drivers/staging/iio/meter/ade7753.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
> index bfe7491..ea9284a 100644
> --- a/drivers/staging/iio/meter/ade7753.h
> +++ b/drivers/staging/iio/meter/ade7753.h
> @@ -1,18 +1,12 @@
>  #ifndef _ADE7753_H
>  #define _ADE7753_H
>
> -#define ADE7753_WAVEFORM   0x01
>  #define ADE7753_AENERGY    0x02
> -#define ADE7753_RAENERGY   0x03
>  #define ADE7753_LAENERGY   0x04
>  #define ADE7753_VAENERGY   0x05
> -#define ADE7753_RVAENERGY  0x06
>  #define ADE7753_LVAENERGY  0x07
> -#define ADE7753_LVARENERGY 0x08
>  #define ADE7753_MODE       0x09
>  #define ADE7753_IRQEN      0x0A
> -#define ADE7753_STATUS     0x0B
> -#define ADE7753_RSTSTATUS  0x0C
>  #define ADE7753_CH1OS      0x0D
>  #define ADE7753_CH2OS      0x0E
>  #define ADE7753_GAIN       0x0F
> @@ -27,22 +21,15 @@
>  #define ADE7753_IRMSOS     0x18
>  #define ADE7753_VRMSOS     0x19
>  #define ADE7753_VAGAIN     0x1A
> -#define ADE7753_VADIV      0x1B
>  #define ADE7753_LINECYC    0x1C
> -#define ADE7753_ZXTOUT     0x1D
>  #define ADE7753_SAGCYC     0x1E
>  #define ADE7753_SAGLVL     0x1F
>  #define ADE7753_IPKLVL     0x20
>  #define ADE7753_VPKLVL     0x21
>  #define ADE7753_IPEAK      0x22
> -#define ADE7753_RSTIPEAK   0x23
>  #define ADE7753_VPEAK      0x24
> -#define ADE7753_RSTVPEAK   0x25
> -#define ADE7753_TEMP       0x26
>  #define ADE7753_PERIOD     0x27
> -#define ADE7753_TMODE      0x3D
>  #define ADE7753_CHKSUM     0x3E
> -#define ADE7753_DIEREV     0x3F
>
>  #define ADE7753_READ_REG(a)    a
>  #define ADE7753_WRITE_REG(a) ((a) | 0x80)
> @@ -52,7 +39,6 @@
>  #define ADE7753_STARTUP_DELAY 1000
>
>  #define ADE7753_SPI_SLOW	(u32)(300 * 1000)
> -#define ADE7753_SPI_BURST	(u32)(1000 * 1000)
>  #define ADE7753_SPI_FAST	(u32)(2000 * 1000)
>
>  /**
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/972438f1c7bc46153df933c5861fac91f6793e92.1488250885.git.kdunne%40mail.ccsf.edu.
> For more options, visit https://groups.google.com/d/optout.
>
