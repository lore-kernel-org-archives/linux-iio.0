Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DC18C2C;
	Mon, 27 Jul 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114241; cv=none; b=urzsqk225nihS11GVR6yU9E1giosj8yTJhtzD69H/bp/gFgR8ZkN5hYWMAL9vM6OrsP9OL1kt0aL7ZAqAoReTa5joWx3LTJi8I7OTuTK+YdbetC5EzQHtg2osPknnmhwGytJT8azPvuI2ftGtDSj63XsHlbTtoDA9oDQ10JHBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114241; c=relaxed/simple;
	bh=pPjkUZJV0wKJWjN87TCXwkddjwkavfq5/Ci41Zd8ag8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTF1uznnbWxEckYKDD9z+d89RdlAWGhTt73dDqmJmv9KGqyPVIYyGTHcIx4a/IVkD0RQHLKzrpoDALP2tPQyi9EplFPtRxyhhqdPvUut+5gNzv3o9XHJ3crAA4POVO1S3XEhkMoAUTHc+7MkQlsg22hx5UdzZdzTtt5LhzXvJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xarctk9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xarctk9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD801F000E9;
	Mon, 27 Jul 2026 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785114240;
	bh=8mzdSM86o6j/XiomfeN1i+drLxXHqRa9TueBwOMc7Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xarctk9urbFo7o4vg5p69/jvvgiJwaEF35vD31bCfyLuxim29ICHfADS+XMuskCIL
	 ryi+MH6P0ejTSvWIFYntjiF+lRXmZLUn9y2ozuN/GB6LMKFITKG5u+irYE/tZ0nCdi
	 NUpuQ4SXyM6RxhCigl/LWuVgZUihnYp5iKJ7SJdzU+6cP/v7keMl/2nPqhmIS2KKxk
	 hBFQ2wCAmZ9TZrrK1Nyl7lRvhAlbDwTMuCIAEZD016CRGGCMhuuEdXVnV1Iz7woxxc
	 JVUZhBY3bSrN1aaK4MwiyBBrqDfzorG0oJxuw2BrRe2FvKXcigrRVY1zXQl8bRFOXD
	 i9lpeIdetiyYQ==
Date: Mon, 27 Jul 2026 02:03:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Message-ID: <20260727020355.731746c1@jic23-huawei>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-1-98b06f3d47d9@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
	<20260724-iio-adc-ti-ads112c14-buffered-read-v2-1-98b06f3d47d9@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 10:55:06 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
> data integrity of all I2C transactions with the device.
> 
> For now, it is always enabled, but it could be made optional in the
> future if needed (e.g. for higher-speed data acquisition).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes:
> * Rebased on iio/testing.

Just one trivial thing.

...


>  	if (IS_ERR(data->regmap))
>  		return dev_err_probe(dev, PTR_ERR(data->regmap),
>  				     "failed to init regmap\n");
> @@ -1158,6 +1274,14 @@ static int ads112c14_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
> +				 ADS112C14_DIGITAL_CFG_I2C_CRC_EN,
> +				 ADS112C14_DIGITAL_CFG_I2C_CRC_EN);

regmap_set_bits() or maybe some future patch breaks using that?

> +	if (ret)
> +		return ret;
> +
> +	data->i2c_crc_enabled = true;
> +
>  	ret = regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
>  	if (ret)
>  		return ret;


