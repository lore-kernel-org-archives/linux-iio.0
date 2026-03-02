Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1033FFABF
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463297; cv=none; b=sdHB+kxtqKP0Jw+186xLXJaBz88Po/AfyPKGontplfCu5aNhpa7S1WUtx8nNWHwGAa/ppWVYtMKodMkocHduTn7Q1HOEITtGL7byfqrIa/mNlaaEceBsUQ+Uer0bXySqPzGbeiLphx+K08/DBB8/YIsCmDaQUrkP3+93QWmc5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463297; c=relaxed/simple;
	bh=GTZg6XYgl3GankwVmsFvj7iWf80OnSj8heKlKML4YFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuccjyfldiJP5hkwv4SYBTt4Lw9nMk83CvRHo7BWWc31G90GUYHfjUf852NOBLoSjJK2apA0qybVlva5ti9HVfcxDB7e8O8J8NXYModzygSbyJMYqQikE8gzeNFw4XTPaTNTdAPXKhBY7rPSMxpVYZlLJLhj7CVQ2kAPb1IpxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2AVSk/8L; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2AVSk/8L"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463ba60966aso1704525b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772463294; x=1773068094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laA35qcUF8fFZPEbHTBhJGs7e81IdNGotfYLLezzUpQ=;
        b=2AVSk/8LjfEOH6CweYXqxTUI48Uv2vorBBqXQURmgZXwKb7AilUFmlTCrx/Z53TqoJ
         G2dF6C0OAV11jz/LD4iOJaGZGORcoW5sOESiu66pyLkupSHCq7Z/AO7dSikhDy9N6ruF
         9HY8zP/Trj/XP+gRyBtBx/00DJjZEfTG989OF50Q+5IMThLP1UPokrT3DpzwliImyOWj
         4AQrtnluBosiMxdBX0TnIFExmLAc47wOf7PF63BCABOegSa8oQOUcZ+X9i/WwcwnsSQd
         nipr+RhTkvW0WxdkHGB7HvTpaoCQQ3fwa6WD7GqfOGo5r/sJzoPkxRkM817BSvUzYuX4
         C3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463294; x=1773068094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laA35qcUF8fFZPEbHTBhJGs7e81IdNGotfYLLezzUpQ=;
        b=J+TXea1TAX1F5mcC0ENVqFnH48Q8VPdakkrIHgK+S+bA6Z3cH0vrFnI7YBcMnYdvxv
         z8E+HKl1ehRUrFgIUPXH9Z7EOMguUgDyQaXs+WA9ng+UgC1SiYb5bHUynRm5j19dcdCX
         jJe321c/TCMu5HiMzfaCnd8VII6q1eulQEceRl86GPxupVnYBZ+NojAIl51UYkIKWxL+
         wOb6YOLO8zAtcF/eVGG0Hnv4lNH2mqOnOK4faYIlSkQacYeRyDws6dV5tEiHNz04xx2t
         qGtLbRG/9WUXiIoTOsEWqKQqiXQ7kN37DtXBxA1+zJThepEGpfkaNwsnXv3IfNLZnXHC
         5w5g==
X-Forwarded-Encrypted: i=1; AJvYcCViT7Y60N4MooOXsii5juzVa/BVBajSpKrQKxyPgWvgFv/O0lH54Uc+WR0aoVkYshAIcymEmggTDjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuWgpMiS26tY4N8vjH9ZyCxQxX6doVAu7N+o84tKjJEURzDHC
	fgTtLuq0Q6rK+BtU+aL2s1RIagWyqIr5leA/f2nHAfMzOweyZ451c1EgA1+YgMtQ/BE=
X-Gm-Gg: ATEYQzzAaUIE8v4V2VvSWlfTCZ47XRou/UzFShhrTDYBZKvjx3LetBtvXq/JLQFnSXD
	L7siUzvVu42O7AO4oee2dW6jUCVYQdpYG86FBexTFAVfn5KhFS5sGIYb39tKLUbUHWZX6p6OiI7
	BbBzJXLz8hU8UII2E60CJWGPwuDVka9NfgXOouQ8jKadfUzYu3G1Pry31D0PsYhe08chuHrhlMJ
	mW0v7e1THIxCSmODQ2TSbPV1IrDw22JMGMfEmos0zDRtEW7dCmUZyIlcKKqigUS7jhSLIDsNYx7
	Ej/qANjvszt1SQal7F5PhF6XEtrpjr9kcYD6l2XbskJn0MoQ9o2ZbYSEQFWh9/TXiCM3lNxhX5k
	ZjzcU86kkHpm+De4PlJYdlZ6rLVyXpyaSJaIIWknMfRA6Ogkcw8XNZm3bqjHCtVF4R1OYtE9alc
	OHOr3NwdQ85EakjEIuHBUJXZuEyC4b6ofFameLcOprZmSl5N7EIMI+loF7jtPIiNELIEn6GT4J+
	g==
X-Received: by 2002:a05:6808:c281:b0:450:ac94:5ef5 with SMTP id 5614622812f47-464beca9f23mr5602599b6e.16.1772463294195;
        Mon, 02 Mar 2026 06:54:54 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf239e0sm12546081fac.1.2026.03.02.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:54:53 -0800 (PST)
Message-ID: <2e4acc5f-2079-4160-a4d3-6453b48eef03@baylibre.com>
Date: Mon, 2 Mar 2026 08:54:52 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
 <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
 <aaVCuE8rwFikaL5c@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVCuE8rwFikaL5c@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 1:56 AM, Andy Shevchenko wrote:
> On Sat, Feb 28, 2026 at 10:50:00AM -0600, David Lechner wrote:
>> On 2/27/26 6:43 AM, Antoniu Miclaus wrote:
> 
> ...
> 
>>> +					    !!(fifo_samples & BIT(8))));
>>
>> Technically, this works, but in terms of understanding the code I think
>> fifo_samples >= BIT(8) would make more sense.
>>
>> fifo_samples is a count, not bit flags.
> 
> I even would prefer to see in such a case
> 
> 	fifo_samples > (BIT(8) - 1)
> 
> that it will define the maximum that fits the HW, or plain number
> 
> 	fifo_samples > 127
> 

Now that I looked at the dataheet, I get Jonathan's point.

The reason this is here is that we are filling in a 9-bit value
using 8-bit registers, so the MSB goes in a different register.

So actually, it would probably make the most sense to write
it as `fifo_samples >> 8`.
