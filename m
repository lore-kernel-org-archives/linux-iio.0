Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC40343889;
	Tue, 21 Jul 2026 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632689; cv=none; b=MtU/z2JEPXUezgCKhZ3F2mHvTTQ6Qvdcmj/wYVEmxGkP2nrY61pbopwKJjxqYtvTrLoAKsGsz2j35+p46rD/HiiXpC4bGTRoYfNBJzmSyZwUuJQy3sBqu6nqQ/s/apiPCrSApg0EcrLjvscZo5w5h/8tfH4l3FuHVk3h7V6yMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632689; c=relaxed/simple;
	bh=ZfgIxFQSh3PVkOpy6rqrwFEhS2mluFlM0Ws+aGWuEXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=ODqg6doeOklWRddXKJxVmJkZI6JpODfiTV/UkjzQWhiNEuxAZSlDg1s6LnoygsiBdEym9uXuGUyOoTyuVr+CUiYuk8APqUgrpAyMRuzXYGY3cyNuyPMDAfcwiu9j+DaYXuuK0zJnyFMWHQqB+yh5ixF8/T2yIMri7kYynmbK9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/1SHL32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/1SHL32"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EB1BA1F000E9;
	Tue, 21 Jul 2026 11:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632686;
	bh=saQPacCFeQ8croeaYwGiWBeXc/MFwVHTZ8cJTa3GPlo=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To;
	b=I/1SHL32sYQ4ITJ8oZARKOeMKvNywLNCXO8Nvv7EmovgpndIHQwNGAtKakcbo6mCY
	 N9D5UrIXa/Rn7xVqP0NZBV7cF9QM67jZiaqgsFe20+K6Qqe7vbs+ZaHc1tsO/ba1e9
	 JFcDttDNHgIsdmulKudYKaZP5X5wE00p/V95S8huWeJugXOFEAlwBS0smZLvUn0MV+
	 n7QiANqeRDwbwPzEV7Jpbmsvqh0+gxPdxq+sOxQW/nUwast0dOdNQTfIwNITzmNChO
	 cHJYNI35Q2/fcDwEseuvG/g0CEAPhtfhZnIiewvWLVLJX0aj1lCG2h96f5Sz4WEglk
	 n3d6HT5A1PM6w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8b9ff402e4734a9448001927c39405147de410f1750836df5fe108ac95dc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 13:18:02 +0200
Message-Id: <DK47HK67DGGW.37OGI53JJAVUL@kernel.org>
Cc: "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux@analog.com" <linux@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, =?utf-8?b?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
 <cy.huang@realtek.com>, =?utf-8?b?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
 <james.tai@realtek.com>
From: "Michael Walle" <mwalle@kernel.org>
To: =?utf-8?b?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
 "linusw@kernel.org" <linusw@kernel.org>, "andriy.shevchenko@intel.com"
 <andriy.shevchenko@intel.com>, "brgl@kernel.org" <brgl@kernel.org>,
 =?utf-8?b?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
 "wbg@kernel.org" <wbg@kernel.org>, "mathieu.dubois-briand@bootlin.com"
 <mathieu.dubois-briand@bootlin.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
 "andy@kernel.org" <andy@kernel.org>, "u.kleine-koenig@baylibre.com"
 <u.kleine-koenig@baylibre.com>, "dakr@kernel.org" <dakr@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "o-takashi@sakamocchi.jp"
 <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v6 6/8] gpio: regmap: Add set_config callback
X-Mailer: aerc 0.20.0
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-7-eleanor.lin@realtek.com>
 <DK42I02A80FJ.1TX1U341LOAXG@kernel.org>
 <520080c564ef4a039b67d2a820e7a646@realtek.com>
In-Reply-To: <520080c564ef4a039b67d2a820e7a646@realtek.com>

--8b9ff402e4734a9448001927c39405147de410f1750836df5fe108ac95dc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 12:46 PM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=
=9B] wrote:
> Hi Michael,
>
>>On Tue Jul 21, 2026 at 8:58 AM CEST, Yu-Chun Lin wrote:
>
> (...)
>
>>> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h=
=20
>>> index 45a30f50043f..23460995c1d1 100644
>>> --- a/include/linux/gpio/regmap.h
>>> +++ b/include/linux/gpio/regmap.h
>>> @@ -89,6 +89,9 @@ enum gpio_regmap_operation {
>>>   *			mask before writing. This allows driver-specific logic
>>>   *			to append additional bits (like write-enable masks)
>>>   *			dynamically based on the current operation.
>>> + * @set_config:		(Optional) Callback for setting GPIO configuration su=
ch
>>> + *			as debounce, drive strength, or other hardware specific
>>> + *			settings.
>>>   * @drvdata:		(Optional) Pointer to driver specific data which is
>>>   *			not used by gpio-remap but is provided "as is" to the
>>>   *			driver callback(s).
>>> @@ -150,6 +153,8 @@ struct gpio_regmap_config {
>>>  			   unsigned int base, unsigned int offset, unsigned int reg,
>>>  			   unsigned int *mask, unsigned int *val);
>>> =20
>>> +	int (*set_config)(struct gpio_chip *gc, unsigned int offset,=20
>>> +unsigned long config);
>>> +
>>
>> Do we need an additional struct gpio_regmap pointer as a first argument?=
 How
>> does the driver fetch the attached opaque data pointer? I see that your =
driver is doing
>>
>> struct rtd1625_gpio *data =3D gpiochip_get_data(chip)
>>
>> But it is the gpio-regmap core which will attach it's own data pointer t=
o gpio_chip, no?
>>
>> -michael
>
> You are right. I mistakenly used gpiochip_get_data() here.
>
> My current plan to fix this is:
> The set_config callback in 'struct gpio_regmap_config' and 'struct gpio_r=
egmap'
> should take 'struct gpio_regmap *' as the first argument (replacing
> 'struct gpio_chip *'), and the driver should use 'gpio_regmap_get_drvdata=
()'
> to retrieve its own data pointer.

You also probably need the struct gpio_chip, to maybe call into the
gpio core, no?

If so, what about

int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *gc,
                  unsigned int offset, unsigned long config)

> I'll add a wrapper in gpio-regmap.c that bridges gpio_chip to gpio_regmap=
 and
> handles the fallback to gpiochip_generic_config().

Yes.

-michael

--8b9ff402e4734a9448001927c39405147de410f1750836df5fe108ac95dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal9VahIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hsEQGA9lrTNZekIwEAKarij0Y8ekh0iIA1jHyY
CdjoCCBiigEFDykUh9rqX3K7LlH3RZtlAX9U2AeiIsMNMPQrLHaDPF4xMSPCoXwR
yBmjN7mh50pNz8GS2QRpwm8N9xWinHRb3YI=
=Xd0N
-----END PGP SIGNATURE-----

--8b9ff402e4734a9448001927c39405147de410f1750836df5fe108ac95dc--
