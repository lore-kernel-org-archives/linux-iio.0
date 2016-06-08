Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56033 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161358AbcFHHRw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 03:17:52 -0400
Message-id: <5757C69B.6060502@samsung.com>
Date: Wed, 08 Jun 2016 09:17:47 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Alison Schofield <amsfield22@gmail.com>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: use iio helper function to lock
 direct mode
References: <20160608001856.GA15114@d830.WORKGROUP>
In-reply-to: <20160608001856.GA15114@d830.WORKGROUP>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alison,

On 06/08/2016 02:19 AM, Alison Schofield wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.  Includes a
> tiny bit of refactoring (single case -> if) and simplified return
> flow.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>   drivers/iio/light/gp2ap020a00f.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 6d41086..af73af3 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1287,22 +1287,14 @@ static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
>   	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>   	int err = -EINVAL;
>
> -	mutex_lock(&data->lock);
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		if (iio_buffer_enabled(indio_dev)) {
> -			err = -EBUSY;
> -			goto error_unlock;
> -		}
> +	if (mask == IIO_CHAN_INFO_RAW) {
> +		err = iio_device_claim_direct_mode(indio_dev);
> +		if (err)
> +			return err;
>
>   		err = gp2ap020a00f_read_channel(data, chan, val);
> -		break;
> +		iio_device_release_direct_mode(indio_dev);
>   	}
> -
> -error_unlock:
> -	mutex_unlock(&data->lock);
> -
>   	return err < 0 ? err : IIO_VAL_INT;
>   }
>
>

Nice patch.

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
