Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AA3B5301;
	Mon,  9 Mar 2026 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085132; cv=none; b=LzWkxcWEHOdXj19aBbCW3fS31u3jJHGjOPCUY4FyOAyCCrPDA8lRFahTGhm8AT/g005GgjWxMNUxmAgGCgpRB6l09T9CMALzaWwnbD1sANfpUZ3zLnVdFig8aHQypRRcVdO7W6TqJO83YVaNpPVds91/vd2x4cv5SYn/CAWHffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085132; c=relaxed/simple;
	bh=UgBTjnA/UWCqy16++mw2F7x01R8eJ2Sv874mUF8A/+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hShNwtRn+AxoUcqRJ2dqIeFCk3Uw3Mj3wyhlJizpA2SSZHukoVmc1IRSM3eR7BfiKq+b4esoZvOYQa/JHlVMas1LevBpxkHh844TUNwMgICaFoVtf+AzrcD88SixB+Putac/7xn5o34z58rJ2Ud7HozziWNcRxdRp2+eSIpqb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0i0Gsji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0i0Gsji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9AFC4CEF7;
	Mon,  9 Mar 2026 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773085132;
	bh=UgBTjnA/UWCqy16++mw2F7x01R8eJ2Sv874mUF8A/+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0i0Gsjim0bHPhthdReTr5GprJgPNCg6zvoRRJ4Zhvqu9DYaS2htyjVoFMHIHfSG3
	 pWQVSdDA3a7OjT5RZEMI2Lq83Q93ZYdcQgWbg2Yo9vhJcMaqPC3BhZc1vtstmneBh9
	 Vo5qmPeoUzSB83GQfmoCnMM7gPyrHRPoTN9blmlsx01vCGP4QqXMgbhc/APxFs0TW5
	 S/LGSRDMBB+jZHpgqT9i3jhZKzP7LEde5aZZYs9TAP3cABtnZ1btKMW6ytTWFaTXIt
	 jHpkwkWIPKoXe1Gan54cJSqpf+yn2bryd8ZK4pK1i2ZK54+F3yRW7NMv8SGWVJ3Y/N
	 7nzVUjydjushQ==
Date: Mon, 9 Mar 2026 19:38:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: adc: ad799x: cache regulator voltage during
 probe
Message-ID: <20260309193843.66136463@jic23-huawei>
In-Reply-To: <20260308182811.33471-3-architanant5@gmail.com>
References: <20260308182811.33471-1-architanant5@gmail.com>
	<20260308182811.33471-3-architanant5@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Mar 2026 23:58:09 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation. Since the reference voltage for this ADC is not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Determine the active reference voltage (either VREF or VCC) during
> probe() and cache it in a single variable in the state structure.
> This improves the performance of ad799x_read_raw(), removes the
> dependency on the regulator pointers during fast-path reads, and
> allows the removal of a redundant negative-value check.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
This is a little more complex. See below.

> ---
>  drivers/iio/adc/ad799x.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index c1a7fa37706f..28f1901698a6 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -135,6 +135,9 @@ struct ad799x_state {
>  	u16				config;
>  
>  	unsigned int			transfer_size;
> +
> +	int				vref_uV;
> +
>  	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
>  };
>  
> @@ -302,14 +305,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> -		else
> -			ret = regulator_get_voltage(st->reg);
> -
> -		if (ret < 0)
> -			return ret;
> -		*val = ret / 1000;
> +		*val = st->vref_uV / 1000;
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
> @@ -809,6 +805,10 @@ static int ad799x_probe(struct i2c_client *client)
>  	ret = regulator_enable(st->reg);
>  	if (ret)
>  		return ret;
> +	ret = regulator_get_voltage(st->reg);
This is broken for some cases.  If the vcc reg is a stub provided
by the regulator framework, or a regulator that we simply have no way
to read back the voltage from, then this will return an error.
Previously that was only a problem if we actually need this voltage.
i.e. we didn't have a vref.

So we need to read this voltage only if there is no vref.

> +	if (ret < 0)
> +		goto error_disable_reg;
> +	st->vref_uV = ret;
>  
>  	/* check if an external reference is supplied */
>  	if (chip_info->has_vref) {
> @@ -827,6 +827,11 @@ static int ad799x_probe(struct i2c_client *client)
>  			ret = regulator_enable(st->vref);
>  			if (ret)
>  				goto error_disable_reg;
> +
> +			ret = regulator_get_voltage(st->vref);

For this you can use
	devm_regulator_get_enable_read_voltage()
Read the comments for how that works with optional regulators.

> +			if (ret < 0)
> +				goto error_disable_vref;
> +			st->vref_uV = ret;
>  		}
>  	}
>  

