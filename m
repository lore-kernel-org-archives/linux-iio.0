Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884A3D16EA
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441692; cv=none; b=GWlZtEKPwN5F8eFSrfzgmTrCZTg+y1QArqzulxziA5WIzb+wMlz8oH9ZcVbEeTEgoLJFzQJ5Vx9Af0weHs1Q3aDZjb+yqq4cDx+JI1SN/dZFE6nBQZWEM4AEfFZrrdgwWBiXb9j0aj5wNVatmP0JYE6IGewYGSmNXqjiDPTt8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441692; c=relaxed/simple;
	bh=g/6UWxw6tEfMb678Ee7PF48rfli6DCqIOAlLOaWdLvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SShMwB05/irTKXKUOstUz1kKz7krPWv7ullp234FhqlWuFeGFdEFzJrtLu/9NV9xSlF+2rLaykM2Nd21A1pIKWENC2yli1N1TYZh3CTcvctNf65LUq2E25m5qI6Aog0GizQyTHPZfWnBzWrdJPrxKkcAW9qi6rtNai0TLQXj8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxqY8xe3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxqY8xe3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486ff201041so44647615e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441690; x=1775046490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/6UWxw6tEfMb678Ee7PF48rfli6DCqIOAlLOaWdLvU=;
        b=SxqY8xe3ysRamxUaQ+wNvz0UwpiYGWjmwe2146VN9ClLHMHy0t/Opq/43ahDlxyZCQ
         IyZIxYUvm1eujExL6tTWlQFIMhY8/jfGMn9xrQVoryf2qQXJiM563O/vURuKxWv6vpJW
         oQFpXaBOVLCjYYJC6aLnw2y+dZ2aKtMuwaQgECHWV/iWADw7sRPF3kct6wfLE0fF8BDG
         ZYfL/wo1ALBmiNUEE2VpAeAHTbclMYA8cufimC9PnuTBJ/SdviztroWNM5IlDJI1wJcb
         ZwncyFKvYc7HZD8AMAgJputE+ojJeQiB25OIj6YTWgASIlV0ZToeAgRZWUFKA1fPhDUH
         0pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441690; x=1775046490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/6UWxw6tEfMb678Ee7PF48rfli6DCqIOAlLOaWdLvU=;
        b=BC5Lz3ChgQLifYO+/M6XiatpQa/YxWSo1YOY/EsD1PTHfSu3bYX5a63JwN1emw+lzC
         qL1ml7FmEAQ6Ml2dJVttYatVi9H3r7gKD0f+0eAVwcck4LX3vQMRM1BzIlUu5DMIMR+M
         RvQigoSbtoYA0DYVHp8UPKVKnqfppq/M1RgjECyU2Ctc8NcC6zHpB+QGptwB1tYob1vL
         umJszcOpGwHMEf0N0804hjQgC1ETVM3SOcw1S+1GV3R33IMF697rq4rdad9/qKcuI8wO
         iDeaQFCxGMX5HcHuPtpghkvitqh3i2LSdn0llO0RXTOC4O+SYbfgXstdMWjoGjQzeUmE
         31Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVWNICd8AWdF+q5XD7RaeCwIn6fjYyljGJfBi9ccwva1Sa2uPDiJpt0f2kPQa2IUkyYSGeR2HC4FIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12prH6U29mtUb3CBzPNOedffcQUBYc6wtzjrT1SIwCazeRyRq
	QCZK2Nxs652WkzqSofOAuBQsLvlynxHW9+Zp0szJFrkxzzyTSN8INaH6
X-Gm-Gg: ATEYQzz68MHWEsrwoIuRf7wUy7aZj5UILmPCUsUL6/p0olOqGKJ6xXPC0FYp8qfdV2r
	P2/bXGiC9RvCgnRDfOvizt8hgkYLUuyF9uKoffn/UltHSlr4uvhCeB9Pu4lHEI0bgsjOBzyoBMP
	zl9tkin7tAKMgqq0PgpzDozaM+7Q+APuRMQJk7tXG8fNpuh0TuW6A9/RDBd5d8dsIywoaQHOhC6
	xmTue07Z5zyMu+v/w4kPKW5FJAIsMzyTJztQxZwF/nbg0OSS4tnEeoQ4lb5cUh9t/UdUu3CJY37
	AzOLUzQBWKKz6V/XZgzkozEObJ/4kTXzqCCALfE03gHFgzeC4WgghNCOdxCajxoNpgdTIkID5Dp
	vBE5tl2WzJOktn6SJgxLMbjvGMG7SO+vxwtzuX7nHQ+fhBSOcjRkI2q8r4QktuEKcNq0GZhb+aI
	SyZHl+lxTn2RpNIbwoYfb+R/IJqs8TcuY=
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-48716039b83mr48642735e9.20.1774441689774;
        Wed, 25 Mar 2026 05:28:09 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113d73c0sm145198315e9.0.2026.03.25.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:28:09 -0700 (PDT)
Message-ID: <7ce63fa7bd71c7f844b02db0b2ea71bf7bfd7969.camel@gmail.com>
Subject: Re: [PATCH 0/2] ADRF5702/ADRF5703 Digital Attenuator support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Date: Wed, 25 Mar 2026 12:28:56 +0000
In-Reply-To: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
References: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 11:12 +0000, Rodrigo Alencar via B4 Relay wrote:
> This is a small patch series that adds support for two extra attenuators.
> Basically, new chip info and device table entries are added into the
> AD8366 IIO driver.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Rodrigo Alencar (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: iio: amplifiers: ad8366: add =
adrf5702/3 support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: amplifiers: ad8366: add support for a=
drf5702/3
>=20
> =C2=A0.../bindings/iio/amplifiers/adi,ad8366.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0drivers/iio/amplifiers/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0drivers/iio/amplifiers/ad8366.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 22 ++++++++++++++++++++++
> =C2=A03 files changed, 28 insertions(+)
> ---
> base-commit: af980a79bfed43c4a0be12cca786be46f1a0c5e8
> change-id: 20260325-adrf570x-iio-support-e199418fba40
>=20
> Best regards,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
