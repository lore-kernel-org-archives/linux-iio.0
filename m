Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:54481 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbAANqG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 1 Jan 2015 08:46:06 -0500
Message-ID: <54A54F91.3000403@gmx.de>
Date: Thu, 01 Jan 2015 14:45:53 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 02/10] iio: imu: kmx61: Don't ignore
 kmx61_set_power_state errors
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com> <1419340953-23161-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 23.12.2014 um 14:22:
> ..except while in an error handler, where there is nothing
> to be done anyway.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/imu/kmx61.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index fe0cee7..e9cbd91 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -830,7 +830,12 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  		}
>  		mutex_lock(&data->lock);
>  
> -		kmx61_set_power_state(data, true, chan->address);
> +		ret = kmx61_set_power_state(data, true, chan->address);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +
>  		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
>  		if (ret < 0) {
>  			kmx61_set_power_state(data, false, chan->address);
> @@ -839,9 +844,11 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  		}
>  		*val = sign_extend32(ret >> chan->scan_type.shift,
>  				     chan->scan_type.realbits - 1);
> -		kmx61_set_power_state(data, false, chan->address);
> +		ret = kmx61_set_power_state(data, false, chan->address);
>  
>  		mutex_unlock(&data->lock);
> +		if (ret)
> +			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> 

