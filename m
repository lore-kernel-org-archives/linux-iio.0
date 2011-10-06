Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59654 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899Ab1JFNco (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2011 09:32:44 -0400
Message-ID: <4E8DAFF6.2030602@cam.ac.uk>
Date: Thu, 06 Oct 2011 14:41:10 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio: AD5638: Fix channel address
References: <1317907147-15677-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1317907147-15677-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/11 14:19, Lars-Peter Clausen wrote:
> Commit c6fc806247 ("staging:iio: ABI rework - add in_ or out_ prefix to
> channnels") added the AD5868_CHANNEL macro to simplify channel initialization.
> Unfortunately the macro hardcodes the channel's address to AD5686_ADDR_DAC0. As
> a result writing to any of the channels will change the value of the first
> channel.
> 
> This patch fixes the issue by calculating the channel address based on the
> channel number.
> 
oops, not one of my better moments. It always seems to be the simple
cleanups that have this dumb ass bugs in them.

Less churn to use
AD5656_ADDR_DAC##chan, but yours is cleaner in the end.

Thanks!

Please send on to Greg (no need to go through my tree now Greg's
is publicly visible again).
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

> ---
>  drivers/staging/iio/dac/ad5686.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
> index b55ef42..adf898f 100644
> --- a/drivers/staging/iio/dac/ad5686.c
> +++ b/drivers/staging/iio/dac/ad5686.c
> @@ -26,10 +26,7 @@
>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> -#define AD5686_ADDR_DAC0			0x1
> -#define AD5686_ADDR_DAC1			0x2
> -#define AD5686_ADDR_DAC2			0x4
> -#define AD5686_ADDR_DAC3			0x8
> +#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
>  #define AD5686_ADDR_ALL_DAC			0xF
>  
>  #define AD5686_CMD_NOOP				0x0
> @@ -103,7 +100,7 @@ enum ad5686_supported_device_ids {
>  		.output = 1,					\
>  		.channel = chan,				\
>  		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
> -		.address = AD5686_ADDR_DAC0,			\
> +		.address = AD5686_ADDR_DAC(chan),			\
>  		.scan_type = IIO_ST('u', bits, 16, shift)	\
>  }
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {

