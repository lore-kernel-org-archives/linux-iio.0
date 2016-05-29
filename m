Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34098 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbcE2Stg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:49:36 -0400
Subject: Re: [PATCH] tools: iio: Add ability to install/uninstall
To: Peter Robinson <pbrobinson@gmail.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
References: <1464183073-4379-1-git-send-email-pbrobinson@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fe12fc83-c9ab-15d9-3185-2a351311559f@kernel.org>
Date: Sun, 29 May 2016 19:49:34 +0100
MIME-Version: 1.0
In-Reply-To: <1464183073-4379-1-git-send-email-pbrobinson@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 14:31, Peter Robinson wrote:
> Add options to the Makefile for install/uninstall similar to other tools.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Can't say I personally care that much as I tend to be manually scping to boards, 
but presumably some people will find it useful!

Applied to the togreg branch of iio.git.  Will be pushed out as testing, but
not sure if 0day is autobuilding iiotools yet (have requested) so may do
nothing with it!

Thanks,

Jonathan
> ---
>  tools/iio/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 3a7a54f..5c32e90 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,6 +1,10 @@
>  CC = $(CROSS_COMPILE)gcc
>  CFLAGS += -Wall -g -D_GNU_SOURCE
>  
> +BINDIR=usr/bin
> +INSTALL_PROGRAM=install -m 755 -p
> +DEL_FILE=rm -f
> +
>  all: iio_event_monitor lsiio generic_buffer
>  
>  iio_event_monitor: iio_event_monitor.o iio_utils.o
> @@ -11,6 +15,17 @@ generic_buffer: generic_buffer.o iio_utils.o
>  
>  %.o: %.c iio_utils.h
>  
> +install:
> +	- mkdir -p $(INSTALL_ROOT)/$(BINDIR)
> +	- $(INSTALL_PROGRAM) "iio_event_monitor" "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
> +	- $(INSTALL_PROGRAM) "lsiio" "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
> +	- $(INSTALL_PROGRAM) "generic_buffer" "$(INSTALL_ROOT)/$(BINDIR)/generic_buffer"
> +
> +uninstall:
> +	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/iio_event_monitor"
> +	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/lsiio"
> +	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/generic_buffer"
> +
>  .PHONY: clean
>  clean:
>  	rm -f *.o iio_event_monitor lsiio generic_buffer
> 

