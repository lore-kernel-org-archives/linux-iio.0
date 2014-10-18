Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51228 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaJRMLf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Oct 2014 08:11:35 -0400
Message-ID: <544258F2.5000405@kernel.org>
Date: Sat, 18 Oct 2014 13:11:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Send x, y and z motion separately
References: <1412958629-30776-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412958629-30776-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412958629-30776-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/14 17:30, Srinivas Pandruvada wrote:
> This chip is capable to identify motion across x, y and z axes. So
> send different events.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This is an odd mix of a true fix and change of functionality.  It probably wants
to be broken up into clearer sections.   We 'could' take this through
the fixes branch... I'm just not entirely sure if we want to.

I suppose it probably makes sense as it is an abi change and the driver
is just working it's way towards a mainline release.

Can't take it just yet via that route due to backlogged pull request.

J

> ---
>  drivers/iio/accel/bmc150-accel.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index fdb101c..352d959 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -44,6 +44,9 @@
>  
>  #define BMC150_ACCEL_REG_INT_STATUS_2		0x0B
>  #define BMC150_ACCEL_ANY_MOTION_MASK		0x07
> +#define BMC150_ACCEL_ANY_MOTION_BIT_X		BIT(0)
> +#define BMC150_ACCEL_ANY_MOTION_BIT_Y		BIT(1)
> +#define BMC150_ACCEL_ANY_MOTION_BIT_Z		BIT(2)
>  #define BMC150_ACCEL_ANY_MOTION_BIT_SIGN	BIT(3)
>  
>  #define BMC150_ACCEL_REG_PMU_LPW		0x11
> @@ -850,7 +853,7 @@ static const struct attribute_group bmc150_accel_attrs_group = {
>  
>  static const struct iio_event_spec bmc150_accel_event = {
>  		.type = IIO_EV_TYPE_ROC,
> -		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
> +		.dir = IIO_EV_DIR_EITHER,
T
>  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>  				 BIT(IIO_EV_INFO_ENABLE) |
>  				 BIT(IIO_EV_INFO_PERIOD)
> @@ -1097,12 +1100,26 @@ static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
>  	else
>  		dir = IIO_EV_DIR_RISING;
>  
> -	if (ret & BMC150_ACCEL_ANY_MOTION_MASK)
> +	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  							0,
> -							IIO_MOD_X_OR_Y_OR_Z,
> +							IIO_MOD_X,
>  							IIO_EV_TYPE_ROC,
> -							IIO_EV_DIR_EITHER),
> +							dir),
> +							data->timestamp);
> +	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +							0,
> +							IIO_MOD_Y,
> +							IIO_EV_TYPE_ROC,
> +							dir),
> +							data->timestamp);
> +	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +							0,
> +							IIO_MOD_Z,
> +							IIO_EV_TYPE_ROC,
> +							dir),
>  							data->timestamp);
>  ack_intr_status:
>  	if (!data->dready_trigger_on)
> 
