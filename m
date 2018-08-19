Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeHSThS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:37:18 -0400
Date: Sun, 19 Aug 2018 17:25:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Add check for val2 in the
 write_raw function
Message-ID: <20180819172514.370d34fb@archlinux>
In-Reply-To: <20180811102636.6171-1-himanshujha199640@gmail.com>
References: <20180811102636.6171-1-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 15:56:36 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> val2 is responsible for the floating part of the number to be
> written to the device. We don't need the floating part
> while writing the oversampling ratio for BME680 since the
> available oversampling ratios are pure natural numbers.
> 
> So, add a sanity check to make sure val2 is 0.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

As discussed in David's patch series v3, I think this is still relevant
but now needs an update to cover the new code.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/bme680_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 7d9bb62baa3f..9d5a05e054d1 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -852,6 +852,9 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
>  
> +	if (val2 != 0)
> +		return -EINVAL;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
