Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E342F6193
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222897; cv=none; b=uNo+rYTUSkr9cf1inGGPL7WMAfEhcqjTIpAH54Ik7rufNTY5Psgpvp+5FqR0LPQKGVx8qrBWQPBJvAezr9dp84taJj302tNuhTKCW87kAGrOUwPIPlniTEHNf5eOktaPaDHLJH5vOexv5toYl1q3W8hBfo84KvcIkhrzd9ut6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222897; c=relaxed/simple;
	bh=aD3JG2CFG0c/0J99/RvgjjGJymEw45rYyKXCIerd8MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2ETHwuBsZM5/ULtyqc+NyBLCa4MaIp7UQPltcviIUJasPBR+ULsVavLOqinVjXand7oK6JrjfyzCAkyXfdVKokydewGi9zwkhok2N22bWczALyalFmJ0ZBPrlUlmo3BxpKlEE2K7HiCrITj4uacGhTiRv/h6c1NQY4G+aPzCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjn9pUFz; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjn9pUFz"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649db2b6cdcso90164d50.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770222896; x=1770827696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aD3JG2CFG0c/0J99/RvgjjGJymEw45rYyKXCIerd8MA=;
        b=Wjn9pUFzWfE3RTBKprt0ESn5qv1wW0359wQg8otruxEO3bVNPhZyySwCx0Z4E99JkP
         Mw/M8ll/4anNUm6QOjqhtkp6OTwZRzMegKPRT81TjhFoad3BulgU+eqFXTDmuApHgyBd
         Xh6JsfLrHfj4NwalokwIeq0xSENo2rwRBWf8e3jTzJ1nxbsu6YVfr4ULenUEL3RijmTD
         jrbEm35jBCIuSpoKerXunT3pWGQSW3yF5cMxN6NtG+SbK0pclHi3eHUetLqBMfJxgOtM
         aK7Rnb2+Gc8lYizinjUe5qgkG/IcjlqO/eQFRoUMA/YbvpIt7/d8nJtripaNsau8X3C6
         3U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222896; x=1770827696;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aD3JG2CFG0c/0J99/RvgjjGJymEw45rYyKXCIerd8MA=;
        b=sBSMlviuKCuWu6zAuPDND4AYoelM2KrkEvt8CggmuXlCmKGAwUKUlnD+w3BAwbtn9F
         DqsqriZn9g5EV6J8a1Q5iIdhgenHxZix4n2TNFn+lALDgpdF2jWw3DrORQLlSj3470xa
         xzK4h/7lHPTSONuMb7qyl0poDwonhF6W8Fv95uTlZV7fWh2fOZAswi8B+AtW+LvRncNC
         HXWmBp6PWYrx594Y0Xdxv57HT+6Tuh3f+VTesKMbIu4S0qXHFs/1Dx7BYD5IWw5cn4jr
         q5VtbZ0Y1zMdRMyQtCeSlkx0cbRDf7tPfqDvm1wiUY/3nEUZBggjJa0XUH2em1YbO6VP
         xifQ==
X-Gm-Message-State: AOJu0Yy72tt5EjzgYZSM7DFmqNlr8AA7/mHOqNfqDnqAz2TPjTHwSthN
	31vpbIXhqh9ycP+fWoBGpDcAv/U7rcsc2Sv/DKDuvVnObaCUF8dbUUFB
X-Gm-Gg: AZuq6aJShSYaNZHwYk3YU7CSjg+WJsvUZiaFs0TiWSiZrcCFVktkp5SN59L0HPvukTd
	MS2pADPtC/NO3wpUhmqyV/IQpmhBvRKtrtNaPIgLCYubOQLcL5u2z7Nt3GFxx+i6wu584f+ZAVM
	epzmqZMqpeU7PZunTL1kTa1GpUn8/h+AVHuECRYAT3VZuyFnPmNLDnWP/1xF9w5du8K6hCoOIKa
	yA/z1JifjG8MSpar/+qvP5S5nYQUkPn6hz+SOwf2fgmRkZQjPwCeL6WPyYyHehSJSemd7ck0rNV
	i04abAVjxDn1ZtfkGN4N8Pu5CccPcxpHC5kaDbWngUyDVbsacAkJpNfyqHBoUniXakdHkt0gcMU
	9wWAsx9rGlverSyFj0TOeOXbCOcC7nZoKpnDFm4WJYdsnc23XzGl16YY4C5Hu78ckwpqUyVil1i
	wOTLuBOUxuaAgeUA==
X-Received: by 2002:a53:ebc1:0:b0:649:af6b:7427 with SMTP id 956f58d0204a3-649db4bd3aemr2658511d50.78.1770222895989;
        Wed, 04 Feb 2026 08:34:55 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc4b7e06sm2822790d50.6.2026.02.04.08.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:34:55 -0800 (PST)
Message-ID: <34824fc2-af03-48e3-98b8-04fae28c9a64@gmail.com>
Date: Wed, 4 Feb 2026 18:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
 <20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
 <eb922433-3951-409a-a397-b48efef57b7b@baylibre.com>
 <b133521f-434d-4972-82a3-6e7978e557bd@gmail.com>
 <086d6b35-8c19-4e92-9cd1-557b98991d35@baylibre.com>
 <372c9172-ea01-4a3a-b737-3f7f14519791@gmail.com>
 <0b001503-5882-446c-a0df-642a9f75e7e3@baylibre.com>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <0b001503-5882-446c-a0df-642a9f75e7e3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> I assume you have the hardware and can do a test to confirm this. :-)

I tested the formula used in Xiaomi's driver in the mainline kernel and
compared it against the downstream kernel, and the lux readings match between
them. Therefore, I suppose this solution could be good for now.
Although my formula for calculating scale is wrong - it should be inverse
proportionate to integration time. So:
80ms -> 1.28
160ms -> 0.64 (what Xiaomi uses)
320ms -> 0.32
640ms -> 0.16
This can be achieved by multiplying als_trans_ratio by integration time used in
Xiaomi's driver, and then dividing by integration time we have set up at the
given moment.
For example, suppose we set our int time in mainline to 80ms
16 (als_trans_ration) * 16 (160ms / 10000) = 256
256 / 8 (80ms / 10000) = 32
Starting here, we calculate based on how Xiaomi calculates scale for their values:
32 * 40000 = 1280000
val = 1280000 / 1000000 = 1
val2 = 1280000 % 1000000 = 280000
And that leaves us with scale of 1.280000.
Of course, comments on how we came to this value would be included as well.
