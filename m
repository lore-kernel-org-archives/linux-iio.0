Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584200;
	b=otiZwa8JTnAv4+gzyOtuv5p8mWIOkR9t9qpIKjCa+nHlrpFQY4a3Gnxg5IVphLAlyfka
	 0Pah3e48XJblXfMX9Bw/CUImRTvjBDx+lBrC5FC3nAgnpqFZcDH3yzZjgkIBlOMKXOggN
	 XGXXSW7sT8wulN/AxzPqJOfoOSdxTytG7Fz8lmZAU4F1meN8KL4hu89rIVuUq/Q+4p/F+
	 AOTKIqm1kqP1p0LzmgkGindiRbH2NXg5aPpJx9OVeMycEcF7/VVLQbedz86q0SOa/x76N
	 6HFMAZ33voxKsfW4tysCtLfXAFG+ZrSNB06BE6KDdCuCd+KxyEnmxL9xrbQKIYehg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=x62ZihgS7kh4nWdNrWclZKqO2BrkWNZR/gkUNOF/E3Q=;
	b=2DLUs/SM2UjtQP0wrGGf1UP2nz4yHqFkvIQZ2tSZ8vu4yzQlEI4rXX1I7Mx2w7ZdXuNC
	 oxu6MCrVo4bbS1uK/ecbJYXlQBNMOkT5dTdlLDSOhn/vBtkXTr4Y8nkNOh5uJb9clPO5c
	 Gjj1BPGpgnz91UYj/Ji2etxRyEN2t4oBhNLU3yAWGxigVtNMcuRavuZ1ulmtVEQM+bpCF
	 cZ+wOBWezbqrBratnJY6zxfh88URiRlF5r8ix/7V4kwGvxbwJDqQoMzJ/v4a5SyweTnXr
	 6/Gudbhn3quZb4U+Zl641mIZLWHogZMvE2tGQHbTYwOcWUUq6YnCRGjqSA2T302tRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rOwFdNzH;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DE606A327
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 15:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B8DE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rOwFdNzH
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab46699a09so15825031fa.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584198; x=1795188998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x62ZihgS7kh4nWdNrWclZKqO2BrkWNZR/gkUNOF/E3Q=;
        b=rOwFdNzH/fyJv94XjX1UieKx8ePFP8iuZ7nP4Ih6XTpFMPP/l6PmZbpLrStQb/Ejbb
         SB2PTsN7A/l1Y4z5fNNxcv4gkf/VPebjCxm1aUE+9wAHG000TkHrndxkA0+z0d0dXCZg
         kaRKYraNW2gB6WcJp8h3+yoXHLyfR4UAlI5z1YEgK11EAg8u1LcnD8VqPrmODmZYMw90
         37xoGDhB7724r6OLL6En9NLUqfD+aOrgp05SWbCiyUua9YX+kieQcuMsKnEi9gQbJsyJ
         GjzEFTZrCtDeL1vkX/LZ1KOjgUjtPNMsUb3oZPy+++9COmIMLAYtDC9aB2lnGZpa4T7x
         mkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584198; x=1795188998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x62ZihgS7kh4nWdNrWclZKqO2BrkWNZR/gkUNOF/E3Q=;
        b=XCYqu1ThkIWOKQ0PtuXWm8T+FQ1rnFm6qhbX2wCxl+GCsFBg7Ie/Th1EI44cCdv7wH
         ZiSs50WwOhE8OebosIw75exylesk4A4K9QZB/tlh/P0gn9d9UUDt6LR5M7I6o4Qeb+u6
         aq+lQ6CP916nnbcugJyu61rGpCygzQKnXU4MJekIQc1FKtp+1zJBf60DghDG70CqkLqW
         +dOpauOf2ypMjudX8wcWCite48B8/8rmpUKUNwDl1p8Yz/yGus5DT8hrryGXmtoBy8GE
         xMcGT7DlwFro0TxcEo18nSonbVZnUkY1lsSPf/Bj2vhXEE04UHfORBp+40AgKkurdP2n
         q1Bw==
X-Forwarded-Encrypted: i=1; AL+hErFo6jxTGvCq1Yp9qaLx4vHGhR/RZhfhtEyl+nZD0dCVkAXJQktJFnlPYY5TT5KKXH3ZvCadCukU0BI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yUj5eb9Ubv7MQqjyKy3c6O7CED+yGq92RcI4KV/qQvo6JyHLo
	RAKhjkSBFwgepaSPxj2aIUFZpQNFY5YSssFGOypYtreZxpUzJliW13zl
X-Gm-Gg: AYBFou0t/xc9cKscX2PBne9XqodYEnaahUrktr5auFAVcBdEqQPchuURc0fbsA3zemE
	YbtyHmQ/YcMeD0pgstmPbdrCeYrJGYaM/RmrCT1yWyOxgZQIULrcnRU1Dmn7zS6hqNuCKFiabzX
	Fz5aWaKxjNjGOjNxJ86EzneH/ugJjAvPoYbMZk6Mc3bWo0cwcWkk+fTcYAbnQE+39Q0gNFPPR8W
	7R4twnPRo6UbdCT5Z7UpKEicluW494ktUSsv0X03TDFF6Xuz+h5XbDKIqTnC+4tSKjqTgGyJjLC
	Cg3md8wgPnBwpez7rh5B1C6LfOaAZ3T3AChn3IWG1SdFxUyMQ8WNHWBws56nbdqUb9/IG3buyjF
	VY8eMKw8hLg/XxC+7yc1P7klX6ZtSYiObaKyiYT3gp4apNRsZMAsAofetgtfxr1pe+6SPVr7xl4
	se+rSUiQ2NZ//4psS/2uz/XMw2jhWS8z2KbsMQ+Z9qO5WUSbd+KNv6Gja1tIrisiYU3d+AH1Ibs
	iynA6tkxIx3SBDQ9E6HGn7/zGxW3wIcHgljyr5wfIlQTde0KkG9aWUsl3zccbHns4dqzbCw4Ee8
	T/xB81k98KED1Ge/RG+l6nCuhMACFZikdM6GmtY8807WT83z0nyMl0hxArKi1ksdDLg1X5l8fzq
	ccJLXCy5yBdEXcSDKnhkevXu9INEve1A=
X-Received: by 2002:a05:651c:1596:b0:3ac:97e4:4987 with SMTP id 38308e7fff4ca-3ae2b4c77cemr10278541fa.7.1794584198178;
        Fri, 13 Nov 2026 07:36:38 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7808cbsm9395051fa.14.2026.11.13.07.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:36:37 -0800 (PST)
Message-ID: <ef47542e-308c-4211-9b42-ba2de13f5f82@gmail.com>
Date: Fri, 13 Nov 2026 17:36:36 +0200
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
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, Joshua Crofts <crofts@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Victor Chernyakin <chernyakin.victor.j@outlook.com>,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
 <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2026 17:15, Maxime Chevallier wrote:
> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
> 
> This is a very simple driver, allowing reading raw values for each
> channel. GPIO mode isn't supported for now, as well as buffered mode and
> the 16-bit averaging mode.
> 
> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
This looks very familiar to me. I am pretty sure I've reviewed this. Is 
there a reason the RB-tag wasn't carried over? (Sorry if I've missed 
some change(s))!

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
