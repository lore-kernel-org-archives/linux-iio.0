Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACF3AAF4D
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264086; cv=none; b=sIkYtPKv+o+aKhMIN8AiUj+H/lcHiKJQUPUypShOA0pWS+j1ugUwiENQdL/DXsSxqJyvL9bEERYAz9Cpsm31/vlBV9P5rBmcL6r/m/RwwM8+JJ1ePdKLVzjLVSyk4MjZmCzA8tT0M+k2Bk6rlZ6wQ3Oct9O5UHrInon0tjpDGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264086; c=relaxed/simple;
	bh=ztQMnOAhsVLsTHPjrj99yVY1PEfiigj3zy0kNYd75Z4=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=Y4SlBwnt+zM3j5V+3pf2ivwynWgV5onYU1cdSXu+8wxT/E6WReqE2P6O73OgCZtWG6zMttJwz8B5xDknROKwOL4atAir6ThSo7aFZeOrFFE0Plw45Bh4bfstSZeTJJrLKNrRzBtoz4cngbdPUDmdYH3nYZrKC71t3yK5n1ZaU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noI+9hVV; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noI+9hVV"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so392392e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786264084; x=1786868884; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wwu0sNSPRL9t1VlX8pUN/G4E4jICdzc6GI/iobwP1p4=;
        b=noI+9hVViPEmkwBNJM0ZpftidmnOSf7YPziIC6B6+hdc+d6sYGJwj6wCAvsEYGAddJ
         ss/TuohXTuhHNqPwAAXySloqwHoXiJgEURQDxHEZJp3wl5w/5YnvJA03rFGWJb9fGFFr
         F0vmA1KnvUqB4Vn8ZshGql9IFnz6tAHzTMwbwmlhAlDuRYkW01rk0JGSVb2r+1PnFYKu
         Ol+omts26uQZ8KJBmYbJk3ZeHLHBO8n5igFpMTI+v7fkxoN4nUUBdMKuIFyBFbg7vr7G
         a8peu94z861RLzmMTQo4mDp1HbtsCg4bVtJjVaXYhNLxSx/FL8duW6KrrsM1PO9v9t6r
         x8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786264084; x=1786868884;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wwu0sNSPRL9t1VlX8pUN/G4E4jICdzc6GI/iobwP1p4=;
        b=ntzxUVdq1rz6aEpGtpd6Yqs/0d+J6B35Y9Crqai6LJcSSmhmpeWwQjcC1ERFOScWGe
         +Ldhea/clh4w1MbYaJvraoYx8PSxhTSD3nARh4tlhA60YLVyzuyi28hmwVNYufEQqF3W
         KBJ55L5DiNt2yf5ZsFgB4ob2olUaq4tAEygJJfBUCI2cPz8lh32VTT5Uw68uIXyxZoec
         VZ10s7h77IukHKrhkB7EFOvYplyUwLgCjctE4d68Hq7Cz6gsU75iLl55XMueZt+7VNOs
         0dJ0bYssvjis+Qxhb5Hq3DLoLx++NgCmo5m1e5k+vWLXoXIRIrFeZp2cWTEFgpGhBVcI
         W9mw==
X-Forwarded-Encrypted: i=1; AHgh+Rpy79JxSSLdbEvbopzSts+OU8mvrTNdOuJN9z7Ub59EwerYh/YmPyv3tLl/NWuDyzTSQ3DVMerYKoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30FdNZt47UsaF6SX5Sy75M44e1InFBmOt/thJ2uIKqLNSoh0Q
	2BrR5CbH5Nh7UXtKqq1wCu0uGJ4LQTrk1pzhNCQCTwffeco+REZ4CKgo
X-Gm-Gg: AR+sD12auaWcCE7uAnCqpXiCw8mG3IQ/Zk6bZmv4wf7bRnXZXKFU5djIByj1L92/dDK
	PgDE20ER7UDRH9VjCz2G3EEtbbZQAfMiZRaFyoheM16HjjXt+5Clw2UlHDNDKVRI28busGf2kGO
	5S1Jiz31XGUwA59SsFoGnxUxK0UZmpwVyZO7Bl+9rlJtu/d1Tf13hZ6dJg7EYPG7jXsVRL+U6w2
	wknl0/R7xMiHUtsInEltohqrBNMroE1UUByDewiHQwka4iTwSM/NZivzPf6FjutxqmvoyuxZATE
	1f901TtEpCdmNiPBRfOdrO5kX0SpDIpM7RZoV+dY6HqnidkFLKf/P1lE7zm8joFsFdLezKWvLPu
	aGBHvou8omExKxYa+hx2KtFysvFbZiMw48NFgIGvcI/BRIJO/J7b5fSNZPAioRKqQZocLOoTTn/
	e+iOJYoH0yTMPq3FB6o/93cXPjzrK0EFNZS09o/nfdZbIhgeAoFIgOyCtLsDcCXA==
X-Received: by 2002:a05:6122:e250:b0:5c3:61c2:9ec6 with SMTP id 71dfb90a1353d-5c3d9161b60mr3772625e0c.7.1786264084241;
        Sun, 09 Aug 2026 01:28:04 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm2751296e0c.16.2026.08.09.01.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:28:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:28:01 -0500
Message-Id: <DKK9RQR8LIQ5.2SWUEDKZTT98P@gmail.com>
Subject: Re: [PATCH v3 4/9] iio: adc: ti-ads1262: support per-channel
 reference and gain
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-4-f89925d72792@gmail.com>
 <ff566148-b3fb-49fc-9e87-6c5a317e1a2f@baylibre.com>
In-Reply-To: <ff566148-b3fb-49fc-9e87-6c5a317e1a2f@baylibre.com>

On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>> Allow each channel to select its voltage reference through the
>> "reference-sources" firmware property. Then, use the reference voltage
>> to calculate available scales.
>
> It looks like this is also implementing PGA gain at the same time, but
> isn't mentioned in ght commit messsage. I would also expect something
> here about how we should handle PGA bypass (even if it just says default
> works always and we can consdier controlling it later).

I forgot about the PGA bypass stuff. I do believe it should belong in
devicetree because it changes the voltage range of the analog inputs.
See datasheet section 10.3 and 7.3.

>
>>=20
>> The ADS1262 allows single-ended supply configurations or bipolar supply
>> configurations. In single ended configurations both the analog and
>> digital rails share the same ground, i.e. AVSS =3D DGND =3D 0 V. In bipo=
lar
>> supply configurations, AVSS can go below ground, e.g. AVSS =3D -2.5 V.
>>=20
>> If AVSS is below ground, the ADC can achieve true bipolar measurements
>> and the external references can also have voltage levels below ground.
>> This is currently an issue because the regulator subsystem doesn't
>> support negative voltages.
>>=20
>> The ad4170-4 driver faces this problem too and the same workaround is
>> used in this case: assume every regulator reports magnitudes (absolute
>> values). If the chip has a bipolar supply configuration, then assume
>> positive references are above ground (>=3D 0 V) and negative references
>> are below ground (<=3D 0 V). This is not a hardware constraint, but it i=
s
>> the most common wiring.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/adc/ti-ads1262.c | 417 ++++++++++++++++++++++++++++++++++++=
+++++--
>>  1 file changed, 406 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
>> index b3b7b1249102..360ce01a5871 100644
>> --- a/drivers/iio/adc/ti-ads1262.c
>> +++ b/drivers/iio/adc/ti-ads1262.c

[...]

>> @@ -688,6 +818,91 @@ static const struct regmap_bus ads1262_regmap_bus =
=3D {
>>  	.max_raw_write =3D ADS1262_MAX_REGMAP_WRITE,
>>  };
>> =20
>> +static void ads1262_calculate_scales(int (*scales)[2], size_t num_scale=
s,
>> +				     u32 full_scale, u64 mult,
>> +				     u32 resolution)
>> +{
>> +	unsigned int i;
>> +	s64 val;
>> +
>> +	for (i =3D 0; i < num_scales; i++) {
>
> This could use a comment explaining the relasionship of the index in the
> array to the PGA multipier.
>
>> +		val =3D mul_u64_u64_shr(full_scale, mult, resolution - 1 + i);
>> +		iio_val_s64_decompose(val, &scales[i][0], &scales[i][1]);
>> +	}
>> +}
>> +
>> +static int ads1262_populate_scales_resistance(struct ads1262 *st,
>> +					      const struct iio_chan_spec *spec)
>> +{
>> +	struct ads1262_channel *chan =3D &st->channels[spec->scan_index];
>> +	u32 full_scale;
>> +
>> +	if (WARN_ON(!ads1262_ref_is_external(chan->ref_p, chan->ref_n)))
>> +		return -EINVAL;
>
> WARN_ON() is a bit strong for something that is coming from the devicetre=
e.
> I would just fail the parse() function with an appropriate error message
> so that we don't have to check here.

Actually, an IIO_RESISTANCE channel without external reference is just a
bug and would read past the end of buffer below, which is the only
reason I verify it one last time. We should never actually hit this
warning. I'll add a comment explaining that.


>
>> +
>> +	full_scale =3D st->rref_ohms[chan->ref_p - 1][chan->ref_n - 1];
>> +
>> +	chan->num_scales =3D ARRAY_SIZE(chan->scales);
>> +
>> +	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
>> +				 PICO, ADS1262_ADC1_RESOLUTION);
>> +
>> +	return 0;
>> +}

--=20
Thanks,
 ~ Kurt
