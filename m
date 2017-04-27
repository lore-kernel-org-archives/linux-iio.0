Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37682 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdD0Fd5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 01:33:57 -0400
Subject: Re: [PATCH v2] tools/iio: Use include/uapi with __EXPORTED_HEADERS__
To: Sekhar Nori <nsekhar@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <69250d97-707a-ff2f-ce74-f049bc42faf1@kernel.org>
Date: Thu, 27 Apr 2017 06:33:52 +0100
MIME-Version: 1.0
In-Reply-To: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/04/17 13:31, Sekhar Nori wrote:
> Use the local uapi headers to keep in sync with "recently" added enum
> values like IIO_UVINDEX.
> 
> Build tested using:
> $ make -C <kernelsrcdir> tools/iio
> $ make -C <kernelsrcdir>/tools iio
> $ make -C <kernelsrcdir>/tools/iio
> 
> This follows a strategy similar to that used by tools/hv, tools/net and
> tools/leds among others.
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore it.

Jonathan
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

