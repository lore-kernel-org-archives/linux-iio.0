Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699916;
	b=hrtLXWuu2WOUkzsnOw2Hf9Cgzw1X+K3hnVlNC1XftSzpHcecInoJMCzvCob3ueXueETa
	 wB4yFUvJR7j6vtdUlCXPdFOD8mQd7ErDfV8IzMIfj3qIbWjW8wafmv0p0NsCiftcvBHGj
	 WEXLs/qooQvKskaKBGKVL1UTsAsCg/itmI3wFOMu11nzKRP0Dh3ymf68lK99JHdQLay7G
	 ewLrnOdMOhevSQqTEVdxrhTIELE8QVkyzvluqZHWP++Bcyi8ysUsyVs6HsUCbsgid1oAC
	 Gm3Je4jtmSDGZxmhYTq8Ch23FziYyva50qCN63aIGCpEQdBK/XUN59oi6g6hA0KWgcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699916;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KujlzOPpP0vIKDupyNtfjG8Z21pegzW93H5I5f/gK5Y=;
	b=XenvhYmXS1A6DZblyob/lPTrSieBSpdnCL2YI+LCKURj+fjEdYL5vzxZWTHoim3O1s2e
	 zxF8ps+Wwy2ZGTUx2GP4lTRdKxAdk5YEd0d08hCIyZdayvMJ4ViWOnYye+B0hHqfJHw9l
	 A1GJ/QQxpQBdapDjzmJ4z8E4bFJNmbnGBu4Bl1z0UZkIF25gX8yRjv0k7PAW7hZcrCa+t
	 D/fON6xvwNJkXwxEAPPlPUb3klB1PVemuWKUY55DrRuf3KV1JTJEH0OqxJmv4I+R1Ib7N
	 gp+Hs6Y6WLiDWDBkaOan4tOezl6tZmx8/SgSNBloV53kkDlcdDlq8NCclj/BMGoL/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVdWMyiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4A606A326;
	Thu, 26 Nov 2026 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVdWMyiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5706C1F000D0;
	Thu, 26 Nov 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699915;
	bh=KujlzOPpP0vIKDupyNtfjG8Z21pegzW93H5I5f/gK5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gVdWMyiB96e8BavOcj4hPKuLJ4M+sqwDzRUBUqlWznqfIexDjAN2n+LixiIVmue5+
	 RSz2Etfo8J3saKobUc8B3TN0j/xzc2JGHUrdsI4QPHYEnCtIFsasZAW4tKl+/xC0Ek
	 XAIbTXd+kpHYmb6s4OiyaaHVzXYQryKt74x8Vjqs+LOBuPn/foIffvVZcX/l0ATVwN
	 xrPv6DW/FQY/gHF1Gv07IB1DJBmTKK1Qg35qipindFrG+yVsdimTZZwipEAnybklGG
	 O7kmpw+Vh1W8hZ28Ki2Hl5nYUgpbCuyYMxx2oeLxvoog+2VdCby9aM0ldpUI6gyg56
	 xXXqtoDgD+u9Q==
Message-ID: <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
Date: Thu, 26 Nov 2026 14:31:51 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 14:23, Matti Vaittinen wrote:

...

> diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
> index 127ccc2c4a22..1d58bc1544a1 100644
> --- a/drivers/iio/dac/rohm-bd79703.c
> +++ b/drivers/iio/dac/rohm-bd79703.c
> @@ -41,7 +41,9 @@ static const struct regmap_config bd79703_regmap_config = {
>  /* Dynamic driver private data */
>  struct bd79703_data {
>  	struct regmap *regmap;
> -	int vfs;
> +	int vcc_mv;

_mV is the preferred style to denote SI unit variables.

> +	int vfs_mv;
> +	unsigned int num_vfs_chan;
>  };
>  
>  /* Static, IC type specific data for different variants */
> @@ -49,7 +51,11 @@ struct bd7970x_chip_data {
>  	const char *name;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> -	bool has_vfs;
> +	/*
> +	 * Some ICs use VFS-pin for full-scale voltage for first N channels.
> +	 * We need to know these channels to get correct scale

Small nit, but missing period at the end.

> +	 */
> +	unsigned int num_vfs_chan;
>  };
>  

...

>  static int bd79703_probe(struct spi_device *spi)
> @@ -184,23 +206,26 @@ static int bd79703_probe(struct spi_device *spi)
>  				     "Failed to initialize Regmap\n");
>  
>  	/*
> -	 * BD79703 has a separate VFS pin, whereas the BD79700 and BD79701 use
> -	 * VCC for their full-scale output voltage.
> +	 * BD79702 and BD79703 have a separate VFS pin. On these ICs, the VFS
> +	 * pin provides the full-scale output voltage for half of the channels,
> +	 * and use VCC for the rest.
> +	 * The BD79700 and BD79701 use VCC for their full-scale output voltage
> +	 * for all of the channels.
>  	 */
> -	if (cd->has_vfs) {
> -		ret = devm_regulator_get_enable(dev, "vcc");
> -		if (ret)
> -			return dev_err_probe(dev, ret, "Failed to enable VCC\n");
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
> +
> +	data->vcc_mv = ret / 1000;

Better to do ret / (MICRO / MILLI).

>  
> +	if (cd->num_vfs_chan > 0) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "vfs");
>  		if (ret < 0)
>  			return dev_err_probe(dev, ret, "Failed to get Vfs\n");
> -	} else {
> -		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret, "Failed to get VCC\n");
> +
> +		data->vfs_mv = ret / 1000;

Same here.

-- 
Kind regards,
Joshua Crofts

