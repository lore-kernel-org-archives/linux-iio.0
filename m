Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58871 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcGXLof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 07:44:35 -0400
Subject: Re: [PATCH] iio: adc: ad7298: use iio helper function to guarantee
 direct mode
To: Alison Schofield <amsfield22@gmail.com>
References: <20160718193408.GA3854@d830.WORKGROUP>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a74b6191-1e2e-3ce3-83d8-e0ac39430357@kernel.org>
Date: Sun, 24 Jul 2016 12:44:33 +0100
MIME-Version: 1.0
In-Reply-To: <20160718193408.GA3854@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 20:34, Alison Schofield wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the togreg branch of iio.git - initially pushed
out as testing.

If Lars or Michael has a chance to look at these as well,
I can easily enough pull them or add Acks etc for now.

Jonathan
> ---
>  drivers/iio/adc/ad7298.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 10ec8fc..e399bf0 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -239,16 +239,16 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> -		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> -			ret = -EBUSY;
> -		} else {
> -			if (chan->address == AD7298_CH_TEMP)
> -				ret = ad7298_scan_temp(st, val);
> -			else
> -				ret = ad7298_scan_direct(st, chan->address);
> -		}
> -		mutex_unlock(&indio_dev->mlock);
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->address == AD7298_CH_TEMP)
> +			ret = ad7298_scan_temp(st, val);
> +		else
> +			ret = ad7298_scan_direct(st, chan->address);
> +
> +		iio_device_release_direct_mode(indio_dev);
>  
>  		if (ret < 0)
>  			return ret;
> 

