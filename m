Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0A33E347
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159961; cv=none; b=ETSdrXWrew2sTOFayqHWmho4q6PiEr3AvD4DMK5hWjR0V9N1Lvm386CJLovoSD5n6J6stOx3w5X1uqQhyZsbfTAqhW7sLN04od5lJrauDKXfDD0RzORNilenkXLjvwBOKGQAcOPr+KBQuUoUVbptptnVcykrtcomVVF80ajqqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159961; c=relaxed/simple;
	bh=ZAdXlptvW7/luciaw/bQsN13K7E6dyysYrpPEUuQG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR2M3dhhZj+c5d8w6vVeqKNd4jz+xHqnVahMmbZgVzQ+r2hAJdfEzSOynipr8tp+P1oNJe9ozmDaTlssSFOS2wAR/afImVvVe+EpNX7WMoTxXYliK3ASqkJ/IlV/Y85z9FEKIo6mnRnaeeT1cLmq6hJdD0szwtrgY4yfNKdvwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MZ7XYaZq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MZ7XYaZq"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6b554044fso2298892a34.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785159959; x=1785764759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27xxIauuK05vKGL5dQ5O20x7vu0xdxg2ow4luyIKsSc=;
        b=MZ7XYaZqWVBTtZdBj9+YWMCSgIcmoY9AzdCvl8/bv5vNcpN90y3DXdFUHDFRC/4Rgd
         G0/vB/IetoZGW3nlerd7kyQklzqmI17OOFF4NqO9+/1JvMTG9AzWhEtSjrUmk4wXNYzX
         L2CSpxFmJjW12qA+CQOVw3lzZQ5kXynMhrHx0uLys6kMEAJB4VvF7om3LfQyJ8tDkCYk
         83Aca8bLHJF+mn046tJLWlqOOwUpsYisiuY/mlZc9R5MTG3B7Rw0eY+Rjk9+DUDCo+Hf
         NO3PdmHXgVnkhZKkL6Cd3+czJ3PWM2KY6z46py4lpG9NfCUP9xfDy3rBtu8LKgIaaWXr
         S8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159959; x=1785764759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27xxIauuK05vKGL5dQ5O20x7vu0xdxg2ow4luyIKsSc=;
        b=A9ssT2KNKVrPcYgGVAX+t9QBzxDK7GBG3LAiP+d2EDPz0AphI7U35rSJX2Eq1wmclb
         7XffOlMZNNn3113xA7sMIs3MDyZ9grhx6g9Nvjcg+URb/tgR14gzRZUTVXY1KKQ7dugv
         IBineNBp6B5v/xIbi2n1w8PStR/CSgO+p6CN1d5LwTUfCg+shf6QUPjegmue/mIPtWNj
         A1Dvz8dunM/DteKwFFZC0foKsJQl8OmFzrDjLtCm1qt76wgC/YRzvugFjVVHdJxaOnWs
         HBaAJJc6LL69i09gt/kZ+LZHsSAYZjLC+9ngLMlQ523RXi0prknVB6qux/58QyWdlWnT
         LBmw==
X-Forwarded-Encrypted: i=1; AHgh+RpGXTagOlFe8Qcf9g6mz6NRPSa7nZzBoKe4V+QSdCwfB/oJkhCgiQymYieDR4WmfibMyuxb0NE0h/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzC146z9EepDr2ny5W1U0NKqFXNcGhmAexmeQF6iY2WLNDlkjp
	qJoa4hepjvrVNGspCCQI8bqe8ICk7T99UBacdHGMh4Y0W90DO2krs4k9z1H/6ShcvJc=
X-Gm-Gg: AR+sD13Z2vlXezWB9SJDroBFTWUm/t3MWhpGMBnrLnJKvd7D8sQpWAPWTXbU2Q1KhT1
	1a9znVwhusJadRKnXXYk35Eb9btOWCAYlvFNMS56GcVTrq+1ZgT9DDGyhfGK5luj5cCLPdBF04Z
	n8YUaE28NKXHDEA3Hnnu6J7Drsc5hdhM1BafMxdHl2Lql9ojKKaE4qLnaBQM6OtvFdcPyrIJFA7
	e7C8Y+hc2EEE+437hvW7uH4DuKlQEAPwzctos9KYGWcjl8sCkad58spNG/gVtwno3iU9Mc4Dp7g
	XIOjmyT6ju4Wgqy7P0V6oDdTni38oSjxsSyYXSekSYt6CIw2NUP8bAQipEzXQi5nRQOcXchfG3B
	Cbu/WtlQatRs1bsFiEcTddb9RxxiLyW/Ei5Wm+wk4rM+f0jVA8T9zgSRymejZ/USNaG/0aMmiT1
	60ZV7Wxbdedi3HTffuR7R26/ON9JBzIab8r8bAmZdXiOoSKWQx1mga
X-Received: by 2002:a05:6830:6f8e:b0:7e6:f7fb:9678 with SMTP id 46e09a7af769-7ee78c0a489mr7133180a34.1.1785159958709;
        Mon, 27 Jul 2026 06:45:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:41b4:f2ef:8a0a:2104? ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee39e9e9d1sm11181298a34.16.2026.07.27.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:45:58 -0700 (PDT)
Message-ID: <cf727776-07df-400f-a153-97297ecdbc5c@baylibre.com>
Date: Mon, 27 Jul 2026 08:45:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-ads112c14: add continuous mode support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
 <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-2-9eb0b7a4f020@baylibre.com>
 <20260727024559.513fadff@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727024559.513fadff@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 8:45 PM, Jonathan Cameron wrote:
> On Fri, 24 Jul 2026 15:13:11 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
>> mode the ADC itself is starting each conversion, so we add a trigger
>> based on the DRDY interrupt to read each sample. This mode is also
>> limited in that only one channel can be enabled at a time since the
>> chip does not have a sequencer or simultaneous sampling capability.
>> Continuous mode will only be used when this new trigger is the current
>> trigger.
>>

...

>> +static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
>> +{
>> +	struct ads112c14_data *data = iio_priv(indio_dev);
>> +	int ret, ret2;
>> +
>> +	if (!ads112c14_using_drdy_trigger(indio_dev))
>> +		return 0;
>> +
>> +	guard(mutex)(&data->lock);
>> +
>> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
>> +			   ADS112C14_CONVERSION_CTRL_STOP);
>> +	ret2 = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
>> +				  ADS112C14_DEVICE_CFG_CONV_MODE,
>> +				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);
> 
> This is odd looking code. Needs comments on why we should prefer returning
> the error for the second call over that for the first.

It is arbitrary, I just went with first error wins.

Other option would be to return early since the hardware is going to
be in a broken state anyway.

> 
>> +	if (ret2)
>> +		return ret2;
>> +
>> +	return ret;
>> +}
> 
> 
