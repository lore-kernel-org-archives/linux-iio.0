Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949319B5A3;
	Sun, 15 Mar 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773599212; cv=none; b=NvyejxXq1vOe1vY/5i5BcTTPgfr4xw/6Q0pFusja6NGFtSV05dWKmYsRK6txwq285de67P4ZKVIW4TtCFCcY/rXYbI7LYa1gV5k1r4oRAjjVzyVL/qst5YMKQKnSta+JpMYVKFXFBHp/LGcVtiA2qzpyfDL2QJdJEdHb3zkCZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773599212; c=relaxed/simple;
	bh=bA0X/cdAPTa3TTm+zrn9vDdqCAipGretS+zp96/vxyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSdDu6zUtoGfnTc7QA8CmegZwvPaAqXTgUDZNHjzGu75gl8qymNwX0vacOxPoNrmbhDlPaUxyt8k3Ixkn3ZG4NxWV11FMg1t2DWkYcjTtO/3QrSkcv2WAFx8NvV+RiKmflginIuik48/6zZA1IYZWvIqpAgNsIgQ0zcaMzx9tUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVHnml3+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVHnml3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5236EC4CEF7;
	Sun, 15 Mar 2026 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773599212;
	bh=bA0X/cdAPTa3TTm+zrn9vDdqCAipGretS+zp96/vxyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hVHnml3+ZneQQO5V1+nquOTr+v0PrGhAdTFh9sgmSXrRQXM617BiDKdOM+EdH/fBZ
	 +WSE3Bq4rVCUjAv8Ri9wGkAyHaRzooNUc5acT3IXq8JYxWEBSI9wJH5s7Jo4nwBdaE
	 kGDTak96F2a7ccy+shu1CdSbjkUOxw+tz0pl6c7BoN19O0Vc+8Ewiw+MXsZzANIygh
	 zmwy+lgjLoIB3L9Zm0CtAk2udTUtZY69ZA/y/NGmzxWVDp2eq1TFR4TdaNz5oYxni3
	 687zY07NSt1yYTmu3ZeAtMD+OT7kLXzYy8eBPCUwNENzWVDpOq56SucVFqfuw2hqGT
	 KAlVtGFl06wAw==
Date: Sun, 15 Mar 2026 18:26:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
Message-ID: <20260315182642.5c6918ad@jic23-huawei>
In-Reply-To: <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
	<20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 18:06:32 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> Replace mutex_init used across driver with its device-managed
> counterpart, so all assigned mutexes get destroyed.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Hi Erikas,

One related area that I noticed whilst checking this patch was
safe wrt to ordering.  I think cleaning that up before this
patch would make this one more obviously correct.

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 939ff2d65105..0ee307fc5ab7 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -356,6 +356,8 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
>  
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
> +	struct i2c_client *client = data->client;
> +	struct device *dev = &client->dev;
>  	int ret, id;
>  	u16 regval;
>  
> @@ -400,8 +402,14 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	}
>  	data->al_scale = data->chip_spec->ulux_step;
>  	data->ps_scale = 16;
> -	mutex_init(&data->vcnl4200_al.lock);
> -	mutex_init(&data->vcnl4200_ps.lock);
> +
> +	ret = devm_mutex_init(dev, &data->vcnl4200_al.lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_mutex_init(dev, &data->vcnl4200_ps.lock);
> +	if (ret < 0)
> +		return ret;
I think this is ok because the only thing undone in remove is the power state
setting that is the last call in this function but the mixture of non
devm and devm calls in init is less than helpful for readability.
Given both init() callbacks end with
return data->chip_spec->set_power_state(data, true) and the remove
just calls that callback without any wrapping up in different init functions
I'm thinking it would make it all more readable if we didn't consider
turning on the power as part of the _init() but instead called it
directly from probe().

That would perhaps give more readable code and avoid mix of devm cleanup
and other cleanup in those callbacks.


>  
>  	/* Use 16 bits proximity sensor readings */
>  	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> @@ -1985,6 +1993,7 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct vcnl4000_data *data;
>  	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -1997,7 +2006,9 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	data->id = id->driver_data;
>  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
>  
> -	mutex_init(&data->vcnl4000_lock);
> +	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = data->chip_spec->init(data);
>  	if (ret < 0)
> 

