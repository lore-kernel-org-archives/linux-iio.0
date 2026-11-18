Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996125;
	b=lhxW2LENyeIK529ltAIasmvc5t1rg84p/Vm3gaV2rXdLiXyLO4oXwc9Oa/0f6A/toVED
	 0RoQGOk+zHLDmsyrEugKz81MEBOuicip3mXGlUcPxG+C7G3aBbUwgwv8q/DQqZm1DQIe9
	 N66SmE6dHUTm2e2rNbx7hxOdLlBNXLZss5Yg2iswaEMkcWU3cZ+PldHqxjj3i74R5fIaR
	 5pyzEjuX7ep874wH1b5PQfUILc6FpNhaBLI2gazBOnXYyj6Q0pr3FJVHeihLoV/hfucse
	 S0SMgidgT+DMkXIXekmiJdBkXUahV3SBn3CuHNRm615TDYlTX3R/eUAiXMtIhAJDFYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996125;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x0yTvrJ+UMNYKHXzMx/+j7xgjyNDhX1uNO9zmb0AOjE=;
	b=EEAAr2CNwanFEOTKXFat93j371Rh6CpYsFj2c3/SjD4Dyp3ZW6TBf+E+Vl4YASU3/g3r
	 zFe+2B6dB0ir6lBqGiykWo+8I3G85ONrLOUBH9bti6um1w5wBRy/Ore3KPaEv4XETex8s
	 6eGhLAEjudFFnFaWpBCZGKOur3VJkYRqgQVnG2rJJywtCPR2hOTpHuoTMH3QW9OI2T9CD
	 1YdK7wXG9gtBe6rt+misRf2GGhiBuwgxVBAG2+V1pXnAfNgtuPdfYOfoL+3Rsshif3ZRu
	 9HS7/j3wMvUsdcReXIBuSKKVoY6NvsipKBeKh+KkPI0Wetbzs1Uv8JMbL+wJ82UPkGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mD+WRFof;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EB606A31C;
	Wed, 18 Nov 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mD+WRFof
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794996125;
	b=XaZjXDtWET0HyfwkJkO9o5xfwOTYdvTs+ewziMGOhKkpZWnJelzS6UE8MaZ8BnlUx+GV
	 jj1+gOawA188xeNGd7sjHBsTctRLJslIpXWGgaVgZKfR/N2MrnG3Aj686nVN3uQBLcKd/
	 mUyNSuyYK65PWLNaF15NM1veYjweuWtHxgsYyHHGsCHtHpg+R3WwFXaGlAd1EtJDJlASe
	 wYpt8QzClat+lYxbt+59EIiZ8D7uL1gTgtVouhs3mkPBJ27SO9rX7Psim/e92iODhzALq
	 ET+iTW7cIkqT2bBUOy5GJIDDRpA/JbFFBU89j+fC4nTiUuPRCwNUqYPK2InJ+MbGDGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794996125;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x0yTvrJ+UMNYKHXzMx/+j7xgjyNDhX1uNO9zmb0AOjE=;
	b=xC72gAkOJNYw9PV4A6MmOiBpn2aYm7rQbhfVTu2m0Fl26YPhlOssKDx4FyTKXX/JDXPQ
	 d2GKwG/UDsUpcOzA4pKCDPbjyv4bYZsur95u9dCaL1Fkv/BUkKODtFKCUsWXmmg2Ayu5z
	 UBpLtnGCnH6Q4zb6Tkkp7Oewtv7iKi7ft1Eca8ATnQEUkX5GnS0/4HFZ1uJUonVZ3QXQf
	 qJ27yQzpaQXpLQmdrMPGFT1UBen0ZkKzvFVfwo0OpW9r4Pwhd8/dov3Xo9ACyO5f5Nqss
	 4r7fgSMPNWd2ERyxOCrXAvaRDyIAxrqABjvF9WiyNBYGVwzvJnJLRkYIWIhECeP0LoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 133D11F000C4;
	Wed, 18 Nov 2026 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996125;
	bh=x0yTvrJ+UMNYKHXzMx/+j7xgjyNDhX1uNO9zmb0AOjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mD+WRFofFxhz5e6+i3DTzy0MJTtbB9uf0ZRmaP4hauRPr7DQ7zClHuIpLIdkMa4lU
	 o7NTfVdZd6eJ6lv79GOQQXLbdRMVw8pfzvufsa1P3qQ6YfTxDTVP6tzjau4XlIUvL2
	 6IGoy/F4YYzzOhzkyJQEx9oMfK1baUpXOes4lqyzD06DLp1IBC1mY6Eg0bOMnrL/qK
	 nmhurHIDCISzBoywVsFOr/RQGzduS7nDzesXzRf2bfF9E4uhCHiKQ3maMY+eToAM9u
	 xtSWQDAj+cyYzUwq4lr+pqPLIDHwF8muDl1FpN+OColqosHEThAWcjKNEzdhVzZdjx
	 rZNGHNHlRlMqg==
Date: Wed, 18 Nov 2026 11:01:38 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: stk3310: add vdd regulator support
Message-ID: <20261118110138.000003ab@kernel.org>
In-Reply-To: <20261117-6768-stk3337-v2-3-92f4c7be3bc6@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
	<20261117-6768-stk3337-v2-3-92f4c7be3bc6@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue, 17 Nov 2026 20:08:37 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> @@ -745,6 +746,10 @@ static int stk3310_probe(struct i2c_client *client)
>  	device_property_read_u32(&client->dev, "proximity-near-level",
>  				 &data->ps_near_level);
>  
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
> +

IMO this should work, but I don't like the mixing of devm_* and non-devm_*
functions, this may cause issues down the road. Consider moving the driver
to all devm_* functions?

-- 
Kind regards,
Joshua Crofts
