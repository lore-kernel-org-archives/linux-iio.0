Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41805 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbcHOQNN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 12:13:13 -0400
Subject: Re: [PATCH v2] iio: accel: bma180: use iio helper function to
 guarantee direct mode
To: Alison Schofield <amsfield22@gmail.com>
References: <20160725191109.GA10048@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fbf0223b-1f8d-5828-0b51-abb3b2189dd2@kernel.org>
Date: Mon, 15 Aug 2016 17:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <20160725191109.GA10048@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/16 20:11, Alison Schofield wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied.

Thanks,

Jonathan
> ---
> Changes in v2:
>  - put back private data lock I had removed in v1.
> 
>  drivers/iio/accel/bma180.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index e3f88ba..0890934 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -469,13 +469,14 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		mutex_lock(&data->mutex);
> -		if (iio_buffer_enabled(indio_dev)) {
> -			mutex_unlock(&data->mutex);
> -			return -EBUSY;
> -		}
>  		ret = bma180_get_data_reg(data, chan->scan_index);
>  		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		*val = sign_extend32(ret >> chan->scan_type.shift,
> 

