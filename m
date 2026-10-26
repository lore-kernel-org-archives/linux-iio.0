Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973501;
	b=VV3NxFkb7lOeviuGKkXzFQYvJ591L0HLgAezPEe5iaAS74tqE/efSqHts4oNjZoq0Da8
	 m3nzP7akxpmx6TJLhLTjckzitfqCh6zBbPRmmloQfLpntAgSCLxjLnKH4w6rb+a1tlthG
	 lByr5+aqpbt92+7m/oPbSDBvv8aoOVivvIIRtUr2/OOsKYhhm07xin2fNyTW429dzxF2F
	 qDd2Y7mG4RE9wWqaXhqRYoKO2RixCd3acozPe+qACJ9wMisF6nw8y4M5x7DdIOnumLKDC
	 vKY+IQCdisF6sr0OSr3qS/m9eQHIWatrzn+9NvwyYqKfq0O9A5VVmd5+m8OdyTH7zkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rsqxAz7lqfB62WUBWW1eOoWDX04yDtpDlQeAS6FSONM=;
	b=Mbhy1Yi2GXRJruJ19bCX9NcSmp2WJearCWwVgSCoNOdCZxH9q9WzS7v3vD6l6yHA8poR
	 OUWi0QKaxM+yWfBJM/bMrjOWSrR8H/OWja3wXRFPwJMv2485ZLNc8E8yl1Xg4LhQpfjIk
	 YabjxWzv5v4L3HIYTikYKMyso8KTFtA2qVbaKpHsohujxAAk0shM/nouQnxwPeXellg96
	 +uFTkOYNGSX49mysJSuI5o9F4j0bvUR4ggpQ16JOMWx25jylmULwQcMjwn81C2jlFbpjo
	 uuclYTP/YDt7ppYMJ0cHPAcrmMrJ9DDBRDJ2yAR7ESJIB8nfzwyAgiUn5DySf4k+wFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvwtPgnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729E606A31A;
	Mon, 26 Oct 2026 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvwtPgnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE2C1F01829;
	Mon, 26 Oct 2026 00:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973501;
	bh=rsqxAz7lqfB62WUBWW1eOoWDX04yDtpDlQeAS6FSONM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HvwtPgnbuwetsVWXXssnFHCP/M8UWpbIWGcioo2dwCtZlINpELRyJmXvs3oi7PHpj
	 UUevTDDFYKfca3T0tpuGJzJgVhyTND8ZWdI3fqsyhxVn8LSdrJyjzPFLGFhdqDIMmw
	 0eU9+8OBtPdQb52Q2hOsq5XRt/rupNLzMGn8hwnEco4ygUAIliaETqHYjwMqVlIgF7
	 nkTC6+Vihl5L74ytuabu6BiNwRuqljtxkJJJ2IfYDmHuaozWsR0qvme3Zm9R1IyfKW
	 Jn7GP8iwbsNnVydaJE7B9SdnE81PDZ/Fn76zEQU/1S98OfYrtHBDrCxNrugCL3VTXI
	 u8u6cbts3vlXQ==
Date: Mon, 26 Oct 2026 00:11:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 7/8] iio: imu: adis16607: Add external clock sync
 support
Message-ID: <20261026001132.3c76529a@jic23-hlaptop>
In-Reply-To: <20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
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

On Fri, 23 Oct 2026 12:30:24 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for an optional external clock (clocks property),
> selecting between SYNC_DIRECT and SYNC_SCALED modes depending on the
> supplied frequency, with the internal 8 kHz clock used as the default
> when no clock is provided.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

> -/*
> - * No external clock sync support yet: always run on the internal clock.
> - * Default dec=0 after reset, so period = 1 / clk_freq_mhz.
> - */
>  static int adis16607_config_clk(struct adis16607 *st)
>  {
> -	st->clk_freq_mhz = st->info->int_clk_hz * MILLI;
> -	st->sample_period_ns =
> -		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * MILLI, st->clk_freq_mhz);
> +	struct device *dev = &st->adis.spi->dev;
> +	const struct adis16607_sync *sync_mode_data = NULL;
> +	unsigned long ext_clk_hz = 0;
> +	u16 sync_scale = 0;
> +	u16 dec;
> +	struct clk *clk;
> +	int ret, i;

where there is no other particular reason for ordering, reverse xmas tree
preferred.


> +
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk) {
> +		ext_clk_hz = clk_get_rate(clk);

Hmm. What if it is a controllable clock?

> +
> +		for (i = 1; i < st->info->num_sync; i++) {

		for (unsigned int i = 1; ...

> +			if (ext_clk_hz >= st->info->sync_mode[i].min_rate &&
> +			    ext_clk_hz <= st->info->sync_mode[i].max_rate) {
> +				sync_mode_data = &st->info->sync_mode[i];
> +				break;
> +			}
> +		}
> +
> +		if (!sync_mode_data)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Clk rate: %lu not in a valid range\n",
> +					     ext_clk_hz);
> +
> +		st->sync_mode = sync_mode_data->sync_mode;
> +	} else {
> +		st->sync_mode = ADIS16607_SYNC_DEFAULT;
> +	}
> +
> +	/*
> +	 * Write the full desired sync state explicitly for every mode,
> +	 * rather than only when enabling non-default sync: USER_SYNC's
> +	 * documented reset default (0x0000, direct mode / scale 0) means
> +	 * this isn't fixing a known reset-state issue, but each mode
> +	 * establishing its own complete state here, instead of only
> +	 * touching bits conditionally, is simpler to reason about and
> +	 * doesn't depend on that default holding true.
> +	 */
> +	ret = adis_update_bits_base(&st->adis, ADIS16607_REG_USER_GPIO_CFG,
> +				    ADIS16607_SYNC_GPIO_MASK,
> +				    FIELD_PREP(ADIS16607_SYNC_GPIO_MASK,
> +					       st->sync_mode != ADIS16607_SYNC_DEFAULT), 2);
> +	if (ret)
> +		return ret;
> +
> +	if (st->sync_mode == ADIS16607_SYNC_SCALED)
> +		sync_scale = DIV_ROUND_CLOSEST(st->info->int_clk_hz, ext_clk_hz);
> +
> +	ret = adis_write_reg_16(&st->adis, ADIS16607_REG_USER_SYNC,
> +				(st->sync_mode == ADIS16607_SYNC_SCALED) ?
> +				ADIS16607_SYNC_MODE_MASK | sync_scale : 0);
> +	if (ret)
> +		return ret;
> +
> +	switch (st->sync_mode) {
> +	case ADIS16607_SYNC_SCALED:
> +		/*
> +		 * sync_scale is a rounded integer, so the hardware's actual
> +		 * effective rate is ext_clk_hz * sync_scale, not necessarily
> +		 * int_clk_hz - use the real value here so sample_period_ns (and
> +		 * therefore FIFO sample timestamps) don't drift from it.
> +		 */
> +		st->clk_freq_mhz = (unsigned long)ext_clk_hz * sync_scale * 1000;
> +		break;
> +	case ADIS16607_SYNC_DIRECT:
> +		/* DIRECT: external clock is the effective internal rate */
> +		st->clk_freq_mhz = ext_clk_hz * 1000;
> +		break;
> +	default:
> +		st->clk_freq_mhz = (unsigned long)st->info->int_clk_hz * 1000;
> +		break;
> +	}
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL * (dec + 1),
> +						     st->clk_freq_mhz);
> +
>  	return 0;
>  }
>  
> 

