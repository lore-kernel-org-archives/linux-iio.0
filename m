Return-Path: <SRS0=Uw90=OT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C85C5CFFE
	for <linux-iio@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E6A20672
	for <linux-iio@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544476559;
	bh=9GohbqKgPU8laOMPjZ7Etub0cI9YW+au8XcbIT+sulA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2TwIATDMuxeYk1DId3h6Rq7OxP0WSyFJR/P91QvAJ+8uquE9wAvZ4Ud4htpdyazTG
	 NJEOKr4g5inQFfUh+8M07rJBZqmXePeTpbqjRsk679Ci1Iaqr1yb7ZTheUf+xo5dkE
	 u4yJZ9ZBDW2XoVAzTImxUt56Shiwkrz75rgV5iWY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E6A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeLJVPj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbeLJVPj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Dec 2018 16:15:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10432084C;
        Mon, 10 Dec 2018 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544476537;
        bh=9GohbqKgPU8laOMPjZ7Etub0cI9YW+au8XcbIT+sulA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zq1IHoqR595yWr4NVSJT+IA2LxWFcgYOE7F1kSDX1suHrpJWIY11E01p1j5xpIMdM
         u3BhFRVWzbXMLaAtZutBTjBIstQtHH38bB4s7fdKww3rEZ+ElbtjdLjxMxXkNRznNt
         bj70RC6HJIseOc/7ESG4i3ceDGnQxzdM0dKQpXsM=
Date:   Mon, 10 Dec 2018 21:15:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2] iio: bmi160: use all devm functions in probe
Message-ID: <20181210211534.35aef897@archlinux>
In-Reply-To: <20181210031455.2836-1-martin@martingkelly.com>
References: <20181210031455.2836-1-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  9 Dec 2018 19:14:55 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Currently, we're using the devm version of some but not all functions.
> Switch to the devm version of iio_triggered_buffer_setup and
> iio_device_register to simplify the code a bit and decrease the chance of
> bugs.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>

Great little tidy up. Thanks.  One little tweak. You missed the header so
I'll tidy that up as well.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.


> ---
> v2:
> - Use devm_add_action_or_reset to prevent device uninit prior to unregister.
> 
>  drivers/iio/imu/bmi160/bmi160_core.c | 38 +++++++++++++-----------------------
>  drivers/iio/imu/bmi160/bmi160_i2c.c  |  8 --------
>  drivers/iio/imu/bmi160/bmi160_spi.c  |  8 --------
>  3 files changed, 14 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index c85659ca9507..b10330b0f93f 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -542,10 +542,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  	return 0;
>  }
> 
> -static void bmi160_chip_uninit(struct bmi160_data *data)
> +static void bmi160_chip_uninit(void *data)
>  {
> -	bmi160_set_mode(data, BMI160_GYRO, false);
> -	bmi160_set_mode(data, BMI160_ACCEL, false);
> +	struct bmi160_data *bmi_data = data;
> +
> +	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
> +	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
>  }
> 
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> @@ -567,6 +569,10 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return ret;
> 
> +	ret = devm_add_action_or_reset(dev, bmi160_chip_uninit, data);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (!name && ACPI_HANDLE(dev))
>  		name = bmi160_match_acpi_device(dev);
> 
> @@ -577,35 +583,19 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmi160_info;
> 
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -					 bmi160_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      bmi160_trigger_handler, NULL);
>  	if (ret < 0)
> -		goto uninit;
> +		return ret;
> 
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret < 0)
> -		goto buffer_cleanup;
> +		return ret;
> 
>  	return 0;
> -buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -uninit:
> -	bmi160_chip_uninit(data);
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(bmi160_core_probe);
> 
> -void bmi160_core_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct bmi160_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	bmi160_chip_uninit(data);
> -}
> -EXPORT_SYMBOL_GPL(bmi160_core_remove);
> -
>  MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
>  MODULE_DESCRIPTION("Bosch BMI160 driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 155a31f72445..5b1f7e6af651 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -38,13 +38,6 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  	return bmi160_core_probe(&client->dev, regmap, name, false);
>  }
> 
> -static int bmi160_i2c_remove(struct i2c_client *client)
> -{
> -	bmi160_core_remove(&client->dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id bmi160_i2c_id[] = {
>  	{"bmi160", 0},
>  	{}
> @@ -72,7 +65,6 @@ static struct i2c_driver bmi160_i2c_driver = {
>  		.of_match_table		= of_match_ptr(bmi160_of_match),
>  	},
>  	.probe		= bmi160_i2c_probe,
> -	.remove		= bmi160_i2c_remove,
>  	.id_table	= bmi160_i2c_id,
>  };
>  module_i2c_driver(bmi160_i2c_driver);
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index d34dfdfd1a7d..e521ad14eeac 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -29,13 +29,6 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
>  }
> 
> -static int bmi160_spi_remove(struct spi_device *spi)
> -{
> -	bmi160_core_remove(&spi->dev);
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id bmi160_spi_id[] = {
>  	{"bmi160", 0},
>  	{}
> @@ -58,7 +51,6 @@ MODULE_DEVICE_TABLE(of, bmi160_of_match);
> 
>  static struct spi_driver bmi160_spi_driver = {
>  	.probe		= bmi160_spi_probe,
> -	.remove		= bmi160_spi_remove,
>  	.id_table	= bmi160_spi_id,
>  	.driver = {
>  		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
> --
> 2.11.0
> 

