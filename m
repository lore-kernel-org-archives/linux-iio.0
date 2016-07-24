Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58835 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbcGXLjq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 07:39:46 -0400
Subject: Re: [PATCH] iio: accel: bma180: use iio helper function to guarantee
 direct mode
To: Alison Schofield <amsfield22@gmail.com>
References: <20160720042525.GA31927@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <35455bc4-3147-878c-65b8-56dd71e46aa0@kernel.org>
Date: Sun, 24 Jul 2016 12:39:43 +0100
MIME-Version: 1.0
In-Reply-To: <20160720042525.GA31927@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/16 05:25, Alison Schofield wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
> Peter: I was not clear if we want to keep the data->mutex lock
> in addition to claiming direct mode.  I see that lock assuring
> exclusivity amongst a few other tasks in the driver. Let me 
> know if this needs both locks. Thanks!
> 
I'd go with keeping it.  Makes it change obviously correct,
rather than requiring a careful analysis of the driver..

Using that lock to protect entry into buffered mode would
probably never have worked so I think we definitely need
both locks to be taken here.

Jonathan
> 
>  drivers/iio/accel/bma180.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index e3f88ba..ce5a476 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -469,13 +469,12 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&data->mutex);
> -		if (iio_buffer_enabled(indio_dev)) {
> -			mutex_unlock(&data->mutex);
> -			return -EBUSY;
> -		}
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		ret = bma180_get_data_reg(data, chan->scan_index);
> -		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		*val = sign_extend32(ret >> chan->scan_type.shift,
> 

