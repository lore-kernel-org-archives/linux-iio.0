Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32525B09B
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878658; cv=none; b=GwXk1hIXAzaG1LgSIO5PrYeIrUXrUaDhoZfA7+0HZ8D8wbhwBGLcF5fkrh5kXnPHsYB7zJHwAP87p2Hed9lmI4TCkLGI70ycjbEPYf+MzXxBkN1nwK9nz1LDdGIxem4JjMHK2R0W8ZSyaRgflPiEWeNIO12rv/63g5ApudTsolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878658; c=relaxed/simple;
	bh=3I5w7PUD8xXxUELwWNDPP6mAWT64QdkiV9GNcO/XBLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET9boWADVQI9h3VzB3xHW65kMXa68C1YCjYZygNi6O5ycImntZW2YKiaSJbC8VRThIX4cygZXuxT3SlwpbpbQY+IeMl9ficz7p5vciZuxDF0OZQPM6H/GQ8T2qw9tpOf+EID6Ud5u6OducwNqyHczd0BuFKzOesUxQU9IBc1xSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mkHsu1MX; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mkHsu1MX"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6e9408e30so1978638a34.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781878655; x=1782483455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Ri3Du5mr4CihtoWPG+kzBAY1WB2KTuSyTj6curlvV8=;
        b=mkHsu1MXUa4yNxUjCo6oK9wgcqHWiByZAjx0w0IQSyYQgx5FXTPzzKDcEt6zu1ZpXJ
         aa01y6jIsoPq2ml1G2l5PAC2m+unjzLhPU5VAdL+4Pg5A1ftT7uQYB8ydMmcvRQbV0/r
         xawpD/Shc3OnBoPN/3dINDzTvJp+1HaontBXpUixvb0kriDM+G+LGAKmPYnxdzo6rjdi
         1RhWXMK3Q8SQlXxr4cTBvIjMhMtfWPxNE5KaqQ9Mye4i2htU71V8RguBXhCF7Y+/RR7B
         nVpc2a6VN0/4+062XK9NaTEaklCANvXBzMMGTg+3vGNGHdGEVaL/GYOf0mh8Nw1+RFRK
         6b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878655; x=1782483455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ri3Du5mr4CihtoWPG+kzBAY1WB2KTuSyTj6curlvV8=;
        b=gU/EsTMS+2LCixGsrFyLNzSJOfdz/hQHUgTgNTfm/C2zVnv+T5VUsD4MOUjFnbJbW8
         sa7NsQX5srA38GnZruTcpgP3ZhwgvnGWiemvEKd+vt6PN9qFkW7B574wGzbZhlISLggw
         szi9gfck+aHLZtgsWAtX7iS06oxj+qvqkJQVcN+mG2VfAj5wMMq5SGLm8anWMR3atHJW
         rz+CgSBQkozteZSJRBIjSnt6m5iW8RTyNIPg7JKIJhYVQ4d0KcsvlH6F4517SAwGE8DK
         eS+76Nn4pS6hLrKe/y5WgEiZBZdd5+tcACj2i38U17Ij9JCSBV6VvRdLfJhlKaLHjv5S
         JXNw==
X-Forwarded-Encrypted: i=1; AFNElJ+wlvqDaf/4eHI9iyeDtN1CmnGDxA+8AaWC57QccnJ4/VLa7mteTHTsvQmsQCo00G7QvDhDH31NDBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnq423NDS67ZEK0JIYO/hKKBIfHMat1DLS4yYycpw4Q3+Z3pvM
	vFln2/lZpNzEKWqzD1lPk8QCZbX0z/ixwaiuHsYDdpp0jLbrFJa5DxSYkQFM7LUyKhg=
X-Gm-Gg: AfdE7cnTv6KJU+4ReDWn4GSkBNwg+yuqlW418wIIpSe6pfll/npMt/TeaeZmQmvMTHW
	Ab+CZ5tNcERb9q5Msf7mqIIQrkj50bzNEESqVTBBcwQV6ApT4+IKigUzMPl70Ejmoi+Jy0nA6O8
	irTX2cbt12vj4yAUqtKmyk4TUrrNJQ/6ChMqAGn0b5vVJ5j3tnIbvhECYftg6uOIOrsXs9HoDHx
	YB1MdEnkSaLjUc2clhxIBOHNWliyzi4hiyu5mSmVDz4xzlJ0FNG3Scvp9kA3+uvDqBdmhQ11+YW
	FJcy8m4+6pcwoQyqufz2GXlPCqMU9VN/AcC17UU0scaxur/sloST85NwJRHmyWNQV1afCeKzml/
	nB4qWG/s3czZpIieq4yK9NJqclpcJSA/eiAgN7HV+hGjksGMcw1MfYVdtoVnDn8qbDNSJBiixeq
	4E7w0hme8hho1vM2zhG/3ppCdhsxoOkDR1nD6YQrTCAjrM9vQs/4x2aDs5ag==
X-Received: by 2002:a05:6830:2789:b0:7dc:cd0b:58bc with SMTP id 46e09a7af769-7e92d839d2fmr2946067a34.7.1781878655500;
        Fri, 19 Jun 2026 07:17:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e92ec7f08esm1847945a34.13.2026.06.19.07.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:17:35 -0700 (PDT)
Message-ID: <1dd07840-9a52-4f9c-8e4b-476232d2d4c2@baylibre.com>
Date: Fri, 19 Jun 2026 09:17:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] iio: buffer: Extend DMAengine buffer
 interfaces to take extra sysfs attributes
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <a09f2cac2d26fe385f1f7790b0db64b7d9953ac6.1781661028.git.marcelo.schmitt@analog.com>
 <3b96ec10-b022-4135-9ade-6fd9eb6e78a6@baylibre.com> <ajPJdoTgpw7Ndczh@nsa>
 <ajVKzNgGzoueI1lW@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajVKzNgGzoueI1lW@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/19/26 8:57 AM, Marcelo Schmitt wrote:
> On 06/18, Nuno Sá wrote:
>> On Wed, Jun 17, 2026 at 04:43:18PM -0500, David Lechner wrote:
>>> On 6/16/26 9:03 PM, Marcelo Schmitt wrote:
>>>> Some devices using DMAengine buffers are connected to extra hardware that
>>>> allows setting how fast data is transferred to/from the buffer. However,
>>>> those extra pieces of harwdware are external to the sensor chip such that
>>>> supporting the transfer speed as a sensor property is a bit of an
>>>> inaccuracy. Expand IIO DMAengine buffer interfaces to take arguments for
>>>> extra sysfs attributes, enabling the transfer speed to be configured
>>>> through the buffer interface.
>>>
>>> This message is a bit confusing. It sounds like it is attempting to
>>> control something about the DMA controller itself. But based on the
>>> later patches, it looks like this is just so we can add arbitrary
>>> sysfs attributes to the bufferX directory. And in this specific case,
>>> a sampling_frequency attribute.
>>
>> Agreed. Seems like rate control comes from the buffer.
> 
> For this series, that was the actual result. Since we already have extra
> sysfs attributes for kfifo and for triggered buffers, I thought of trying it
> wish DMAengine buffers as well. The intent is to decouple the sampling frequency
> sysfs attributes (which depend on SPI offload and PWM availability) from the ADC
> IIO device. And the reason for that is to avoid making the device driver
> directly select SPI_OFFLOAD and/or depend on PWM because these devices can be
> used without offloading.
> 
Selecting SPI_OFFLOAD when it isn't needed isn't a big deal IMHO, it just isn't
very much code at all. And PWM is quite common for fans and backlights, so it
seems like it would be rare to have a system that didn't have PWM enabled for
something else already. So it just seems like extra work to me to try to make
things optional when it may never be needed in practice.
