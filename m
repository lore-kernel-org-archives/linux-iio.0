Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427640B0E9
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967005; cv=none; b=DEghFfZfr4tM7xjhXlJ5DSfzLYlGv9bmueESQD8pR5yFN2sb41fqYMCZJUwXZfP0V478aYwDOBnXwfj6/DjVaNCx/U/sK1QDir0G+9B/E6Aah/YWQb8fie+l+b0MEzeB85qK/ZAzFx/J9rFEz10nIjiUwrgnRMHZCy6+d9FLDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967005; c=relaxed/simple;
	bh=fIskz79NQn02ibLnjRh7ZKaMY8crCq3Jl1RoqA/q/5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyx3KBng94SQXe8erLT8rp0Of57ATQAqyPOdjKgwn5vcxKQAj8YmVgS1YXCDgN1Knh/UTGHdAN0FeEB+va+JdeW7QKMZ/dGQVKGy782K1ftI0FVfTNLBktiE4sJtpoeD/jb2eaObgfosc0guxDiJhbu9NjpoKhDt3a+ZAsCBVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqif9PHh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqif9PHh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso2983308e87.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967001; x=1787571801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6OMi1IqNUrs5qkhXZCHNpckPTiNqfFRI2wV9B5mW3o=;
        b=dqif9PHhOo6cNfwcR2c4I91a3a+La3/EWt2HdIASFCluWz0R26IhVJ6fECFGM0icAx
         YhemFBlcJDtyiMxiPk+6rnZKqR8Rq3tUeA2zFephgcauoYuEw852y/LhSiEjN/DKjJyK
         gSrPZE5C7dLJyAQlaKu14fkmGm6LHjemE6jXxmwBXlv1gsyUjMKKtrzebdUz3m4vgg7C
         Y0y4iI+kHrFWCeB3vUjFqQH+62SWM9ueJKS8ga2chlo1u2/cuVbvNqHGbjsKzRGIQvHM
         eKYoh1TEzNtjk1CrAr6MM6Yp41XLBRwhYUVaBX0cQC0XsiWJqRFd9LOtkKxi0Vm00ZQz
         6RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967001; x=1787571801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6OMi1IqNUrs5qkhXZCHNpckPTiNqfFRI2wV9B5mW3o=;
        b=V7vwyc+CPFJmzFZj+mr/52j6LMBJ84M04cejMB3OC1Itsq+aL6Zz9tzWm6mJNEU3ik
         R+dVuRc8hqSzWq5+YeIQA3cdQF7egLcUEkVe1MKT6wv8x1IEUlbSX64m/WPhIb+mlBUR
         E4qDmyFbe4l+dpgnS/R3FaUncPv2KhNwcZd+iGkkmZTiCZ+uSozx2uCJDpnoCDdPfZtJ
         ttzvINFQ99TT/muxbog7VGgqvMN6r40y79UTJqCA8TxycOrwHdORl/u6qq7PZZiiKxWd
         O0WXGrbtiVTmYTgOZbbMrjrdRV5KDLegRUW1t2FvVxwELAAkaHNb1bCqFDjd+jEyC4v0
         80Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrxjzjTA/XzCto3sieQQAh0WxHWMV1cO7GViOUamuINxaegNK7/IftCt2JrDKfIRtU9kfVrwJgj27o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfRoQSLepUJHKmu6/cR2Q4ZMsV81Xjlw0P6URvRHQjvwT6pNW
	AO39g7TmgQ6BylvPMLOeXTfRrGLzfar300Uj6YZZK7m8r0aB0ncP+Kkb
X-Gm-Gg: AR+sD10KZWn8Cv4HczY8MGwXcqXngNRYxeLSNyo4XZwb06MJLVV1BaGbljfXxas3Hlt
	0Q5XRpGtQzLAH3I5nzc7V83yzzxWALAE9F1bro5CtGXbBde/WFcW5Exua1lGZdue9ZD1vADs5OG
	N9dCmczVKMCmiznhoQ5twYo0ac0rx4vz2TV8lToai/cFqH0YV5gT/TQrUhlhm67beJDY0s/cV1Y
	ACfYcWsvJ12I1OCQHHlUypO3rol3/LYN7ENFT/Ihw/GsoBAk6O3fFxrStrnSfbFocfl1v0U7Avx
	14i/MX2HF33z8s9Lu2Zh7P+gIpmh6PPGDtKYbwahw+sdgIlPM7vZIXSY5dW1977TMZ7ZxnnFnpc
	lNlNKHZMBB/DyHMsyJ53XIdGg8cMLrLK0GOBYEuWPLbAS+KzrLJT6qZaEDQUAryX0jWxSPA/H6o
	XQhfuRaHnS4A0FHWkLG16zMPms7/Be2XVA6yeB+5GY2LzbyxkYmi2TdzLm8EvI8XX0AHhVJneUs
	RbCgjaoH1ETHbuuduaxlASOnzjOhleAhFwtq6I0M64/
X-Received: by 2002:a05:6512:6892:b0:5ae:bf45:e3be with SMTP id 2adb3069b0e04-5b45916afe7mr1885655e87.21.1786967001285;
        Mon, 17 Aug 2026 04:43:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa0e69sm330552e87.23.2026.08.17.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:43:19 -0700 (PDT)
Message-ID: <0498393a-1313-4781-8afc-6dab918233b6@gmail.com>
Date: Mon, 17 Aug 2026 14:43:18 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
 <20260817025351.5d3baf14@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260817025351.5d3baf14@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:54, Jonathan Cameron wrote:
> On Mon, 10 Aug 2026 10:55:25 +0300
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The "interrupt polarity high" -macro for KX022A variant is defined as:
>> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
>> using the KX022A_IPOL_HIGH would produce a compile error.
>>
>> Fix the define by using correct mask.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
>>
>> ---
>> It appears the KX022A_IPOL_HIGH is unused as the IRQ is currently,
>> unconditionally set level low in kx022a_prepare_irq_pin(). The KX022A
>> hardware would support other configurations though. So, another
>> potential fix would be removing the define altogether. I decided to
>> leave the define there, as having it will allow users who need different
>> configuration to simply change the KX022A_IPOL_LOW to KX022A_IPOL_HIGH,
>> which is kind of a "easy to try" thing.
> 
> Handling interrupt polarity options at the device end is typically a
> 'feature' rather than a must have given in most cases we don't have sharing
> going on and these days interrupt controllers can cope with most types
> of input.  If anyone needs it they can propose support.

I take this as a "please, drop the unused define rather than fix it".

> Note I've never been happy with how we do this when we do support it
> because the argument for letting DT set the polarity is there may be
> not gates or similar in the path so the driver can't know, yet if we
> read the type to set the polarity at the driver end we are saying we
> do know there aren't any such not gate (trick for level shifting on
> the cheap). I haven't figured out a better binding.

I was more thinking of people who do downstream projects than a proper 
upstream support including nice mechanism to select appropriate 
polarity. It's quite easy to experiment (and carry a downstream patch) 
with one-line define change. Especially so when defines are already there.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
