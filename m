Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35862 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbcEDOju (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:39:50 -0400
Subject: Re: [PATCH 01/13] iio: health/afe440x: Fix kernel-doc format
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
 <1462135023-14445-2-git-send-email-afd@ti.com>
Cc: linux-iio@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3597f852-8c82-3ae1-d6a1-d82ac0dceae2@kernel.org>
Date: Wed, 4 May 2016 10:58:32 +0100
MIME-Version: 1.0
In-Reply-To: <1462135023-14445-2-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/16 21:36, Andrew F. Davis wrote:
> Fix kernel-doc formatting for structs, and while we are making little
> fixes, clarify the module description and update the copywrite.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Applied to the togreg branch of iio.git - to be pushed out in a day or two
as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/health/afe4403.c | 18 +++++++++---------
>  drivers/iio/health/afe4404.c | 16 ++++++++--------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 88e43f8..2094113 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -1,7 +1,7 @@
>  /*
>   * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
>   *
> - * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
>   *	Andrew F. Davis <afd@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -103,13 +103,13 @@
>  #define AFE4403_TIAGAIN_RES_NONE	0x7
>  
>  /**
> - * struct afe4403_data
> - * @dev - Device structure
> - * @spi - SPI device handle
> - * @regmap - Register map of the device
> - * @regulator - Pointer to the regulator for the IC
> - * @trig - IIO trigger for this device
> - * @irq - ADC_RDY line interrupt number
> + * struct afe4403_data - AFE4403 device instance data
> + * @dev: Device structure
> + * @spi: SPI device handle
> + * @regmap: Register map of the device
> + * @regulator: Pointer to the regulator for the IC
> + * @trig: IIO trigger for this device
> + * @irq: ADC_RDY line interrupt number
>   */
>  struct afe4403_data {
>  	struct device *dev;
> @@ -704,5 +704,5 @@ static struct spi_driver afe4403_spi_driver = {
>  module_spi_driver(afe4403_spi_driver);
>  
>  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> -MODULE_DESCRIPTION("TI AFE4403 Heart Rate and Pulse Oximeter");
> +MODULE_DESCRIPTION("TI AFE4403 Heart Rate Monitor and Pulse Oximeter AFE");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 5096a46..7127d03 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -1,7 +1,7 @@
>  /*
>   * AFE4404 Heart Rate Monitors and Low-Cost Pulse Oximeters
>   *
> - * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
>   *	Andrew F. Davis <afd@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -106,12 +106,12 @@
>  #define AFE4404_TIA_GAIN_RES_2_M	0x7
>  
>  /**
> - * struct afe4404_data
> - * @dev - Device structure
> - * @regmap - Register map of the device
> - * @regulator - Pointer to the regulator for the IC
> - * @trig - IIO trigger for this device
> - * @irq - ADC_RDY line interrupt number
> + * struct afe4404_data - AFE4404 device instance data
> + * @dev: Device structure
> + * @regmap: Register map of the device
> + * @regulator: Pointer to the regulator for the IC
> + * @trig: IIO trigger for this device
> + * @irq: ADC_RDY line interrupt number
>   */
>  struct afe4404_data {
>  	struct device *dev;
> @@ -675,5 +675,5 @@ static struct i2c_driver afe4404_i2c_driver = {
>  module_i2c_driver(afe4404_i2c_driver);
>  
>  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> -MODULE_DESCRIPTION("TI AFE4404 Heart Rate and Pulse Oximeter");
> +MODULE_DESCRIPTION("TI AFE4404 Heart Rate Monitor and Pulse Oximeter AFE");
>  MODULE_LICENSE("GPL v2");
> 

