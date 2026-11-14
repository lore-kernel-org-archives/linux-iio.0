Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664112;
	b=rO5GCC2TY6/+g/PsGhINC42iwFZzLk221NnltmhqolldScI+q5nOHyvLpqPxxSzVXhSv
	 xKw9LfVg2WaWnpeOYIulGkTcnJ+MNU+8XK7d0LvT/uf4yx0JH1jKRgsJ3R88RfB03YMXD
	 h8SJS5nAEr9FtMhjmNjzz9s7ierN8ty0EGYBqyX0M7hTmbMFQ02i/WTkNRUapoi+K92RG
	 zXwW4nqMHg9qOZuOzMPx/B9G8O75h+wVeFIFi+p2AA5DIiNO20hS4dDRZC4tTowVRhqxL
	 1C4nnNuv1ge6dDTPMw0baunXyeBstSX1c14Y2+w/aPvUfgLnEP7nwZxmUsnCqqbo2fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VDgDlOGUe6uT3r1CqvgvQwBiUgaOZZaH4ErtEdDzCpM=;
	b=FH2ANOvf5t3ByUAiv9U7aaEWeYT79RjEnTIgZrNO+Xb6Pr+GI3fS91GNRX6kVd4jKewV
	 zm56QBCt0gCaRynxzMZoBGrCUhFtY+ZhH2+1Cyc7Y4Zk7W87JWr4JjyxS14EFnXX6imDD
	 T+8spG8uSVUsl1XUiF0LQad6NZ/Gt4b1ZrIhG7GAEjuRiVGvzF4m12kbuj4tQub9BdcL2
	 +OtWh7zY5Y1DjiW4Y7rMM6U2qyGN0fQ4c86ohedKxdAjrhXaQzZpfZMeUuRFCeagzYwia
	 w7MofrrOz0SJ6EpP46mc6IbI1SJ1YsMXKGpIQMSz6G9nK7ShljFaj6ItHiWPSxYI/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTclAqN3;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9621606A323
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 13:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9621606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTclAqN3
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c10dc41270so2341822e87.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794664110; x=1795268910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VDgDlOGUe6uT3r1CqvgvQwBiUgaOZZaH4ErtEdDzCpM=;
        b=CTclAqN3iyKjhwJJ88Y7yPQtewFcTd8p5Cf7k4sh1yvU2+ElFfuLmjhDhTQVwJUZuZ
         d2lExdQZE9BLDo6mMsQ3FGwGXlpifNYYLq5POfnIfjC18m/bzf4hSnpTuxwixhIvzX2w
         uSrgBkE7/OVM0QcoSPGM91YENF8whksU7YaZw3kgTbRBfD+gS+QHNdrC5dDKntFqE8no
         x6VIKgdPgUysloQOHCGWbayiSo33K4nMoHy4qkh/K12+5R2SuNUTDdTVQwtmqs6HCNT3
         B7/xRT+nWg9gSLtgp6uAV7rD/KzCxwLfQD8S9aam41KrMThX0mebHeZRCaw1X3aaS8Fo
         qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794664110; x=1795268910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDgDlOGUe6uT3r1CqvgvQwBiUgaOZZaH4ErtEdDzCpM=;
        b=vRMTXlxF7SXKN5GzlCCI7zbA2Ghd/czJidYZ7L/IazUkM74qcp0bvKZLWiUQdYJ0TZ
         cJFBabE8cyDG4D69Q4q/rt9WYzTI7xd0hxNO21uTT2sRxJiyctiFY8xIwf/Ca2UtV+Ik
         qXPL/x17S9XBjYU3ucPgihJDM/gKqvpAfdT0XXpxX612AjyDpSjdZO5EICRE69e1Hdyz
         s5k1Kw8NT4tjFBgstD0tNdlzBQUF3MOlYJEQUnFDbPlG6mTOjTgFFy6SLvzB83HRKCUs
         4KcpWW130KMVCPGKhUmhHHLVL0g1bxHe10iJEA0g2Vq37DkTi+etVQPY5MU561jwubBC
         kBjg==
X-Forwarded-Encrypted: i=1; AL+hErGgDDQuPUwbU1uHHpN/2NGQWhFy0T9s4XcScggeqrL8DP1j2NBQd3JeuFZJzupDTIB7lxhxnpHrAU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l/Ao5/BPSF8LUaLKixwFa9rHeJ8M54UrhoxDOfLq1fSH5gsZW
	6diySmah7pAxZ40ix+xyAx+DUqK0g3Zq0dPrS5lmJ9HWs3uwwi5GSLEe
X-Gm-Gg: AYBFou0bY14iC3lk71rVyweaGdATLAYvfnfr/+c86AexwDP7ZKKe61DGy5ycqV5TfvO
	wS6RqiegeLbNbN/wNe8nid+HRz6pWkmDEC0gUNM4WfbnnrgmV/p/RQ/QiUkppH5pUD41NWfrLrT
	cWvXVVdLPIwfrTYr6PVx5fx/UY8nfQ3lVNkG90UtwFJe7/rOm5P0z9oGm9MKC8nSntEzVN7RKbB
	/7HwSEB0KSfLZIFueX8c//vJULx+d6IV7QfT9M/JLJEozVLvFB6ThW8La81+Y2LDqtZiedlJgi4
	LVZDPA2B1darOvf8zlZzw8e1ja+yn+Ixk2w/cDY/qjjs9jtLO5S2R3pnlOpXbWY0/TJqt0n6r75
	tEllTPB5FoX/cIDA+rvLx9ktPpoYN2htjwoxSJ5IIfqg85wVvE++S52y8HpDhhx7/XCL2G0om8Z
	/FImUjwiKwibB6avsOZ13VPCjof3gkGjuSEOpzShMMJrT/du4PtAC3VjUnvzs+NTRMjkuOGVHpI
	jljf3DrCjfO643OaC/gkl6FvSx1YBJMu7rb/22xn0rHBI2KH+MPuuPnDmBxWaRKBHKyLgHOqIsC
	EU7XUfRF5gHbCzS9uEWG2TmYFtL/O2nmhBya3oVfO+Z6h42J/mLKuVXS3xjGZX7f+EKumSARiDQ
	wrmT7V0KzEQ==
X-Received: by 2002:a05:6512:b06:b0:5bf:dc6d:3153 with SMTP id 2adb3069b0e04-5c170b46db9mr2206296e87.67.1794664109863;
        Sat, 14 Nov 2026 05:48:29 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1713337a9sm1690619e87.28.2026.11.14.05.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 05:48:29 -0800 (PST)
Message-ID: <966210d3-9a59-4d16-b003-75892fb29a64@gmail.com>
Date: Sat, 14 Nov 2026 15:48:28 +0200
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
 <ef47542e-308c-4211-9b42-ba2de13f5f82@gmail.com>
 <1be528e6-9189-42d5-afe5-298be5af6b39@bootlin.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1be528e6-9189-42d5-afe5-298be5af6b39@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2026 18:25, Maxime Chevallier wrote:
> Hi Matti,
> 
> On 11/13/26 16:36, Matti Vaittinen wrote:
>> On 13/11/2026 17:15, Maxime Chevallier wrote:
>>> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
>>> channels, that can also be configured as 16-bit averaging channels.
>>>
>>> This is a very simple driver, allowing reading raw values for each
>>> channel. GPIO mode isn't supported for now, as well as buffered mode and
>>> the 16-bit averaging mode.
>>>
>>> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> This looks very familiar to me. I am pretty sure I've reviewed this. Is there a reason the RB-tag wasn't carried over? (Sorry if I've missed some change(s))!
>>
>> Yours,
>>    -- Matti
> 
> You did add a Rb tag on V2, but I dropped it for V3 as the delta between V2
> and V3 was quite substantial and included changes requested by other people
> than you :)

Ok. Thanks for the explanation.

> I mentionned your tag being dropped on the V3 cover, but I didn't carry that info
> for V4, sorry about that...

Keeping the note in the cover version history can indeed help reviewers.
> Anyways thanks a lot for the help,

No problem. It looks like a clean and nice driver to me. Good job.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
