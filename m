Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60607 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1FPJCg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2011 05:02:36 -0400
Message-ID: <4DF9C88F.5070609@cam.ac.uk>
Date: Thu, 16 Jun 2011 10:10:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: driverdevel <devel@driverdev.osuosl.org>, gregkh <greg@kroah.com>,
	linux-iio@vger.kernel.org, torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3.0-rc3] staging: fix iio builds when IIO_RING_BUFFER
 is not enabled
References: <20110614150018.fc7d5516.randy.dunlap@oracle.com>
In-Reply-To: <20110614150018.fc7d5516.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/14/11 23:00, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
Ooops, my mess up, sorry about that.  Thanks Randy.
> 
> Fix build by moving enum list outside of
> #ifdef CONFIG_IIO_RING_BUFFER.
> 
> drivers/staging/iio/accel/adis16201_core.c:413: error: 'ADIS16201_SCAN_SUPPLY' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:417: error: 'ADIS16201_SCAN_TEMP' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:422: error: 'ADIS16201_SCAN_ACC_X' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:427: error: 'ADIS16201_SCAN_ACC_Y' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:432: error: 'ADIS16201_SCAN_AUX_ADC' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:436: error: 'ADIS16201_SCAN_INCLI_X' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16201_core.c:441: error: 'ADIS16201_SCAN_INCLI_Y' undeclared here (not in a function)
> 
> vers/staging/iio/accel/adis16203_core.c:374: error: 'ADIS16203_SCAN_SUPPLY' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16203_core.c:378: error: 'ADIS16203_SCAN_AUX_ADC' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16203_core.c:382: error: 'ADIS16203_SCAN_INCLI_X' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16203_core.c:388: error: 'ADIS16203_SCAN_INCLI_Y' undeclared here (not in a function)
> drivers/staging/iio/accel/adis16203_core.c:392: error: 'ADIS16203_SCAN_TEMP' undeclared here (not in a function)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/staging/iio/accel/adis16201.h |    2 +-
>  drivers/staging/iio/accel/adis16203.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- lnx-30-rc3.orig/drivers/staging/iio/accel/adis16201.h
> +++ lnx-30-rc3/drivers/staging/iio/accel/adis16201.h
> @@ -81,7 +81,6 @@ struct adis16201_state {
>  
>  int adis16201_set_irq(struct iio_dev *indio_dev, bool enable);
>  
> -#ifdef CONFIG_IIO_RING_BUFFER
>  enum adis16201_scan {
>  	ADIS16201_SCAN_SUPPLY,
>  	ADIS16201_SCAN_ACC_X,
> @@ -92,6 +91,7 @@ enum adis16201_scan {
>  	ADIS16201_SCAN_INCLI_Y,
>  };
>  
> +#ifdef CONFIG_IIO_RING_BUFFER
>  void adis16201_remove_trigger(struct iio_dev *indio_dev);
>  int adis16201_probe_trigger(struct iio_dev *indio_dev);
>  
> --- lnx-30-rc3.orig/drivers/staging/iio/accel/adis16203.h
> +++ lnx-30-rc3/drivers/staging/iio/accel/adis16203.h
> @@ -76,7 +76,6 @@ struct adis16203_state {
>  
>  int adis16203_set_irq(struct iio_dev *indio_dev, bool enable);
>  
> -#ifdef CONFIG_IIO_RING_BUFFER
>  enum adis16203_scan {
>  	ADIS16203_SCAN_SUPPLY,
>  	ADIS16203_SCAN_AUX_ADC,
> @@ -85,6 +84,7 @@ enum adis16203_scan {
>  	ADIS16203_SCAN_INCLI_Y,
>  };
>  
> +#ifdef CONFIG_IIO_RING_BUFFER
>  void adis16203_remove_trigger(struct iio_dev *indio_dev);
>  int adis16203_probe_trigger(struct iio_dev *indio_dev);
>  
> 

