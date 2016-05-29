Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34141 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbcE2S6N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:58:13 -0400
Subject: Re: [RFC PATCH v2] tools: iio: Rename generic_buffer to
 iio_generic_buffer
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1464102235-11360-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b9311dd5-dc86-6a86-5cc1-84d17dd3108a@kernel.org>
Date: Sun, 29 May 2016 19:58:11 +0100
MIME-Version: 1.0
In-Reply-To: <1464102235-11360-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 16:03, Daniel Baluta wrote:
> This makes it clear that generic_buffer is an IIO tool
> and also complies with filename conventions in tools/iio.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Pretty uncontroversial bit of common sense to my mind ;)

Applied to the togreg branch of iio.git with a few changes to merge it with
recent install patch.

Pushed out as testing for the autobuilders to ignore it (probably).

Thanks,

Jonathan
> ---
> Changes since v1:
> 	* use -M to detect renames and make the patch easier to review
> 
>  tools/iio/Makefile                                   | 6 +++---
>  tools/iio/{generic_buffer.c => iio_generic_buffer.c} | 0
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename tools/iio/{generic_buffer.c => iio_generic_buffer.c} (100%)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 3a7a54f..e8a009b 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,16 +1,16 @@
>  CC = $(CROSS_COMPILE)gcc
>  CFLAGS += -Wall -g -D_GNU_SOURCE
>  
> -all: iio_event_monitor lsiio generic_buffer
> +all: iio_event_monitor lsiio iio_generic_buffer
>  
>  iio_event_monitor: iio_event_monitor.o iio_utils.o
>  
>  lsiio: lsiio.o iio_utils.o
>  
> -generic_buffer: generic_buffer.o iio_utils.o
> +iio_generic_buffer: iio_generic_buffer.o iio_utils.o
>  
>  %.o: %.c iio_utils.h
>  
>  .PHONY: clean
>  clean:
> -	rm -f *.o iio_event_monitor lsiio generic_buffer
> +	rm -f *.o iio_event_monitor lsiio iio_generic_buffer
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/iio_generic_buffer.c
> similarity index 100%
> rename from tools/iio/generic_buffer.c
> rename to tools/iio/iio_generic_buffer.c
> 

