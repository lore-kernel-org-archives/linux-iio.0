Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620306;
	b=1k9ilzQHCyMOHju+YzZd/I5mP+dotz1cGJipr3hQr8sczkwkPlemkjGGZZcIrrDyIUxt
	 EoW8VXCOloo6QB2CHRXXjBdiFclp/WphOPa0xMf6jsQevgZcoOqNHUOokS/JUNUZYfGCe
	 Wa55Gk1056VeWAxq45erPDAiD9y7hwW4YJB5PveyCKifV/Td+v0mvNg2u3AE143YWc9fl
	 xAMw+5ldANr5N25pHOBbVtTSViqVufyAqzZYlzhKumbi0ducmyOX5irYyEdB7ac4Cd6/d
	 dJjba+fnVHgoo5HJY1CNzmg555xFoNOkChRzvNp7KdxKXPLcf7Gt7s1hbbVHyUOuCLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620306;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NJjtYTOuhIHMXwOIrydK7G80hPPVsywfe4p9y5S0ecM=;
	b=P38xq/WxIm4IVgeG5JF2JTTTByzCqrCl4u/G7g8p2vesVyAasSssDsB04qDL+zNPk1f1
	 Jpw1DAfnQ4Mdl1o8cMe+MIPl2Sv0Cus5yqBRF7H2BKvpaAFhAvYWQP1Y6/yNorcQ09FKp
	 Krxwo2IjufzNwndb2ZPt1rdwP/QZUmyL+CXyPw03yrrPd/lIb+KPnAmge7JA9u3SiPZg5
	 7y3C19/1wM6Ld40dBYzhhjmUDQg3mSLydIBokYElD5g2bu4Ph/bXi3/W413FJqzHX3dAf
	 uU5NNl9tFP8HIpjcZqTRK8R5uZVcGUlqyPZOXCRoJs3llAYmSXJPxRnL6UIZ305h8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Byao/rNK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA272606A32D;
	Sat, 14 Nov 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Byao/rNK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C27B1F000C4;
	Sat, 14 Nov 2026 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794620305;
	bh=NJjtYTOuhIHMXwOIrydK7G80hPPVsywfe4p9y5S0ecM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Byao/rNK/SUzxcVKOm+DIWIOgkEmBgs6E42gsPfxBnd1tV+c3YAoE2SUsJnJeW0es
	 ijIRPA2KeARvNhINfD6xNaAR2CjBsIcvDGv1wgj6PqjOJcx4X9G4Oiago4KJi7TKEW
	 k+7s0Ablk1NHzs8thT5RNLVYzuZKrMhpXF2T5b0VuZncvGHgty9V/dw+8E+uV8FVgF
	 /+OGKAiH3iVSc9k0ipv7w2nZ1ItfjslFNGtoJh0csrfXS34/F++qKByYrgGc1nVmIf
	 AYj8pLM5W/PQ+T1yBqlRWXw0hQhWnO6OtO2DnnVF6uhyGlWf4SzMKsU2tRIuvSkVWh
	 Sqga8YHdH0HtA==
Date: Sat, 14 Nov 2026 01:38:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Arnav
 Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new
 temperature in trigger handler
Message-ID: <20261114013817.476f8fb9@jic23-hlaptop>
In-Reply-To: <20261113230241.82046-1-zoone.rupert@gmail.com>
References: <20261113230241.82046-1-zoone.rupert@gmail.com>
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

On Sat, 14 Nov 2026 01:02:41 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Each scan waits for a new temperature result before reading pressure.
> With pressure sampled faster than temperature, scans then come at the
> temperature rate: an 8 Hz trigger with temperature at its default 1 Hz
> gives one scan a second.
> 
> Read pressure first and take the latest temperature, as a direct
> pressure read already does. Wait for temperature only when pressure is
> not in the scan. Read a temperature in probe, so there is a latest one
> from the first scan on.

That was potentially a while back.  Why not do it in preenable for the buffer?
Will make the buffer start a bit slow but should 'work' from there on.

> 
> Fixes: 9b7cad9ce2ed ("iio: pressure: dps310: add triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261110154254.39092-1-zoone.rupert%40gmail.com
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> v2: read a temperature in probe, so the first scans have one (Arnav Kapoor)
> v1: https://lore.kernel.org/linux-iio/20261111195118.36853-1-zoone.rupert@gmail.com/
> 
> Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
> Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
>  drivers/iio/pressure/dps310.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 85df58ac1809..3d05540f95dd 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -910,10 +910,18 @@ static int dps310_fill_channels(struct dps310_data *data,
>  	unsigned int i;
>  	int rc;
>  
> -	/* Compensation needs a temperature, so it is sampled either way */
> -	rc = dps310_read_temp_raw_locked(data);
> -	if (rc)
> -		return rc;
> +	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
> +		rc = dps310_read_pres_raw_locked(data);
> +		if (rc)
> +			return rc;
> +
> +		/* Waiting here would hold scans to the temperature rate */
> +		dps310_refresh_temp_locked(data);
> +	} else {
> +		rc = dps310_read_temp_raw_locked(data);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	i = 0;
>  	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
> @@ -924,10 +932,6 @@ static int dps310_fill_channels(struct dps310_data *data,
>  	}
>  
>  	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
> -		rc = dps310_read_pres_raw_locked(data);
> -		if (rc)
> -			return rc;
> -
>  		/* Pascals, see the channel definition */
>  		rc = dps310_calculate_pressure(data, &channels[i++]);
>  		if (rc)
> @@ -1017,6 +1021,12 @@ static int dps310_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
>  
> +	/* Pressure compensation needs a temperature from the start */
> +	scoped_guard(mutex, &data->lock)
> +		rc = dps310_read_temp_raw_locked(data);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * The device measures continuously in background mode, so a capture is
>  	 * just a read of the latest results. The trigger is not aligned with
> 
> base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c

