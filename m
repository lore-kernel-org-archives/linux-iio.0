Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCF331213
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814414; cv=none; b=nC9kC/e2+yv58zKelFoiMoQQWRO8AvX9rfdQ503msnSlfQ4H47L817HIJPVQuUbC9AnWsiWK+bC70eN1FYb+cogfdnMM5xo1hVJ9/fd2ak3GZJ8BmVcP0fNdu+JePvkVF+wEUjsJpJNOpFdKPXY+RcrioM/xNxYJbcL2NuvgYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814414; c=relaxed/simple;
	bh=76r3kjz+9Z2QMvQAe7Brgp6OaaRZYG9+O1OD/q5LJyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIFO7VOqvqMifutRiprFdepPKiuIMcPR4nV6uulmgF5rLwJ9DEfUfzYMPLY5VidSu71JOTkJjdtu7tWuE87owwglbVNx+ALbe3T7yMc/Uo7opW+mHzPIvEsB3F+cXC/yDSJ0cJCEWOdjko3ropGfSnnxiwwo7Yv7vaujMZ9Ww0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToW8oEvA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToW8oEvA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so871545a91.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814412; x=1782419212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0TnOsVUyZhZEFtMn3lxQN/Z3qhDIQt2PMSD3OahT/M=;
        b=ToW8oEvAbSYaGQOck3E8JRJEWzxfPj+6xXdhsrT8tjmyDRkh6NYgO5Ql2pOqqNYRdm
         7BcNS1npsWCLJPhmmV4RH8zzKYOa6fnB5ih9vut8es0YL/89eszFt8Haq73I7W5WbHpY
         FQOJ6G5PzCpX+UnMvy/8aMeotjoJr0jRYUSANViKP6+qDBHaVauvNViXud237ybYzzyk
         Vn++kMlDaqFNJZiEjVEvkt4tWxqdS0i/93Al7le8Lh4FJ6gAqOaE4PqK62S4mVxGMEv8
         B3CUILg5p6RXzz91vyyYkqEXrNPEbPCL2UA+8u1YxZbiEz4ArZuWI+sTq4U6G+BU91JR
         M30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814412; x=1782419212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0TnOsVUyZhZEFtMn3lxQN/Z3qhDIQt2PMSD3OahT/M=;
        b=SQsbovRl7sDlQgHg+cflajWK7k2DIag3BBuf22v9qUpNZpIS7PfHpmLTiIgJF0D1b+
         0ccUARMNiUCM1zR/FmLgTg4ae4AtzP2XwMBgezsJvDcYd8Q0lh7UuLNhk+Nr8UdGnD8a
         ez2Iu9PwNzYNTWtx9pZFsnvDc03sfGbRiphrK9UoCfvOUdynrJVBfRMwFLyIkA4HaIcN
         +p1ay0dgrGxbU8QbRjlS9chtZDZb5dXa7fexlYLMbv2pd/tFFO0PE9MDKxL8xPiXI7NA
         ezESgOm0TZ5EQSIH+VoqDJe1CBzWUWYdp5CbOt9LrMEvcgAWReKDp1ontzhVv7rUv/gA
         2uDA==
X-Gm-Message-State: AOJu0YzLtkNMNAGsA0DruZ00kRmtIOhpIPYODeh9zlD7zua1XdwPbJAr
	9gSEPBCVfW1cvmu0b79ghnMfVSlESHad2nJpX0UxQ/y/DmeVk/i68hQ=
X-Gm-Gg: AfdE7cno8GsSB5i7tJ26fbLLXW6NhxDRh6dnMlBBdDHIZP7ejYnBVl8LuDgazBroWzK
	ngUPF9rwVEHkBfWxAzvmdqS3nHWDDSOxcMDiqftC2FCALV/tlKerM+nYWPpOTJ6R8FewDlA0Iwj
	GI4vzcyMkxnP01K10LjYtJ7lqECjQ/VxL7coRcyGaZJ6qSJib86UvoY8IY4zkbhje/at1twvBZh
	OLSEyM2MlBxkdx1rIYG+ae73Mj0kpHXmRhUbwD5HdJyQsE3q4mWAjiQ3lgdNGAo0aDm0Y8Pw0zn
	9WbaHIp3FThD7HHnRzXbIxirJC4jwpsSXNqiWLZXgTkIY4q0qAd3dzEEu/WAB4Xe9wM057PBbE8
	iTlKTEQigeqqTUUFwMXeD9SgYAnn9nzQQnr/oKm1gy01OlD2qvBB6tQSY2j3MHTlVKc8LApjpo0
	/i5xHNXpWgR6wSDTnzsFWFzHBrpUKhATx1fXn17R/ysT69rHWWrSxmGRj8UA==
X-Received: by 2002:a17:90a:d610:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-37d13cc9b69mr1245175a91.0.1781814412328;
        Thu, 18 Jun 2026 13:26:52 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d153601e3sm573269a91.1.2026.06.18.13.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:26:51 -0700 (PDT)
Message-ID: <9ef6ef71-e2a0-416f-8b49-b8b446f76b78@gmail.com>
Date: Fri, 19 Jun 2026 01:56:47 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Melexis
 MLX90393
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
 <ajQ_9uHMcTY2Hnmx@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <ajQ_9uHMcTY2Hnmx@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19-06-2026 12:29 am, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 09:31:39PM +0530, Nikhil Gautam wrote:
>> Hi,
>>
>> This series adds initial Industrial I/O subsystem support for the
>> Melexis MLX90393 3-axis magnetometer and temperature sensor.
>>
>> The MLX90393 supports both I2C and SPI interfaces. This series
>> implements support for the I2C interface while keeping the driver
>> structure transport-independent to simplify future SPI support.
>>
>> Currently supported features:
>>
>> * Raw magnetic field measurements for X/Y/Z axes
>> * Raw temperature measurements
>> * Configurable gain/scale selection
>> * Configurable oversampling ratio
>> * Direct mode operation through the IIO subsystem
>> * I2C interface support
>>
>> The driver has been tested on Raspberry Pi 5 hardware using an
>> MLX90393 sensor connected over I2C. Magnetic field and temperature
>> measurements were verified through the IIO sysfs interface.
> This doesn't answer to two important questions:
> - why do we need a brand new driver?
>    Can't one of the existing be updated to cover this HW?
>
> - where to find the datasheet? Any Links or other means to get it?

Hi Andy,

I looked at the existing magnetometer drivers in the IIO subsystem,
but none support the MLX90393 or a sufficiently similar register map and 
command protocol.
The MLX90393 uses its own command-based interface and device-specific 
configuration and conversion logic,
so extending an existing driver would require substantial changes with 
little code reuse.
Therefore, I chose to implement it as a separate driver.

The datasheet is publicly available from Melexis:
Link: 
https://media.melexis.com/-/media/files/documents/datasheets/mlx90393-datasheet-melexis.pdf

I'll include the datasheet link and clarify the rationale for introducing
a new driver in the cover letter of the next revision.

Thanks,
Nikhil

