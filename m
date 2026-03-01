Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E3322B6F;
	Sun,  1 Mar 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371364; cv=none; b=h7+IFJzpPCtaa543dwfU7vBqwQ+B6n0BJQgqhysN9q4aEf2zSqGwL7lF26EOspwDjUFnvbxy/CriN+oEa7lJ7pzLts2KrYrZTArDETEnMB7+mFHBJP7nV7hikuGpe4wfbaDGDR1I9koruvSPp5ziXwRYYqkQUvXpGSnjuIcMhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371364; c=relaxed/simple;
	bh=ewaT/AczdVrgjT85pS7mzH/7ZX4XAvQziqNe7y3qZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4ycULq8DkS6U7NKv51nC8bTthA89NKvu7XnyvWoa2WwUmqOOx5RfHR4EaCdLtKRUrKMlKEoxPPBQY+C6nsU/Il9n4Bt9Lv9nF/WpuPTJ8jUIY72LmG6IJTctyqo6oyMvvBfQxeJp5QQ4Xid0PZJv/+Qr3rmkyTxwypEy/JtxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X71BLiWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X71BLiWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBD8C116C6;
	Sun,  1 Mar 2026 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371363;
	bh=ewaT/AczdVrgjT85pS7mzH/7ZX4XAvQziqNe7y3qZ6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X71BLiWvPR0GBHo5jebrikMcnfEy6z9KEtkUtfry6eDYH3ADgj6br8ZjgGmbujv0v
	 ArGOtbi9xGj9+Wg+Lu7QeL0RSZnEXOe3Ar2jjbHSp9ih7z7q1KctT9AdkPFndhTgjg
	 /QM3TxWY2MvCISM1iDez+lNq1rKtr5o5BdF+Fz+4T1BGkTCZiQroCHFGtAeS1bU6Zo
	 8UfsP9y4zwkUtBAhNnVanGuvu1u1joObCze5oeITvLxUIOgL3BUnyPAdgE+oZ/Gysi
	 IEaZidZUg7YZkGf2Y6ztJvy1qYysW60zNMqrCpJeGoVfRV+v+xFmNxLakUEiMOWGOp
	 VK/toZdhAmDWg==
Date: Sun, 1 Mar 2026 13:22:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 3/8] iio: frequency: ad9910: add simple parallel
 port mode support
Message-ID: <20260301132233.1ab64642@jic23-huawei>
In-Reply-To: <20260220-ad9910-iio-driver-v1-3-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<20260220-ad9910-iio-driver-v1-3-3b264aa48a10@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:46:07 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parallel port channel with frequency scale, frequency offset, phase
> offset, and amplitude offset extended attributes for configuring the
> parallel data path.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
One trivial comment below.

> +#define AD9910_EXT_INFO(_name, _ident, _shared) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, _shared, ext_info)
> +
> +#define AD9910_PP_EXT_INFO(_name, _ident) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, pp_attrs)
> +
>  static const struct iio_chan_spec_ext_info ad9910_shared_ext_info[] = {
>  	AD9910_EXT_INFO("profile", AD9910_PROFILE, IIO_SHARED_BY_TYPE),
>  	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SHARED_BY_TYPE),
>  	{ },
>  };
>  
> +static const struct iio_chan_spec_ext_info ad9910_pp_ext_info[] = {
> +	AD9910_EXT_INFO("frequency_scale", AD9910_PP_FREQ_SCALE, IIO_SEPARATE),
> +	AD9910_PP_EXT_INFO("frequency_offset", AD9910_PP_FREQ_OFFSET),
> +	AD9910_PP_EXT_INFO("phase_offset", AD9910_PP_PHASE_OFFSET),
> +	AD9910_PP_EXT_INFO("scale_offset", AD9910_PP_AMP_OFFSET),
> +	{ },
No comma

> +};
> +
>

