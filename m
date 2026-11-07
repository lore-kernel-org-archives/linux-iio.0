Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091191;
	b=t1tpZ86HC8MXxnFkZMRB9w1UGNgSbG8Ofjm+xbH4ipCOIiTDtOLEHwgMfI0fXvXIh/Hg
	 kEinSG6MVJFJKO6k7g4AK/m3SlvQ2F/wATJzRYFWb5/7NSYfuJbQ93znwjwQMpRT0kQ3u
	 7oh2C4ccyZfYOtcpqgc5Usve9KAybTEz1m14Kfyq66F34i5zLDrdEqZoV/Ju6SXoMFgHx
	 LNb+jVJ1BcOhbZ1Vh5bOkOi6tE6CWhCAYo8OsO2eaadQOZjADzH882vlwp7DC/S8rUmKd
	 IfPPDy8So2YmV9T2ETClUq0us2fzMxuN6f+kbcAvFDdMZdLZcN3fq1Ri8yzRAA6kjAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=osD5+OBjagTxXN4lD90AGnaKeqSDfchEEYWp3KGPtrs=;
	b=ejjUI1/XNq9/lhHms7wRKnidYGEXPK5cLxU55wLdRl9X1CeS8J1Ks/c7vySCVDx2uqoJ
	 qpDcjdBQAY1neM0YUqZ9oxUkSIK5CDPk7pCwoW6wI0a2Gy6DqRTotNhkSQvxJ08ihl/KH
	 A8uWbrKJ+wSULQvySojKo9v1vkyljY7hxeH09PV4yx1Rz5z/bAn4UoL8LAQP4Nih46FL/
	 hQ/VaxeggaFhEv+3bcVmD6Pyde/MyDuhTNcdSHy1EJLkUdJQWXLydzthYL9z4xZWXZQYm
	 8Qw1gAr1yMaA6mgl2pmuM8GISG+vXRqkLVqFZ71oWCyBWV5zh9G+eup58lDu7xqqGZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjVjl49O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24902606A326;
	Sat,  7 Nov 2026 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjVjl49O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5C21F0089F;
	Sat,  7 Nov 2026 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091190;
	bh=osD5+OBjagTxXN4lD90AGnaKeqSDfchEEYWp3KGPtrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LjVjl49OLZdaKiwLmZr4YaWKneFC6c7lw9BaXBS3Q9N9XtuxP2wlGa0pOZYgIRpfG
	 cdVGGVtvHBlh0gh+Mmm2ka8ALKj5YPEEiaMLKtCzFrf7rEzsYDSfolwh18lua9D4EP
	 mf1CCH+Uw6BHILOxYIPPrf1USAiLjKyCREklUQpn0pmNlbTd/hVIlm+baoKUdm07sd
	 Gr01c7WkpiWIKzDlZ1Wbo+luE16jzIalRbUyt4cKI211yrCSj6JJXG0sy0W7ojq0FT
	 WX26rS4hVzp2NUKRR9Joazp+Ls7nv5EtFu+1EWdlQFvCnBS8Lm5mtSCatdkZGl1sZ7
	 kvag0KU/39PLw==
Date: Sat, 7 Nov 2026 22:39:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: light: stk3310: add stk3337 support
Message-ID: <20261107223943.40c5c38f@jic23-hlaptop>
In-Reply-To: <20261108-6768-stk3337-v1-4-0340c99b0e33@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
	<20261108-6768-stk3337-v1-4-0340c99b0e33@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 00:15:06 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add support for the stk3337 sensor, found in the Xiaomi Redmi Note 9
> phone.
> 
> In addition to the standard stk3310 ambient light and proximity
> channels, the stk3337 provides a clear intensity channel, matching the
> layout already used by the stk36c61.

I think you should probably make it clear that this is a subset of
the stk36c61 channel spec as that also has other colour sensors.

I was briefly confused as to why you didn't just use the chan spec
from that given this description.

Other than that, looks good to me.

Thanks

Jonathan


> 
> Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  drivers/iio/light/stk3310.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 2f4747c06f43..6d629ce726fc 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -60,6 +60,7 @@
>  #define STK3311S34_CHIP_ID_VAL			0x1E
>  #define STK3311X_CHIP_ID_VAL			0x12
>  #define STK3335_CHIP_ID_VAL			0x51
> +#define STK3337_CHIP_ID_VAL			0x5F
>  #define STK36C61_CHIP_ID_VAL			0x95
>  #define STK3310_PSINT_EN			0x01
>  #define STK3310_PS_MAX_VAL			0xFFFF
> @@ -111,6 +112,7 @@ static const u8 stk3310_chip_ids[] = {
>  	STK3311X_CHIP_ID_VAL,
>  	STK3311_CHIP_ID_VAL,
>  	STK3335_CHIP_ID_VAL,
> +	STK3337_CHIP_ID_VAL,
>  	STK36C61_CHIP_ID_VAL,
>  };
>  
> @@ -233,6 +235,12 @@ static const struct iio_chan_spec stk3310_channels[] = {
>  	STK3310_PROXIMITY_CHANNEL,
>  };
>  
> +static const struct iio_chan_spec stk3337_channels[] = {
> +	STK3310_LIGHT_CHANNEL,
> +	STK3310_PROXIMITY_CHANNEL,
> +	STK36C61_INTENSITY_CHANNEL(CLEAR, STK36C61_REG_CLEAR_DATA_MSB),
> +};
> +
>  static const struct iio_chan_spec stk36c61_channels[] = {
>  	STK3310_LIGHT_CHANNEL,
>  	STK3310_PROXIMITY_CHANNEL,
> @@ -260,6 +268,12 @@ static const struct stk3310_chip_info stk3310_chip_info = {
>  	.num_channels = ARRAY_SIZE(stk3310_channels),
>  };
>  
> +static const struct stk3310_chip_info stk3337_chip_info = {
> +	.name = "stk3337",
> +	.channels = stk3337_channels,
> +	.num_channels = ARRAY_SIZE(stk3337_channels),
> +};
> +
>  static const struct stk3310_chip_info stk36c61_chip_info = {
>  	.name = "stk36c61",
>  	.channels = stk36c61_channels,
> @@ -870,6 +884,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
>  	{ .name = "stk3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
>  	{ .name = "stk3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
>  	{ .name = "stk3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
> +	{ .name = "stk3337", .driver_data = (kernel_ulong_t)&stk3337_chip_info },
>  	{ .name = "stk36c61", .driver_data = (kernel_ulong_t)&stk36c61_chip_info },
>  	{ }
>  };
> @@ -888,6 +903,7 @@ static const struct of_device_id stk3310_of_match[] = {
>  	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
>  	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
>  	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
> +	{ .compatible = "sensortek,stk3337", .data = &stk3337_chip_info },
>  	{ .compatible = "sensortek,stk36c61", .data = &stk36c61_chip_info },
>  	{ }
>  };
> 

