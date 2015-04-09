Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51611 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbbDILp7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:45:59 -0400
Message-ID: <5526667C.5020003@kernel.org>
Date: Thu, 09 Apr 2015 12:46:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iio: accel: mma9553: check input value for activity
 period
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-7-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-7-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> When setting the activity period, the value introduced by
> the user in sysfs is not checked for validity.
> 
> Add a boundary check so that only allowed values are
> reported as suuccesfully written to device.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Good point.  This one counts as a fix so put it early in the
reordered series.
> ---
>  drivers/iio/accel/mma9553.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 57868fb..96e4708 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -839,6 +839,9 @@ static int mma9553_write_event_value(struct iio_dev *indio_dev,
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

