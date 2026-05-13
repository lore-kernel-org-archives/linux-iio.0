Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38533451BA;
	Wed, 13 May 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681749; cv=none; b=N7mmWR9WA90FP7GzvYnJwTDQjZD1AdMKJBXT/Xk+grHZ3PBce7ipEKK3ylin2tdbHaui5jwMuOF8VERvvAxgukPK07NKTVOKPqXmiHwCu8kwYkq/KT/QllC0572F2kGUxl0Ze1XmpneBcjBc/pwTg9Dtec22IvVw/sNlZ+wtvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681749; c=relaxed/simple;
	bh=AB+vxV1pQc0hUy3u/xhnUS6AlF5DDT962iXFGB+wIZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poxyAY3f3pWq/bmipSFu7pTnZv5643KF0bW1nnaLi00y81Gv1u8OH+oI/ad1IYGF/hAWslQZcOSAlFdDugnFPxMgCfTcj319AqADEQf7dFvgaWnro5mvCIyGYQfcK5mMDDiXTw+FTPgdFok9623/cTmSj1GDu06v8GIQ7sDU/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTwxPgWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTwxPgWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBC2C19425;
	Wed, 13 May 2026 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681747;
	bh=AB+vxV1pQc0hUy3u/xhnUS6AlF5DDT962iXFGB+wIZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTwxPgWQFwiTmnJ4+Rq/7ZaEpzfxB7Jlro9FRIPX4ZpwhorJ0rUExcz2zMNqIVW9b
	 HwTOepRuOn71FLXnIYWStKnAiuSwaS+9FdSwvkxz7plIGHv9b0Jljzxg6wPAh/XIyh
	 qh8lYxIjgNtFRfOGjrtl6ZsvCnReFg5UGTrdSweaXJdlDCimF0yqhSTPJUeuqp4zpg
	 ImCaLvYuiHOMx1Krs1dR1pKteJImQzEzw6UDs/FXt8dGN5IMlxRT/xw+qXXeW6qM1r
	 wn906G68gpT8mVjeqNUDwBrCFK+RHvCSb50nLuCO4+1bR5p/Jau8uXXofW3zUYXbH5
	 2hhffj/qwPsuw==
Date: Wed, 13 May 2026 15:15:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: arthur.becker@sentec.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6040: add suspend/resume support
Message-ID: <20260513151539.48b0207c@jic23-huawei>
In-Reply-To: <20260513094536.8038-1-sozdayvek@gmail.com>
References: <20260513094536.8038-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 14:45:36 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> The VEML6040 RGBW light sensor stays in auto-measurement mode at all
> times once probed, drawing its full active current (~200 uA per
> Vishay VEML6040 datasheet, Doc# 84276 Rev. 1.7). On system suspend
> there is no need to keep the sensor running.
> 
> Add system sleep PM callbacks that toggle the SD (shutdown) bit in
> CONF register 00H to put the chip into shutdown on suspend and back
> into normal operation on resume. The bit semantics are documented in
> the datasheet Tables 2-1 and 2-2.
> 
> The existing veml6040_shutdown_action() is unchanged; it still runs
> on module unload to leave the chip shut down.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Hi Stepan

Suspend / resume tend to be a little non trivial to add and datasheets
are sometimes less than perfect in describing powerdown modes, so can
I confirm: Do you have one of these that you are testing this with?

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml6040.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
> index f563f9f0e..ffd0a2a70 100644
> --- a/drivers/iio/light/veml6040.c
> +++ b/drivers/iio/light/veml6040.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  
>  /* VEML6040 Configuration Registers
> @@ -201,6 +202,32 @@ static void veml6040_shutdown_action(void *data)
>  			   VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
>  }
>  
> +/*
> + * Per Vishay VEML6040 datasheet (Doc# 84276 Rev. 1.7), Table 2-1 and
> + * Table 2-2, the SD bit in CONF register 00H controls chip shutdown:
> + * SD = 1 disables the color sensor, SD = 0 re-enables it.
> + */
> +static int veml6040_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct veml6040_data *data = iio_priv(indio_dev);
> +
> +	return regmap_update_bits(data->regmap, VEML6040_CONF_REG,
> +				  VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
> +}
> +
> +static int veml6040_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

dev_get_drvdata() rather than going in circles.  It's get of 'implicit'
knowledge that works for i2c sequences like this so most instances of what
you have here got ripped out years ago.  I've never really like the missbalance
and would love to get rid of i2c_set_clientdata() but such is life!


> +	struct veml6040_data *data = iio_priv(indio_dev);
> +
> +	return regmap_update_bits(data->regmap, VEML6040_CONF_REG,
> +				  VEML6040_CONF_SD_MSK, 0);
Andy pointed out regmap_clear_bits() is handy here and set_bits above.

> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(veml6040_pm_ops, veml6040_suspend,
> +				veml6040_resume);
> +
>  static int veml6040_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -271,6 +298,7 @@ static struct i2c_driver veml6040_driver = {
>  	.driver = {
>  		.name = "veml6040",
>  		.of_match_table = veml6040_of_match,
> +		.pm = pm_sleep_ptr(&veml6040_pm_ops),
>  	},
>  };
>  module_i2c_driver(veml6040_driver);

