Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF21F1932
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383572; cv=none; b=YBfrElwdnM105ioisRDqUHvTr1Fx+JDzfgdqvWez8zA7cygv9hnEHZGHZccZNHf5J/ljZqsaBmqO3MnlECp7raOYQkbWr3Ik5Xet5R4o7iEU8YY5Y1I1GoMWXOO0VNg1qi0s6ZSZo7v5Jh7Emqu+CLwOGEc7r1C+ctx+RGyGu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383572; c=relaxed/simple;
	bh=h0h8gA420ufSwg5IkYm3n1FAETvw/pVCAn0GXXUXoKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePYcUiT6sIwiwdH5/saegZatpdhQsby6HcA3jHWp+HUcqMevPkiU4oYH4rXbhyRleN+rGN5a5IMvqapu4Awfs197cK7UsK3jwwLtJAXCiXJf9wjTNi7h2nLkrGRZ9NmTJE6tsVyVUVtEVhW3zsouq3l7nZKkhtYzVOkDWVlKUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IyPrB4Tr; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IyPrB4Tr"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-679ed01869fso1392834eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772383569; x=1772988369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1O1vv66ph658au/3xOQ7obK8EPF5ZNCD8eDceGWp7A=;
        b=IyPrB4Tr0yfGWVFO9h1u7GKfS0u1jI2SzvPNg2gND0/xjKG+1jPvOsrwdmZiAu7x6p
         tHy9S0sNL/hbLVSbuUk1RoVV0jMOfduNiK8hEzd6/KutP2rSLdb5qclNgL+wrIk5tzlB
         edqyeH2d5YMLN8X0SDZjC6DpsWW+xKSTtwJ7ybHJR8h9DJ8WDPOqYJ2WuEy2ceMkpxpa
         GLhmH0xx7j2tTo57hLnWOisbpFP6QyfCkM512NmYwjGd17SupoMG9lDwVziHwLorunBh
         1Vj3hx8muxj2lewmivgCHJUI/yoFv3BxFTUKbLqCW5jFeuaXBlCmkVYFeaTscspKSePn
         ynBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772383569; x=1772988369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1O1vv66ph658au/3xOQ7obK8EPF5ZNCD8eDceGWp7A=;
        b=q6uX7s/YoA8JBONzEalO75R9xG9cdTKlqL5GT7S+O7QxkSXz6gHOMZYzQsgfy4pThG
         4noieakPl1cJpxosf2LcX+2QgaVDX5zDqvO95UiIiQvXBe8Sg69jWyiXsUkGdXkQ1ZU0
         Q64opdYUDCpfRfwNmvdl1JmaQPz/sPSZlX06+/w/7H5SYszEF3Av9gQ7+xAXBwnys4kK
         JK5rDwDiiocRUBJt1eKtUQ+T4Gr+LmZ6RyTTl7EUko4ULCHOTJ+s0Pia6tcH/itn0Rby
         9+eWVh4LrahsV8rEo+mrJkQ2GYolZ3GGaCqd6mQ0QlrofBdoj4/K6WNXZm+O3kxLyv4B
         Q6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWXzsA/4bLfXIeEKqTquMHxkhErh9EsrxE0MjW7iy4AOg1ATKRwWfLzADQTsrPc4r+4Fzj5sSYYGbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVwOUl6g8iwPnUKQvDI8usvD0XmlqR2kDZQKIbjeWa2CSrphy
	SfTTafw7OS9/Ag+3XxIs0SEu/PrVsfFmexP90xUK5dobQV1stwC6xlUO4HhaadO0IEY=
X-Gm-Gg: ATEYQzxpZt2TG69nfyBmBYzdXv/vwKeR148s2NPt2MaQH9puhiWlS4ufUfuZcr+5Iy6
	BBldluzFHWrjKVZLfLYU2ZCmYCuJ4ICll1vn5+ovnjnh3WYGXc5xjS84tiAX//8u/hIF7x65VOc
	F+pJcktVBLOymEGm0LSHPIygpsBSln311Yv6zoRBT3NpjrQVjmG7paxfbUAQJ/kj2h1HytiIEs3
	jgWbgeSMH71uy2kURvR6WdIBQI/VuH8/6obpAk2eGMFUFRwLazDlUN3oXRW6N9HsZnAIFNJvbhI
	SlwtTtdlc11eXLWPVT+s5LAQxXWv6LyuG8StdAIXYk4WxzHgngRWAciaTp+teFkGErz6mJbAFkX
	RqPV9wTqTNVECdin/pZSxdM0eJuUd5FSnKd0STuu2iZysoZcWsz18oknN0Bmgk8wpiyBVxKiYn0
	WUoKREOfCnAAS0LX4jHsEnxv5iytPbF9Q386VmOLjiY2qOmZ2a6pyPXHFeiOx1JwTjLuaqS8DxK
	JP1pskhc3mP
X-Received: by 2002:a05:6820:4512:b0:65c:f14f:91ca with SMTP id 006d021491bc7-679faf03520mr4203859eaf.49.1772383569540;
        Sun, 01 Mar 2026 08:46:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8b9c:d657:204d:5a5f? ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d856d2sm7131043eaf.10.2026.03.01.08.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 08:46:09 -0800 (PST)
Message-ID: <8bf08908-b8fd-4c4f-ab74-66575ed771ab@baylibre.com>
Date: Sun, 1 Mar 2026 10:46:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228154515.16639-1-architanant5@gmail.com>
 <641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
 <CADJHxWA6QT9LqAR4n3UUHsr73X1S=SvwWCtO=M220SBUD91p-Q@mail.gmail.com>
 <00ee6df6-422e-40db-8494-3f9da4ccb227@baylibre.com>
 <20260301113452.7e1f95ee@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260301113452.7e1f95ee@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/1/26 5:34 AM, Jonathan Cameron wrote:
> On Sat, 28 Feb 2026 11:35:15 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 2/28/26 11:19 AM, Archit Anant wrote:
>>> Hi David,
>>>
>>> On Sat, Feb 28, 2026 at 10:06 PM David Lechner <dlechner@baylibre.com> wrote:  
>>>>
>>>> On 2/28/26 9:45 AM, Archit Anant wrote:  
>>>>> Convert the driver to use the device-managed versions of
>>>>> iio_device_register() and iio_triggered_buffer_setup().
>>>>>
>>>>> This simplifies the error handling in ad799x_probe() by removing the
>>>>> 'error_cleanup_ring' goto label. It also removes the need to manually
>>>>> call iio_device_unregister() and iio_triggered_buffer_cleanup() in
>>>>> ad799x_remove().
>>>>>  
>>>> Since we are doing this, why not also handle the regulators and
>>>> rx_buf so that we can drop the remove() function completely?  
>>>
>>> I completely agree that dropping the remove() function is the
>>> ideal end state but I initially stopped short of doing that because of two
>>> hurdles:
>>>
>>> 1. regulators: since ad799x_read_raw() needs the regulator pointers
>>> to call regulator_get_voltage(), I couldn't simply use
>>> devm_regulator_get_enable().  
>>
>> In this case, we can use devm_add_action_or_reset() to register the
>> disable callbacks.
> 
> It is vanishingly rare for for the voltages to change after driver probe,
> so an alternative that is almost certainly fine is to read and cache the
> voltage at probe.

In this driver, we still need the handle to the regulator for suspend
resume, so that doesn't avoid the need for using devm_add_action_or_reset()
in this particular case, I don't think.

>> #define AD799X_MAX_CHANNELS 8
>>
>> ...
>>
>> struct ad799x_state {
>> 	...
>> 	unsigned int			transfer_size;
>> 	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
>> };
>>
>> Note, it is important for this to be the last field in the struct
>> for DMA alignment purposes.
>>
> I2C driver, so no need. I2C by default bounce buffers everything anyway so we don't
> need an aligned buffer (or the padding that results in at the end of the structure).

Thanks for the correction. I just saw an I2C driver the other day that
was incorrectly doing this then that lead me astray.


