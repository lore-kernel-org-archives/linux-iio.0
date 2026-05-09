Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129D3CBE89
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363244; cv=none; b=j4FYQq7QFeDTOsvqh+eRnZPFP6NB+PHpD5P+MRiVFHe7xa4MF8ngCJeAbkPHRXxF6Lmss8QNuZ8NLIYR6WMdX9U6ZBSIsgsAEeh2UXJPM38VH+IGA8kOBq4pa2bS6mdwIxL+YILEKu8UIxX2Q9lp/xhVxRGDOP9IDxIEwz5jJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363244; c=relaxed/simple;
	bh=L7nbRIzbIN+BvCH7led9bntZ8t7xIfoW9DdhBmRjaUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txyNcAfb5trgjtLOgnIDdM9zlmP4ccaOms/+jJjmh545rpJkIsrKI9M8SDKcPM4lXzmF2vAJ8cNO+ktgwrHqe32j7gVXqKE44/CatNCuE9uVH6BNSB671vTqVKC1rerFelgl8ChyjDaVRfD2KwRh2lAVsa5tlZrlgQuNiCm7haE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UhilQVM7; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UhilQVM7"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so1602769a34.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778363234; x=1778968034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLsgqjiauXUHOOz4Y63xwmK3jjt7GtmWKwgselV/o2g=;
        b=UhilQVM7Ogcw4QZPFbdiQUAYxib3US7J7jRJiydcOs9PeGBLw21y0wxgWoejNp+bZK
         7sH/PjVitHKwNiiUJWHmvFIyqcpFtbBxqZkhxnW3fI+bVDtQo6XW9V1zmodluHwcPmQn
         N4FOVjHH/OpSxZhivpXEKgRKi89tzxQw3wNYM0pgORYcdYVW1lzRUe2WnpPSfoPjG+2/
         BM7crUn0/FiW03OC6gDOSvdtpWpZLLQAExHytk6Mdi4iQC79Nk1wa9ub8rfQNwe/leyJ
         kVc0htTZGgi5/w9naRR5LEdF8MwEGWK2lXj2XAlamMqnmHn+h4yAkFwMl+vjpPMKe5VK
         aKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363234; x=1778968034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLsgqjiauXUHOOz4Y63xwmK3jjt7GtmWKwgselV/o2g=;
        b=cS5YrOJV33EEH5E99dN22/75eGEbbnRJly+jXTknLdaHUF80j5E/y0gzSeaH2RN4j1
         DWJbiGiYd/5lm7v/cC4tLTRoNqqXGVr/Fi5m2a3kVlQTXpKrxpJhlQ6eHLekGaA58XQu
         e/vGnZ12i8MMFtVpXT9XJkRndQhJVTec9IN8k3zNZ1XiQF9vK7smBDxLTxK+gYKLjtye
         7SpLY883fzh9Fg6IXNCF8E5XdgM8f7EwsUtFGZZWDikpfNVaIEaVoqk73P3N4BKUF4FZ
         oglbImQC4JoOXqHdkuzvQ5lttxhHYOloKUj4wMJbUls9BNcpW8Z7v0hvwdkpmTND/xjR
         hnBg==
X-Forwarded-Encrypted: i=1; AFNElJ8lG+wtuMnt+wtM0ufXG+6hpi29uxpF68hM+S+9nic5ObmtNez5lHfno4nlW2IfLZ2j6PX6DsWYY7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/BLflhTSMUjy6JbDGQlML7DK1DlSVfjs27eYnOsb1UdckJW5
	Z7CjmGZrM72Ol+r3dkpnfpRPxME8clgeR059kKyTliGDXkeKiAG3sefaBSqE8hrEY54=
X-Gm-Gg: Acq92OF6/qlvUSAuybaolzkjMml/Yre7X19OHRtPyPcEPh4MOvaZu7FputGVF/mk6Gr
	Sir6G1vGBwAjvuhkXmU4ZUjMhtOQg40crB4Faise1e9sJZEbjIJEy9cXvcYIJaTjmf3s0bK3YHP
	OXmmkZavXFDfmfcLsciTgM1KBrle2UcRRVtbaPTc4vd9PjhvztCrfyLhMdfKeBqEZnWZfZVgDGc
	aCTaY3t8MjrnVksqAj48OZQ6G/vu7SrMDzvOiUEP2WK4MLjs+LqeBfmTnwI8AJADG7RJSBpiD6r
	UajUN0ixFvVMhAXxubt3+bGPgqgfCrirlYjTx+if+Mkj/MxGTdoT46Mu4QFzTUkn3PqzmqQ7qbn
	zHi7Gzs6AL7B5k3504o1ONIoXk6VlDU438IeaECIRCEuz3yOb+c5qu5a83xHUQen/W0uE0h9GoN
	BrTNznc10CSLmNWlxTchCGTaRQe88UQz/D/6pTUaXfOQOWxNXPOARqdYK6qxew616Prmgg9yRIp
	+/+tO4bms9zbYA7hk/ImU8=
X-Received: by 2002:a05:6830:4992:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7e1deed3d7bmr10846987a34.12.1778363234496;
        Sat, 09 May 2026 14:47:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d4fe15sm3737018a34.18.2026.05.09.14.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:47:14 -0700 (PDT)
Message-ID: <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com>
Date: Sat, 9 May 2026 16:47:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero
 error
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260509211921.84969-1-m32285159@gmail.com>
 <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
 <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/9/26 4:36 PM, Maxwell Doose wrote:
> On Sat, May 9, 2026 at 4:25 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 5/9/26 4:19 PM, Maxwell Doose wrote:
>>> In scd30_read_raw, the current value of tmp in the
>>> IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
>>> value we got was 0 to prevent a divide-by-zero error.
>>>
>>> Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
>>> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>>> ---
>>>  drivers/iio/chemical/scd30_core.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
>>> index be8c055be184..3e2bb6f4e42c 100644
>>> --- a/drivers/iio/chemical/scd30_core.c
>>> +++ b/drivers/iio/chemical/scd30_core.c
>>> @@ -237,6 +237,13 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>>>               if (ret)
>>>                       return ret;
>>>
>>> +             /* Likely only taken if something really strange happens */
>>
>> Instead of saying "strange" I would mention a possible hardware failure
>> to justify the EIO return. I'm assuming this is reading the value over
>> SPI or I2C?
>>
> 
> Yes, we're reading over either SPI or I2C, the sensor supports both.
> Hardware failure is going to be the most likely cause of this path
> being taken, but I could also see some sort of noise on the bus being
> the cause. Perhaps we change it to:
> 
> /* Likely taken if hardware is failing or noise on bus */
> 
> best regards,
> max

Sounds OK. 

A more verbose alternative:

/*
 * Value of 0 is unexpected, but could happen, e.g. due to
 * hardware failure.
 */
