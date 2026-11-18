Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011427;
	b=vzatE0v+Ri2uB2pG0rzZZyrl2JWRvAIXih293BJvNDTbtPoJl2UcgMw7Ohk5+RHjaRz0
	 bf16aueVGD+GiRnX6zY0p77ZL4lyBY6Bl70gud1dFL9i6Qxj0kD8ABaSIZMtPlbXfqpv7
	 Luf0vCpu4OG0vBtW1i/svDJQwQCxOYCcF8CFZb7KuZ+hQTRO9WDVUji3QugTj1Vp4TZ9C
	 D/AvMuL0PZrbavtVqWxPpaDSqL5Q3wioWBXXAmIOarJsMFZTqfOIN2HO6+q210L38s2v7
	 fG7+7oo5dcwqIlfKSiavVIYqK2++ItGYcHrvNDpvoSQw72pMJaZDpBCK7l4m/xyeTyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=b34pYwhIMCotuo8i6v1F1rxLaKP3lXW4Z9fyRTfdjpA=;
	b=mS+j9wzsXrLOhI9719LJHSq02UOSGrLaghxO5BpYRpXjC4pr9jUL9nPtIMcivlgbovUL
	 ZyG5hpdNTkHG9+j2UmmgIBTwPVmfwGDQe+ltQQmQBFRv4Jf9MRZjmQxQ6xmxdJs0jBG6V
	 VhDZRTqlaGksV4GydBkqHbPxffItVO6sDyvB+Gu2nwBNSl1r/bTGO6qjKYzTx8EOHAnrk
	 9RptcWLnWVuFvbYbfPL8rpV6XYfnmTfQQchFpM8LDI61R1TDOm4A98rpKXLKPOumgG0LB
	 5lQCzxZbVhCRYX75ltcRyUYevg5rTkP1cdFqd3l/5yL3c7t2hFcf15vvSpsaVaq7fZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwpEQ2Bi;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8660A3811
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 14:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D8660A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwpEQ2Bi
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c1479be604so762539e87.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011424; x=1795616224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b34pYwhIMCotuo8i6v1F1rxLaKP3lXW4Z9fyRTfdjpA=;
        b=nwpEQ2BiyJzOgY/K6KL8CsKsUbtaIvzKrUXkCoyATGr0FA3sdNfjtAepVBzRgKdnzz
         8P8bTm2Eij1xtGat/HJ7k6Uzv5XCBA79Mi2zxZFRdLdxSndLo8b9eRz3ID1OwezpqKf7
         RRBO/k7C0kSFghrsE2yPx3VwRU+vWH+vZ6plAFbLHgMWtR0nE/f+JGDPn+IcAUNHHnf+
         lyG4YQoGKUYiC9BV64aV3/qDdY1GhCKP1ghJRV1rtgGXqC7JrRwKN9tZUd3myDRsie3C
         1i7gqOBjYTViooXM13NMXeW1OjX52710QfMEAJfbcjjm070/5fQtfbAg+AFdLgj60h0E
         9dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011424; x=1795616224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b34pYwhIMCotuo8i6v1F1rxLaKP3lXW4Z9fyRTfdjpA=;
        b=rXMzFJxQo+/R6SxqKn59mg/5OdiesOt3KJtt+FfOASfZhA1UeSkaSvDEUaHvX3EfFb
         2z6QcqWVDxHxc0TWH+uJZYtBL8KuGJP/NsRZxS1eXSfgy+zhK+I2RKgwyN5+fJaPF6As
         p+5LMuSgS4KmNfyXzcfzGO3sgIOlZe65Yz5Xv//5T9uvWgoJO2Wp6LBxBjQShpQMnM4E
         mrGCcNOqOVKLR2ZP/3wDWWK6vDo/T0fHZ1gZ2E6vLoQOwB2FiRKuoqVVVf6/qOHn5esS
         xwPbm0b6UGis/1uWE1u434VDqySRtCGFkOBESrh3iBrQ4VMPeQPrTel8zEgLXvYdFkaU
         Rosw==
X-Forwarded-Encrypted: i=1; AL+hErFUgUaT80zn94+SKQk/AvoEF5QPo1svmgbjL5uiVnwav3CnzJSIxZSwRHiPJ7c6bAHjy+aYYEPBlE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SNjfUmDPhcuHxYraJi3srJYF2cpdcbF7Rt1qjdAQM5mArEHFi
	jpoh98wST+fp7G987gFubcwM+Rf1I8gyXM+jldo9dAUJlGsZIGO/Tgoe
X-Gm-Gg: AYBFou0pczscGsq29C9/ox5/hm+NrvnnPc2+kzLpxF/ELu171PaddkavsmEdk3ct8lK
	gil2apyvwp4wOsgPWD/p8j7+uBr9FoHz5DcT6Ghb1sgK5chR6tQ7sn9VZFoLDZMasEl872k0iCf
	v/1dSN1asrkOJRl+Q2kKHYyTPgCWSkZsTKTWwtLVgUwpAsyb5Dvvsrwum1g4DHj/3wWVCEm2AQl
	6AgQmP+M4xPL6aG//3dbLRU89fx5QJwDKaY5tdagdDWah9HNU2YjwVMRxMW7ZPhTGUI1WXbpWDa
	0thyLhL2hfBh3z0BRkUZDHNLguoV/QUEb0ofkoa9Fayf8tV9H/R+MxO1QJTZ4j5VmSx5tHRmtrn
	zlwBr3bIRCVc2V9XYWqSxz3fvA+d7ucbjiZtpuPR9M5rJjkdD4X5Oc1euF1yb+JQEzaV0qJtnRa
	7Ced2CPHsssBDFBYMMWzXn9Bl4GqkZwfBH1WMOFFNJJZ/mJ7i449lgvqvXC4tcKuM5jp41KVGSY
	PB7QNR/HTPyl1IXe7xaPOjYE0lV/WYoxZKWkmk7Ww/b6CWxJxe+MkKORboDN2rNsZPvCNNSt11J
	n5bZ+//aXfdfEaYoL+RTJDVZ1li2nOvieN+T3ow84KB2g0WgNj32XEPjmG6jl2RUZ4IhvA7samZ
	O9SYD6scrng==
X-Received: by 2002:a05:6512:3043:b0:5bf:ce24:b1a with SMTP id 2adb3069b0e04-5c1aa072bf8mr1080207e87.12.1795011423541;
        Wed, 18 Nov 2026 06:17:03 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa7707b2sm553396e87.30.2026.11.18.06.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:17:02 -0800 (PST)
Message-ID: <c1a68be0-36ed-4671-82a6-8aafb1855c4e@gmail.com>
Date: Wed, 18 Nov 2026 16:17:00 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
 <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
 <820865f9-2ef5-4316-abbe-5c44c7df55ce@gmail.com>
 <av2PPiin8mJiJD_q@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <av2PPiin8mJiJD_q@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2026 13:42, Andy Shevchenko wrote:
> On Wed, Nov 18, 2026 at 12:31:59PM +0200, Matti Vaittinen wrote:
>> On 17/11/2026 16:21, Andy Shevchenko wrote:
>>> + Cc: Matti (even he is not listed as maintainer) for possible another pair of
>>> eyes and/or having an answer why this was missed at the time of the driver
>>> submission (from my perspective this patch is correct).
>>
>> Thanks for the heads-up Andy. Unfortunately, I have never worked with this
>> IC, and I don't think we have it in the ROHM Finland office (but I'll check
>> this just in case. It'd be nice to have this covered in my test setup).
>>
>> What comes to missing this in reviews... Well, I suppose the reviewers are
>> just humans, or if they're not, then they might have concentrated on other
>> important things, like styling, instead of the real functionality.
>>
>> On my own behalf, I was away for 1.5 months when the series was applied, and
>> I only looked at the GTS-helpers usage when I did my shallow and badly
>> belated review. (Furthermore, I am 100% human, so I might have just missed
>> this even if I had all the time in the world to do the review).
> 
> Yeah, I don't know how ROHM is big, but in other companies usually there is
> an internal mailing list is set for reviews. Maybe that helps?

I took a look to the Wikipedia. ROHM isn't that big. 2017 it has been 
around 21k
people, and I have a feeling (no facts) that size is still about the same.

List might help, if we had more than 1 upstream Linux developers... :)

(I actually did request a list when I started at ROHM - and we had 
something for a couple of years. Unfortunately, I was the only one ever 
using that. After a company IT-change accidentally killed the list I 
never requested a new one. Still, even when we had the list, the bd1745 
patches wouldn't probably have emerged to it. The get_maintainers.pl 
folks use to get relevant reviewers, wouldn't have known to add that 
list for a new driver with no 'rohm' -prefix.)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
