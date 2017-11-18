Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965833AbdKRPyw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Nov 2017 10:54:52 -0500
Date: Sat, 18 Nov 2017 15:54:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] iio: adc/accel: Fix up module licenses
Message-ID: <20171118155448.34031532@archlinux>
In-Reply-To: <20171113102955.5257-1-linus.walleij@linaro.org>
References: <20171113102955.5257-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 13 Nov 2017 11:29:55 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The module license checker complains about these two so just fix
> it up. They are both GPLv2, both written by me or using code
> I extracted while refactoring from the GPLv2 drivers.
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git which will probably be be pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxsd9-i2c.c      | 3 +++
>  drivers/iio/adc/qcom-vadc-common.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 98fbb628d5bd..38411e1c155b 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -63,3 +63,6 @@ static struct i2c_driver kxsd9_i2c_driver = {
>  	.id_table	= kxsd9_i2c_id,
>  };
>  module_i2c_driver(kxsd9_i2c_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("KXSD9 accelerometer I2C interface");
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 47d24ae5462f..d249ce643e48 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -229,3 +229,6 @@ int qcom_vadc_decimation_from_dt(u32 value)
>  	return __ffs64(value / VADC_DECIMATION_MIN);
>  }
>  EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm ADC common functionality");

