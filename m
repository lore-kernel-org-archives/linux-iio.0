Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdHIOPb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:15:31 -0400
Date: Wed, 9 Aug 2017 15:15:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
Message-ID: <20170809151523.1533bba1@archlinux>
In-Reply-To: <20170801082605.kxzqtnrbt6glplmu@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
        <20170801082605.kxzqtnrbt6glplmu@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 1 Aug 2017 10:26:05 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> When reading diffrent channel value than device is currently processing
> wait time of conversion period is applied, which is not enough as device
> might be already in the middle of conversion and therefore previously
> converted value is returned - the one belonging to another channel.
> Fix it by waiting for two sampling periods.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Strangely we already have a fix in place for this it seems.

See the fixes-togreg branch of iio.git

Clearly a popular device at the moment!

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 884b8e461b17..86fd2753869d 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -260,7 +260,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  		return ret;
>  
>  	if (change) {
> -		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> +		conv_time = 2 * DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
>  		usleep_range(conv_time, conv_time + 1);
>  	}
>  

