Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E314A6F
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943184; cv=none; b=B61FG2nea6N8vn6DotYQpo0+yK6q/5Y7bG764WUSv/YVaJuWc925LwjwoFzTkIMoY6wkUs3Tu/ef/AHEiuyS3s9RYNiTpmrrS5JTdJ/qowhRE8wzHDCVutyZ0V9OHxIwZzM0miWzBLgPS74rFUdRRYfFYwanF6G6Z72ymq2BEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943184; c=relaxed/simple;
	bh=o+EwF5sNn/62qlSMhm+//xRPbGNuVP8t8sGE3lVuums=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PngtcJAyrQsdjrPxb8a7o4QSMh08WtU/JYlVnn8WIT1Pqt3dZL4rv/ur+pg4kgpP8XKzBOQUYWSNlM946jIMpnq21UUjvrXPOyAbHxalVfo9dX3lNtrB6VX/XFrZZI0QuI43tTiKk2oaJ5j6TSrfqXNUfFyNIwWhTlTgxizBcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDSmM+a1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDSmM+a1"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0117dda13so2846387e87.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943181; x=1787547981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+RYmCe6QLOGqYQGrPMnf2Nsi3pMxXU8BaOAMJ9Mmig=;
        b=NDSmM+a1zNeDhb2vm2sAD3SKY1LE9kfvo1nG8IKvZPDjHge3t7T7yapkr0Di1W1ZoI
         oF+wnZwxwRnSscMiqidrbAcRnXi+2Lix0RgAX0Hjuiy1pc2n2zhaYVIs6Vs3ayju2D58
         Dmvwp1DF2bouo2+GHsrLgwsgYoK/pi3VE3P5UZRSkZSXkEOpZMC3PDF8HV+RrqSI0d0C
         fh37nK2/I7Vip/y+3Hd/+tbI2EruKZ1tUW2cF+owb4BXCpf6h0Ny+GzoFIGQcLBKXlg5
         hJVa9ZE9uz/sHeSiZXVmGSPL/OndZzAncZxWbrzvv/oO6xK2hn9d7emIcJ5qGR6wEA3X
         8qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943181; x=1787547981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+RYmCe6QLOGqYQGrPMnf2Nsi3pMxXU8BaOAMJ9Mmig=;
        b=LL7SYWZlDa1WQ25ISu5ahdM9LLY1+rfMhLPcLMKrQDmWDa1h6CSUMY5VMN5e3l4B/1
         JwEFF+kDUhaHtUo6CZfCaZUSI10lbo44AMLbNmgairhccwxyWc4/s54j8zP9tjMtngg4
         ZK0wbk27IlHCwx+HBsV+RcanyzVKkiZ3WU1o0WNNuz7z5e6bnU7XLN3ZOZGJSzLAJfSf
         xDRaXaNjCuWWBuwq8Z8R+JWbnflmTICgvH15tryrQGDLiKt/3r7i6PYOMBZm085RtLfY
         ALLoTCnFFBP7eom6e8LqLhuBznPl6pIs2Ixk4ewGPInXACQV7GoacIynCUSHploQF6S+
         bGdw==
X-Forwarded-Encrypted: i=1; AHgh+RoFS/mc8fAm9XIi0KRBeiY97udex5lVi16c9vdwf0yxa75h2DFiQZGrwkdpF9DUmV/IDiBCGo05Rew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVl1kuh8+jnyh8vNFZkv0L0HfaQ6W4fQeYpvjekSe9Iza/uqnj
	uIk70JkQKLSEFAdg3DhUDyoXfjvb3NHDQYU5JcxnrAJRnSLu2dQEhJ4v
X-Gm-Gg: AR+sD11uFH+TRZJbQqZ39w1mqDwGm8MMhYKIK+R1NVUbQ4kskXwYRkDb2iMFr6cnq6M
	P79qMmkGDEAXqH1cw4wYxN/e2TFNL9lmRtbWDka2ubJlr4sBovhA33bDsSqp+buCIhQakd74H9Q
	I4E0T0ZIV4zwgZ2IRLxOY5ur2Q1qMiR7nR3zBKzGA8Sbvs3XDbNsXHjPerbhy1SdD1726YZMVhd
	UHV32/TEjWz9lY6F1VeD6RITYu+aa5qeg0+2+0V5FVlK8OreKu5WHGhMi/vuF4hvsx1FWs47qDD
	nvpEIGMshup8mFZHGjjHDqYn9g2wh2m7+IKEDBW5DLDSxTdpRre7LeKQsZjP67ayLWbem56KwKu
	qV4IixpTQR6tEBB22vkEp0lMC/5yAOclcB1dYjswx0ZVFNcljrDwp8rs7YnlyFvFNpBSv5HPkvI
	GRPh8uwlusuwGUs8705CqJRpUczwEVszOfQ/F6ag57PlWlA+64Ed1+Q/fkmPI4qGUu6GhgPMn9l
	8Mc1uZUVWmRvyKmrRZ9Lr0zWbk1tNpdeT5pVgYYROQlVhRChg0ukhc=
X-Received: by 2002:a05:6512:3b91:b0:5b2:aaa2:1d80 with SMTP id 2adb3069b0e04-5b459149932mr3844377e87.47.1786943180507;
        Sun, 16 Aug 2026 22:06:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa096asm65020e87.19.2026.08.16.22.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 22:06:19 -0700 (PDT)
Message-ID: <a4b7cbb2-17f4-45fe-8cac-b8a7b1859206@gmail.com>
Date: Mon, 17 Aug 2026 08:06:16 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] iio: dac: rohm-bd79703: Do not allow writing SCALE
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <bf75f4bb0d3d620e5c613c04cfc874767a51ff38.1786347811.git.mazziesaccount@gmail.com>
 <20260817023217.2fd9e42c@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260817023217.2fd9e42c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:32, Jonathan Cameron wrote:
> On Mon, 10 Aug 2026 10:51:38 +0300
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The BD79703 has adds IIO_CHAN_INFO_SCALE in the info_mask_shared_by_type
>> so users can read the scale, which depends on the used reference
>> voltage. This, however, enables users to try writing the scale as well.
>> This isn't really supported but the bd79703_write_raw() does not check
>> the mask, and if written scale values pass the validation, the driver
>> will proceed writing the DAC value when users writes the scale.
>>
>> Prevent the unsupported scale setting and return an error.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: af6aca656a85 ("iio: dac: Support ROHM BD79703 DAC")
> 
> Applied.
> 
> BTW convention is Fixes goes before SoB.
> I did wonder if is documented anywhere and claude sent me
> to the tip docs.
> https://www.kernel.org/doc/Documentation/process/maintainer-tip.rst
> 
> IIO can follow that.
> 
> Anyhow, I'll swap them around whilst applying.

Thanks x2. (Once for pointing it out and once for fixing it!)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
