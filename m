Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7F2C11DE;
	Mon, 20 Apr 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687105; cv=none; b=RGMgNrwc/ZaAdpHAEsb+aLC23hNLyhFLwx184kHhdU8L7REXMv7g29Bj6NjyKlFgCaDOCw+XaDF8PsNppSc/KA1ExdGoNi2VNlgd5sBbED5KSsaNk89JZ5+Hdyn56qwHlT4CV2Pb4h6VITzXMJIhADCrTtSawGMWJPMEBgVu8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687105; c=relaxed/simple;
	bh=893zaj1e2JM2woVFdRnYt7YiI+4n2cKbt2gdPIN+waI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhHU+O2HOzqXPGmOGb9cLiYZk95nld2tnKJOZfxmLhUlWxKgW7G/kJMmcVOIHtjX9MdG57s6lydyhkRRbOoM/K78q1HY8XNCvn75tNVBUKgvRSUcsqbuq2kRMSuREKr2saTMi81LQLh5boCFIsSH6YOdoryu8/Gx5bHEBHMPjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HosL66xF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HosL66xF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2D8C19425;
	Mon, 20 Apr 2026 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776687104;
	bh=893zaj1e2JM2woVFdRnYt7YiI+4n2cKbt2gdPIN+waI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HosL66xFEEhF4TbbTXaBQ2l0jOY9SNuenY6t7SDP7YNS6dgSq3FH8GUYG/u9+tPEF
	 9GzX4KL5FU1sSpJYf6uaLyXqIQi8hvsrRoYvizo4yBqlr0OBcMv4SNWhXyDZCcSPUD
	 cQHagZD8cYSTHiY6oMToyr0RUzwt7MsB3BFJeiDF/A3V8dkfyAGAk3CdEnBU5JdrwO
	 8OCn+SpdazeMwFm97XwWmC9fn4qWtHJHSCerLS/0gZjIAZwkmQxQok9THZe97wBV7K
	 c5NsxDWzygQGTKUZguxTwd+we5dFtC11LkGIFVzP1b2rxS9NE0t8crooXyx7/LuvFe
	 x1C66U4uTmIaA==
Date: Mon, 20 Apr 2026 13:11:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <20260420131136.6f3857dd@jic23-huawei>
In-Reply-To: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 15:33:38 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Initialize vref1_uV variable to 0 before calling
> mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
> uninitialized value when have_ext_vref1 is false.
> 
> Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  drivers/iio/dac/mcp47feb02.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index faccb804a5ed548088aaf83266b16ed45a92916c..efd4847913e46a4fa1b671aa9c5bd3e1430406b7 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1095,9 +1095,10 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  {
>  	const struct mcp47feb02_features *chip_features;
>  	struct device *dev = &client->dev;
> +	int vdd_uV, vref_uV, vref1_uV;
>  	struct mcp47feb02_data *data;
>  	struct iio_dev *indio_dev;
> -	int vref1_uV, vref_uV, vdd_uV, ret;
I haven't caught up with the rest of the discussion yet, but this change
seems to be superficial style stuff. Doesn't belong in a fix patch.

Thanks,

Jonathan

> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1146,13 +1147,13 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  		dev_dbg(dev, "Vref is unavailable.\n");
>  	}
>  
> +	vref1_uV = 0;
>  	if (chip_features->have_ext_vref1) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
>  		if (ret > 0) {
>  			vref1_uV = ret;
>  			data->use_vref1 = true;
>  		} else {
> -			vref1_uV = 0;
>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
>  			dev_dbg(dev, "Vref1 is unavailable.\n");
>  		}
> 
> ---
> base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
> change-id: 20260414-mcp47feb02-fix4-614de9334f22
> 
> Best regards,

