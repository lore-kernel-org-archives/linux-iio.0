Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E444368D7E
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787438249; cv=none; b=Ri/CfkJdeo+JUu5VghV6Cm3Meyzsj0FgvKjDuG7pE8YkD04Cf8lZ/dRtrYLvFxE1OJd80hFRnzzpBwLYmfk47XO/TbV25It7LwWZwAFOCc1hy9RhvSRtEyeL/2GV55rr29CcNqSU/i72UzV8s/BctwB5zK+vUNJoqfACOVfPGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787438249; c=relaxed/simple;
	bh=DH+J42rJRU47iRWVqVay7ZwyKA1pmoS9rIXhXaUE1ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AExHs1t1/xOdckes1UNpH2HJsnCk4ARPMP2UgKH1Bm4RCVY1gCOk32oof5lbP1sFsPupHIe4AoL14mo0qQcvKNAWBV7jHZpzZPjAKg9UYVLQFhcC4WkHnO+KdLBU52xnHs/iTZYJSGXtRlVhwVvdozXrWCpwO1uLuJg2yqOiRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HJkHYFBv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HJkHYFBv"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b0ff4a57so2993185fac.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 15:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787438246; x=1788043046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpJFDAtg7SWcM0ZQElBMQw5ahKUR/8XcA/uOWdRC5MA=;
        b=HJkHYFBvDlqwO+XFzEhCHWA+ZPus8DlnfUjrNsVmYeLRSsB+2mfbKijy4hd15huDGq
         Tx7qbT0Ruo8AsmuTEbUxN6CWHa1sV7BfNBzdjWaDpDK1tuGgq9Vm7RRg2qVnL7hUG4Zm
         AGuBkUbOBmo+9jVN3PNxjOQPQ7c3Ov8Ah3V0mraC/ezs/H/qX3NV70LKETdnRZ/Jxa7H
         JVakQjO5SGu9AUggdHr/eOUDhM5Ec5SwGmGeqhAaH+2DP7+nBgUobINY5fpX/SV5FjPM
         TAfs1PhiyiOLYnMuN8RnfK5xs0QWrV5OqO3tfR/gvh7QtZAxJE/ckYuqmUWQOgyTbcCY
         l+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438246; x=1788043046;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CpJFDAtg7SWcM0ZQElBMQw5ahKUR/8XcA/uOWdRC5MA=;
        b=DUWXOSVZiB+wS9HYCg2s5uq7k1WtFgo4eRCxdPJcLoqHb2RRrmriP072XLp93zkOG8
         cGR5ajlFIH94zsh39Vvb95l9Eo6HoFQFJyuR5k+8F0n2eL9zikj2TzZ3O8hZPGBnROIJ
         WDVjMGX6udawIp7/93kEh9Rv95XpqHsJqrT2nI2WF5ZJ33eTNpaOsDXpwqdhWbXz2cVN
         7qPwYBBVFBLMCtBq0gCDo3tYk+Lr2qIV2Yc5Iq77E8Z3drQ4R9xgU8pAzKQq8PlYQ8x6
         jMbN0IlNmMwIMniBYB5ryRHKevfyoFWZyMIGejcxB/b1GNsjtO/2D3ptGFnzqJYkdeWH
         GwTA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6T35O0iXz9s4zOgB5omrtP8nm+aul6iFEm1LTB+2gzQlJdrX9/S9YdYF/m2pZBx9cw8y07RRzKpc=@vger.kernel.org
X-Gm-Message-State: AFuF++kT6R2r2G/a1f0J4mpTsGxdaB+Jeq2Ib9B+4gHSTzVx0bFQniTh
	w8eFrRVZvEUaTnUwAzThiTYmnYplQJ2hYH/N/aN9g0YM44Ef9qJzG4SmWP+J5yz/HW4=
X-Gm-Gg: AR+sD12ZOn1EmrocJg5wTYijylGZzgUarmThevT7wHvcA1FHvLca1ZDNrcOAG1Vtrqv
	JekMAPYNFKzTZ3SH59gXlYS39uuIwaBxaJQl62/fTUjc3z4tTNzPA6XOoDyvgSpcJsXGu/H0/QX
	HN0HDiJuTuUeNYzQKmOrWKHdkUaeEivAO0Fx6IsmMjINXOfJiesNujL8BkaVUpIYzIK2EfHnJwI
	4VOAserLmvaiIWLrlLQ9Zla9Luvu47KsZ0LZSegA3fZEPZYchllZu8G8T9kCeeQH7RQuvfVFeVr
	0xKZUwkf5HV1W3mLDWNT2fD4Oiw18xdaPgv4ayLrgOXGHU///aI4H/UjseyEtgmzmbV7+kpjHzO
	nMoWi+xcwaCjghCfilHuh+vKkBNenE9bkMyV//n+lLDsmX2t6TZEbhp3IozfZyNDTyNl5rifpL0
	2vaGjEdnTjx1n105J/By3nDURysTw8M8lX7Sx8U8/YHBDF5HRXGt+gfvNBVAtr76ykm20IjzY/v
	sB/wbjQCY1OmTscc3b3ioNyroWosO3XqP8si58=
X-Received: by 2002:a05:6870:4589:b0:448:89e3:4c58 with SMTP id 586e51a60fabf-463514dfc38mr16883387fac.18.1787438246236;
        Sat, 22 Aug 2026 15:37:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638354650dsm2255165fac.16.2026.08.22.15.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:37:24 -0700 (PDT)
Message-ID: <c34ed727-9ece-48f4-a7b7-45b0f5f558e3@baylibre.com>
Date: Sat, 22 Aug 2026 17:37:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, conor+dt@kernel.org,
 conor.dooley@microchip.com, devicetree@vger.kernel.org, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
 robh@kernel.org, skhan@linuxfoundation.org
References: <f35aea7d-0844-426e-ac81-d5b156b60e4a@baylibre.com>
 <20260822193621.18800-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260822193621.18800-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 2:36 PM, Taha Ed-Dafili wrote:
>> This is one that is starting to emerging as a common name, so I would
>> call it clear-gpios instead to match the same name on chips with a
>> similar function.
> 
> Worth noting Nuno asked for the opposite in v2 review, specifically
> to match the datasheet's /CLR pin name:

Normally I advocate for matching the pin name too. But there are some common
things like reset-gpios where we try to always use the same name. This clear
input seems to be one of those common things.

> 
> https://lore.kernel.org/linux-iio/a79296dc96215a579c29c5c9eda464f818f050d6.camel@gmail.com/
> 
> Let me know which name you'd prefer given that context, and I'll
> update it in v7.
> 
> Best Regards,
> Taha Ed-Dafili


There is only one binding currently with clr-gpios (adi,ltc2688).

And only one with clear-gpios (adi,ad5791). Plus at least two more coming
soon [1] [2].

In [3], there is a /CLR pin, but we called it reset-gpios because it also
resets the control registers.

I didn't re-check the datasheets on all of these, but hopefully we are being
consistent.

[1]: https://lore.kernel.org/linux-iio/20260820-ad5529r-driver-v9-2-ba62e0b2a816@analog.com/
[2]: https://lore.kernel.org/linux-iio/20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net/
[3]: https://lore.kernel.org/linux-iio/20240714133000.5866-5-kimseer.paller@analog.com/



