Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45435 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1D2MMP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:12:15 -0400
Message-ID: <4DBAABA6.8090807@cam.ac.uk>
Date: Fri, 29 Apr 2011 13:14:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 5/6] IIO: GYRO: ADXRS450: Fix sign issues, properly shift
 results and limit values
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com> <1304074721-18159-5-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-5-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/29/11 11:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> RATE and QUADRATURE_CORRECTION data is formatted as a twos complement number,
> and therefore must be handled as type signed short.
> 
> TEMP result should be properly shifted.
> 
> Dynamic Null Correction is a 10-bit signed number.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/gyro/adxrs450_core.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
> index d73acff..e71b91c 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -126,7 +126,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
>   * @dev: device associated with child of actual iio_dev
>   * @val: somewhere to pass back the value read
>   **/
> -static int adxrs450_spi_sensor_data(struct device *dev, u16 *val)
> +static int adxrs450_spi_sensor_data(struct device *dev, s16 *val)
>  {
>  	struct spi_message msg;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -217,7 +217,7 @@ static ssize_t adxrs450_read_temp(struct device *dev,
>  			&t);
>  	if (ret)
>  		return ret;
> -	return sprintf(buf, "%d\n", t);
> +	return sprintf(buf, "%d\n", t >> 7);
>  }
>  
>  static ssize_t adxrs450_read_quad(struct device *dev,
> @@ -225,7 +225,7 @@ static ssize_t adxrs450_read_quad(struct device *dev,
>  		char *buf)
>  {
>  	int ret;
> -	u16 t;
> +	s16 t;
>  	ret = adxrs450_spi_read_reg_16(dev,
>  			ADXRS450_QUAD1,
>  			&t);
> @@ -247,7 +247,7 @@ static ssize_t adxrs450_write_dnc(struct device *dev,
>  		goto error_ret;
>  	ret = adxrs450_spi_write_reg_16(dev,
>  			ADXRS450_DNC1,
> -			val);
> +			val & 0x3FF);
>  error_ret:
>  	return ret ? ret : len;
>  }
> @@ -257,7 +257,7 @@ static ssize_t adxrs450_read_sensor_data(struct device *dev,
>  		char *buf)
>  {
>  	int ret;
> -	u16 t;
> +	s16 t;
>  
>  	ret = adxrs450_spi_sensor_data(dev, &t);
>  	if (ret)

