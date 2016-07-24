Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58860 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbcGXLmo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 07:42:44 -0400
Subject: Re: [PATCH] iio: adc: ad7793: use iio helper function to guarantee
 direct mode
To: Alison Schofield <amsfield22@gmail.com>
References: <20160718193513.GA3862@d830.WORKGROUP>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fd48bc76-6c82-62dd-6781-cb01d2cf5d16@kernel.org>
Date: Sun, 24 Jul 2016 12:42:42 +0100
MIME-Version: 1.0
In-Reply-To: <20160718193513.GA3862@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 20:35, Alison Schofield wrote:
> Replace the code that guarantees the device stays in direct mode
> with iio_device_claim_direct_mode() which does same.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the togreg branch of iio.git.
> ---

> This driver is not doing any error checking on the code I just wrapped
> in device_claim/release.  It first saves info to the global state and
> then writes it to a register, with no error checking. 
> 
> Does similar in both *write_raw, and *write_frequency.  
> 
> I could add error checking in another patch if it's desired. I don't have
> this sensor to verify.  Let me know if that would be welcome. Thanks!
I'd be keen to see this cleaned up.  Michael / Lars, can you easily test
such a change (or we could rely on it being simple enough that it shouldn't
be possible to get it wrong ;)
> 
> 
>  drivers/iio/adc/ad7793.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 847789b..e6706a0 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -519,11 +519,9 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
>  	int ret, i;
>  	unsigned int tmp;
>  
> -	mutex_lock(&indio_dev->mlock);
> -	if (iio_buffer_enabled(indio_dev)) {
> -		mutex_unlock(&indio_dev->mlock);
> -		return -EBUSY;
> -	}
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -548,7 +546,7 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
>  		ret = -EINVAL;
>  	}
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  }
>  
> 

