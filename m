Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2D389E05;
	Mon, 20 Apr 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687718; cv=none; b=TAWcmzNoMqgTZwbyaVLackrTdMcDho/s/CGeuq1QylWQtfTzuz63S4aZl0HL/hiwkI7UrEWqekDrKliUf+u+gPAA5ZynhSS8AZCqAWmDEGBZe2BCkZUxRfSPjI6q3hiA1IBqvkqmi++TE1FupKOergC6BuGztVH7/+pRsOfeFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687718; c=relaxed/simple;
	bh=fmbF8m+zdfoTWRc4DTs8+j6cO4Jamz+R9xbjsP693V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBh0iALiQVPS4dQauZM3knjxC1xRRY9rx8YMt8eyJHIDMFmF7nXzUJF9ah/Th5QJU3bBI5OFRH1bJ27ZflWN0zCAXTJG5RQtJ43px4kRR5sb1bZCYkhreL22o27vshvztUYmYOhFWa7QDW+/lwSonUNKk2BmZ/CTZabZMhc2IvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atyYUwml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atyYUwml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546F8C2BCB4;
	Mon, 20 Apr 2026 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776687718;
	bh=fmbF8m+zdfoTWRc4DTs8+j6cO4Jamz+R9xbjsP693V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atyYUwmlLhjhgH08P1vHi2eIQYhicw31NbJ4cKl7jwtlzdLVxkXGlaw2guVREPX4t
	 dK9tC1ERSB6RSctAk1+S4W2II+A+qdS13i/z4vsTUcxsZ6nxI3oflAEMga6YMB3EAO
	 Wqm3DgKNY5FfdCQ2JHtqLygfQ7Iv6/+r2qa642Zci0lSfkA7TQQXBneoh3Gb+Gs9V7
	 IJ4zSMZQt18a2aiQQCNhBIytnDk14gEVTrGhIm34Ptf6ANCZ1RMGvLE5oOCKjc/tO5
	 sffH6hI6ObXJT9qbPK9uTGM1VkaB6CN4tXh4oFqPGeTXdeEyVwyusSXfO/4wRbu/XE
	 yRn7BMnp++OoA==
Date: Mon, 20 Apr 2026 13:21:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Message-ID: <20260420132149.2ed9f4b1@jic23-huawei>
In-Reply-To: <20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com>
References: <20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 11:04:12 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Ensure that if a device has Vref1 but reading the regulator returns an
> error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
> vref1_uV value.
Just to make it easier for folk to tell if this is critical or not:
Is it a real bug?  See my reply (just now) to v1.

Otherwise, same thing I just raised on v1.  Forgot to check if a new
version had come in today.

> 
> Also add a device_property_present() check for the Vref1 supply before
> reading the regulator.
> 
> Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v2:
> - return the reading regulator error to not use vref1_uV uninitialized in
>    mcp47feb02_init_ctrl_regs() call 
> - add device_property_present() check for the Vref1
> - Link to v1: https://lore.kernel.org/r/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com
> ---
>  drivers/iio/dac/mcp47feb02.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index faccb804a5ed548088aaf83266b16ed45a92916c..a876ed71ecdf101784e0f98668a1681a1cd19ed0 100644
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
Solution is fine but this change seems to be unrelated noise.

> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1146,16 +1147,16 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  		dev_dbg(dev, "Vref is unavailable.\n");
>  	}
>  
> -	if (chip_features->have_ext_vref1) {
> +	if (chip_features->have_ext_vref1 && device_property_present(dev, "vref1")) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> -		if (ret > 0) {
> -			vref1_uV = ret;
> -			data->use_vref1 = true;
> -		} else {
> -			vref1_uV = 0;
> -			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> -			dev_dbg(dev, "Vref1 is unavailable.\n");
> -		}
> +		if (ret < 0)
> +			return ret;
> +
> +		vref1_uV = ret;
> +		data->use_vref1 = true;
> +	} else {
> +		vref1_uV = 0;
> +		dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
>  	}
>  
>  	ret = mcp47feb02_init_ctrl_regs(data);
> 
> ---
> base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
> change-id: 20260414-mcp47feb02-fix4-614de9334f22
> 
> Best regards,

