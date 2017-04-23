Return-Path: <SRS0=9oZt=37=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH v2] tools/iio: Use include/uapi with __EXPORTED_HEADERS__
To: Sekhar Nori <nsekhar@ti.com>, Jonathan Cameron <jic23@kernel.org>
References: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a357589-7169-5cff-e842-657b52049b15@infradead.org>
Date: Sat, 22 Apr 2017 19:22:35 -0700
MIME-Version: 1.0
In-Reply-To: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/21/17 05:31, Sekhar Nori wrote:
> Use the local uapi headers to keep in sync with "recently" added enum
> values like IIO_UVINDEX.
> 
> Build tested using:
> $ make -C <kernelsrcdir> tools/iio
> $ make -C <kernelsrcdir>/tools iio
> $ make -C <kernelsrcdir>/tools/iio

Hi,
Did you do any testing with O=<outputdir> ?

Thanks.

> This follows a strategy similar to that used by tools/hv, tools/net and
> tools/leds among others.
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Change since v1:
> Shift to a strategy similar to that used by other makefiles in
> tools/ folder. v1 posting here: https://patchwork.kernel.org/patch/9674937/
> 
>  tools/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 5446d625e17d..8f08e03a9a5e 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,5 @@
>  CC = $(CROSS_COMPILE)gcc
> -CFLAGS += -Wall -g -D_GNU_SOURCE
> +CFLAGS += -Wall -g -D_GNU_SOURCE -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
>  
>  BINDIR=usr/bin
>  INSTALL_PROGRAM=install -m 755 -p
> 


-- 
~Randy
