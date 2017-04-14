Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56476 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdDNOmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 10:42:03 -0400
Subject: Re: [PATCH] tools: iio: add ability to pass kernel headers
To: Sekhar Nori <nsekhar@ti.com>
References: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f009aa7-f1c0-cf7b-344b-fe83f3b4b7b9@kernel.org>
Date: Fri, 14 Apr 2017 15:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <d5f344548931389ea4598be946bdc28af1790cc9.1491908438.git.nsekhar@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/17 12:06, Sekhar Nori wrote:
> Very often, especially when cross compiling, there is a need
> to pass kernel headers different from those installed on the
> build machine.
> 
> Add support for doing this for iio utils by using the
> 'INSTALL_HDR_PATH' environment variable. This is supported by
> 'make headers_install' for installing kernel headers at a
> user specified location. So you will do:
> 
> $ make headers_install ARCH=arm INSTALL_HDR_PATH=<absolute-path>
> $ make -C tools/iio ARCH=arm INSTALL_HDR_PATH=<absolute-path>
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

It's a bit of an oddity as that usually refers to where to put
the headers rather than where they are.

Is there a more general solution?  I couldn't find anything
particularly consistent in tools.
> ---
>  tools/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 5446d625e17d..75607043d6e2 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,5 @@
>  CC = $(CROSS_COMPILE)gcc
> -CFLAGS += -Wall -g -D_GNU_SOURCE
> +CFLAGS += -Wall -g -D_GNU_SOURCE -I$(INSTALL_HDR_PATH)/include
>  
>  BINDIR=usr/bin
>  INSTALL_PROGRAM=install -m 755 -p
> 

