Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58933 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbcGXMBP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:01:15 -0400
Subject: Re: [PATCH] iio: ad799x: Fix buffered capture for
 ad7991/ad7995/ad7999
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1468238057-30373-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f9f21df7-eb12-e262-05a4-92f16be625fe@kernel.org>
Date: Sun, 24 Jul 2016 13:01:09 +0100
MIME-Version: 1.0
In-Reply-To: <1468238057-30373-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/16 12:54, Lars-Peter Clausen wrote:
> The data buffer for captured mode for the ad799x driver is allocated in the
> update_scan_mode() callback. This callback is not set in the iio_info
> struct for the ad7791/ad7995/ad7999, which means that the data buffer is
> not allocated when a captured transfer is started. As a result the driver
> crashes when the first sample is received. To fix this properly set the
> update_scan_mode() callback.
> 
> Fixes: d8dca33027c1 ("staging:iio:ad799x: Preallocate sample buffer")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg-post-rc1 branch (because fixes-togreg is
currently empty and hence this'll go upstream sooner) and marked for stable.

thanks,

Jonathan


> ---
> Appologies if you received this twice, forgot the list on the first try.
> ---
>  drivers/iio/adc/ad799x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index b616376..9704090 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -527,6 +527,7 @@ static struct attribute_group ad799x_event_attrs_group = {
>  static const struct iio_info ad7991_info = {
>  	.read_raw = &ad799x_read_raw,
>  	.driver_module = THIS_MODULE,
> +	.update_scan_mode = ad799x_update_scan_mode,
>  };
>  
>  static const struct iio_info ad7993_4_7_8_noirq_info = {
> 

