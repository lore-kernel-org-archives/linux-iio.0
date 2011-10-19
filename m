Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58221 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1JSL4S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 07:56:18 -0400
Message-ID: <4E9EBAE5.7090300@cam.ac.uk>
Date: Wed, 19 Oct 2011 12:56:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: cdc: Fix pushed event code - Typo, should be IIO_CAPACITANCE.
References: <1319024389-14243-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1319024389-14243-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/11 12:39, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/cdc/ad7150.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index e185f0e..a761ca9 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -473,7 +473,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  	if ((int_status & AD7150_STATUS_OUT1) &&
>  	    !(chip->old_state & AD7150_STATUS_OUT1))
>  		iio_push_event(indio_dev,
> -			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
> @@ -481,7 +481,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
>  		 (chip->old_state & AD7150_STATUS_OUT1))
>  		iio_push_event(indio_dev,
> -			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),
> @@ -490,7 +490,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  	if ((int_status & AD7150_STATUS_OUT2) &&
>  	    !(chip->old_state & AD7150_STATUS_OUT2))
>  		iio_push_event(indio_dev,
> -			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
>  						    1,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_RISING),
> @@ -498,7 +498,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>  	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
>  		 (chip->old_state & AD7150_STATUS_OUT2))
>  		iio_push_event(indio_dev,
> -			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
>  						    1,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_FALLING),

