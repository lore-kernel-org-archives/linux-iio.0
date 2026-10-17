Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FF4CF49E;
	Sat, 17 Oct 2026 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195509; cv=none; b=scTBEk18IDAlWfIIQLpZEurdo0y3Mka4n+oSeloNrzTaQB6vYKSKVHfCodaHADgy4CNn+Ngp0gDDtFDn/MtlJPhw55VuZ4HeZfi9Ckb/Q8/npA9gjyCT3j/eM05aySIksXM3fPKP78kd5gZn1V+gex0dO04waP7hqluYNsHwGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195509; c=relaxed/simple;
	bh=DBOpTQMF0EgcSbdTbsSaWuCYTUflbitFRHuZzO9jhTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm2WqXCQ86E7L0Miho02GWncYPkbx5RLR8iANzVDnRsaq71qFr3KXY7XVAjzpXYEV3lBPfl0aleVmLMU0MUjfQkzPP5A6pNuyM3X+V7pDQjdiUbJzumBRv9y8rPdFHUDlkXhl8+iCKthjjzJ6ejBX+B6+2omBOh9iBY0LkQrJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQiRf6KD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQiRf6KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C2D1F000C4;
	Sat, 17 Oct 2026 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195507;
	bh=ZEEP+hDmF0puw+t08sFA5eA5k0+vUWBsEJ35A4r0ZiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KQiRf6KDaxFzOIAHP+DJxPT8/lu8MUTgGYrvKvS+QJO34vm9VQTTSc4+vpYfdDC/N
	 QZ3KnoiZgF6hdO8y0g/UyZHr92Z0m9QL/HBrm5cFEsQ/D35tbC34qP8+zL2igifdfx
	 zjSZbpBumP0WmbxybJ7F3nKbONnFTN/Sm6VN/hu4HyxvOXab8dt1olotjsbl4pXoiF
	 y1qNSEj5tvIyrRD9Ges3Dr0RTES+jKmgZ1iL+MXSlKhzBFdWJdVOSk+zIaEZHTZXf1
	 cXYSXp8/VQeR+YYV7i0bflrwj6PEGDDueU5c2ieH4a+RLeanJiS45oQpJSDku57bgN
	 5qF82Hk5wxQ1Q==
Date: Sat, 17 Oct 2026 01:05:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: gp2ap002: add led power supply
Message-ID: <20261017010501.70eb3ee4@jic23-hlaptop>
In-Reply-To: <20261016-iio-light-gp2ap002-v1-1-7c93312fa8d5@rudorff.com>
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
	<20261016-iio-light-gp2ap002-v1-1-7c93312fa8d5@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 16:43:06 +0200
Christoph Rudorff <chris@rudorff.com> wrote:

> According to data sheet "Recommended external circuit"
> this got up to three supplies, we missed VLED
> 
> Now it works (tested on msm8916-samsung-j5):
> 
> $ cd /sys/bus/iio/devices/iio\:device1
> $ echo 1 > events/in_proximity_thresh_either_en
> 
> $ iio_event_monitor /dev/iio\:device1
> 
> Event: time: 1791460068846871297, type: proximity, channel: 0,
> evtype: thresh, direction: rising
> 
> Event: time: 1791460068876669724, type: proximity, channel: 0,
> evtype: thresh, direction: falling
> 
> ...
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

A few comments inline if you resolve the question Linus raised.

> ---
>  drivers/iio/light/gp2ap002.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index de29081fd3b2..c03eb0f1988b 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -129,6 +129,7 @@
>   * @dev: pointer to parent device
>   * @vdd: regulator controlling VDD
>   * @vio: regulator controlling VIO
> + * @vled: regulator controlling VLED
>   * @alsout: IIO ADC channel to convert the ALSOUT signal
>   * @hys_far: hysteresis control from device tree
>   * @hys_close: hysteresis control from device tree
> @@ -142,6 +143,7 @@ struct gp2ap002 {
>  	struct device *dev;
>  	struct regulator *vdd;
>  	struct regulator *vio;
> +	struct regulator *vled;
>  	struct iio_channel *alsout;
>  	u8 hys_far;
>  	u8 hys_close;
> @@ -169,7 +171,7 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
>  
>  	if (val & GP2AP002_PROX_VO_DETECT) {
>  		/* Close */
> -		dev_dbg(gp2ap002->dev, "close\n");
> +		dev_dbg(gp2ap002->dev, "close %i\n", val);

Why?

>  		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
>  				   gp2ap002->hys_far);
>  		if (ret)
> @@ -179,7 +181,7 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
>  					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
>  	} else {
>  		/* Far */
> -		dev_dbg(gp2ap002->dev, "far\n");
> +		dev_dbg(gp2ap002->dev, "far %i\n", val);

Why?

>  		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
>  				   gp2ap002->hys_close);
>  		if (ret)
> @@ -530,14 +532,22 @@ static int gp2ap002_probe(struct i2c_client *client)
>  	if (IS_ERR(gp2ap002->vio))
>  		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
>  				     "failed to get VIO regulator\n");
> +	// returns a dummy if not declared:

See comment syntax elsewhere and match it.

> +	gp2ap002->vled = devm_regulator_get(dev, "vled");
> +	if (IS_ERR(gp2ap002->vled))
> +		return dev_err_probe(dev, PTR_ERR(gp2ap002->vled),
> +				     "failed to get VLED regulator\n");
>  
>  	/* Operating voltage 2.4V .. 3.6V according to datasheet */
>  	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
>  	if (ret) {
> -		dev_err(dev, "failed to sett VDD voltage\n");
> +		dev_err(dev, "failed to set VDD voltage\n");

Good to fix, but unrelated so separate patch.

>  		return ret;
>  	}
>  
> +	/* LED voltage 2.4V .. 3.6V according to datasheet */
> +	/* nothing to set: it's a simple "regulator-fixed" gpio pin */
Use multiline comment syntax.
> +
>  	/* VIO should be between 1.65V and VDD */
>  	ret = regulator_get_voltage(gp2ap002->vdd);
>  	if (ret < 0) {
> @@ -560,6 +570,11 @@ static int gp2ap002_probe(struct i2c_client *client)
>  		dev_err(dev, "failed to enable VIO regulator\n");
>  		goto out_disable_vdd;
>  	}
> +	ret = regulator_enable(gp2ap002->vled);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VLED regulator\n");
> +		goto out_disable_vio;
> +	}
>  
>  	msleep(20);
>  
> @@ -635,6 +650,7 @@ static void gp2ap002_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	regulator_disable(gp2ap002->vio);
>  	regulator_disable(gp2ap002->vdd);
> +	regulator_disable(gp2ap002->vled);

There are enough of them that if this goes forward consider using
the bulk handling.

>  }
>  
>  static int gp2ap002_runtime_suspend(struct device *dev)
> @@ -659,6 +675,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
>  	 */
>  	regulator_disable(gp2ap002->vio);
>  	regulator_disable(gp2ap002->vdd);
> +	regulator_disable(gp2ap002->vled);
>  
>  	return 0;
>  }
> @@ -679,6 +696,11 @@ static int gp2ap002_runtime_resume(struct device *dev)
>  		dev_err(dev, "failed to enable VIO regulator in resume path\n");
>  		goto out_disable_vdd;
>  	}
> +	ret = regulator_enable(gp2ap002->vled);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VLED regulator in resume path\n");
> +		goto out_disable_vio;
> +	}
>  
>  	msleep(20);
>  
> 

