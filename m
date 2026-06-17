Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BC2FE59C;
	Wed, 17 Jun 2026 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695205; cv=none; b=UPbfKLqgYahHPy2XMzTgZshnd7av/nbE/7BDdJ5gpAi1DwAt07/ptyR4PXT04mxRB7Dwmcq2lF9W8Sci7Yoy/l5k8075i2sSSM0VItvTgONFB4pLDcFg3xZZ6Bhf2VpmXShwCRF/j5AMQQ1IeHPEBKUssTT8KjDGlykndWhK1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695205; c=relaxed/simple;
	bh=QmpVju6t1H4zbdKM4jpMagQX9IqAMGicbUC5PSgBpBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ExU55O5ToqvKQE7ZoInaXVJIfPXLKxBBSYs7yfZWoMJ1nxujYAq8PuIbsG8qzZUkk65BguNPDzHFH/9CmrgRdcFWsPZAu+Jksyn/Kv4zTBhdJYEhSizMAyJ9ipV2YHYY/GaVOuzlgAuyHO6KwILrK/vAiNiAwbNRRsQJk0TGJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhZtZrAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhZtZrAG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8A03E1F000E9;
	Wed, 17 Jun 2026 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695201;
	bh=QmpVju6t1H4zbdKM4jpMagQX9IqAMGicbUC5PSgBpBQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=PhZtZrAG+elWGzO5YoCFGusWT/CYMgHWieRPrvrURowNfPQ3i90TlohgdoYcZWStV
	 63YhnI3BEDnLp5pOeFtRmfuARqqxNNxDhOQBibpKrVfEpRUJ/jLpgUka9Xe/kxuX0L
	 8xm8dxJsy5nDd1ML0Wlkpm3O3TLHWPbZ+YVom7RLrXbub6DtIw740NjKhMPj2dSzTH
	 iXTyyDktgyQ1pGUf7Qja511gLgGeKC4saFivTLL14M9sbarXAmMUFN622usU9e8zo6
	 LBq5lmcQUPVmNk6vga/hZra0w+OqfwBJoS6mJHaQr2DApaZDdDPQL8goTVyk3UfXIK
	 sUlA5j1Pdejxw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=30991a780f930c85dbe063c06cf260d6554dfbcf048d534393a8b0204307;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Jun 2026 13:19:56 +0200
Message-Id: <DJBA8HX2E2HL.3H9NMHA9PW7N2@kernel.org>
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip()
 accessor
Cc: "linusw@kernel.org" <linusw@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "afaerber@suse.com"
 <afaerber@suse.com>, "wbg@kernel.org" <wbg@kernel.org>,
 "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
 <andy@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
 =?utf-8?b?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-realtek-soc@lists.infradead.org"
 <linux-realtek-soc@lists.infradead.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, =?utf-8?b?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
 <cy.huang@realtek.com>, =?utf-8?b?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?=
 <stanley_chang@realtek.com>, =?utf-8?b?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
 <james.tai@realtek.com>
From: "Michael Walle" <mwalle@kernel.org>
To: =?utf-8?b?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.20.0
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
 <20260512033317.1602537-3-eleanor.lin@realtek.com>
 <agMM9soiqpG-TRSb@ashevche-desk.local>
 <adff3a2d21a64d3ea3b408d62157ee1e@realtek.com>
 <ah92oEavMu4QRn8y@ashevche-desk.local>
 <CAMRc=MdA24z-tB_D8CTw68Di8e4OVQJ1QH4+rDskFzq=xjJ5BQ@mail.gmail.com>
 <DJ3QVMZ6XLW9.1M9W541O92QWJ@kernel.org>
 <39de4d4ada5446e7a33e48c43f410439@realtek.com>
 <DJB6XO07EC8Q.1X9P752MLFB4N@kernel.org>
 <61c053a5a8e6461f9e6fcd40b6b5064d@realtek.com>
In-Reply-To: <61c053a5a8e6461f9e6fcd40b6b5064d@realtek.com>

--30991a780f930c85dbe063c06cf260d6554dfbcf048d534393a8b0204307
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Jun 17, 2026 at 11:54 AM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=
=9B] wrote:
> Hi Michael,
>
>> Hi,
>>
>> On Wed Jun 17, 2026 at 10:36 AM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=
=90=9B] wrote:
>>>>>>> Without an accessor like gpio_regmap_get_gpiochip(), we cannot=20
>>>>>>> retrieve the gpio_chip instantiated inside gpio-regmap.c to=20
>>>>>>> fulfill these requirements in our
>>>>>>> map() function.
>>>>
>>>> Why is gpiochip_irq_reqres() called in the first place? Isn't that=20
>>>> only called if the irq handling is set up via gc->irq.chip and not=20
>>>> via
>>>> gpiochip_irqchip_add_domain() like in gpio-regmap?
>>>>
>>>
>>> The panic was caused by my driver including=20
>>> 'GPIOCHIP_IRQ_RESOURCE_HELPERS', which forced the call to 'gpiochip_irq=
_reqres()' and crashed.
>>
>> But why did you use it if your irq domain isn't managed by the gpiolib, =
but rather your own >irq domain? Before going with option #3 I'd double che=
ck if that is correct in your driver.
>>
>> -michael
>
> Do you mean that a custom IRQ domain shouldn't be mixed with gpiolib feat=
ures like
> 'GPIOCHIP_IRQ_RESOURCE_HELPERS'?

Honestly, I'm not sure. I've never done anything with irq domains
except for using the regmap_irq_chip. But from what I can tell is
that GPIOCHIP_IRQ_RESOURCE_HELPERS are tied to the handling with
gc->irq.chip, which isn't used at all if you add the domain via
gpiochip_irqchip_add_domain(). Please correct me if I'm wrong
though.

-michael

> Additional information: our GPIO controller receives 3 separate interrupt=
 lines.
> Because the standard 'regmap_irq_chip' mechanism in 'gpio-regmap' does no=
t support
> this multi-line hardware design, we are forced to create our own IRQ doma=
in and pass
> it via 'config->irq_domain'.=20
>
> Given this constraint (that we must use our own IRQ domain), are you sugg=
esting
> that we should implement our own 'irq_request_resources' and
> 'irq_release_resources' callbacks instead of relying on
> 'GPIOCHIP_IRQ_RESOURCE_HELPERS'?
>
> But if that is the case, we would much prefer to let the core gpiolib han=
dle
> these resource and state management tasks for us *as proposed in option 3=
), rather=20
> than duplicating the effort in our driver.
>
> Best Regards,
> Yu-Chun


--30991a780f930c85dbe063c06cf260d6554dfbcf048d534393a8b0204307
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCajKC3RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iFxwGA9GnpxKtX1eMaDBRZLS2qXUO5rwxnfcPH
PrpuryubAiSmq4+/qWts4440bm64mrTxAYC8thI7zuN+jL1FtOZG+peZJT8y/pS2
Y9xeRMo/jVCMUytnXmfeeRq8Ax2WJG+bC3Q=
=l7H9
-----END PGP SIGNATURE-----

--30991a780f930c85dbe063c06cf260d6554dfbcf048d534393a8b0204307--
