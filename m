Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60619 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162088AbbBDSkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:55 -0500
Message-ID: <54D257AF.60407@kernel.org>
Date: Wed, 04 Feb 2015 17:32:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ak8975: fix AK09911 dependencies
References: <7968545.0Cq9DcaG85@wuerfel>
In-Reply-To: <7968545.0Cq9DcaG85@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/01/15 13:58, Arnd Bergmann wrote:
> ak8975 depends on I2C and GPIOLIB, so any symbols that selects
> ak8975 must have the same dependency, or we get build errors:
> 
> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
> drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
>   ^
> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
> drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_write_byte_data(data->client,
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 57e73a423b1e85 ("iio: ak8975: add ak09911 and ak09912 support")
Sorry, I failed to register this was present in the linux-next tree rather than mainline
where at least the i2c dependency is present).  Given timing, will have to wait until
after the merge windows to send this now (last pull request for the merge has gone
to Greg)

Will fixup in a couple of weeks,

Jonathan
> ---
> I found this recent regression doing ARM randconfig builds, please apply
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 4c7a4c52dd06..a5d6de72c523 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -18,6 +18,8 @@ config AK8975
>  
>  config AK09911
>  	tristate "Asahi Kasei AK09911 3-axis Compass"
> +	depends on I2C
> +	depends on GPIOLIB
>  	select AK8975
>  	help
>  	  Deprecated: AK09911 is now supported by AK8975 driver.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

