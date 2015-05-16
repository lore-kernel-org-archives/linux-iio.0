Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53088 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076AbbEPKJa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2015 06:09:30 -0400
Message-ID: <55571756.2070909@kernel.org>
Date: Sat, 16 May 2015 11:09:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, pmeerw@pmeerw.net
CC: srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: ltr501: Fix proximity threshold boundary
 check
References: <7acfd1ed6ffbaab2f64e77ef1959c7ce86161173.1431732634.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7acfd1ed6ffbaab2f64e77ef1959c7ce86161173.1431732634.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/05/15 00:42, Kuppuswamy Sathyanarayanan wrote:
> Currently, proximity sensor boundary check is done
> inside the switch block but outside the case
> statement.Since this code will never get executed,
> moved the check outside the switch case statement.
> 
>    867          case IIO_PROXIMITY:
>    868                  switch (dir) {
>    // Following line has been moved outside the switch block.
>    869                  if (val > LTR501_PS_THRESH_MASK)
>    870                          return -EINVAL;
>    871                  case IIO_EV_DIR_RISING:
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index ca4bf47..417369b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -865,9 +865,9 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_PROXIMITY:
> -		switch (dir) {
>  		if (val > LTR501_PS_THRESH_MASK)
>  			return -EINVAL;
> +		switch (dir) {
>  		case IIO_EV_DIR_RISING:
>  			mutex_lock(&data->lock_ps);
>  			ret = regmap_bulk_write(data->regmap,
> 

