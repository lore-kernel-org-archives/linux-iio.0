Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbeCJQpl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 11:45:41 -0500
Date: Sat, 10 Mar 2018 16:45:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio:ad2s1210: Remove unused #define
 directive
Message-ID: <20180310164535.14b610d9@archlinux>
In-Reply-To: <3e7250cc1e99d3cb284e0337fcf4b1188940cd69.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
        <3e7250cc1e99d3cb284e0337fcf4b1188940cd69.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Mar 2018 20:46:05 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes some #define directives not used in the code.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

One comment inline.
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0cdcd71e285b..79cb56670fc2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -35,8 +35,6 @@
>  #define AD2S1210_SET_RES1		0x02
>  #define AD2S1210_SET_RES0		0x01
>  
> -#define AD2S1210_SET_ENRESOLUTION	(AD2S1210_SET_ENRES1 |	\
> -					 AD2S1210_SET_ENRES0)
>  #define AD2S1210_SET_RESOLUTION		(AD2S1210_SET_RES1 | AD2S1210_SET_RES0)
>  
>  #define AD2S1210_REG_POSITION		0x80
> @@ -53,10 +51,6 @@
>  #define AD2S1210_REG_SOFT_RESET		0xF0
>  #define AD2S1210_REG_FAULT		0xFF
>  
> -/* pin SAMPLE, A0, A1, RES0, RES1, is controlled by driver */
> -#define AD2S1210_SAA		3
> -#define AD2S1210_PN		(AD2S1210_SAA + AD2S1210_RES)
> -
>  #define AD2S1210_MIN_CLKIN	6144000
>  #define AD2S1210_MAX_CLKIN	10240000
>  #define AD2S1210_MIN_EXCIT	2000
> @@ -64,10 +58,6 @@
>  #define AD2S1210_MIN_FCW	0x4
>  #define AD2S1210_MAX_FCW	0x50
>  
> -/* default input clock on serial interface */
I'm not sure what this has to do with the serial interface.
It's the clk input from an external clock source.

> -#define AD2S1210_DEF_CLKIN	8192000
> -/* clock period in nano second */
> -#define AD2S1210_DEF_TCK	(1000000000 / AD2S1210_DEF_CLKIN)
>  #define AD2S1210_DEF_EXCIT	10000
>  
>  enum ad2s1210_mode {

