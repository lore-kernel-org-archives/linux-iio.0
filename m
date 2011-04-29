Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37970 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab1D2MJv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:09:51 -0400
Message-ID: <4DBAAB16.3020208@cam.ac.uk>
Date: Fri, 29 Apr 2011 13:12:06 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 4/6] IIO: GYRO: ADXRS450: enforce sequential transfer
 delay of at least 0.1ms
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com> <1304074721-18159-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/29/11 11:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Fair enough. Nasty hardware requirement of the day award goes to....
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/gyro/adxrs450_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
> index 5671276..d73acff 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -116,6 +116,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
>  	if (ret)
>  		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
>  				reg_address);
> +	msleep(1); /* enforce sequential transfer delay 0.1ms */
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }

