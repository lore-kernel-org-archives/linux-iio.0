Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B552299931
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565030; cv=none; b=hPq0wzbXzYF4a93pv0qZRa3U0IRQB/wCmyIAECTOZ9YrPKjwJozBbkj8gTAYhljlqlKWAF5Wv8l4vA/LPIr1F4tRnq1iSm1UrczFq4l4WCVNIWewBodx43AbEnk3khs4bG0Ly3k1okoRgQkYECGlW8Jfc3Eo1kcvthEI0MDRFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565030; c=relaxed/simple;
	bh=T6PJIcN0CqXy1IMyNX5j7l7VoaRlD1edtziIdcR7Ezw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XhsFMJ71Qw+wAHTGF8M5FSPciWDdAPXji8ZbbEKrEyPaKLFsCgDbP5IXNRpj+mVLxSYxbAeFCAycJ82DGBS2DkHBq+n3tyBKwlA3TN0orOY24HHrF7pptV91woyBBejtWOkxGslczZjmWzYqgN+uRYTWiAIEf8svJeaKXG8NCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1fbb2dv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1fbb2dv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4602e2a0372so13890f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780565027; x=1781169827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E1VE4yRo1ptgnYBqpUBjxBfNspfbEp7xrbxqWVzPNzw=;
        b=C1fbb2dvHxijK0jOpH4PMUoBFfGybQauCkcJL6AVFTIMRKF+Ny2SzisWeZLIl/0Vwf
         EXNmTCOhseM4BZrXupUNvGFumlAVqobzdRVUkd53Tz7JtjzWAGtPNAX94woh3RNZscf5
         20sgQYCqsiug7fe6dAD6v/p79EyT4r8ypMTzLgkjfp04e9AxNb3+VuyMEwJaqeO+wtaL
         zjb1YXBinFnSRxSjEY+hVYjaGi3s1m0eHuq4dEo0KwTp/NWi0Xyjc7Zo7w3aRJmgwOj/
         pKiS3rbz1Xr0AEBM0U5kbKg2NUze/Rn1iX2my6kaJZ2VMGZf6KVfgyiBTO7Cf12hxTG9
         MUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565027; x=1781169827;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1VE4yRo1ptgnYBqpUBjxBfNspfbEp7xrbxqWVzPNzw=;
        b=gMklWvKlNPPWD+NpBVOOCOG/nWiVfLt0N8Y3K04ewy1filLeKhPt2XqItwO+leZ+xl
         3hUB81/NzCqJuk5rYBqjRVQXznIW0fRH5qGEKUM0hHlAh6ofIQXPBvXa31i3nocJtWGE
         yNmsgsP3uudG4MJEeeFildYk39cyOBN0wnjYhwQhRutZ2+aoVLnZUv509pJOWOE0X7r3
         8dJyDYMQ6yFj3oBZ4yBuM+zCOZ2GuT3NaSQqG1wAeew5O+rWSmC9VR8pq+xyB8L3rGx7
         q9tEErPO+Jh36CUA68pKxiSlSMxXy32nB0P7eZzi9QjCdRdSswt4hILfVH0mlFq+BHA2
         9ZUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FeKhsH4WQ+wnHo6oIlkvCQOiMUbWKB7hlYYGyCXw+ox9DOflV+wP4xsiaoX9HPXFzNbIIX2eHX2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1Ofpp3UuYiLpkoqH7m/XU/U2Si6gdCqA/1+6+y+OC4QqIJTl
	NNgRjmq3AkuvUcTkb4qR4YM1tEGwXfrXMaZjyEmSwoBOOccdfdIVjc5s
X-Gm-Gg: Acq92OFboS4SBFvn0QACXoli+Dw6MJNKbSSp1IwG7JkjEhus9ll5a99QN4+C7CEcP1x
	XjESeZWOrtoTgJ/OjX8lCJ895LkDlAO8qKKBSQdtPWqnqoAeG7uaMci+besgFqy3aTOxadT50o9
	quT3sB5u0th6BGIqG+/udQUiTF6R5aU5mxD2Tb2sUNGqtGmtRMheahwbFlNXL8btkeqoljiVoZc
	3RS7wb7T1yGMPBDYKQwOjImbviZzq5hc2eAVY/sCpsMUuBhpjSbcoLMsmyA4yJeh0b06AyvK6Lv
	BCM/Q3PjGWKglSpHFrYtMopCVJ+YcQj0yAxc0r8ymg6mm6zoIq+AYHk/ZPhz+tLzpo1UUtoXDsb
	lCQPnKCr7+ws5hjYN4pKPIwUhrAMcjaG7sxJS54DS7mactL1BC/k6ZnGpMu4whJwRm1DDLvN3Ll
	lrjg4mbsk+e1KcMk+kGnBA9Pq8Ai4lna0UcRrOORp8
X-Received: by 2002:a05:6000:46da:b0:44a:247e:67b1 with SMTP id ffacd0b85a97d-460216bdebemr7681514f8f.5.1780565027275;
        Thu, 04 Jun 2026 02:23:47 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm14667219f8f.3.2026.06.04.02.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:23:46 -0700 (PDT)
Message-ID: <9c0bec93-e102-4655-8074-fd544b16d912@gmail.com>
Date: Thu, 4 Jun 2026 11:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20260522123420.45495-1-aldocontelk@gmail.com>
 <20260522123420.45495-9-aldocontelk@gmail.com>
Content-Language: en-US
In-Reply-To: <20260522123420.45495-9-aldocontelk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/26 14:34, Aldo Conte wrote:

>   static int tcs3472_req_data(struct tcs3472_data *data)
>   {
>   	int tries = 50;
> @@ -166,16 +214,131 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>   		*val = 0;
>   		*val2 = (256 - data->atime) * 2400;
>   		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int cycle_us = tcs3472_cycle_time_us(data);
> +
> +		tcs3472_cycle_to_freq(cycle_us, val, val2);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
>   	default:
>   		return -EINVAL;
>   	}
>   }Hi Jonathan,

One more thing on v4 before I send it.

For Sashiko's "tries too short" finding, I made the timeout dynamic
based on the actual cycle time:

	cycle_us = tcs3472_cycle_time_us(data);
	timeout_ms = max(1000U, (cycle_us * 2) / USEC_PER_MSEC);
	tries = DIV_ROUND_UP(timeout_ms, 20);

2 * cycle_us gives some safety margin, and the 1-second floor keeps
the original behavior on default configurations.

This solves the timeout issue but introduces a new concern:
tcs3472_cycle_time_us() reads data->{enable,wlong,wtime,atime}
without holding the lock, both here and in the SAMP_FREQ case of
read_raw() (also flagged by Sashiko).

For the SAMP_FREQ case I'll just add guard(mutex)(&data->lock)
before the call:

	case IIO_CHAN_INFO_SAMP_FREQ: {
		unsigned int cycle_us;

		guard(mutex)(&data->lock);
		cycle_us = tcs3472_cycle_time_us(data);
		tcs3472_cycle_to_freq(cycle_us, val, val2);
		return IIO_VAL_INT_PLUS_MICRO;
	}

For tcs3472_req_data() I plan to use scoped_guard() only around the
cycle_us computation:

	scoped_guard(mutex, &data->lock)
		cycle_us = tcs3472_cycle_time_us(data);

	timeout_ms = max(1000U, (cycle_us * 2) / USEC_PER_MSEC);
	tries = DIV_ROUND_UP(timeout_ms, 20);

	while (tries--) {
		...
	}

Could this be ok?

Thanks,
Aldo
