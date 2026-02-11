Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C0350A09
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804471; cv=none; b=lu/4OnNOmQB1KbBKVjfNYV0GoZs9DMj1PTBV1mrSCdppnVibeFeH5bgnA3a/k2lWT8RuqPx9Fo62OTd6tJ+ltBSnojBTKFypKafoNU9aHGNuy71fNs2J4KPZfzItwKbkNuHP6IIghLik7YJrql9scctHih5V/jrs8MXCh5V/DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804471; c=relaxed/simple;
	bh=Z/GZBqQCmQqhyUddNtRKYVJhCP5a/7Enct9wdD8/d5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f5jkNDxO/q2h2GyRG1xFTP40BsEjBpV9l4811kDFjz8vUNieMzCOqgs85y5GDXXk9ZBXSBMxmhHziKS5NKJ59uilJKECq9Uc6JaSsqP1Fei5SVdg6T33rJt/3bDfZhzw7MAszARs5qZNVwyNCKAvzZmzNbw1cW++uBFwleyXtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXT/v1WS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXT/v1WS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e555so27795465e9.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770804468; x=1771409268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBJ0NKlYQHSTcX5I6AxqwzGVfI3Ct5XxPEslgPpmVnc=;
        b=eXT/v1WSL5Zz3bFDNqpQsuLgfHFORzAM5e6JQCrZgRQjBP1E5oZHSGzAAjsLo3F6Bs
         7dvRSOfVdhqMIsYskNnh6b+bH07uwfMmPtAwa+A4bHkDLITdmTKPCyZ9a8mU73+KN+41
         LDP/3TRNGjVNiMfoWl1D4nhqiw+qZNjNv4+p1CbDMgYZHs6+2sBflZqSQqNMi/zI6Adl
         syBOzAvFYxkeMXiRQtr+LfzXsVtegLzX3mABmseNuaiXMysBVqOGpCfGOa5ksA3BkBK2
         lnzZGeHvJLohoo1p6zWR+2BDuDUAxaGtBynzMyYDs/w/lQHQonndcr8dHGWqz2mBgETd
         4amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770804468; x=1771409268;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBJ0NKlYQHSTcX5I6AxqwzGVfI3Ct5XxPEslgPpmVnc=;
        b=AxQaHRTwGT+O4OMAXKw/viKjmRRXxO6kmDC62SNrxnmkUEJRtXwwUkmj2lOsO/G+u4
         jqe4L1dF0xf8nfTxMFFSV7MgE7ZUToxAF/j08IrjdMY6/vBocd5CTZMjVxh5UW0b3Ry1
         Tkvs08nYKo/cpKHUJS8LE6YgiRnbsupIQLVqCfEP9k7ZdUotb+o9PKDoA6Rm/uGFQLmF
         kNyE7KC/AcXrqbI+vowOQLPXGCaf7ypdeLJGxj/tdynT/Gl83yxU4flZoIYZUrrdpQuD
         d0Ks6iTl6rhP/0QrM8QJTY5qx61m2pFqMVlzGLJOF2nJN3qHiuEg/dS/FYb/Unqtvkal
         4Heg==
X-Forwarded-Encrypted: i=1; AJvYcCXsl8/n6ZrRExeinIpp9luLSumma9JrJXWBnUwVCsJ19Ky7to57jFcYYk8v1BkyFTOKX8vxMs6IEho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw413lXh27l1g/K4p9JgcpnNbWVIRoKXB73vhisggE0W2iEP3M3
	WqkqcA6fx5/++80XrNRM658BVGtYMVzWzbat+hiLZHFiIXGjHV9YmjKm
X-Gm-Gg: AZuq6aKmedtQ4ggkRP06O5nGjMuDjBsliHyeDG0wQV4aut5J1K/hixuIyB/jXES5f3s
	SUqXECy+1HfUgDwK9qce3Lq97lxVXU/Tm9ttg+BNxojyz9loJ7JQPOvDOf1HOpgQMZvf+th1AU6
	iv20eEt4pXABSRSfLULrkrd67FPGWKGtgo8wsE+xQ1lSfa4EzRzU2KneHx+sSg0aZGxgntxrBxz
	bQaV8D7SD79wOWvgDqV2VZ+2rrqLQvAe0V2fDTILHf7BmhZMVD4Wub8hLFUmxL8dvaGKEvHD7HM
	LE9kgKlevufL3W+VGxNjs4RermXQ+aPP6EKyN6REmTF9eJ1upmAcdLK8skw8TPKAghJfWO5x+zB
	1W4YgxlLJpQWzc28zcTaKEdKtNC94ERf3LnWh9V8qBb9tKyBJhVgxWva6pNvIqjIvlFKRzziMPs
	wD/ibJmRWD36Rfw5FXPrVLRdoGHnTBKm79jOtuZAfY/2rQeR9yRQAE4Qbxob8hH6HyY600
X-Received: by 2002:a05:600c:5288:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-4835b90c34emr27593875e9.10.1770804468157;
        Wed, 11 Feb 2026 02:07:48 -0800 (PST)
Received: from ?IPV6:2a00:f502:160:28bc:50b:5000:8e7d:e760? ([2a00:f502:160:28bc:50b:5000:8e7d:e760])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a5c7c4csm55048775e9.0.2026.02.11.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 02:07:47 -0800 (PST)
Message-ID: <b95d7a49-6191-4d85-b725-4a941505b40d@gmail.com>
Date: Wed, 11 Feb 2026 12:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
 <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
Content-Language: en-US
In-Reply-To: <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/26 8:49 AM, Krzysztof Kozlowski wrote:
> 
> There was CM36686 v1 and v2, so I do not understand versioning here.
> Also, lack of any changelog.
> 
> And how is it supposed to work for us? Try yourself:
> 
>   $ b4 diff 20260210-cm36686-v1-1-aef68dd46ad4@gmail.com
>   Could not find lower series to compare against.
> 
> Please implement previous feedback.
> 
> Best regards,
> Krzysztof
> 

Since I am making changes to the existing driver instead of creating a new one,
I introduced a new patch series. As I mentioned in the cover letter, cm36686 is
fully compatible with vcnl4040, so instead of creating a new binding, I create a
fallback compatible for the device. I probably should have named this patch
series something else.
As for the previous feedback, I added the subject prefix and removed the
redundant phrasing.
