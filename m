Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002073537F9
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787423074; cv=none; b=Ln6ZkjLkFkShoP/6rcQ0FZDUFmCPnEXbYXKSXHiuyHhyypHiMWiPya0SsUi07eJ7C3MSomCCMGC7vodas5qtUjFBe/4b24iXXjHjJDI+/OaFktpMhMM+fgIql7PHN72NjOD1foU4z/gLYLKbJf4/0kUzZuYpjLwVKmpPUi1JWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787423074; c=relaxed/simple;
	bh=I0EoiW47USBxE6T6MYvTawQh7ajMMiXvhTvG+Px5aok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWOury8UAYR15xPzqVFtUuv8tMZSEaVLXCKBqsWsE5OXll61yAbh1Lmsy/LZvwSbLAKBkB3voOMnhQ3dAgwtDAaWHpGIjF3GSleqGKSUimOcN5g6gkpd1QatjsswGBsipLTv3jzUvznOCyr4/nqOdYlzIzQUeMMFklHpx4VpPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=D9PPhSdJ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="D9PPhSdJ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a43c2a126fso903044b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787423072; x=1788027872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AAUPoDO0LbXR3ORuYSehuTzgSLzhcn+D4ZySu9rxxeM=;
        b=D9PPhSdJwq3c489sWygiPwnXLHEr04XOslOMbw3xJVOSgMiLVwO7Lro85RQdgZuU/q
         8nREs4ly8Pz2m9mJWDbBxPvTkaMF6wmwdKYGanP24VPh3IFApH/oqw6LHrpIg0z6udqH
         yne74shUQBcd5nABZR0ghbANn1pfkmYDG0f4nr18HCfvdfMhW/5ZveZMgcSfRt8AeI3n
         5pj5fC9rIWHo+s9dAJ+OXLUUCx6b1WCGqhNoNFIdMIX8q/xY58J1MqQN+ZrLfyC5C2sl
         044n47jrqnNmJtJHGJSDaZ/F7HojjX2TNHy7wY9GJCiYsf6I9uIyS4ee7z/b5G3S+Syv
         ldWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787423072; x=1788027872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAUPoDO0LbXR3ORuYSehuTzgSLzhcn+D4ZySu9rxxeM=;
        b=CL7hwfhktZPmVTX08g4bz8pEGQsLxw3mOqpQZ3kwQJR8bpg4h9ouHTvRiY98uRiYf1
         2zJi0SyDbETh1AnwVuqxnS1xGVy8HEcZTY2acP6UIrOoY1JAo2tv9t08iGVVLzGJzjkM
         CsPG6ZK/Znvick8/1XfDgTJSpsxFl1GntO29LTGJie/vsFlBuLhUy2lBid7nG+yIZG+i
         Z0pfQwicZ9Oz1XosXitHoV4qTCX8j/IA/NxwBOt9r8U9mjmKtDQmg/tfvKtF5dMiU0FZ
         uBwC7jJsdhNd6cGKhZVw2nZAkgSP9H0JlMe/EBC+QG+LFycm/LHcvxbKefPqu83UFN1J
         Bsdw==
X-Forwarded-Encrypted: i=1; AHgh+Rrogr8/RanoD04qEj3iN22ZYirKjfzgUHCe81hv84rShFKEgSuxTSuqXIN4yQMt3mZ8aerOsgVcpZg=@vger.kernel.org
X-Gm-Message-State: AFuF++mojeHHVD2xmOGjWYVISnLwk2SD1q+6NVdLubIqLhsYZoYZm6Oq
	KVoVRTGQn6ujwODh7uYcacSnFUvLXbVcyBkhCOmOlBG52Bg1qXTFqWG+d+ZaDTPSRQs=
X-Gm-Gg: AR+sD1270v8aNN5vs8VckRf/o4e6nvfdpXXctimvzOJ/dPKGsrwPHy7w98rvndpRC/8
	mJ+nc5TU4KLzh2n5nW/1tXiI4or38y6X9+E0D3G2BQX0Y/Eb0eyGQw3WVi1ctidWP6h8ysDla8B
	rjx1KcDr3ebzrYzcZje9ZobXA2qtvPwahWO8rEkVCq1gwe8c0d2z/FXkgtqHR4z27HHdl/FwmXI
	4AhnD1+0mM92NNdONAHNYLPGfgxaDGDlhur5eppVGwVvdOL7WZ1cx4NHLr6TuGnXNN92q9rdNSP
	xasbUZ6MOpR++oco02uLJL6xtUH2Ewgt/sL5uLzx8I2KVW9kr7R4+/g+8JedO47EnzXsInggCig
	3iFwTyXtLVwwqPC7naCneYS9J40BJakOzWUliAEO5sKiA9TKk9pPSlKfAEl5qzigPUOlfb6Jpxl
	V20Sd8sAHff2iQfNn1Dmkm05mxoS9YW6iugiWeE7qUna3a4tW8h0k8X9gccxsFxolhYlfaKqtiB
	7tPGIVabwl4bPSpd2iKnBMTY8z+4YTQBktn8IU=
X-Received: by 2002:a05:6808:1998:b0:4a4:c12:49d9 with SMTP id 5614622812f47-4b30998a580mr8468928b6e.3.1787423071836;
        Sat, 22 Aug 2026 11:24:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6cdd6cbsm7668245b6e.10.2026.08.22.11.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 11:24:31 -0700 (PDT)
Message-ID: <fb0b857e-eac8-4755-9330-5cfe55523271@baylibre.com>
Date: Sat, 22 Aug 2026 13:24:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] iio: dac: ad5504: support scale via
 output-range-microvolt property
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
 <20260822085850.17527-7-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260822085850.17527-7-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 3:56 AM, Taha Ed-Dafili wrote:
> The AD5504 output range is set by the R_SEL pin, not the VCC supply.
> Add support for 'output-range-microvolt' to set vref_mv directly from
> firmware. Use device_property_present() to distinguish absent from
> malformed property rather than relying on the ambiguous -EINVAL from
> device_property_read_u32_array(). Fall back to the vcc regulator
> voltage for old DTs that predate this property.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  drivers/iio/dac/ad5504.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 74679feea385..d0a3dd4b000d 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -300,6 +300,7 @@ static int ad5504_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	struct iio_dev *indio_dev;
>  	struct ad5504_state *st;
> +	u32 range[2];
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -315,12 +316,30 @@ static int ad5504_probe(struct spi_device *spi)
>  	if (is_acpi_device_node(dev_fwnode(dev))) {
>  		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
>  	} else {
> -		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret,
> -					     "Failed to get vcc regulator\n");
> -
> -		st->vref_mv = ret / 1000;
> +		if (device_property_present(dev, "output-range-microvolt")) {
> +			ret = device_property_read_u32_array(dev, "output-range-microvolt",
> +							     range, ARRAY_SIZE(range));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +							"Error parsing output-range-microvolt\n");
> +
> +			if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
> +				return dev_err_probe(dev, -EINVAL,
> +					"Invalid output-range-microvolt\n");
> +
> +			st->vref_mv = range[1] / (MICRO / MILLI);
> +
> +			ret = devm_regulator_get_enable(dev, "vcc");
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");

We should probably handle range-sel-gpios here. Otherwise, if a new DT tries
to use it, it will end up falling back to this old wrong behavior.

		} else if (device_property_present("range-sel-gpios")) {
			
Either return an error here that it is not supported. Or implement it by
making IIO_CHAN_INFO_SCALE writable.

> +		} else {
> +			/* Backward compat: old DTs without output-range-microvolt */
> +			ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret, "Failed to get vcc regulator\n");
> +
> +			st->vref_mv = ret / (MICRO / MILLI);
> +		}
>  	}
>  
>  	st->spi = spi;

