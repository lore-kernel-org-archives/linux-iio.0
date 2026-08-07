Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE7472F6A
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106388; cv=none; b=T9bYsKM/5YZMLkQzJUzUBFbexWl8+tHvQUOPYGUZSxLBC28BNUPaIXyJ7ovmdDtugOubN+C0xPbwWKFc0B1iGWpC0xYJDkJ+enFUojqkYDt6hUxJ+NQIWgNyGgXaQHDuxwjsy91JUViMdQIyqb92pC78YibRPLZrC/LA5hQpdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106388; c=relaxed/simple;
	bh=BnR/V70D1klGicVGiC0AYnn1EcOqw+kFeyar+iKh14Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f43jx7SwuFnDMH2qaBt1PUuq/WAXEMKXzPjGlzIMY7ZPKxlvVl4XyjwR8IjId6E7AqoKiD9NBaE4NvhE0iso5r0SntxWgkxFQrcbdv36ZHPCSLhZsJ1XCNgSyHEKJ2H7SHDsHyFBlvA1dWxA1vF4p7FmpHKyAjoDr88f9R6Dgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXpGGD0/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXpGGD0/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so3713783b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786106380; x=1786711180; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/QKpsFF+J0UfrrRtGkrOmdWFW2gWZ8ToHnQMm/dBIQ=;
        b=kXpGGD0/bNnO2uWtP8zO9qqOKguw8P/PdX8XT6lPTTkGehAv2mXIP36Ol7AxtTuXC6
         vmIJk8DP8zyfpeU8MqXi3dgS+weyUKyCk1bJTbpcZgdzVGa4h7samu+WODOjGEo+0wLO
         PYFZeb2NUWAaSVdl9faYuto+a1ieYkyJZK7L5v3JnMw/b42THAFgcoEA5SO8kqzvSoFv
         0sv6V5alinPkx2CDo5UbgUHIpfqwszR3xcYSLu1/0Yf7XC/brQyoIfLjVm4tJfkLae0a
         2KLQaazLv3BqF0LC+qsTRd8W3+LPP0sKA//TuHUhDU9534DaUZmtIUedQikYzriaLBMD
         o4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106380; x=1786711180;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/QKpsFF+J0UfrrRtGkrOmdWFW2gWZ8ToHnQMm/dBIQ=;
        b=Z3qXo/QZgZjEDxFXn2mN7l40ATHNo0IjSc3sxlWQCO1j3MeUmewINsOhvP81z+K0iN
         dhqPCSm0Jokmgd3ayCbbrecoSDVLfgmVjiJvd/cJzJXU5FDhG06Bk0r1GXnjWAIHVhLM
         BgZwOMRU/RQhJSFUNVpClEAQHZzLdMDWdt98qO/VcUzu8KVbaYraRmk+9BKA7yqnQATs
         YrAtIKe8OfZ75F8WihXlgWDoofZNTw9pQpw1o3p2Ou/U5TG6WTWjIIFbSfgrATe6t0oj
         vzwx1DxZ3yDA6eXj2O73AI3jp4Kw3frCrhiKpNezgKJX9eKlPi9ikgQ73287CcCijN3m
         I8Pw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/jANqQvCRjPYRwxxBYOdpGmKE7Lugi4KfXYRSY89Aa4roSY/41i04ZawLUtr0pHl4rvxctuDVG90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNNa1jKEAsbzranU0MCWD61SkyVt5t7+bFodN6ooKyC3n8iZ5
	x0wpmawIWNtAHgEhjcS0pqZ1KeozgLqth0gsvf3preBSMeWYr7RlPWY=
X-Gm-Gg: AR+sD13w6poOmQbwkVeaTDBelIHHSOqh7fhBYcOxuVzayfOTrPu6GyIWkWBCLzCo7dm
	c5bCiLgVqyFg4W0ND/B+KJ1GOHfHlpKOZv4UBmN/YmjedMek0YMTXCiFOoFtKjAIuLIQjHmmt6X
	8B8QbGFcvKDwlSFwS6DVDPzWOaJ3KRhMcDrXt51RpXMtgc6tEVSSdqwVITiaWOX43BhzX7K3ztq
	ksMzytqe3lxq50ElGtjhK+gFUYlKfPUoSvNWs5VRioXO3M1TBIzNqxObWKlwN9ODRv5QrRBljEr
	u3CngxhQsuZQVx6ifjCFQVyxkkvPG4MSXuKFmX8DyBAFbEhIRz9/+Oqt8fuHVpkfvx2LecrqUNm
	PcRcticRpQnjdKiUIvPEnD0Yr5kCJjhpzR/PGyijRk3U8wpKnK+vm7j6kVjK5PBmxs5Ci0SjxCP
	8480vrYV/a4AaenXx+H5PB5rfvIY2bVJoDBj1VKEwJa2b+7eSjBUUJ4+vgF1WPPxtDUhXebX5vo
	tD3I08bXA1Ytg6xXyG0O+bq
X-Received: by 2002:a05:6a00:230a:b0:848:2e7e:353a with SMTP id d2e1a72fcca58-84f2dea7014mr24055825b3a.0.1786106380246;
        Fri, 07 Aug 2026 05:39:40 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38c703sm674579a12.30.2026.08.07.05.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 09:39:34 -0300
Message-Id: <DKIPV92KXQQ4.3RDOLTYMBQ1SR@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy@kernel.org>, "Brigham Campbell" <me@brighamcampbell.com>, "David
 Lechner" <dlechner@baylibre.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH] iio: humidity: am2315: add am2320 to i2c_device_id
 table
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260805183733.1000550-1-nico.antinori.7@gmail.com>
 <anRXbXxTLUfUgEPd@nsa> <anT9y_izVXiwPKrS@ashevche-desk.local>
In-Reply-To: <anT9y_izVXiwPKrS@ashevche-desk.local>

On Thu Aug 6, 2026 at 6:34 PM -03, Andy Shevchenko wrote:
> On Thu, Aug 06, 2026 at 10:46:13AM +0100, Nuno S=C3=A1 wrote:
>> On Wed, Aug 05, 2026 at 03:37:26PM -0300, Nicol=C3=A1s Antinori wrote:
>
> ...
>
>> >  config AM2315
>> > -	tristate "Aosong AM2315 relative humidity and temperature sensor"
>> > +	tristate "Aosong AM2315/AM2320 relative humidity and temperature sen=
sor"
>> >  	depends on I2C
>> >  	select IIO_BUFFER
>> >  	select IIO_TRIGGERED_BUFFER
>> >  	help
>> >  	  If you say yes here you get support for the Aosong AM2315
>> > -	  relative humidity and ambient temperature sensor.
>> > +	  and AM2320 relative humidity and ambient temperature sensors.
>>=20
>> The above (same on the tristate title) does not really scale nicely and
>> we've seen too often already. So I use something like "... and similar
>> devices"
>
> Right, and here something to be a list of the supported devices (in case =
more
> will come):
>
> 	  If you say yes here you get support for the Aosong
> 	  relative humidity and ambient temperature sensors:
> 	  - AM2315
> 	  - AM2320

Excellent! Will send a v2 with these two suggestion combined.

Thank you

