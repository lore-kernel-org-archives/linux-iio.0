Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42506 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbDZSoB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:44:01 -0400
Message-ID: <553D31EF.40909@kernel.org>
Date: Sun, 26 Apr 2015 19:43:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 02/17] iio: accel: mma9553: check input value for activity
 period
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> When setting the activity period, the value introduced by
> the user in sysfs is not checked for validity.
> 
> Add a boundary check so that only allowed values are
> reported as successfully written to device.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
hmm.  Not that critical as it just gives miss information to
userspace that is writing an incorrect value.  Still it's small
so I've taken it in the fixes-togreg branch.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma9553.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 607dbfc..03120fb 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -54,6 +54,7 @@
>  #define MMA9553_MASK_CONF_STEPCOALESCE		GENMASK(7, 0)
>  
>  #define MMA9553_REG_CONF_ACTTHD			0x0E
> +#define MMA9553_MAX_ACTTHD			GENMASK(15, 0)
>  
>  /* Pedometer status registers (R-only) */
>  #define MMA9553_REG_STATUS			0x00
> @@ -869,6 +870,9 @@ static int mma9553_write_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_INFO_PERIOD:
>  		switch (chan->type) {
>  		case IIO_ACTIVITY:
> +			if (val < 0 || val > MMA9553_ACTIVITY_THD_TO_SEC(
> +			    MMA9553_MAX_ACTTHD))
> +				return -EINVAL;
>  			mutex_lock(&data->mutex);
>  			ret = mma9553_set_config(data, MMA9553_REG_CONF_ACTTHD,
>  						 &data->conf.actthd,
> 

