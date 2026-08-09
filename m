Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D73AB28F
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264145; cv=none; b=jX6GggGshYdr6TheSf+4grPlQkCzeCwAfXN1azA09K0i8XOFyHNmcbGy0PUO8RnR2i0jft2gE/MSJ7YSdGUEC1qICx9dJ9sZP291mLJf11+wywYHRtM7j6lJnDS/BnPP6aRTbMvO93983zsZSvv/3CqTmcALw6qoO2gR53B7Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264145; c=relaxed/simple;
	bh=DjBhbqW14d9nmpPCYYk6v+xFyikmQDSHMu3Aajds3Lg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=Mtu522CDhfpWcvs2r/1yt5Cz0Zn8OnkfMGWJRIZTm7+2RsH2pDEvoMAx5uPb5duY0ITExMW+Oe2sRlk55LCk73t4dQ8qUYchq9UThA0Nwyzk97PFmXcNL6RQ8Kuk4fzqNkZtyUA9Y6J5H7aEclDZueaWycWM+Nzj4lWAHyf0gzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzovIO6f; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzovIO6f"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf9466412fso853098e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786264143; x=1786868943; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rqHnH3bazfPo8L9yN8K7qxpi9gCCvgA/6bCTLUUeJSw=;
        b=FzovIO6fwwTaNTJKTj37e3TwV5BuW0iQUg6l0854Vs5HEsKCCWWWf+M0KB0Wmi3xcG
         CQTAuxwWYxDdqx6urzDylQ5vQjti48MHkE1D2bWIjSjuJW80uHKjYTsvcSv6Jjm9AY1q
         nNCCBFwTPfBUjaVr4fbduGGy/zUVo9PH58K1kefbxDvUS+oH3Tc+uoAH8WbS4Gpu0MqD
         8QK/HxvOmP7WsdxDprU0bUy2q2kF4w6KjI6o2IbhvpI5jLXPcuurapSBWfWW3MihFkAi
         uzffmWwO/o+eJGfQIJUWZx93nrpROhJo6P6tOjpUrRqqYxgWmEVG5t5TwNR6v/CGXAe5
         LqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786264143; x=1786868943;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqHnH3bazfPo8L9yN8K7qxpi9gCCvgA/6bCTLUUeJSw=;
        b=IKSH1iB//xIpoYeAFhDL1aV1XY98cSESEERwhlms1SgETJLzPqSXTGtESTX/b8iSOd
         QIHq8mJctPvoLmpFwNM3jhB0krW/zdcdmGLyMGkYbY+IVQXqzF4d8YPdo32V1z6R7BWe
         7l30kCX/GJTPJfWD+92qe6Rl5R4BEbz5PqtwAHfGBLn6/AZ0kiKxhiTjqYPY1JiHdtUN
         nr44g0NN7EkBnUhK/y6DCADkOH4vpMeenRuxJ3rBt77cJ9dPQwxWvLC3aLnR6YCBErRL
         CFOTdWMBMHgFtukaUxO8pcnF2YdARGEIqyqMvAfRi8PYIXHZGMhxcdzRw1aHAK2bnrP7
         ZHxA==
X-Forwarded-Encrypted: i=1; AHgh+RoQAi2u/7gzQtv1lFf0cJHiSwz50ycrKto51Hg+xwPCwUT9zSzwymqm280sAQy8FBpej1quqQ9V8B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K3akleBA6avQFl+PDuVhOamVR0EcoyBOPW4qaapDO3D4vkgI
	4agXqs971AkANtPA7gI+un1/xHGDPZz/lmeGVpC4y6aCiTPpssQe+h0G
X-Gm-Gg: AR+sD10trx4BkmjoWcbRkvhNGTLzGMK9hQDuwIuoyZPic8PaCGDenEAXKV49jImfNJS
	8g36f8PzT4IiZfkdM30ibXBaWufza5Bngi6ynMWbskUr7do0rbCHyq2Rg/0fDT3fDDD59YAKASh
	aNxel8w+3h4J8Mk68737D8UEaGA+642Vjm2eGKXRgzuxHL4/X24EvEuZA7p9jUyPFH54Alqxip5
	ZuR1ZJs3g4D1I8nLnykQG2iIvyM/yWNbj8W0T9CKlS/miXlvWl+r0CXA0eGXDpIuAYVg/mQdY/4
	lUrICAew55tyLYuiwfPq+VVKLBOuX9/ymEcy8ghZ6pNCMO1RWMW7ux/TkG2M1hk4vXueG5g8uXk
	+LSnMEaenqQUP6ldkyueO+1tDSql36YyfEDsKBqtA43gMah+dXSAWZS14cytqJOmKGwBdJnqvut
	JgJXaQ6sTng87X3Wtptp+dSRNC9oJph01WBk0LaVVP6AHVT5+vCBSbM+fZOT0rmTc=
X-Received: by 2002:a05:6122:ca2:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-5c411331e5amr1700380e0c.4.1786264142723;
        Sun, 09 Aug 2026 01:29:02 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c4130b358csm2114122e0c.14.2026.08.09.01.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:29:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:28:55 -0500
Message-Id: <DKK9SFCQK0Y8.3Q7SZMMPRYE9Q@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] iio: adc: ti-ads1262: support REFOUT and VBIAS
 regulators
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-8-f89925d72792@gmail.com>
 <9f0779e5-3139-4c49-96b7-330f70b523a9@baylibre.com>
In-Reply-To: <9f0779e5-3139-4c49-96b7-330f70b523a9@baylibre.com>

On Sat Aug 8, 2026 at 1:40 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>> Register the "refout" and "vbias" regulators to be able to use them as
>> common mode supplies.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/adc/Kconfig      |  1 +
>>  drivers/iio/adc/ti-ads1262.c | 90 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 91 insertions(+)

[...]

>> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
>> index 24a7ecb9fbd4..533574169b04 100644
>> --- a/drivers/iio/adc/ti-ads1262.c
>> +++ b/drivers/iio/adc/ti-ads1262.c

[...]

>> +static const struct regulator_ops ads1262_vbias_regulator_ops =3D {
>> +	.enable =3D ads1262_regulator_enable,
>> +	.disable =3D ads1262_regulator_disable,
>> +	.is_enabled =3D ads1262_regulator_is_enabled,
>
> This should also have a get_voltage() op that returns
> (VAVDD + VAVSS) / 2. Otherwise it won't be usable as a
> common mode voltage.

I'll add this.

>
>> +};
>> +
>> +static const struct regulator_ops ads1262_refout_regulator_ops =3D { };
>> +
>> +static const struct regulator_desc ads1262_vbias_regulator_desc =3D {
>> +	.name =3D "vbias",
>> +	.of_match =3D "vbias",
>> +	.regulators_node =3D "regulators",
>> +	.supply_name =3D "avdd",
>
> What does supply_name do? Make "avdd-supply" the parent supply?

I haven't looked at the code, but it seems like it (sysfs verfies it).
I'll check how is supply_name handled before the next version.

--=20
Thanks,
 ~ Kurt
