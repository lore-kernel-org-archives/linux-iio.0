Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41308 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbcK0Laj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:30:39 -0500
Subject: Re: [PATCH 1/2] iio: adis1620x: Fix mixed up device descriptions
To: Reto Schneider <reto@reto-schneider.ch>,
        linux-kernel@vger.kernel.org
References: <b9c4b9f8-0c6a-3fb6-18bb-9a325cebeb09@reto-schneider.ch>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6743aa3f-ad67-2b0e-043b-e42d8d0fe437@kernel.org>
Date: Sun, 27 Nov 2016 11:30:37 +0000
MIME-Version: 1.0
In-Reply-To: <b9c4b9f8-0c6a-3fb6-18bb-9a325cebeb09@reto-schneider.ch>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/11/16 00:40, Reto Schneider wrote:
> From: Reto Schneider <code@reto-schneider.ch>
> Date: Sun, 20 Nov 2016 22:11:24 +0100
> Subject: [PATCH 1/2] iio: adis1620x: Fix mixed up device descriptions
> 
> The module descriptions for the ADIS 16201, 16203 and 16209 drivers do not
> match the actual function of the devices. Update them accordingly to fix
> this.
> 
> Signed-off-by: Reto Schneider <code@reto-schneider.ch>
Applied to the togreg branch of iio.git. Initially pushed out as testing where it'll
be ignored by the autobuilders ;)

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201_core.c | 4 ++--
>  drivers/staging/iio/accel/adis16203_core.c | 4 ++--
>  drivers/staging/iio/accel/adis16209_core.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 6f3f8ff..7963d4a 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -1,5 +1,5 @@
>  /*
> - * ADIS16201 Programmable Digital Vibration Sensor driver
> + * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
>   *
>   * Copyright 2010 Analog Devices Inc.
>   *
> @@ -243,6 +243,6 @@ static struct spi_driver adis16201_driver = {
>  module_spi_driver(adis16201_driver);
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16201 Programmable Digital Vibration Sensor driver");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("spi:adis16201");
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> index c706717..f32c900 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -1,5 +1,5 @@
>  /*
> - * ADIS16203 Programmable Digital Vibration Sensor driver
> + * ADIS16203 Programmable 360 Degrees Inclinometer
>   *
>   * Copyright 2030 Analog Devices Inc.
>   *
> @@ -211,6 +211,6 @@ static struct spi_driver adis16203_driver = {
>  module_spi_driver(adis16203_driver);
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable Digital Vibration Sensor driver");
> +MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("spi:adis16203");
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index 8dbad58..a599e19 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -1,5 +1,5 @@
>  /*
> - * ADIS16209 Programmable Digital Vibration Sensor driver
> + * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
>   *
>   * Copyright 2010 Analog Devices Inc.
>   *
> @@ -243,6 +243,6 @@ static struct spi_driver adis16209_driver = {
>  module_spi_driver(adis16209_driver);
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16209 Digital Vibration Sensor driver");
> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("spi:adis16209");
> 

