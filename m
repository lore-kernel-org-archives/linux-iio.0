Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679A3FD15F
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465974; cv=none; b=TYIDXJjXfDdlwp7JjB1AJxuH5fQXXRH1pWO5X3ZcMwJbPtCCW24BydhNItwjiBeoLJtrY88rVvBgmfNZVPpp7ESBvfILKQikeUB71lBU0wsrKZFnwmkf1J5bYpUH8mr54ASR1WAdqkYskRH/s4xT2aIY/djvpHESbIDDL6QdAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465974; c=relaxed/simple;
	bh=pu1I02sYh4+cO2CSPw9w87sHzIWlMmVNgS2cffxbA6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxmoS8VaJNh5U5qQVtemXveXigX0ffqU4CmcOIvITDbx84Ke+UfdI6Qa1F+DMBK4qyUOwZxp+vfLvPyowD13fJuYx2NbfD5lxUk1GfiNcCzQS6lIeWhSVOehLVGmAh58kAcQlIiIva3Sj8NooidMTRxYWCwCD2GmnTCqQhZmHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9ZJxG5V; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9ZJxG5V"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c4cacf78so2292627a34.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772465973; x=1773070773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQKYDG8QbYnUOgU9BiYmvyjnHkVzeJt+cs+KoB644B4=;
        b=c9ZJxG5VgiFCXPtHXziRtMzO8J8YRis9FBfWQ2Kd5FqMD/GBW+w1nNZJw43R/WacJA
         lZHwG4hoJno/SFdgV1t2FIJisYkaXNmhTzMVrgPhHsZ6coC1bqaNQvCqxyKyLDCtUGdq
         zg/1qCi00TDIXdux+NG4hXcYscxeQAzUAtjCmhb+tmMB4v0/eu8O9TW5u4Z0jgCb0o7W
         UQd0L9x12O1Zv8QPX9Ba5jOKmBezOAfwAY51NVoDJUASFZAywUJDRg41fq4QwPFa97Gc
         wFMsyMnA/FxGROhFxv3gPnpjmgIVsk/SdWMT5cWg3XuMPPLJr/KF+Tb2jqmzJ4Y96un7
         8ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465973; x=1773070773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQKYDG8QbYnUOgU9BiYmvyjnHkVzeJt+cs+KoB644B4=;
        b=W3AI6WyNpLQnY/IRwIbx/MWztvunQHTeDd/qmDJFvaolIQul2ZWD6GUfw4WYSqe6WL
         5nteh8LDya5aycSk21lgowRlO0kpUA7cMoNRbVXmUrANnEWDI5vfUNp3y9AzPnnnP4Gw
         qClduccc3Qz+aFIm7cvWwsp9vCRGTkdzR9rT+59y8FBoilpMCQVw5ap+96OLAMwnRpY3
         P1B2/lsqF9prsa/qT7QYOHfOvuU+ml306ORDZtBjmpbAUSzKh8Tw1ieea1GFAC/h8VxW
         M5ai9EBdElDnvteLFnNEFizVwzn97EjMBJr1+MA3E1mwiu17z50sAs/j7t889SUPy7W0
         LotQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSq3MSzxpF5KnX72fcwrOvRIXMTtULcKKbE3nqPg4EaJOhmwklik1h2Z/NCUnfGaRBAwhpp7C23a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMaxO4FUWqqdVl5BRuKMATIO4wp9bo/aM9IJBxnRiVxbT0uqb
	7tM1OO93IXD6J2GMlpD/bNUe5UWFdXYLya4bQqgCuRcHM25gtF1HxkwsBPkD8RaBmDw=
X-Gm-Gg: ATEYQzwgNbR0eNhd+JlqbPlpWmu6j/8CLq6uIW0hRW8A9TnqsGgY3EaY6DC8iqrW613
	qB+3eN19A1siqkNFAanwnA05/lEy40S5z1U5Zyyxmkx1fRyN02jCkfyJMJohRzLZnjBwVhke0P/
	jwi0Y/fcmcQYk9+hhgHFRTZ5Ce0b8MQyr3ucuuGEzBfZWT/5ZbYn2pOe53Ctvl1wdGEupsPdCDo
	cw7EDygiVr+cKvuUiHPqGiZ3r3jGZyyOuuorGEy7gR3Tn/WoB7xl0PHd3+/Ar+vlLHwvVyDNwue
	eUkMejpxMCTn9Fobq2gTqUjmJqYIoxzcpGPcw6DQ6T5+A5O+XCgvNW7ib6lV4nuPmDkdYhh1zRi
	IafO2CHIGNeAiBJ72USyh98hdAvg4C1P14CNt3gxX32Xr+qwzhcebPwVeadFPXhGm3HU/fKnJ69
	+VS6Qkk6XcyIbRK2IQhH4KlmLi3Y/dvDtNYpk3CBfZqf9IFu8z93LF8AMPguGHQ1Yj+ZaVozo74
	Q==
X-Received: by 2002:a05:6830:854c:10b0:7cf:e3f3:437 with SMTP id 46e09a7af769-7d591bcdb8emr5176114a34.22.1772465972689;
        Mon, 02 Mar 2026 07:39:32 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm10916908a34.16.2026.03.02.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:39:32 -0800 (PST)
Message-ID: <d7809acc-01e8-4dd7-8c6a-a7e8386a9e6b@baylibre.com>
Date: Mon, 2 Mar 2026 09:39:30 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when quaternion
 in scan
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
 <aaVOrvyzgDKNsB0S@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVOrvyzgDKNsB0S@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:47 AM, Andy Shevchenko wrote:
> On Sun, Mar 01, 2026 at 02:24:53PM -0600, David Lechner wrote:
>> Fix timestamp alignment when a scan buffer contains an element larger
>> than sizeof(int64_t). Currently s32 quaternions are the only such
>> element, and the one driver that has this (hid-sensor-rotation) has a
>> workaround in place already so this change does not affect it.
>>
>> Previously, we assumed that the timestamp would always be 8-byte aligned
>> relative to the end of the scan buffer, but in the case of a scan buffer
>> a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
>> to be placed at offset 16, not 24.
> 
> ...
> 
>> -		((int64_t *)data)[ts_offset] = timestamp;
> 
>> +		*(int64_t *)(data + ts_offset) = timestamp;
> 
> What's the point in modifying this? The comment you added suffice for
> the original line.
> 

ts_offset is now in bytes rather than number of int64_t elements.
So ((int64_t *)data)[ts_offset] would now 8x past the end of the array.
