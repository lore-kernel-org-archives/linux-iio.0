Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34191 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab1HaLGR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:06:17 -0400
Message-ID: <4E5E1796.5040107@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:14:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 01/12] iio: ad7291: fix channel mapping
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> ideally in_voltageX_raw should map to AD7291 VINX.
> 
Indeed, that's more logical.
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Merged to iio-blue.
> ---
>  drivers/staging/iio/adc/ad7291.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index b6be672..32944f3 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -434,7 +434,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  			}
>  			/* Enable this channel alone */
>  			regval = chip->command & (~AD7291_VOLTAGE_MASK);
> -			regval |= 1 << (chan->channel + 8);
> +			regval |= 1 << (15 - chan->channel);
>  			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
>  			if (ret < 0) {
>  				mutex_unlock(&chip->state_lock);

