Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D113CA4A8
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550181; cv=none; b=o0EFWEbNlknac3ie5cfYdN/trQ9DzHdY+x/Wcy7C+gk17sGCMv+i05No+kW6fWWZWhVbTOzjfEJNVvWLFllXt+fY20bWGJuhhFSHaFy1k4Zjk9uycuRhokjZn4wgL8akTZ3eC5KZiku+XKxnx55+9unvvdMhOuCX+4+S51TPzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550181; c=relaxed/simple;
	bh=0AaMJ2ZuNPDpNygnkdWg2dPvVXYhqFjRU2NBOmUvi78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bgyVuFt0DAUfjKXs4oxTfWP1eVS3DyuPcuP0op4zWmcAAMufey6iNr8C0FT8Ima1qi70CtOGOV+rijPp13VEE10zQtde7C5FHVU6eDjs2aAJuWcJZNnwYYTh9Yrere8Mjvf7XHQnGe81RjV1DDKQw8O5S6zK+uxNIa6GoIoreaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keLJ5GAh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keLJ5GAh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so1154903b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786550180; x=1787154980; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eNFhq05aNqziwdNErnHS5ilsR28OC8bIWpEV7AXBxgQ=;
        b=keLJ5GAh0g5RtMV11QpSx2n2/UZJt9lrLY7QD4eGNlZNn9FIeEiokdcdP6RsROEf8l
         U6l6eayJdsXTmELLoMMF+HpyM8DUHSZJY34KizyKdZKwASxR+VE8QPFL9lE0izyBwEqi
         qi/D3gC7vH2xQIX+sCK9li90foUuV90LhNHITSCO3jZ4aR1CdgYGWMatJUwhEQgWtEx8
         rVHWves+vdglinrFZewIaK0qigV2+/PojneTvZUY7aTakNrv0vFm0+GuWspG7MOi+AN1
         rLTb+paNyED/n4IuYwZIPHko4FVvsp4euXFO7zNFWWHO7cUU9+ViY/6Hkl2JZcPZ3aId
         muVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550180; x=1787154980;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNFhq05aNqziwdNErnHS5ilsR28OC8bIWpEV7AXBxgQ=;
        b=Ars2d9dGE+i4U3kZbqVFAh23F7sakyOYVJgo8o13elVItN9qHyziYgqtiCTecugiU9
         rq+ew1KG0FS+Xa0HU0nM02q8za0fH5+5BmZrQ3iF5qWA5bjmirDJKsN3Hoc7u4FEFCBE
         ZpwLhjSbJcGdzuGsqMTI3Eo80HyRfKAcKUxMtZ1w/+Ykwsb6hD64FFAnskbwj/T9GgrA
         ivQ+SqT9qM8xh0YdSygwIgJ+L/lhGm1fq1nhw7Hx4fnOSg1e/049cXMtpBydqDsKDMId
         jgaHKNqYELCUdE8DFEEmJAURfO5ey6M8AWYdnXTM4vFIlHuMKSIcND66mDyHOJZd0cZR
         qlCA==
X-Forwarded-Encrypted: i=1; AHgh+Rqd6tu9LjU8w19KZOVV9e3pjCOxUlPJGl6KOVwPsF99vfAQn5ZNIL+cOFglk6//VyyFLqLpvs2VZAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8F9jpcIg5hfg5tg6rcoTNYhgtP+/+0bPzBhnd5ja9u+95RBGR
	RU6K8aMMnnmSxC/zLUy+1auqPm/SS3/191Vpgog0GIIu8aKqphRj5X0=
X-Gm-Gg: AR+sD13wDstxIqWy5Ptqgd0BVn3vmjWAP9zH+ckLxG+mL5RS9hi2ph90yC5ORPnWjYh
	qANAe6NOsyAIyHf7smROpDuKd7LB/w0fLprMgGyVVjtb1KvbyqyDgGGlT73DPK1ZOgK2lAkgBvp
	TesrDuCPGFp5G5LGexd2uUt/Ej456x2MIl39Q/v6EndUkyEBTwzp9vsKW2oUi+9P5LAqaxQUTaP
	YJ8/e5fAQ1rQ5WKPp+FrPSh4GqPwrc5ocXTtj+BTNYnHoJvxFwEtTnBHdrvSH0Fxtnc9hxh3bmO
	iNPqm9lVquRKkezp8Woh6wiIJv+l+wTSEXPR0NPmy6igPaz5IJjWcjwbQQwwJZYrocWvAGWH9J+
	kt7iRc225HUeQSkJ5nWD9aDb1Ow5pvJrNK18IHL4YfkdEP2MHga0oG1SuvYudujFwoBKkavfAYj
	3m1Ox79Cwl+1+3U4fkMzC8TlXb1uYxEEyz/cpEYD85zwcYSwntJhGdreZBoez62xWhao7Mgx3DS
	2qnOWnecYe1k1dHMvnXuTZl
X-Received: by 2002:a05:6a00:8084:b0:84e:244a:98e8 with SMTP id d2e1a72fcca58-84fb55490b2mr6851084b3a.30.1786550179686;
        Wed, 12 Aug 2026 08:56:19 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f73159sm1220212b3a.56.2026.08.12.08.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 12:56:15 -0300
Message-Id: <DKN36K6SLY15.2Z5PITE3CE9CN@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Marcelo Schmitt"
 <marcelo.schmitt1@gmail.com>, "Andy Shevchenko" <andy@kernel.org>, "Brigham
 Campbell" <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.20.0
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
 <anrRkty6ugdJUGmE@ashevche-desk.local>
 <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
 <2d7dcced-47f9-4fcf-9668-30acb9e8c9b1@baylibre.com>
 <DKMB5HGIEQCW.3EKGVS7GLRBOF@gmail.com>
 <125ac6a1-a089-4ce8-9b20-c3448b6b5208@baylibre.com>
 <20260812054339.6f58b5fd@jic23-huawei>
In-Reply-To: <20260812054339.6f58b5fd@jic23-huawei>

On Wed Aug 12, 2026 at 1:43 AM -03, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 13:06:50 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 8/11/26 12:58 PM, Nicol=C3=A1s Antinori wrote:
>> > On Tue Aug 11, 2026 at 12:49 PM -03, David Lechner wrote: =20
>> >> On 8/11/26 10:12 AM, Nicol=C3=A1s Antinori wrote: =20
>> >>> On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote: =20
>> >>>> On 8/10/26 1:32 PM, Nicol=C3=A1s Antinori wrote: =20
>> >>>>> The AM2320 is fully compatible with the AM2315 sensor in terms of =
I2C
>> >>>>> communication protocol and measurement conversions.
>> >>>>>
>> >>>>> Add the "am2320" entry to the i2c_device_id table. =20
>> >>>>
>> >>>> Interesting. No devicetree bindings for this one? What kind of
>> >>>> system is it on?
>> >>>> =20
>> >>>
>> >>> I am testing this on a Raspberry Pi 3b mounted on a protoboard. =20
>> >>
>> >> How do you tell the RPi to bind the driver?
>> >>
>> >> Since Raspberry Pi is ARM-based, usually we would use devicetree
>> >> overlay to do this, which would mean that we should write a
>> >> dt-bindings .yaml file for these chips. =20
>> >=20
>> > I do it manually.
>> >=20
>> > I use that RPi for development, at the moment the kernel I am using is=
=20
>> > 7.2.0-rc6-v8+ with CONFIG_AM2315=3Dm. When I need to use the AM2320 I
>> > modprobe it with:
>> >=20
>> > $ sudo modprobe am2315
>> >=20
>> > And then=20
>> >=20
>> > $ sudo bash -c "echo am2315 0x5c > /sys/bus/i2c/devices/i2c-1/new_devi=
ce"
>> >=20
>> > (With the modifications I made ... echo am2320 ... works as well)
>> > The pins for i2c I am using are GPIO 2 (SDA) and GPIO 3 (SCL).
>> >=20
>> > If a dt-binding yaml is needed I can send another patch with it!
>> >=20
>> >  =20
>>=20
>> Yes please. It will make it easier for others to use as well.
>
> I think (from a quick bit of googling) that these two parts are
> at least 'kind of' the same thing with different packaging.
> The name is a nice to have and given the packaging may I guess
> affect the signal and how it is used it probably makes sense
> to add it.
>
> They only have 4 pins. Power, ground, SCL and SDA.  So it
> is a rare device simple enough that I think an entry in trivial-devices.y=
aml
> is probably sufficient.
>
> Ideally add an of_device_id table, even though this will work fine
> by the fallback path that uses the i2c_device_id table
>
> Jonathan
>
>>=20

Thank you all for the feedback. I've added of_device_id table, chip_data
struct (and assign the name from there), and added "aosong,am2315" and
"aosong,am2320" to trivial-devices.yml.

I'll wait a few days to send v3 in case something else comes up.
