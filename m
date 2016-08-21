Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53083 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcHUTFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:05:33 -0400
Subject: Re: [PATCH] tools: iio: fix iio build error by adding KBUILD_OUTPUT
 support to makefile
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
References: <20160811060124.6604-1-mugunthanvnm@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <198eb20a-0150-b2b7-8b96-a4a13349724a@kernel.org>
Date: Sun, 21 Aug 2016 20:05:31 +0100
MIME-Version: 1.0
In-Reply-To: <20160811060124.6604-1-mugunthanvnm@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/16 07:01, Mugunthan V N wrote:
> Current make doesn't have support to pass kernel built directory
> to find events.h kernel header file, so adding support for
> KBUILD_OUTPUT support to Makefile.
> 
> $ make CROSS_COMPILE=arm-linux-gnueabihf- -C tools/iio
> make: Entering directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o iio_event_monitor.c
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_utils.o iio_utils.c
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o lsiio.o lsiio.c
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_generic_buffer.o iio_generic_buffer.c
> arm-linux-gnueabihf-gcc   lsiio.o iio_utils.o   -o lsiio
> arm-linux-gnueabihf-gcc   iio_generic_buffer.o iio_utils.o   -o iio_generic_buffer
> iio_event_monitor.c:28:30: fatal error: linux/iio/events.h: No such file or directory
>  #include <linux/iio/events.h>
>                                ^
> compilation terminated.
> <builtin>: recipe for target 'iio_event_monitor.o' failed
> make: *** [iio_event_monitor.o] Error 1
> make: Leaving directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
I can see where you are coming from, but wouldn't we normally expect the kernel
headers for the relevant kernel to available as part of the toolchain being
used to do the build?

They often lag a bit I guess, so perhaps we do want to put this little bit
of 'fudging' in place.

What do others think?

Jonathan
> ---
> 
> With this fix I am able to build the iio tools
> 
> $ make CROSS_COMPILE=arm-linux-gnueabihf- -C tools/iio KBUILD_OUTPUT=`pwd`
> make: Entering directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_event_monitor.o iio_event_monitor.c
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_utils.o iio_utils.c
> arm-linux-gnueabihf-gcc   iio_event_monitor.o iio_utils.o   -o iio_event_monitor
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o lsiio.o lsiio.c
> arm-linux-gnueabihf-gcc   lsiio.o iio_utils.o   -o lsiio
> arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE -I/home/a0131834/workspace/git/mainline/linux/usr/include   -c -o iio_generic_buffer.o iio_generic_buffer.c
> arm-linux-gnueabihf-gcc   iio_generic_buffer.o iio_utils.o   -o iio_generic_buffer
> make: Leaving directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
> 
> ---
>  tools/iio/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 5446d62..0ec3ea0 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,6 @@
>  CC = $(CROSS_COMPILE)gcc
> -CFLAGS += -Wall -g -D_GNU_SOURCE
> +KBUILD_OUTPUT ?= /lib/modules/$(shell uname -r)/build
> +CFLAGS += -Wall -g -D_GNU_SOURCE -I$(KBUILD_OUTPUT)/usr/include
>  
>  BINDIR=usr/bin
>  INSTALL_PROGRAM=install -m 755 -p
> 

