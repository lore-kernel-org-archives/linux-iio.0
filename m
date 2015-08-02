Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44689 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbHBPfV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 11:35:21 -0400
Subject: Re: [PATCH 03/27] iio: Export I2C module alias information in missing
 drivers
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
 <1438273132-20926-4-git-send-email-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE38B5.2060301@kernel.org>
Date: Sun, 2 Aug 2015 16:35:17 +0100
MIME-Version: 1.0
In-Reply-To: <1438273132-20926-4-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/07/15 17:18, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So the driver needs to export the I2C table and this
> be built into the module or udev won't have the necessary information
> to auto load the correct module when the device is added.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> 
> ---
> 
>  drivers/iio/accel/stk8312.c  | 1 +
>  drivers/iio/accel/stk8ba50.c | 1 +
>  drivers/iio/light/stk3310.c  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index c2bd1444d6da..a553736b6e51 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -662,6 +662,7 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
>  	{"STK8312", 0},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
>  
>  static const struct acpi_device_id stk8312_acpi_id[] = {
>  	{"STK8312", 0},
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 16cee637109b..80f77d8704b5 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -572,6 +572,7 @@ static const struct i2c_device_id stk8ba50_i2c_id[] = {
>  	{"stk8ba50", 0},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(i2c, stk8ba50_i2c_id);
>  
>  static const struct acpi_device_id stk8ba50_acpi_id[] = {
>  	{"STK8BA50", 0},
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 48ff7942fa00..993eb201148e 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -672,6 +672,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
>  	{"STK3311", 0},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
>  
>  static const struct acpi_device_id stk3310_acpi_id[] = {
>  	{"STK3310", 0},
> 

