Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA29BD9A
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913512; cv=none; b=RIPPu4WdMA+bKz0JssL+AXQe6gRgDaycPABys6+nRndTMyrCz4JskmRyJsDSHNCpVlRh38Kt9EbaOQkmE53lcCanYYPhF9H4njLyAbIA/e3a85OlJSPG+cPC+GLy/hnNMNMlJuivdnV5iXoQGXO09yu2ey2WbRD0B8CteNigYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913512; c=relaxed/simple;
	bh=WBtQWQRQLZ3+dIWQtnefpQVzOJC+bEiYRJCJsgDBq0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VblQDWx9L5HS3hCNA8dwLcgD6PHj5r0L0jzAwAlT3PhuIAVdQwRGf61cocha+fGu2tNtmOckwaj0NG2ho8vET1TPbBGpiZS4AqlUIwz8/heXSr6Q1dhX0H8UqlIKvu1gpzjIfgqZQaZApt48qb/Iv3068MaMPSQpLfU0pLXmf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzAhMKP3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzAhMKP3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1044693a91.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783913510; x=1784518310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsiouPU8c+6FKj/CX+Yj36YD+qsjrWhaM84VxnsY3Pg=;
        b=KzAhMKP3X+WHbUxfK84fG0Xj3fFQWHidqyOJ1V2NA3rPCsApwiqHDcOf7P+3AbbW56
         rHYIy6AH4j3qgqw1MJuMH1ZcMp+fMI9DnmZ4uNaB+c98K3D1lnVxnIxm6Z4nmp2fI6yZ
         TEasneTLWW3BNAX/WN2UAiKJks1s1I9h72A+solJz66/QRMCpJ7h3skxQ3K9pjZ8Kpx1
         wB3YjLMVZWghl2/gc6iu/+rq4VZFAtkU6373PAADmRp6DvdzRiyGQQ7eQOxsVbf/LJcE
         PHGHuBMyCX21auyfuwgYpiTmUx1G2mcgJ2v6PKzApZyr8asKvYrpigRTAmeFm9B7e3yn
         Kq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913510; x=1784518310;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsiouPU8c+6FKj/CX+Yj36YD+qsjrWhaM84VxnsY3Pg=;
        b=HSnv0hpfFKdET4UTzOL2EidQWeecyVsNwfgYDO/n+Z6OsKQlKL5dU0pKHsHyiEj8Os
         MdXynUkFA9aLzgItgIJvT/p0dRSy1lxAZx8B5hOdHFbMI2DX/N0xvhYQOCjOs8sGWPTa
         m2NLf7no7C7I5Qfe9oHZwaomkLBL+hN5NUNjjsZXI02ygi/Dfh8kF5NoPtpHSYh7minE
         s+4pl5GFRQUJ0QXtlcclYbBDKiGWjpHO7zB34e0k4cjMVHN706TA55S+wEd19E38JCee
         RoDW9oK6pFowqrHAFcjJBCYNqHQKo/yVkwpmZK7SgHG3ggNaTreUnnY83ix2iaMAY89O
         hkjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwZzpyV4CmR2ORUnu10ew3WCZL56xbGF8E6vrJzEkSXP6dreDvKJt5BJpJrNFEDU8u/UWLIyTy6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwwvGCWLo2jHCQnCX67tHAZyf9prR5S8uWcANyYaQ27upRfXH
	5eT/sdKH3TQqiUUjBmZxmy51RlaUHcw6ab2ZFJYzYSRUxuH4L4VKe3s=
X-Gm-Gg: AfdE7ck96LqNTiG51UdNDNqkH230bxM6baPZIQdcPKWYlzjCcKswV2QCdqXBW9eLb2M
	RseieLC2yWr/PWRDX+yjwWIKpB/B5BlCJH9uXy63jecAa3ipdPjfuq5Z36b6OIMcr7DrD3b/8bX
	exbf5RQYskTjEZpUDev6VwRh1nD323hJ/au0LhxAZis6dIja8ayn2pLmDMB8IfGVeIDXnfO74cO
	5ojM5ZJ4TkN2w4ccH1KQezBcR1MjtMsz0+Iz1EfcJ3KPG0XZR2w7oc7KAmgdvsznu0a6D8HBoOo
	Fq5OmQ90b9mHPgn7zX8E+7Wb7qzQghc4Nh43qgPIsT+iDQrqqjJTdKNr09wQvS6UwFXHJxmvwqy
	/7GjMzHoyFTgGALD1U8Ok/PVuFjo6FyZ+yIt3DnxGF1VYyZdGq+6xi6pKV/BGIgLD0WmvVZfnHb
	rOzLAZV+geFv+zuD8SlFbJqPdPa81yb14Q9TI0XPW7CS9gqn9D9jhivd7ZXgCBumxhF5hs
X-Received: by 2002:a05:6a21:4ccb:b0:3bf:a8d7:4f4a with SMTP id adf61e73a8af0-3c110be0abemr7441911637.40.1783913509688;
        Sun, 12 Jul 2026 20:31:49 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm14016195c88.0.2026.07.12.20.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:31:49 -0700 (PDT)
Message-ID: <f83d5a61-8735-417f-8fb1-fd14b7c1ee28@gmail.com>
Date: Mon, 13 Jul 2026 09:01:44 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] iio: light: opt4001: Fix incompatible pointer type
 passed to div_u64_rem()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
 <20260712202451.20822-3-nikhilgtr@gmail.com>
 <20260713014319.7033a06b@jic23-huawei>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <20260713014319.7033a06b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13-07-2026 06:13 am, Jonathan Cameron wrote:
> On Mon, 13 Jul 2026 01:54:49 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
>
>> div_u64_rem() takes a u32 * for the remainder but is passed val2,
>> which is an int *. Use a local u32 for the remainder and assign the
>> result to *val2.
> State what affect (if any) that has.
There is no functional impact, int and u32 have the same size and
representation on all supported architectures, and the remainder is
always smaller than the divisor (10000000) so it fits in the positive
range of int.  I will state this in the commit message and add the tag 
in v2.
>> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> Fix looks good, just add the tag for v2.
Sure, will add Fixes tags to every patch.
>> ---
>>   drivers/iio/light/opt4001.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
...
>>   	return IIO_VAL_INT_PLUS_NANO;
>>   }
>>
>> L
Thanks for the quick review.

Regards,
Nikhil
