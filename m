Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022737F73D
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256737; cv=none; b=Gny6xpvxWKKyHlRe7hmL9yM9j+voDPRhJrn4OTDsx1UZWM8vi7JEJpeCkc+8qTtn2FYHIHM3e4ePEqsmZX10yargaQLpgZKj7w4o6gdkCmbQ7cod+JB8GTqwFHIvk+GjYNJILeAvuFUsLy4XkZ8Wllc3GDJbp7MD4MCfRnsE7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256737; c=relaxed/simple;
	bh=YERU9lGLc4HxubUX/2xk67xtWZgCAKYhkF4vIDq8Nis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqKBsXhbv4r+Iv2M5FKRKPyeXUE2HpXTpPS4TL2h4Awy+Jfaw0N0x4uc51BrO3zp3jhx9dwHuLSRXpGobDE7xjfVZfbaOwFnDHbdia4i1+qXI5p2e4pXYxlP++uw093v8f++w4KDP9AwfIYlIVke87aZcoCEr0FhyMzBb3n/QMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbp0mxDa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbp0mxDa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d383e64so158715e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256733; x=1785861533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5XFsM6KMXkxUPT4JFUTf8mTgfLrrGUKQGVmfyuLu9Y=;
        b=Gbp0mxDaERzf/KfY8g8StxwYVo2VUQBaJTWazdTxFnkQV25M8KGdyYIdK3U3ihUuRa
         3snNYNdlczosfQOBBCPcOLSHllzBrulEYNtqnn8E8ZRTklOYGcsMXXvOLeEW18SuavzN
         8wE+yLvFtGDDRl276rawszvYkPOOL0f0JFg5XooZp3C9oynNubxA3L3krGRAqVrSbTaz
         nrOaaz6K6ZjFxXBQMt5cX100DwH3DVEExfluAprFAQ5VuovJ0Npnj5akxDT8hNogg6zs
         J4pf0YqOC84dumMZlAP8A6X+QoAEbEsuQJOdCJ7F+cVZhJ6hvJn4lCAiSmBuwxbcbgpH
         zSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256733; x=1785861533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u5XFsM6KMXkxUPT4JFUTf8mTgfLrrGUKQGVmfyuLu9Y=;
        b=sLyccjFAZLCiXzaizsJUIkSmvED/KSMaNYFUWJ0HN256S1yHGx9pajxB4QZ7OG7F+V
         FfjsPMIBypQMSHFcgN4bEqFEJeS1XNllLT36LfpykNdza88Q5WfZNHvAWRVZWx+SzxlW
         4YQdv/FrD+sbEpegB2NZmv/SIOD3hvonkz2zVDZPH4zBWAk8PE3HLDU9iT8VmvEfhepu
         sD2pd/QdTOSqY1pAYS+ck6I6M8lR2fsvY9LcTKJ6zH8qA+okwOBdFY1kxoklE0hQSPOT
         1jMJWNmjX3kfDmS900jPcM9++Qg9JKUpVy/u3zy/Xdp2I+s19s2typCRBXxITfrsvmFC
         T+/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6VSMtXaV7PgqHmrXuVu3BSk0wM10t+Xx541VB3H/QTuL1A9+QpObeiZ9rbYzC++Lt/pTwDMHPV7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9lnVLkm1cMZQg11aO9Q7AKL4QQ9QMrvE57NtbOf/VzgIamO8
	o1s0e2g7Qe/HE0WOa8mJgYgbSNj9k3Uct0sQECsqIidWntFrKUMJ2KQj
X-Gm-Gg: AR+sD11rZD1Hgu1evgc9hx64tJEb6X9D5B/KBRBOjFfMfWA9Y7t6VWo8dC/AnfDg+my
	xQPJttbMusUUjma6+h+dxqO7aybdcIzw/I86hmFwKowXQrLVmd25VUDayYd6YTGbLW+Ed27O409
	VKo2xaIqn0SF4afYkMG9JCY8wQC8nh74nCEs9RqddBwAQ5XdR4sbLYVuB2NlOUvLsKghm6s4xMk
	AEuR2aT+waak4dwW98PjaXnlUqPc4kty4oYN3DK5IEOzgPeAhKztYNsj0bsQxCNbmrlvpWPe+WJ
	SMilD7t1YUweDswT0KN/vNHc8o9RDmXXqDLYX2voe1w0KaF8KLJy/bkyhiI/w4rNf1FW9flGYTt
	zBhQNhEZfWRenZulK7dEf9IMHUsWqRa2WeNgDEnlOVtFPXke7eQaRLfWBUKUQKYICa+378w==
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-496c6590745mr34852405e9.18.1785256733183;
        Tue, 28 Jul 2026 09:38:53 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a32sm514572f8f.2.2026.07.28.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:38:52 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:40:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: dac: ad3530r: parameterize DAC resolution
Message-ID: <amjbOIMuS3MFpesz@nsa>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-3-324949dc72da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-3-324949dc72da@analog.com>

On Tue, Jul 21, 2026 at 04:47:12PM +0800, Kim Seer Paller wrote:
> Add a per-chip resolution field and use it in the raw read/write and
> scale paths instead of assuming 16 bits. Drop AD3530R_REG_VAL_MASK and
> AD3530R_DAC_MAX_VAL, which hardcoded the 16-bit width and are now
> unused.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

You could have stated in the commit that this in preparation of a
follow up commit. Anyways:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/dac/ad3530r.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 06b7f280f61b..97483534f8c3 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -61,14 +61,12 @@
>  #define AD3530R_SLD_TRIG_A			BIT(7)
>  #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
>  #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
> -#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
>  #define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))
>  
>  #define AD3530R_SW_RESET			(BIT(7) | BIT(0))
>  #define AD3530R_INTERNAL_VREF_mV		2500
>  #define AD3530R_LDAC_PULSE_US			100
>  
> -#define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
>  #define AD3530R_CH_PER_REG			4
>  #define AD3530R_CH_PER_BANK			8
>  #define AD3531R_MAX_CHANNELS			4
> @@ -99,6 +97,7 @@ struct ad3530r_chip_info {
>  	unsigned int num_channels;
>  	unsigned int num_banks;
>  	unsigned int num_op_mode_regs;
> +	unsigned int resolution;
>  	bool internal_ref_support;
>  };
>  
> @@ -310,7 +309,7 @@ static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
>  	int ret;
>  
>  	guard(mutex)(&st->lock);
> -	st->buf = cpu_to_be16(val);
> +	st->buf = cpu_to_be16(val << (16 - st->chip_info->resolution));
>  
>  	ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
>  				&st->buf, sizeof(st->buf));
> @@ -340,12 +339,12 @@ static int ad3530r_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(st->buf));
> +		*val = be16_to_cpu(st->buf) >> (16 - st->chip_info->resolution);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mV;
> -		*val2 = 16;
> +		*val2 = st->chip_info->resolution;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
> @@ -361,7 +360,7 @@ static int ad3530r_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val < 0 || val > AD3530R_DAC_MAX_VAL)
> +		if (val < 0 || val > (1 << st->chip_info->resolution) - 1)
>  			return -EINVAL;
>  
>  		return ad3530r_dac_write(st, chan->channel, val);
> @@ -525,6 +524,7 @@ static const struct regmap_config ad3532r_regmap_config = {
>  
>  static const struct ad3530r_chip_info ad3530_chip = {
>  	.name = "ad3530",
> +	.resolution = 16,
>  	.channels = ad3530r_channels,
>  	.regmap_config = &ad3530r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3530r_channels),
> @@ -541,6 +541,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
>  
>  static const struct ad3530r_chip_info ad3530r_chip = {
>  	.name = "ad3530r",
> +	.resolution = 16,
>  	.channels = ad3530r_channels,
>  	.regmap_config = &ad3530r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3530r_channels),
> @@ -557,6 +558,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
>  
>  static const struct ad3530r_chip_info ad3531_chip = {
>  	.name = "ad3531",
> +	.resolution = 16,
>  	.channels = ad3531r_channels,
>  	.regmap_config = &ad3530r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3531r_channels),
> @@ -573,6 +575,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
>  
>  static const struct ad3530r_chip_info ad3531r_chip = {
>  	.name = "ad3531r",
> +	.resolution = 16,
>  	.channels = ad3531r_channels,
>  	.regmap_config = &ad3530r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3531r_channels),
> @@ -589,6 +592,7 @@ static const struct ad3530r_chip_info ad3531r_chip = {
>  
>  static const struct ad3530r_chip_info ad3532_chip = {
>  	.name = "ad3532",
> +	.resolution = 16,
>  	.channels = ad3532r_channels,
>  	.regmap_config = &ad3532r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3532r_channels),
> @@ -605,6 +609,7 @@ static const struct ad3530r_chip_info ad3532_chip = {
>  
>  static const struct ad3530r_chip_info ad3532r_chip = {
>  	.name = "ad3532r",
> +	.resolution = 16,
>  	.channels = ad3532r_channels,
>  	.regmap_config = &ad3532r_regmap_config,
>  	.num_channels = ARRAY_SIZE(ad3532r_channels),
> 
> -- 
> 2.34.1
> 
