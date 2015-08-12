Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1089 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933534AbbHLI2L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 04:28:11 -0400
Message-ID: <55CB0396.2050303@metafoo.de>
Date: Wed, 12 Aug 2015 10:28:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: sdliyong@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: hmc5843: Set iio name dynamically based
 on i2c name
References: <1439367630-8964-1-git-send-email-sdliyong@gmail.com>
In-Reply-To: <1439367630-8964-1-git-send-email-sdliyong@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/2015 10:20 AM, sdliyong@gmail.com wrote:
> From: Yong Li <sdliyong@gmail.com>
> 
> Load the driver using the below command:
> echo hmc5983 0x1e > /sys/bus/i2c/devices/i2c-?/new_device
> 
> In sysfs, the iio name is hmc5843, however the i2c name is hmc5983,
> they are inconsistent.
> 
> With this patch, the iio name will be the same as the i2c device name
> 
> Signed-off-by: Yong Li <sdliyong@gmail.com>
> ---
>  drivers/staging/iio/magnetometer/hmc5843_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> index ff08667..3b03644 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> @@ -59,6 +59,7 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
>  static int hmc5843_i2c_probe(struct i2c_client *cli,
>  			     const struct i2c_device_id *id)
>  {
> +	cli->dev.driver->name = id->name;

You are overwriting a the name of the driver, which is a struct that is
shared between all instances of the device which specific data from one
device. That is most certainly not correct.

Update hmc5843_common_probe() and add a parameter that takes the name for
the device and then pass the id->name when the function is called.

>  	return hmc5843_common_probe(&cli->dev,
>  			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
>  			id->driver_data);
> 

