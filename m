Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2D5187E0
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066001; cv=none; b=dJ/jYB2aNZOLOBs2B1RjHHqw/6HThdCXBVFrGVrQSHWCKzG8UsDRhWaaT558ojLPgggZfDM5Bh2JVys8Qmlg9OCbOzn0rRrgfTmogEEyRTGTwnJiOPRWxZTPqjaFGVPg+GA2dxhiQ6FuUikugPf5U5RXeWre9Z5HX7KxZUCEZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066001; c=relaxed/simple;
	bh=83OX0UMUv0Bs3Z8aWMj2bQ4M5vK54eyMiLDCVnQIxVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFlwGdzSCpCt2c2O9NZdXCeEtrLMQZ2Aq/RpSBmzdQROPKZrWIUiDTcT2/QgLLgpgIun/NXfSjrgFK2DXRKREqLTEH8aIyOz86mSeuIoV8uwWZ99pfjXV33MmiiHPBTKzP5hgJTmIVQ4tpj19khrca/ktStjaoJ6wBw2Kbotsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeHO6fZU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeHO6fZU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1004476a91.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066000; x=1792670800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcthknIbaUqeqDySgJzkRaHnqH6Cw0x7W9ii1wYj40s=;
        b=qeHO6fZUDn1v0ThIo8ZuR3GxgqrnoH5P05YRFB/HUo1HZpxzwTf+KdRUiFnuoGTDAq
         JVbOspnSPLkxMk3jXf0IDLNHy2hIJ6wOHDvwL1zdYmDTvLnTf2WZfByC3JmuClywkx1n
         fmxLjhFcyI2yT9Z/Ws7/ymCHKX7nA87Wd5yz3N1TB1jNTw4+ZXZeZAjvYHm6gnmh1ypj
         ReOd4YGLSlt/MqdCsqhdxHHvGd+L4Wge2hqN+BcMr+sUTwxtbf+XlUfYIW8CfHxvRzhf
         qR4w6kcf4mrpVZPxRk0JgDwNPty1BjPevoFJ2sSBvJ+Q3+hoiur0UTyTagguobWpddDI
         x36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066000; x=1792670800;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcthknIbaUqeqDySgJzkRaHnqH6Cw0x7W9ii1wYj40s=;
        b=jh6kI4P9h7Szwrlm4OZDO9gRrW+O02/+CzlqVER2fi5fZpxG5R4sA9WyWXUyMB62/Q
         7dlkkn4sdT3bMqhcwPYSFn8m9f5q1VUI8QrnaflZmOSKdac7UGRaO/fXWY2MJ5aP2EWM
         OZ4Rajmq5e1lja08joeM27C0GaNGT+298TRM2WIi83Ku8JZCBHl/rM9bhwEBSmfppUhv
         oJ76mXrm/V1ktyu3WLFMh6mElR+5MgEYqM6o8NwI+nnzHhj3gKeccNy583NQdCF0p7+3
         ulxOZxUS6A6b2LcsGrgWE7+0N/9e53/jHI2BeA+Xv6mQIMYFEwZ9jfouXN8V+UjOmw7J
         x9HA==
X-Gm-Message-State: AFq9FYIpoZ2lKpdkx1zReFMnjGGsU+LBEhajmG9iQ3oiaOFIv+cSaZh9
	O9JH5HdB3A9EQsLDmHBcPBQourJqYy97+1CNImzG6Fm1gTrA6RQozGw=
X-Gm-Gg: AYBFou1LceutFNR1vRQR7+UtZr1bnwP6C+wsJRB9xMOGNINIjqR3wmwZJDoW62lLJ3O
	2+JcqtQaFnFb3khQHLb+WnBCwSabv50ssVf/k0bbmob/PiGZ/Xm+I5rJ83+/CdtBQg94eQQokwh
	R23AvZX386ypnzKYiM4vXe8u6V4kQ5BBlU4ZMYm4A4Ug5jBGd4F6A1Be2cGI5MJxxAUWLHeqU6o
	o7LjFTT9LXMl1HWQdqMvD8azGySLS3j694H2TOSLozYYhXoAldAj5iXqefJSqhYIMIWru/h5q5o
	mrsnKRZdx9LfjJhlAhoWICYpRf5Vf27WIbPrMoyl9B0ogpchV4cDRtP4AwU1NgEl+7unQek7KL2
	Obcb77Zd8c5vN9C+kYxKxGffFde2ZZHlmNK/+fgtglZI5DgX3rB6J0eTqgcNQmiSl26NNkjO2+u
	zGVbWDQPHwzJd9Ljp3hATiTEpm1I5rfkVcMzOYsx65RzADWYtP6ivFaUb6K5JCcuji4n5FXqohf
	/rhq2Afn2YgCBLNFmQZ0hwtD+M1Cr2Er44MK1Ia/Ks=
X-Received: by 2002:a17:90b:2644:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3acb048faaamr495599a91.67.1792065999597;
        Thu, 15 Oct 2026 05:06:39 -0700 (PDT)
Received: from [192.168.1.45] ([45.127.46.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm4324163a91.4.2026.10.15.05.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:06:37 -0700 (PDT)
Message-ID: <c0a5726c-2a35-4e2f-afc4-8cef65877e8b@gmail.com>
Date: Thu, 15 Oct 2026 17:36:31 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ccs811: Deassert WAKE GPIO on error paths
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
References: <20261014152250.8324-1-nikhilgtr@gmail.com>
 <20261015111145.000065b3@gmail.com>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <20261015111145.000065b3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Joshua,

Thanks for the review.

> Please add a Fixes tag.
>
> ...
Sure, will add Fixes tag in next version
>>   	ret = i2c_smbus_read_i2c_block_data(data->client,
>>   					    CCS811_ALG_RESULT_DATA, 8,
>>   					    (char *)&data->buffer);
>> +out:
>>   	ccs811_set_wakeup(data, false);
>> -
> Keep the blank line.
Noted.
> Otherwise,
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Regards,
Nikhil
