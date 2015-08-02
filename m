Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44707 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbHBPjM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 11:39:12 -0400
Subject: Re: [PATCH 17/27] iio: Export OF module alias information in missing
 drivers
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
 <1438273132-20926-18-git-send-email-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE399E.8070908@kernel.org>
Date: Sun, 2 Aug 2015 16:39:10 +0100
MIME-Version: 1.0
In-Reply-To: <1438273132-20926-18-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/07/15 17:18, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So technically there's no need for a driver to export
> the OF table since currently it's not used.
> 
> In fact, the I2C device ID table is mandatory for I2C drivers since
> a i2c_device_id is passed to the driver's probe function even if the
> I2C core used the OF table to match the driver.
> 
> And since the I2C core uses different tables, OF-only drivers needs to
> have duplicated data that has to be kept in sync and also the dev node
> compatible manufacturer prefix is stripped when reporting the MODALIAS.
> 
> To avoid the above, the I2C core behavior may be changed in the future
> to not require an I2C device table for OF-only drivers and report the
> OF module alias. So, it's better to also export the OF table to prevent
> breaking module autoloading if that happens.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it,

Thanks

Jonathan
> 
> ---
> 
>  drivers/iio/accel/mma8452.c      | 1 +
>  drivers/iio/light/cm32181.c      | 1 +
>  drivers/iio/light/cm3232.c       | 1 +
>  drivers/iio/light/cm36651.c      | 1 +
>  drivers/iio/light/gp2ap020a00f.c | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 13ea1ea23328..b7ad3dce6ff4 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -968,6 +968,7 @@ static const struct of_device_id mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8452" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
>  
>  static struct i2c_driver mma8452_driver = {
>  	.driver = {
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 1c0de2f8885d..d6fd0dace74f 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -353,6 +353,7 @@ static const struct of_device_id cm32181_of_match[] = {
>  	{ .compatible = "capella,cm32181" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, cm32181_of_match);
>  
>  static struct i2c_driver cm32181_driver = {
>  	.driver = {
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 1b508c65877c..fe89b6823217 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -417,6 +417,7 @@ static const struct of_device_id cm3232_of_match[] = {
>  	{.compatible = "capella,cm3232"},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, cm3232_of_match);
>  
>  static struct i2c_driver cm3232_driver = {
>  	.driver = {
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 2a39e141e90c..c8d7b5ea7e78 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -731,6 +731,7 @@ static const struct of_device_id cm36651_of_match[] = {
>  	{ .compatible = "capella,cm36651" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, cm36651_of_match);
>  
>  static struct i2c_driver cm36651_driver = {
>  	.driver = {
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 0334a814b5eb..6d41086f7c64 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1634,6 +1634,7 @@ static const struct of_device_id gp2ap020a00f_of_match[] = {
>  	{ .compatible = "sharp,gp2ap020a00f" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
>  #endif
>  
>  static struct i2c_driver gp2ap020a00f_driver = {
> 

