Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5433506C
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905418; cv=none; b=W9PqiSov8UMe5I78ZV4kJjqBPbjkC2bQpwwO/l1cPZqSKwVXdksZaHjLSauF2fAO3hJ8NORG5S6paxrYExpMu6MH583WFfHVEPz4jrBo/lEFp0zCV/Ag3PGht/bTX2bujv/34Ykzj2uvSxsFXKTWlYvrOzVLMngR/iGCKtzLogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905418; c=relaxed/simple;
	bh=tr3p0PTcxBuivh7N96rweUQQ9Gz4LSzHd362mmpnOeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVXV1YvzxrLgZK1fH+jKfbzrAbbl1oyTsaInr4k/ZgXioLv040MkPrUYr9Nl/hvUB0VAZyJtaelBBHBs6YtoxpIZvyqhbQPEAyYTDVxJzspeGfo0jYn31+7ci7wd/OCxxltphEQ95qRgNmYGFm7A59EWDmUHrDwZkZMpFTCPadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1TpsEIm0; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1TpsEIm0"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d73e0e0a36so112610a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772905414; x=1773510214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFhakp+HczB4woBZn1FB3ZG86sZEhfSMF0Ogqoecu3o=;
        b=1TpsEIm0pN9LaPZsRxiotl1Z1hcidj1wq/uStCvVIRCusKzdaau/vHIEj+xOvqh6wZ
         V89pUfEPr0o8wz13Lj2OzynbAX+r5j6wthhu4H+2oKrRzbaMeSdHoluxZoDFaMIbBqcJ
         m+Lf0QIuWsJYlIaRN0H+hmkoShy+ykY2tWG+nS4jUzcsMuZc4KkBz28JkgJgnXLBy29U
         369cQk941BHSm7wP1NbwxuBnBXXJDMDMAiJlDx/rPI82Wpf7VzjyQjpLApB1BrPAcmcQ
         VAxf8sAYWFMpW9/CWTqEMWn4eCqd1zWQUXUU00xdzCgYwONEveWpezHJ/FxWl1CdC3ri
         VmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772905414; x=1773510214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFhakp+HczB4woBZn1FB3ZG86sZEhfSMF0Ogqoecu3o=;
        b=AlJHdszyxyak174nCsv5EBnz+J4meCKqSmlh9QRRbYUcCmBNmaPOC4+XpUMubwhVZE
         t8W46i6HtFQH/5g4NJ1TR3lHzFY7fzJNJkmusIUXOpgkCJHp8sOzOoojyfobt4rW8cSd
         ZUL8m6ePaPAapRpNDxDrt9Fi+6IKPtEW1MRLc08Uhv10uAVqUKeM2siH9Yi6cCju4w2H
         khN4Qstvs6EFbgitwQUiSxGlpkhnfaDeE1BGsRpRZ6iCrkr+JzaDs8DyHaf9LC2tZ9Y8
         y47Jzwe0mzeZo03TNapQs4KMqmUvaSKpB7wheucbN7fpE6H7PkeHlTWo0OX15XpXTFCl
         T9sw==
X-Forwarded-Encrypted: i=1; AJvYcCU8niAok+dXrFUoe4/pafODZrExYBqTYCDEJ6/gsCFCUAt4UvSlCCSYBrDAk6BiwR65g/1lZ1f0mfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh75pQhy6NcYbRDoI9OAz3MhMRo8IEZhwOZ41iNFUomp36Nzo/
	wilO9r5trT5878dKUcs66GXpv6bbshu7VzQFP+iqQqWDgF8ZCIec4HTOMoLnDn8K+60=
X-Gm-Gg: ATEYQzwSmKaBlh9UXYTJBzmqYKrAd0zdKSMnlrwvDPdycV0xAwggeu1oA0KtZyDSKa+
	lCQ2b4VNUMQ/ovZJgpttdfTxhJrRdFiFMoMP0BaCLHenrbdhdpX0B0W/YCLJPreTa4Es4rcdJuK
	6zIIsoi/VA7JgER2HLGyVmR/pgu5s0aX27WJEfKGf6Q8CkRIPaQMNYZragZXLk8ur5KCO/Ylcka
	jITaq5r6gmU0/aoJevymBQxJqy4gb62d1SMgzIvpUJvg6LMYSBvRQC+27zSUeEq8J3YBudz7OnN
	pBw/LRLPMuwjqXj36oyaWQxJHWa4LW7LPjW/q0mZgZn+myIUMghppLbsCf8KUUP5b7TFATq2fuF
	MHNgZcgLNYM+6h3NHchnd1CQMmyAOGT5oGpRiTxJJSuBp4BdSYvqnaZsf7VxGRKIcFLxWm6TULT
	Axa6Em3tG1ST7NsVcH5VGX9DgoNLPmH98V3ezeRx2aGY/fSslosXlyifVNQGLZpBugnz4pQZIy5
	A==
X-Received: by 2002:a05:6830:838c:b0:7c7:58e9:8e16 with SMTP id 46e09a7af769-7d726f5daf1mr3850525a34.14.1772905414081;
        Sat, 07 Mar 2026 09:43:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728d2eef0sm3316571a34.24.2026.03.07.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 09:43:33 -0800 (PST)
Message-ID: <27ffa24d-a388-46eb-8df7-04624cd32ea1@baylibre.com>
Date: Sat, 7 Mar 2026 11:43:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
To: Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
 <20260307114947.0b946dfb@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260307114947.0b946dfb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/26 5:49 AM, Jonathan Cameron wrote:
> On Thu, 05 Mar 2026 11:21:56 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> The regulator is enabled for the entire time the driver is bound to the
>> device, and we only need to access it to fetch voltage, which can be
>> done at probe time.
>>
>> Switch to using devm_regulator_get_enable_read_voltage() which
>> simplifies probing and unbinding code.
>>
>> Suggested-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Hi.
> 
> I think this broke the ACPI case (where regulator isn't available).
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/ti-ads7950.c | 45 +++++++++++---------------------------------
>>  1 file changed, 11 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> index 273c35e03185..847e83baa876 100644
>> --- a/drivers/iio/adc/ti-ads7950.c
>> +++ b/drivers/iio/adc/ti-ads7950.c
>> @@ -341,19 +341,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>>  	return st->single_rx;
>>  }
>>  
>> -static int ti_ads7950_get_range(struct ti_ads7950_state *st)
>> +static unsigned int ti_ads7950_get_range(struct ti_ads7950_state *st)
>>  {
>> -	int vref;
>> -
>> -	if (st->vref_mv) {
>> -		vref = st->vref_mv;
>> -	} else {
>> -		vref = regulator_get_voltage(st->reg);
>> -		if (vref < 0)
>> -			return vref;
>> -
>> -		vref /= 1000;
>> -	}
>> +	unsigned int vref = st->vref_mv;
>>  
>>  	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
>>  		vref *= 2;
>> @@ -382,11 +372,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
>>  
>>  		return IIO_VAL_INT;
>>  	case IIO_CHAN_INFO_SCALE:
>> -		ret = ti_ads7950_get_range(st);
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		*val = ret;
>> +		*val = ti_ads7950_get_range(st);
>>  		*val2 = (1 << chan->scan_type.realbits) - 1;
>>  
>>  		return IIO_VAL_FRACTIONAL;
>> @@ -580,30 +566,24 @@ static int ti_ads7950_probe(struct spi_device *spi)
>>  	spi_message_init_with_transfers(&st->scan_single_msg,
>>  					st->scan_single_xfer, 3);
>>  
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
>> +	if (ret < 0)
> 
> I think you need to check for -ENODEV and if you see than then
> see if the acpi route below applies.  Otherwise on ACPI this will fail
> and we'll fail the probe.
> 

Or do something like:

	if (ACPI_COMPANION(&spi->dev)) {
		ret = devm_regulator_get_enable(&spi->dev, "vref");
		if (ret)
			return dev_err_probe(&spi->dev, ret,
					     "Failed to get regulator \"vref\"\n");

 		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
	} else {

		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
		if (ret < 0)
			return dev_err_probe(&spi->dev, ret,
					     "Failed to get regulator \"vref\"\n");

		st->vref_mv = ret / 1000;
	}

> 
>> +		return dev_err_probe(&spi->dev, ret,
>> +				     "Failed to get regulator \"vref\"\n");
>> +
>>  	/* Use hard coded value for reference voltage in ACPI case */
>>  	if (ACPI_COMPANION(&spi->dev))
>>  		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
>> +	else
>> +		st->vref_mv = ret / 1000;
> 
> 

