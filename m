Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200072D6E6C
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299107; cv=none; b=ky90WITERb8fLG7/mkFPpzAl49CFzklW68JNH7gc0PYkotbHzfv0UXj+B2ggyoq9jwrlif5RFoC7zPduDEJwdY8ZogV/VzBF6Swp+YPxJPu8Bn9KTB0sVcfhrdzGw6zuuPBDYiGMaCuTVE88IkzvsV9RKdvIT8uxF7YlwGs4vaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299107; c=relaxed/simple;
	bh=idqgkYUCHfUYgMSymQu8BsZ7cjUbG0UF6B0RcoRLpdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQzut6KloMuOPcMNha8mxP/DdcYMpWqYwdLSQLpc39spvRaQ6mVAQLGK3UC4y5E8M9cRuVE6L3p0apjg8vn4o5kHPsC3C/E/+3P8NtmOMs9s//oJq7oDlI1CPGN1ZzCF3//zsYvgNKwO1RNV+aPIvtzCsZtbkZL+9f/9Owy/GvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zZJ0CJ/n; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zZJ0CJ/n"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-464ba2bb3aeso2182132b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772299104; x=1772903904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zA8twdwXSjWkWc+DO82+Rr7rQ9hV2ihUMWLKEI8UmeY=;
        b=zZJ0CJ/nlBxsAHlk8lzoi12011FJDvchRy34a4OuJmZXvOgvXGTYRxYEua8iFlN1jK
         q26v5yfBUeWFVCuRN+bovijeeuZcJ555TmgpKDxQUOJzLSw3BtYy0oLFSfSZmtj7ANHR
         BeXgzUvfAvuK4hto0+9vUfTd5JaHdx+TT+lNBrqxfBH1LBrryzNUTF498vP9/xoBaLQf
         iMjOpn38kYg/ladNhSncoq7hb6sUInV8mX+lbtDul+wWTMMm3iUtiQllE0Y1Xt6Z8Tze
         n61rZ9oqmeOIq4ff2Clr/5l54nDB81oI4hAKKbhx0P3bqawMFAgxlJLF6SqXuXY+x6I+
         /Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299104; x=1772903904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zA8twdwXSjWkWc+DO82+Rr7rQ9hV2ihUMWLKEI8UmeY=;
        b=rPPDSHwmJU+H8W0Vj4tE1cC1k2hKPPDsWwQ99nj+4z54ckras4EAstYaSnOf61Migu
         iuW/k+bNINIIkQ7kIhT9KbcfZ4CCsZjBdPFWbObiEw2oKV0pu4jhZ+8NEGDdHL1XoVhk
         4PGaRA1CnByGyzwZIo83uL4rUY+YRnawj/QrYSUc8kFNXllvEr+u0UV2GSk0ACpcJpHa
         a9SZNDkDkshRKwBkUwbJHD98yE0BrsDFurr1oGS2H3BlaI+gMu7LLGLtkJ4hTbY8FxoF
         XG/F1nMv6skgXueYwk8XJz/buyOz242Ymw2cppZ3fXxkXTu/Kbx5m34p3YlsOaTUmmiy
         Oltw==
X-Forwarded-Encrypted: i=1; AJvYcCWt0fAqASjBnNeMwRpjCx68G14+mQI68H3ecJsWDJekWYr/WovVP6EsPQcg+V2Pau30IWoYiXqVgi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbihduRa/z9vlAFs1tRvRkW22C6ypmLY2CJ3Tx/QUgZKoSuKUa
	4hUxtaSaB2Q5I1vtnuxA+9XroFJ9xDX4HT1Z5BeK2mehLaiZ452tHYUwPEE5x1mmzss=
X-Gm-Gg: ATEYQzyU1abx+FJ6EC6/UQHv267fLKaOk0TcGvPMUW7tEYqerfULBOeAtbuZ8J6LDW8
	fyFU730u40jLa8lElRU4hKTV8SyUlS8fQ+Cdvj/oiep1p31le6KqM+olcCmrnOWZMUhV5/VsWg4
	S75BPNo9gtZfxN/c8Iaa4CCx+rXQ3m0Yzyzsaktgb2Pfrh5m1TSnOPr0vl1YjVbI2zNGiJyI5Sm
	8Q4VmyMqQx1C1R2XMKPn0k6FOLd0os5ukStFh3x06a/CtaJ1e3zb0O8hBpRXgKnRZ8NpW+HpLwr
	lXcxliImwO7IT8iR8AJo88M23syQt4IPc+1NxqthnKDkps2hvfjywR/pTLWFGdEcXDzoExLGQa4
	Ui0aoPiALj57mJYYd4J9ho50ISuy2UrjYxf8iNjqgDzIfu6vgO7IiebfqkY6IxX1EDkJC6ernlL
	dFAJVsIRmah3ObVq3HUXNfhgkuZOF/C1Nac9lOQrRACMZOrX1hh1fjxGtnlRH25ar1mYHyNTFpE
	g==
X-Received: by 2002:a05:6808:c3ec:b0:45f:1f4:f522 with SMTP id 5614622812f47-464befc2afemr3559447b6e.25.1772299104088;
        Sat, 28 Feb 2026 09:18:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm4143355b6e.8.2026.02.28.09.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:18:23 -0800 (PST)
Message-ID: <ca6f9ec7-ec58-4628-b41a-c2e4beb67777@baylibre.com>
Date: Sat, 28 Feb 2026 11:18:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for SPI offload
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, jonath4nns@gmail.com
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
 <79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 5:59 AM, Jonathan Santos wrote:
> The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> the capabilities of conventional triggered buffer operations due to SPI
> transaction overhead and interrupt latency.
> 

...

> +static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	const struct iio_scan_type *scan_type;
> +	unsigned int unused;
> +	int ret;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits);
> +	st->offload_xfer.bits_per_word = scan_type->realbits;
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "failed to prepare offload, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
> +	 * continuous read mode. Subsequent data reads do not require an
> +	 * initial 8-bit write to query the ADC_DATA register.
> +	 */
> +	ret =  regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
> +	if (ret)
> +		goto err_unoptimize_message;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +	if (ret)
> +		goto err_exit_continuous_read_mode;
> +
> +	return 0;
> +
> +err_exit_continuous_read_mode:

I wouldn't mind a comment here explaining what this read does.

> +	regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &unused);
> +
> +err_unoptimize_message:
> +	spi_unoptimize_message(&st->offload_msg);
> +
> +	return ret;
> +}

...

> +static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	/* Requires 1 or 2 args to indicate the trigger output signal */

Would be more clear to say "up to 2 args are allowed, but only 1 is used".

> +	if (nargs == 0 || nargs > 2 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
> +		return false;
> +
> +	return true;
> +}
> +
