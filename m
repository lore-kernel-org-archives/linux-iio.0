Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A4230BEC
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032851; cv=none; b=tgxl6MUBwThsYtGJ9rgCrTB0JQcI2X10dxS3HOkpbntdNTSpmpOFWJpZQWRg5UP+XOMM2+qbFuNPzWBY7p/uafNiYgmvFteu8pqy2OxzKYCmCeOnwL3kitNMCAk8M+4rw3ACApm0kJdEG5+c1SMAd+TI7yhcHQ9R88IOx3nfLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032851; c=relaxed/simple;
	bh=TC32REXWVeZhHNeKwYuLfD/UW0BhQzG14Fg9NjoPEOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwKh6nsUExhd6sv7p61vLoC6xiZRhlgN2XuhdkaBQa2MZmSxjXi3+QaTMdSqEClMH8TkVsuB2KC/N3yvPlelmuQrHABWJVRNG/i+3LFgI/a6MFR3YPpj8fsqDxaxC0mVDUAiRdXMV4OTuHhqyfNimMDv2nlCh+6xxykDI3kA+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RLVab5Dt; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RLVab5Dt"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d196a2334fso1057367a34.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772032847; x=1772637647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Z8mJJ635WxvfIhv2LBrxldcOuIqtdqvK1suPYJofeg=;
        b=RLVab5Dtj862CHGv16yU37WUpC6BjFQth3sa4RNUH89k3qFEiiEsworyowOV/NLT67
         XXp/ZrxmEXDqStV+2EfKoP8KWaVQhNqynfEih8vQn2vKRL/9280Puo9PRJdsfK6mnfH/
         V3CAqhIPNjb490v34ManGB7IWkCVp8lnNqk8rXju8iUxtb3Maea4DchYMF5gvHpYRX2F
         8Xu/uyzK8WaGZ9kWe9I1En2IMrdqNdeVtSi5CKGdX1pWrOJuHPBpGvWjjMKF7zuGMqjW
         ctXKl8eFfrBP8NFf5qxNOxi/Ch7oZgfAtgORwMq7a5+HVCh5z4eurkuTI2JuqNMqoTrK
         nz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772032847; x=1772637647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z8mJJ635WxvfIhv2LBrxldcOuIqtdqvK1suPYJofeg=;
        b=IDnVPPt5Nd4jr26jPLobmzGATwTqBw8x3Ggkq2daT4q23k8EeuOWdmi7O38Oc0gCSU
         Hbu9aN/o4t7LlDyssfRvjOqJ2bnl8Ic228QZPA0cy2oPkwMa3yvJRwaII7mjbkPE59+d
         cPVF1Ht/R9TR31dEI1j6/p8LcnY6ii8kVwRKz4S50BeqNIiyOrdCfeEHKhQ1SWZfA5de
         W/XRyRRvQoY9S54LUcjQWgZhZILpmjGS1MeGP2ZPQ8MFNWnAE0DECdW9T5whDOz+mAoj
         bLCtjrqwMnmlKtHr2BE5JfOeo2DdxE/DZmpRIXLygLl+myw5LxmnGk/GBd9veRX1WjAs
         Dt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4OMKEt+iLnctRP6fBDM139GPecnGNfqPon5qQuKW6EUlBQezCtsFvxx3zg8e7eLzC1PhyVZn3kO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVz3NTTcdf4p6M5LKAvRyBM3Fa4c/YTLx7SYpY8jz06fpNt7V1
	qh+6FszowWXMQRRmycuQjSQ7wE1uZzOifyByHmWpzya7vwz40Muqq3rdQKPhnmwSHLI=
X-Gm-Gg: ATEYQzxtGIrp1gYScy94Q/diVciCi5o+JCmeeRkP5POJoSUW1OnZK+MvrJTwYkOr/45
	SaURrACKltkBaYXxv5TwvfaB9htcefBgbVUKBi28zRf5dAltDpke/TLCpjRb3kd9hGu8xj+z6Tf
	Y1yzz1EjU6dKe5tEAtThoWdYUOwU0nOnwETKt6MIltYsSsxznyfv+f91Yqh5i/8lE/FTefkmA98
	05Vh5Gtgp2s1YuD5vuGMvm42PnfhGpPkBrV38HBUX1Kh67TZhlm7D65+d9QnwW5nhXNdKmWH7Lk
	damccTTl89lOP2awdWSYZ/Kj2pgdawvggm+IY4i4RojBtKXlS/wIWQWvtaH+4YxTkOJTrVe4wF2
	NLOIfLpL+YIkUMAt5BrsrH3+Lc3rKzFOvnC5YoF4PLkHip8dfqnSoTjEaRa50FNI5d6vebMaV9I
	Hs14sGNynrmdBM/ElHfbAnvKhqoUR/3LumRRXRusostlfsNJ60Imms/8fxn6JxJwtKkYySBYE=
X-Received: by 2002:a05:6820:22a0:b0:662:b7a0:4015 with SMTP id 006d021491bc7-679e62d9152mr1736040eaf.32.1772032847503;
        Wed, 25 Feb 2026 07:20:47 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f? ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm10904291eaf.11.2026.02.25.07.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 07:20:46 -0800 (PST)
Message-ID: <436cefe2-2ccb-41f6-89ec-921e234dfa32@baylibre.com>
Date: Wed, 25 Feb 2026 09:20:46 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
 <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/26 5:53 AM, Marcelo Schmitt wrote:
> On 02/25, Giorgi Tchankvetadze wrote:
>> The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the write
>> path treats it as MICRO. Since no write_raw_get_fmt is provided, the
>> IIO core defaults to MICRO when parsing userspace input.
>>
>> This means reading calibscale and writing it back results in a ~1000x
>> gain error.
>>
>> Change the read path and available range to use MICRO to match the
>> write path.
> 
> The updates to ad4030 driver will add write_raw_get_fmt() [1].
> [1]: https://lore.kernel.org/linux-iio/516cccc47e917bd26be29b016907f50a244a68b9.1771865684.git.marcelo.schmitt@analog.com/
> 
> At first glance, I think this could instead add a case to write_raw_get_fmt(),
> keeping calibscale nano precision (unless nano precision doesn't make sense
> for ad4030 calibscale (don't recall from top of my mind)).

Since this is a fix and needs to be backported, it probably make sense
to not depend on a patch that is adding new features.

I'm sure Jonathan will have an opinion about how he would like to handle
a conflict between the fixes and testing branches though.

> 
>>
>> Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
>> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
>> ---
>>  drivers/iio/adc/ad4030.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
>> index def3e1d01ceb..3d823648371d 100644
>> --- a/drivers/iio/adc/ad4030.c
>> +++ b/drivers/iio/adc/ad4030.c
>> @@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
>>  
>>  	/* From datasheet: multiplied output = input × gain word/0x8000 */
>>  	*val = gain / AD4030_GAIN_MIDLE_POINT;
>> -	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
>> +	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
>>  				AD4030_GAIN_MIDLE_POINT);
>>  
>> -	return IIO_VAL_INT_PLUS_NANO;
>> +	return IIO_VAL_INT_PLUS_MICRO;
>>  }
>>  
>>  /* Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain */
>> @@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
>>  
>>  static const int ad4030_gain_avail[3][2] = {
>>  	{ 0, 0 },
>> -	{ 0, 30518 },
>> -	{ 1, 999969482 },
>> +	{ 0, 30 },
>> +	{ 1, 999969 },

This loses precision. Instead I would change the write to IIO_VAL_INT_PLUS_NANO
to match the read.

>>  };
>>  
>>  static int ad4030_read_avail(struct iio_dev *indio_dev,
>> @@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
>>  
>>  	case IIO_CHAN_INFO_CALIBSCALE:
>>  		*vals = (void *)ad4030_gain_avail;
>> -		*type = IIO_VAL_INT_PLUS_NANO;
>> +		*type = IIO_VAL_INT_PLUS_MICRO;
>>  		return IIO_AVAIL_RANGE;
>>  
>>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> -- 
>> 2.52.0
>>
>>

