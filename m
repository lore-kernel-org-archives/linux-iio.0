Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD54DB552
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300120; cv=none; b=tS3yMpWN1CfrX1na1uO7Sk5MeRPTqs0+siHf10iJBwZDL8P4ba8q9TG1M4225bwfaGpqKCr3d/1FM4XouY+JJgFxP+wN75Nl86MD8og3SW5RCCf4edCq699S7uEuM1Xxh1EMn7VX8W84JJ/tZTP/8XWvhnHOQNCjPtrRQgUFtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300120; c=relaxed/simple;
	bh=VpQlLC4yuAZCN83l2FY7W0C9JGWJzKbwyBbG02roCsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+z01J0wooZQR+5qv/wNoFTM/9SrLiHy3Q8WBr5KSGsn40EOV+s+LcygipJZd2AoLcLCI7YuaDfBhTQQ/ZWuLTVvgc06j2hZAASxLDmsMA7VxEEe7Y7ZAmq198u3SUPIB5qW668J4YI3wNqTdCQIlXhi9YLKGkilEQUq6lc+4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=evaMal/C; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="evaMal/C"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d19bfe1190so2665940a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772300117; x=1772904917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46ijH4q4ZMpqLn9riBmDz3nl4kEzUq3GVbhaLZAxiNg=;
        b=evaMal/CSXFIMO2HYWFGkfkZeabChh/rheJB3H86+nS7C0+OHQ6hiqy0iSC3tQ5MI/
         jPJZn72c4JSoiuID5ANryZ41wh37l3AaKnoyblW3IsQ13XCKZjAP4c2pGwl8VOUgHpOb
         PUiw105K/6tuyJGmT5PkqLMbyexG7MJKUA2s0HqH5xVRR7T7HiQGiuvaDw1RrIrVYgc1
         ++HORKppoGLQG/H2rIo7cekPctDk10rSpTf8ehLTDTg+2iTSrrkGMzJEhvxvun8T2lZq
         dX+GwghOp0RS87mRU5IKOQUPI9S/4r3OTdzPpjFOIBVi6OgarS+fiZ0Aafn2e0yZkPUz
         YibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300117; x=1772904917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46ijH4q4ZMpqLn9riBmDz3nl4kEzUq3GVbhaLZAxiNg=;
        b=XbRGt2b9be5ymYEG8JrM4DHUqTM9TGzWLmjaB8bhzyBAO2YTTOLbwtOlLhwFZNeykX
         reuHigZ81M7byni5NlZLfjK+EpbpoE8wE+aSZoQYfOvbtk2pVokRl/36zysQm2RfiIkL
         mm5k4pc6SLo3QgC579MORPzT2c7cEbZw1w5NxbpoG5ISj2JRxnqT4bqhyCoJbYHvaowk
         hwyM11uczXf1dgWWndXcsN3aZyP282HzjXC9bB/BLMmaPsfOdVyun6HzVxrRK1HUbTWQ
         E1w/qilKyQfvR+/6jzWWBVYSe96JZHhmbRN0WjnxiHd2+ahnIBB5CocCf/9pUwIa9Qdo
         lJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Aco2DZtY+ouTyidGLRAemhMgzRogbgQZ0MvSBpS4qEH8NKf8kkaykwVWoQZOwUE1N+sNUlHgk/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLl3wnE1I1o9VK/ROZvp72fwufIFV2MD3SN9OuFf5dI96J6glo
	Gw/lrpfQSJCD6PiWLy32YIlHdErs2slJ+J7B5FAyDvlgLOoerY8NMLqjKQo05m1oVEDboJs8Vca
	YWwuw
X-Gm-Gg: ATEYQzw4h94AZuQUozLKLNoDeqkiqjV8/PUFFAFGIx3W5f+/Dhgioo4/deDPjEr83I8
	Ner28IDSAJZmSqpraZpl6qpgUqbeKs52w0cAGBwyA8ydUQSB/ruVof0Vi6wYKE6mxL46sIWexDj
	iFz4TLDDIWesPK+SKDXwBHlPhy8POwL1IC++LM8Jw1rjufEaHph5tzUKOYnv5oilUbrFgfEtIKo
	l5FT86uX3ww7yu835nflpt0RAaMc5+uwdZAIg1ZYY3b+fr3l+ptaGo+aVhwsE0z9IURqsc4kGq5
	1sRijHWUaL+gMzkTV8nNdfaanKewO6S0mQSjvveQc+3zqjZXDyKRq61DBuIBPLQ93TV8GSPYzL9
	k9waqBnJFpBurGhuOHWwwnYDshgkIkE5n0Y8ujqnuafijYlKulPKKwW8BrgUxb354lNy7uui48N
	Ss1U4/CuRtQw5H7bHQhp5oGPNrOoUPOO7doMkj+UXfwf4VBpPIi/AUFfIXEaUppxIHtATThPXNL
	A==
X-Received: by 2002:a05:6830:25d5:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d591b2656amr4819921a34.13.1772300117017;
        Sat, 28 Feb 2026 09:35:17 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ea95sm6809490a34.28.2026.02.28.09.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:35:16 -0800 (PST)
Message-ID: <00ee6df6-422e-40db-8494-3f9da4ccb227@baylibre.com>
Date: Sat, 28 Feb 2026 11:35:15 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260228154515.16639-1-architanant5@gmail.com>
 <641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
 <CADJHxWA6QT9LqAR4n3UUHsr73X1S=SvwWCtO=M220SBUD91p-Q@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADJHxWA6QT9LqAR4n3UUHsr73X1S=SvwWCtO=M220SBUD91p-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/26 11:19 AM, Archit Anant wrote:
> Hi David,
> 
> On Sat, Feb 28, 2026 at 10:06 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 2/28/26 9:45 AM, Archit Anant wrote:
>>> Convert the driver to use the device-managed versions of
>>> iio_device_register() and iio_triggered_buffer_setup().
>>>
>>> This simplifies the error handling in ad799x_probe() by removing the
>>> 'error_cleanup_ring' goto label. It also removes the need to manually
>>> call iio_device_unregister() and iio_triggered_buffer_cleanup() in
>>> ad799x_remove().
>>>
>> Since we are doing this, why not also handle the regulators and
>> rx_buf so that we can drop the remove() function completely?
> 
> I completely agree that dropping the remove() function is the
> ideal end state but I initially stopped short of doing that because of two
> hurdles:
> 
> 1. regulators: since ad799x_read_raw() needs the regulator pointers
> to call regulator_get_voltage(), I couldn't simply use
> devm_regulator_get_enable().

In this case, we can use devm_add_action_or_reset() to register the
disable callbacks.

> 
> 2. rx_buf: st->rx_buf is dynamically re-allocated (kfree then kmalloc)
> inside ad799x_update_scan_mode() based on the scan mask. If I use
> devm_kmalloc there, it would leak memory on every mask change.
> 
> To drop remove() completely, would you prefer I use devm_add_action_or_reset()
> to register custom disable & free callbacks for the regulators and the
> final state of rx_buf?
> 
> If that approach sounds good to you, I will gladly prepare a v2 that
> eliminates the remove() function entirely.
> 
> 

Here, we could also use devm_add_action_or_reset() or we could drop
the dynamic allocation altogether and make rx_buf large enough for
the largest transfer. The latter would be preferred as that is how
we usually do it in general.

#define AD799X_MAX_CHANNELS 8

...

struct ad799x_state {
	...
	unsigned int			transfer_size;
	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
};

Note, it is important for this to be the last field in the struct
for DMA alignment purposes.

