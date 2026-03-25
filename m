Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715419E7F7
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433547; cv=none; b=W9xGgq20Jz1OoesI5Kr7I7Hk5z92ChTEFrapMLCUu+cYPZO+gHq/Gsnoo+W3Qv6FX9sXmObxg4glEDc/VMRjAIjxC3zt5xYWIz41fbAEcMorsBuE2cvRODQa56x1yia12Hq3nGw7UN+7RwMRr6sNcVfShnLlEcRIYfW6Ng4ObCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433547; c=relaxed/simple;
	bh=m56/b3WOzdczHaxO3PWQ3LHZIR79H+h2yCAj5xOJYe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYy6noLmqzsoI3eZw+x5pzpA3ysXjVxQtMj9Zdj/vu/91QXMNSk/RRyEo0ST/XNaspFyNMwuLEYIpbMxx/wCS7I1ZX/hgjuevCsV2u52tQXhwR+bEsI9S+sp/T72TUrbJ+HV33dte03nHUJKjEQaePLJfIrczxZuJf3onh/3ZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avc3bssr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avc3bssr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so52224815e9.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774433544; x=1775038344; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m56/b3WOzdczHaxO3PWQ3LHZIR79H+h2yCAj5xOJYe0=;
        b=avc3bssreIgFfAmdzrvzIr/Tf0xQ5t5dN+pgfWGhW8TlGyuDhQu385sDwBo9iYv65m
         F3vBh9M+VfI2ywySrtXISxuUxZnh3t3/MjuVBFbISOx8XRSiVGGS7LIjtzRtmfV/7FNK
         zcmE+HhMM9YrfKw2eLjAjSABm1cNthihOdV18QgwPNX+lyIKoCXtpnoI52J9UVZvwKyU
         IwGw+sV3fSDxumuqECvL4rK5LQeKV/oIjZKJ0Q78oGUbECJPJ4aU1RslBFmilm11Pf3M
         gRWBH4yx4U7cQxAaaMDfuVyjCjFu0sNvzZ8sf6hw/b95Td+l/4QmMZIhQ77aihwMNzUD
         yN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433544; x=1775038344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m56/b3WOzdczHaxO3PWQ3LHZIR79H+h2yCAj5xOJYe0=;
        b=Vlnda6NvG3yclD8Gz6Yc5tkHrtqGwxaf0bl5Q1v6NT7zIp3dWy15ZJtgweq2d99UJl
         nBQawoCkBtn1HKmiD0RWtdD5/icnx9XrBbsYhTBwO1fY8qNLfn6NZAlQXQCrJFV/SZg1
         qvRp801gCi2zmmphmb1XnaBiaQo5x1cnGnE+uArnSS22jeYmUGRj3jTqCNkiNx5k4yE2
         K+Kdp/KM/LBrOxEwRIqccG+K8KxfjC9pUv6wsulRJHvtVBNjeziB26LQ0tgGd8BuybZE
         H2IZCRJ80efv0t4xq9tFi/aPso7SFmf5BsOmmYqIuOK1gWYxZxR91LbPaaVtHZB0rcZc
         5Qow==
X-Forwarded-Encrypted: i=1; AJvYcCXGUd3bphezW9cwwx4h4pARiLNaMGuqm+ZOMJIWFkzngw1t6YhVsk7LT3felcqmDD9w/YWCSKBCIlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUFud1gHTaK63WBSjSJ9LUNhPdqY4YnbV5C9qui6d7guJCQwf
	YUd8K6qhZXyqhRFhaQqolGIHSY5tTWxchwdO1WZq6GM7eIiTAy+kLVtoNLEhjzwHNSA=
X-Gm-Gg: ATEYQzyXJ1bGsXGMGFrfW2P9swA8I7MlyFn0o+MdTW2BzPS8mNGlUOWHQmBHSKK02r/
	Zj7H3s8lEMqbexFvIffFSXvn32RlJOhkPjkRBGyI5GVyKwORx/qn8U4hAVOoGS6/p1Rn9VXE4LY
	SoCrOgvLpbvK8IJ0xMT5y9sKOFhmHAh3smshggxFys08CiC9NXPLpUhczfc7IO11w2nnwTzZAxf
	JYCty7uSubG4+18w0ggYCRpwaHLo3xUatwmI7Y3sJDGvYMFrXeP57smhK14ByrDkWfiqJcM+pPm
	cUtw7gg6LFlklIxlubVAcHBoXxrgkLQf5yI8LqA+bKLPbKsDDBjoZyW9S6saNjHf7S+FVpBpC9T
	GOX2tPjPRbi7qY8+dOO4GhRccW24TZljz0H2pTOhz0cKGHZDx+GMl8rz/SQW89eSYiLTSu14n2R
	tfTJVpP2ov0dcoBnY2XgVEq/36T/13PUs=
X-Received: by 2002:a05:600c:5296:b0:487:13d:4e77 with SMTP id 5b1f17b1804b1-48716067315mr43725525e9.27.1774433543852;
        Wed, 25 Mar 2026 03:12:23 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871739609csm16267605e9.33.2026.03.25.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:12:23 -0700 (PDT)
Message-ID: <9bd364de66e86c8f94e410cc926775997f85b070.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 "linux-iio@vger.kernel.org"	 <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org"	 <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Date: Wed, 25 Mar 2026 10:13:10 +0000
In-Reply-To: <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
	 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
	 <abpfdELI33a0Ncl3@ashevche-desk.local>
	 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
	 <abugoaMtEV75Fyk8@ashevche-desk.local>
	 <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 01:07 +0000, Torreno, Alexis Czezar wrote:
> > > > > Changes since v1:
> > > > > =C2=A0 - Removed PWM, GPIO, clock generator, debugfs, regmap,
> > > > > IIO_BUFFER
> > > >=20
> > > > Why was regmap removed?! Was it not used?
> > >=20
> > > As far as I understand it, regmap also gives access to debugfs. When =
I
> > > removed debugfs I also added regmap as removed.
> >=20
> > Not only debugfs, and it's unrelated to the any custom debugfs interfac=
es in
> > the driver, it's just a feature out-of-the-box of regmap.
> >=20
> > > For the spi write/read I am not using regmap as the device has some
> > > features that I think regmap_read/write couldn't support. Namely the
> > > variable data width, as the device only accepts exact amount of clock
> > > cycles. Future patches will also add variable SPI speed.
> >=20
> > We have a lot of flexibility in regmap core. Do you think it can be imp=
roved /
> > extended to cover the cases like yours?
> >=20
>=20
> To neatly summarize, my needs are: (in future patches)
> 1. SPI read/write can have different frequencies and runtime changeable
> 2. SPI data bits needs to be exactly 8bits or 16bits depending on registe=
r width
> 3. DAC Device reads SPI command bits [14:12] for communication, not just =
chip select
>=20
> For regmap to be used
> 1. regmap_config would need new read_speed and write_speed entries.
> 2. val_bits must now be changeable depending on the need.
> 3. I think the read/write_flag_mask can do this.
>=20

Do not forget you can just implement your custom regmap_bus which also open=
s new "doors".


- Nuno S=C3=A1

