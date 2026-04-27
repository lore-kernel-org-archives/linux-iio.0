Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863923264DA
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303301; cv=none; b=ReKpLt1Xv/i6N60hNNY5kIjP2j0WSAM3Qf7WYZP7SQpBVsqM1fCEa4AJDRiY0lkr5mL0zKN+OQNfNmPU0hHE0n2S+Ybus9wAHzaIyjVchoOWWHGI3w4+eHb7OB40TrcJxqQOYIRr8KcDmsDyeORakPfKMciRJN8E3FS9JlrCjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303301; c=relaxed/simple;
	bh=ULJRQV3E0UINpZ1bQ6syPJdZBgATZCzncKAoETZPhlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFflQjMHZcxBLoHVbTkcFPTrPoj9ykKOcHYScF9I2zTIPIJBUr6Lo7YPv8CNIPCt7SWa87MhTwoAyezywX+iHac2Iv+ZVdmSxrDicbQY1vLUqr1cOMo/L8XSJ6G7hq1cdMbJpV/I9pUUFY1MFHZQvgsnxSpvgaohEo1coVGmIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Hhw+4aUz; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Hhw+4aUz"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so5950411fac.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777303298; x=1777908098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNFqGLWNs6epgqAb2w7dNNEwLLcehXWUO7S5uBl+hwk=;
        b=Hhw+4aUzBcTV1hDgs5N5xFRQ2SALxYr3raY9ClvPMo7VEnSodkyyBstIr59zdhCjBj
         9sVb1w/GXDkHZZ+TPgxKTcqg0vWdLhNWxj8oYwsFESjZFTqwEEZSabkQGpm9QziGm5lY
         X7qikf98TcBlIq0KSb3RuyxjBmeDcr56c+F+MeeaA3LS1izPzzpGVAOXsEKp9/eMLLuc
         yscXj8mTYQaqirGmomNzSPUfK9m5rDvI7u+0JdQsLfuiMfcCnEPtgguM/GhCQBWzP4A8
         24khAZ5tZNtJTnYedILJywfzNO7M7LzLsK2u7KZu587VszynXaGVx+1Rm0so3xW93uMJ
         Uhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303298; x=1777908098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNFqGLWNs6epgqAb2w7dNNEwLLcehXWUO7S5uBl+hwk=;
        b=nciN1kypl9mW39e0Uk4aYwKjXKtQpi2KUj+Lz9vceEuo91WSRZkGy935UkWJ6ODdws
         l2KDm72AIl/ugjkUijdLGaPoRpz6LhX7bOFQz/xR/yjOQ5JxVAOhDibCaKOnYblkiXOL
         BltBwTXhkzG63letKTFCZUDcLNwt3U7jvgs9lviLTEAjMzs5NVzDKgBiBl9xEmAYm/Yt
         E6YWT01t9uXYS6PS6MaNYEP0GavMBHvkmO8RG88w0BGOvhCWZ0pdk8yhzl3MbIu7eVXz
         0+wSJp5Wg+a5TKiwCQDZWaypZ0qqDtSnHo5DZYwjsZD4rHaEVgGClRC99wF7F4F6HKog
         JW1A==
X-Forwarded-Encrypted: i=1; AFNElJ+mB64WOcGpg3pjyEe0nDzSI33F2TN9dEq5y0RZW+mqzFS0wV8lFW5qYyckNm8UL24Sct0CWUh+QB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAJibmaFop6IhXcOFfmRQZsAlkPdn5jm3TXkBntsnRko181g9
	QCscIw1O807IDqiac9sV09AP7mXhd7mpUNsd5xYnJgpRIvXsNPdCJ3ylkh5+VULHUxk=
X-Gm-Gg: AeBDiesbXTWj7JQAM9TqRQ6XGVzP+V8Tn3WVLlPgmQ3w8VX7S5PljTIJd1TdzYoSO9a
	UGXfXq8xc+TDZYkj8L/YWPDaZTg+E8U+ChmTn5nfUWS50fi17HGOV58T4RbZw9+c/AX8QSKUZQs
	x5yt3L9FhHEE7e6Um3XhCBMd7il7UgA6A+wQiDLSOyJ2J927mBhlmhU6s3ksePwzahI9I0HVs5t
	pmuYoVaCNEYC4pE/TxzW1/T7HokhQpsivSyZmZnQ84B5s1VZXmKhFvSx+PSuDy8rDfYCnwaQuxG
	KIt6Irr4RLjYTU2QVeofXHO1BtI5nnOL0dacONhlFgnzQFOm7JS5bmlpUcvDPqYPhdEDB8HzVnn
	9Fp/1B/Y51Oe/M4Zp0XV/Kv7p/L69BGERrkccrzHTVrRK8YpRdgJbpVgmD14Uy2Ftf/rDrLkyYQ
	zV9E+tJA0GM6mTjDkg76s5lza8ZIhExt19CdUruaSB4CJJIj1XpxqjQY/4h6gHe6XgbJqidYsg+
	MIiU0u95s3b
X-Received: by 2002:a05:6871:80e:b0:417:4693:ca0 with SMTP id 586e51a60fabf-42abf2e029cmr25519053fac.14.1777303298554;
        Mon, 27 Apr 2026 08:21:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:96f5:eee9:c87c:c599? ([2600:8803:e7e4:500:96f5:eee9:c87c:c599])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c16b64a83sm21928789fac.18.2026.04.27.08.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 08:21:38 -0700 (PDT)
Message-ID: <3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
Date: Mon, 27 Apr 2026 10:21:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Laight <david.laight.linux@gmail.com>
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
 <20260427143137.27bc4552@pumpkin>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260427143137.27bc4552@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 8:31 AM, David Laight wrote:
> On Mon, 27 Apr 2026 15:27:07 +0400
> Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
> 
>> The ads7138_i2c_write_block() function currently utilizes kmalloc()
>> to allocate a buffer for I2C transfers. However, the length
>> parameter passed to this function is strictly 2 bytes across all
>> driver invocations, making the total payload buffer size exactly 4 bytes.
>> Invoking the heap allocator for a 4-byte buffer introduces
>> unnecessary SLUB overhead. 
> 
> Have you confirmed that the buffer is never used for DMA?
> 
> Provided the lock that blocks concurrent access from two threads
> is actually outside this code, a buffer for short transfers could
> be allocated within 'struct i2c_client'.
> 
> 	David
> 
Giorgi,

This is why it is important to include a changelog and a link to the
previous discussion [1] in the cover letter or after --- in a single patch
when you submit a new revision. I think that would have answered David's
question.

[1]: https://lore.kernel.org/linux-iio/20260424081809.61841-2-giorgitchankvetadze1997@gmail.com/


