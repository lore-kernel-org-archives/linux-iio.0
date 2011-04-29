Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45789 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1D2MNU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:13:20 -0400
Message-ID: <4DBAABE8.7000900@cam.ac.uk>
Date: Fri, 29 Apr 2011 13:15:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 6/6] IIO: GYRO: ADXRS450: Don't exit probe, in case the
 power on default is not met.
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com> <1304074721-18159-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-6-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/29/11 11:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> If the part get's probed twice without hard reset in between, the power on default
> register read-back can't be met. This shouldn't cause the second probe to fail.
> So warn but don't exit.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/gyro/adxrs450_core.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
> index e71b91c..7a9d7c2 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -278,11 +278,9 @@ static int adxrs450_initial_setup(struct adxrs450_state *st)
>  	ret = adxrs450_spi_initial(st, &t, 1);
>  	if (ret)
>  		return ret;
> -	if (t != 0x01) {
> -		dev_err(&st->us->dev, "The initial response is not correct!\n");
> -		return -ENODEV;
> -
> -	}
> +	if (t != 0x01)
> +		dev_warn(&st->us->dev, "The initial power on response "
> +			 "is not correct! Restart without reset?\n");
>  
>  	msleep(ADXRS450_STARTUP_DELAY);
>  	ret = adxrs450_spi_initial(st, &t, 0);

