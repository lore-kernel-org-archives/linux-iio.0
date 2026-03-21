Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B428643A
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122039; cv=none; b=YZjvo46465iVrSRLXhkrupNxpCdrES3WpvIWV02P/qHiQrZyLTj8+rBWeH8SrADNevMLSFNUGZILV6cjg3NRFQxZFO/5ItsQ9V9T/cLhzeNPySUYhNvuM3gezzv4OkgWRCJ0VxeBj5WtU4JM02qT2G45WnJ+3DdLGY4npFgXVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122039; c=relaxed/simple;
	bh=OIvDzZ+BfUUfvR5O1o7W5HAd/fdYMitDl3NmLBl+Ipk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxsDq9dXUV3Ee5YKomg/9nCFTjUj4VPWHj5VKbmrLgqD59VvLQG3sqx3cLpShaxWe8jLgevNnn//b0qqeppZSENKa+OSkb9xAHqgq6o2vaIfWqEOspm+2bQJFgUajHmnlZX7FSKZjioePCI5gTXUoGt+3Hkhv1cRVdXHy6CJV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I71f42sK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I71f42sK"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-467e8aaa865so1073713b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774122036; x=1774726836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fe+4n5KT34TE5HqzzhJjD50bZ2llxXjXk7hkDJH1bR0=;
        b=I71f42sK44Wtn/oXpru74ji6QZ6nhrS2hjKMToqoEPryJ/j++EaIucyPcrlsyDelZF
         8eEhzf3OrxFUw+BRqGxkG8Us4ENNCK2RhDgBpusItOi5zoSA6YnevDNi/E1y55hZcJ4G
         qxRvmNy07JpHYd7lgDVzjNYKZSNYYBwMeiFe21RnnnzCH4lbBRg+qeO1uqdf6hRhBRNp
         I2p7zmszdZeWII+v0PnL5Tdxx/OeNU88chUkLeUMHHOZVek3zxvAFDxU2vH5hPGFuUFk
         FhhdI1+fG71P/5eeNm877rDUcK+fPVjXAlydtEm8o+O61XoXLcUkBROMvfBAc2Wcg+pB
         D/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774122036; x=1774726836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe+4n5KT34TE5HqzzhJjD50bZ2llxXjXk7hkDJH1bR0=;
        b=h3KP+hCpaL06vcS24rJbures8YE4W9IH5XzwTn5aOfExFpFf8Udp7nOao94YRVPpz3
         Edsd0jhcejQ+GZ83CEQmaUyKD3vm62Bn2YZOJ0xfscOJNtASRW7T7xiv04G45F/bzGZ0
         8C7jkwiooOGH6/Li8j9u5IXp/4QlumtTmAzPEiKDd5Fy2S6WY6Uh7yF6UNNgKD8+nfAH
         sdByuhTNiHkxJZOhak29aY6lIF9vVMPKG/HspuuP+cqQmPX7GmbtFQZH9+gOJhNOqblC
         M0lfQTswY5ZDkbJl0FzuUU1qWgb5bbtzLlG0HE11TsPFU3e5mb1iWVLHdIFeB99euQns
         B1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgxS9e+J8pTG8S5Mju7sARCffccRBFL3nwzn2PjPnS3H2AjsjUAGk9i+pijikjW89YrXEg4DX9FRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUweHJSe3/7Xvd9PxNczBSPww3L8zlYPukHuCwCUF3IU1u+3p
	e4Nz2wNOkzjWtz/fDfYB5/HQU8wwZLjYgQWm8NdtVcNbW2EimPb0ipU88s27KFLQ0hs=
X-Gm-Gg: ATEYQzyS1IbWS00tLH0SXanFNmD/+hDhsh89XVe404Qz2rNIz3MmFC39f3gMnRLPdYG
	VssPGyvmPFyifozjMHdUqYA/N2lliMHNpUJcUq2JMGDvlOmPg7V6AZe8C+lEoyIA6mC+O7Sqiko
	u17z+f9dB9s0+SsTLfxMhRmCiJg3fef8kXXDqUTu9UhVlmAQlZyIeZnvP8v3d8XWGyaVVycAG7/
	m0V0TTpAE36qR8bYFOwfQb+65TSuHHGA2BS+g76tGwwCBzVS66MN8WGILygCglrj9ZE0TlOIEui
	7BAgobi7BMbVmFZYvl5Z3fS4M9/cK6BIrUCMMO8gSsOEBULd3htr5BfxjEGZReyg6ySX6yfNiVc
	zWVIqfFjUswrSj/wboPneLqwHs7ax+VP3BLmLtW6uV8CxNXZutuDmNn6k5Uf8dflstjbiuFS3m7
	psLghNaeesbrTDXxHW2w0/u9A3/Xto6t/IoHsE2TUVAPW9yvQ4i6KvnSZsGWBXiuLn73bxddUO4
	g==
X-Received: by 2002:a05:6808:15a6:b0:463:c56f:a45b with SMTP id 5614622812f47-467e5ed2b5fmr4678932b6e.28.1774122036135;
        Sat, 21 Mar 2026 12:40:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46811e5164esm248557b6e.0.2026.03.21.12.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 12:40:35 -0700 (PDT)
Message-ID: <2c5083b4-0291-43a0-808f-25d3decdfb5a@baylibre.com>
Date: Sat, 21 Mar 2026 14:40:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
 <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
 <20260316183117.4dde7386@jic23-huawei> <abhfulXY1PbCow-Z@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <abhfulXY1PbCow-Z@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 2:53 PM, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 06:31:17PM +0000, Jonathan Cameron wrote:
>> On Sat, 14 Mar 2026 18:13:32 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>>  	u8 shift;
>>> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
>> On this. There is new generic infrastructure for marking these.
>> https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
>> https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
>>
>> Would look like
>> 	__dma_from_device_group_begin();
>> 	u8 buf[3];
>> 	__dma_from_device_group_end();
>>
>> Do you think we should adopt them rather than doing our own thing?
>> Slowly though I don't want the noise of a mass conversion.
>>
>> As normal, advantage of standard infrastructure is cutting down
>> in subsystem specific magic.
>>
>> I 'think' result is the same (though it also forces the trailing padding if anything
>> comes after this and needs it).
> 
> As I read it it will be an equivalent to
> 
> 	u8 shift; __aligned(IIO_DMA_MINALIGN);
> 	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
> 
> 

It will be:

	u8 shift;
	__u8 __cacheline_group_begin__[0] __aligned(ARCH_DMA_MINALIGN);
	u8 buf[3];
	__u8 __cacheline_group_end__[0] __aligned(ARCH_DMA_MINALIGN);

Note that ARCH_DMA_MINALIGN is not always the same as IIO_DMA_MINALIGN.
IIO_DMA_MINALIGN has a minimum of 8 bytes to account for timestamp
alignment.

I wonder if this would add an extra ARCH_DMA_MINALIGN bytes to
the struct. Or if the compiler is smart enough to see that it has
0 size on the last array and have a special case for that.

And even if the 0 is handled, if someone added a new field after this,
I expect the struct would grow by ARCH_DMA_MINALIGN rather than sizeof(field)
bytes.
