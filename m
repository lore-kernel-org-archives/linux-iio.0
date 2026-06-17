Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E13C870E;
	Wed, 17 Jun 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685894; cv=none; b=XySXgupR4SUc+i6SPi8uOySgk6vZi/TEe5EP1d8fPqtXdPuOOUwCnocSrD79nJuZIj6jnVJt7ugXjXGJECZQe7CAyU/Q6KXMeRgJSMJhzmNLcFnLTclodtDcByEb5uiG1RMSmEP3R9Sl5Ps5sBiclBrLrIfMfqI/bttIvlqVDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685894; c=relaxed/simple;
	bh=q+cUJZOydKXdWDpZXEceW0s0RozWR5kA7NjUSuPBp1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Q0T4QoefJEfuZ3dHbmdcR3ksROo0c5UAybpCLgD8sqSrIrji8Mf1Ycaiz6PD4adZGGgImCULpO2sLwWPrPxl+zZGF2pHtgWDS40VKcRuCPvWbbEIINtv9pUto9cfQDrdlBdCmTjm+SNZV+nBbm/T0IPBvOYyAiszVUUVx4BjHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJqsmqL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJqsmqL5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CC831F0155C;
	Wed, 17 Jun 2026 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781685888;
	bh=q+cUJZOydKXdWDpZXEceW0s0RozWR5kA7NjUSuPBp1M=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=fJqsmqL5tZ/r2VH0IDbyLmtJ/fMTxFUKdxTuwnVob95x+LB24GU7YsTTyi0kN1dQF
	 HKvf3Emei2d/BcrOnOP1KutEq1B6Ic8FXQLLNstMBnQ+vCB8arEO2UAMlNqolz/yZz
	 O1kzRxFmtv4oway1kQfPzAixZQxuVvW5lPcAxfoVBRkLr7dAcJk5KhyqqGFNwKnQ5x
	 M2TjnNUC1yfK5Xx+cZjrGR6UTDHD3Mf/1vySIaaSQ45uQIs/+wxJeaNRDB5oCGkTYW
	 TdWIw29fD8sraD3l/V4vuCaOUGHPF7BaCUrbPm+XkwJkxx1+9hAO8VomFrq08nyW0R
	 eo3cPgfwBLH5g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ae7d6270ac9333222e92442123309da8a5c3fc1e7564e8b96e096513da81;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Jun 2026 10:44:44 +0200
Message-Id: <DJB6XO07EC8Q.1X9P752MLFB4N@kernel.org>
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
In-Reply-To: <39de4d4ada5446e7a33e48c43f410439@realtek.com>

--ae7d6270ac9333222e92442123309da8a5c3fc1e7564e8b96e096513da81
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Jun 17, 2026 at 10:36 AM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=
=9B] wrote:
>>>>> Without an accessor like gpio_regmap_get_gpiochip(), we cannot=20
>>>>> retrieve the gpio_chip instantiated inside gpio-regmap.c to fulfill=
=20
>>>>> these requirements in our
>>>>> map() function.
>>
>> Why is gpiochip_irq_reqres() called in the first place? Isn't that only
>> called if the irq handling is set up via gc->irq.chip and not via=20
>> gpiochip_irqchip_add_domain() like in gpio-regmap?
>>
>
> The panic was caused by my driver including 'GPIOCHIP_IRQ_RESOURCE_HELPER=
S',
> which forced the call to 'gpiochip_irq_reqres()' and crashed.

But why did you use it if your irq domain isn't managed by the
gpiolib, but rather your own irq domain? Before going with option #3
I'd double check if that is correct in your driver.

-michael

--ae7d6270ac9333222e92442123309da8a5c3fc1e7564e8b96e096513da81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCajJefRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hggAGA48SYycuQ31SATiLygkbvb0W1zefVePET
gk6JbWW8iIuoG0dOdIPsod0/pPg692m9AYDoGRmD/J1tvhi2B28P6PCSOkTa7yRs
HmpBeIQ/pXUXteE59FADrOs+i7f7s0N8AxU=
=kuX1
-----END PGP SIGNATURE-----

--ae7d6270ac9333222e92442123309da8a5c3fc1e7564e8b96e096513da81--
