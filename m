Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176103;
	b=RFaALHlv83QeAkKBJbYQelibHNaK+xqQGWhiavQxi+Y1Lspqv3JnVBaMS86lt1brNNFv
	 4iO6ytmXK4EYuSA13Ql3ZuHrc1s5wnGqO8WR3pZYOd30SqksNB+0CuNkNTsbbMAInXiuY
	 a58cF0hg1j6o/NtZorOZtuxjHiY3Tp2EAZw8PYKc/o7gYMBQztnTZ7Gb3VLgu61lyw2Rw
	 5v9IZ+6bVAkpi4F6fkbeJ5sG0lZhBA7hd1hov2al0yEifr2Lsc5NNrUWtWlm09wp4/IKS
	 C3frTnbHyiR2oZ+RrXFeL8oEqR01Tyh6X6wfZXOe4Ms/LTlG5z3ToQgLCzYwpZ/4vqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MAU1alsnTI2aWDlPsrvvBfpXKOIn933Znnm/A0R9ZLc=;
	b=5D69jm/z9voQ+EZGSEfRA0RhWlrbMVWpBCwzn+enXQWQR4tvxXMqxV3q8JfSPI56nLu+
	 igkYDSY96B5AKyApXdWxdv+TJbtYA75sZ4IGf0pIKneIAL/dVC1pDwzJh8uWoGO71pphx
	 CnxZ41K8Io30qJvm9e/J4ACZvscKOeiRZMRsjcQVHTRrmco9LCckcfFlkQN2O7zhX8FA7
	 +IATDHjgTq7otvTcaKbAk70g4xvABYP++g9hNQsB8JkuF/8WojIukPeLS9warLALq+aQw
	 0pKgarsZwNPQ8+uhU70heaj0RT5ddcgtLcGznRQAaN5bxrvzGbmfpZRYaauwdHkAPmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BsVfFHBz;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35930606A32C
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35930606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BsVfFHBz
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3acd239776cso5995401fa.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 04:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795176101; x=1795780901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MAU1alsnTI2aWDlPsrvvBfpXKOIn933Znnm/A0R9ZLc=;
        b=BsVfFHBzdir5k0WfQJg7M2TKjqOQlCznxkryG6RC+SXvakiGG3qoADnIipX3jLyW3k
         wYG+y/NBBdMX7kMd57swLmjdawwqSMGbYRqAe+IGN/evNX/aTFynUaG+PB34OtUMFiGG
         fI3PzFc8pGoQH+NgdxjfD1mkOKTPDCdddPvvdg9i3r6bTEs9TLK2BxJuEKY39pnYJn6C
         hSefyInd50J2VDe7NfW9nHWMRncvyeKq6xhMHdCbQEmoAib+YaU2jRy0suhdEUKel2dr
         h5GfuVwNBone6cywL7EKfYtsY62ftNf5C9ySC51aplwfsocKVSUaZKP3V7thbyINLeq9
         P8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176101; x=1795780901;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MAU1alsnTI2aWDlPsrvvBfpXKOIn933Znnm/A0R9ZLc=;
        b=PDCFtwXWPhoWbuH+ffaUH4xg6dSs8YeLLDrmVKnWK+zTU2t5tD/PR01NLHOz7VHF4j
         BjuZAy1EWdfQZVOHxRlAx7aLGDpCN5UdeCaixhIFaHNImJ+lLYV8q7v+SbK1HYhzEp7G
         A+9iXO5UptTfAjgqL6qbecsE6sHv01ifqbNPanoC0K75b67+1CChbZxY4Je1q1ohU5fe
         B5EsrCObxxj3fbY6RXz3G17Pkon/XydMQcuCIBFr9M8oHl8bp3md3RzQizjXHEV/vf35
         rhnTIxZUq5SdJqyfIhmPPWg7A9C56+Xd9kGUWztaibwpa6oKI8CGM4R2KyOTv/1fhto9
         HLfA==
X-Forwarded-Encrypted: i=1; AL+hErE2FGg6ThcXnqlll15IBcqnkkqlk/82pQqf+X6whbM/wvq8AtleisFJdAa1ibM12anmBPlbkiXLXxg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vgEIP9fIfE2cWqu/0HSe6fGtSs+1nGvyIezZUYOCTUw7WHR9R
	5VP9+UTUDFfuv+qQ1cWSKhL+CFmvEloWDUSNL/Zei5T3reOR9R0Xb/H/
X-Gm-Gg: AZFdTZc2CLc2NqGJhyZauDmJh1UOzIQbG8lNn9bdPMuagksWW93aifX3vG/8247EadJ
	0B4lJfsaSXFCif8w/Fg8iV6A9WD5yyokM7trF2GDOEGSbZJlbmI3zUwWb97Fvk73wHVwD4X6vAL
	S0zU7D2FW6ERmCXMxbhByNJndkcu39Xbo6CV8yyJbCKq4b7XWpV72O2FAnQ7z4oL++R6l6AQwP6
	+d8x5h7MJs8CayCi1aykxKsacL1g2fGjq2Jlcn/oGgLlYFs0hop6bKpA4DCx6fMW5s+a8z6G1n0
	Uey2/5D4RkAhcf5uhScqA4twwgy+p7juL7p6ayMNzQ9Cv9x4ApYR7FioRL/TPF6TVAROMRnvf0Z
	IzDnab3NI7YoNfpjEu/8NAl+M18agGEtrXzXdip0kxjdcaAwpxR08vz8nCD8MDH6+Ltn3Bg57pn
	6QdtQlihlpqWDDL/NoxCWnbC2mzbvjf3ZXBZbDFyuLEPGw0C+sd4r0j7WT0mD1LcFjYuynP8AZe
	7TPc0Ew9GVpSy6ph8UhprTSAeTqf/D5f91rv/H1kNUDTPtDDnaamyfn7SwZmCeFk6nmRflxghhx
	Gta37VhNxkOBauWQ8mZD7rAS6plyXZHgNLqg7db2BSamtSej6TThg1vudIuMPgWJ0Nr4ssEOpWo
	nwtPnc87YdAAzylsYC570lkyTICBuGlE=
X-Received: by 2002:a2e:be8d:0:b0:3a6:6f81:1027 with SMTP id 38308e7fff4ca-3ae7fa94f03mr8379171fa.24.1795176099614;
        Fri, 20 Nov 2026 04:01:39 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8055cf80sm6924401fa.36.2026.11.20.04.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 04:01:37 -0800 (PST)
Message-ID: <bf0dd82b-e1a5-4ab9-9ab7-1641181d303f@gmail.com>
Date: Fri, 20 Nov 2026 14:01:36 +0200
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
Subject: Re: [PATCH 1/2] dt-bindings: iio: Support ROHM BD79111
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>
 <20261118-ancient-ominous-4f2a4a37369b@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261118-ancient-ominous-4f2a4a37369b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2026 19:37, Conor Dooley wrote:
> On Wed, Nov 18, 2026 at 04:19:11PM +0200, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
>> where pins can be configured to be either used as GPIO or ADC inputs.
>> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
>> sources.
>>
>> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
>> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
>> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
>> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
>> clock.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>>
>> Note, I had to change the 'root-level' additionalProperties: false to
>> unevaluatedProperties: false in order to allow the properties in the new
>> allOf:
>>    - if:
>>       ...
>>
>> section. It seems to me this is what a few other bindings in IIO do, but
>> I suppose it makes this "less strict". Well, since I am terrible with
>> writing bindings, I'd better point this out and ask if it's ok, or if
>> there are better way(s) to handle this?
> 
> I don't think you should have to do that though, since the children are
> described in the same file.
> If you instead retained the pattern properties section, and lowered the
> restriction to channel@<any number> with reg with the max of 31 and in
> the conditional section constrained reg to a max of 16 does it work
> without the unevaluatedProperties change? We typically want properties
> defined at the top level and constrained in conditional sections anyway.

Gah. Either I don't know how to do this properly (which is likely), or 
there is a slight caveat. When I tried to do what you suggest, the 
binding allowed channel@X, where the <X> was is out of the range. Sure 
thing this was caught by 'reg' being out of the range, but it still 
allowed odd combination of

channel@X, reg = <Y>, if Y was in accepted range.

I suppose the 'X' and 'Y' in previous example are expected to always be 
the same, but I would still like to catch this type of an error.

I am about to spin v2 where I use the BD79112 limits (channels 0 to 31 
allowed) in the pattern properties, and then do:

"^channel@(1[6-9]|2[0-9]|3[01])$": false
to exclude 16 - 31 from the BD79111.

I am not super happy with it, but it seems to work and is still decently 
understandable even for someone yaml -illiterate like myself. :/ (At 
least for as long as we only have ICs which don't increase the amount of 
default channels. That might cause the exclusion regexp on other ICs to 
become ridiculously long or hard to read. Well, I don't have such ICs on 
sight for now.)

Well, let's see what people think of it :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
