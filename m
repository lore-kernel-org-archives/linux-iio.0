Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B042E8CF;
	Tue, 21 Jul 2026 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617625; cv=none; b=SRz1ldwLpaFk1tnwzx/X9AU3abUUeKFLkIVybO/ikiYME/B7jM0o1Npv9U+MqMxz14v/xpGq7HlJRxsNNMjnOQ5fWrgSM/3TgQvLN+WeDzJSSLzAUCaqyKpMrb1Dl6g2H/Oxxifthm6qejUiPGJgAvv0OIDVai9vyqcaCNqETiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617625; c=relaxed/simple;
	bh=FJ30V4Guh3EzWPIzAwF7f6U79iuabInGuYd7D0JYd2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=MlPSNlZxcnDS6VLv9TF/eRnIeqXLAYrZEuILdP8WhCNnhrPccFx6xirnTUKe0O0GDIYK08Qnn55mNejK6jEqpUeTTl+kMi9Sqq6Jcu8NHALeBTj1RLLOGeVrZTxq52DAE+Bk0UnBtrlnS7G6IC1DE2ffe8v24yqi2y85HBWAvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctkUggDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctkUggDL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ECAB51F000E9;
	Tue, 21 Jul 2026 07:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617624;
	bh=FJ30V4Guh3EzWPIzAwF7f6U79iuabInGuYd7D0JYd2Q=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=ctkUggDLBAwc4YJU8nH3UAHmAcWQIr7wfFVSm9031LPogio5BHuK+5Zh34RSuB7Ju
	 a18OT9CKuGeqDotbzvUN9WfPnuozCNQFi+QVPEk2Ki5JY4p7QUusYsPeUsJBxZUpVQ
	 1eqtH/zztp9wrcwEd5oCZZsyi5DsZvrQkJ+HQpofgpRGx2wCvW6ztf2LvpNIbZPuxf
	 fSKzLeclHgP8iPEHlE+S2BPSKXG3PC1Xrtvl+IbZ+PvD6UNxgVX3aTse1RvU43aXl3
	 kgJEQ26d9U5mHUS/CtOiTm58L3hfyWUXO/4z0bf2YEp3WxP2jvcuABznst945M0YYM
	 p5B9JLzrR/iqw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1a15feb16f330f55b0d82f64f83aaf97aed8b0cb1fdaadb3e3d81b6d4cdb;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:07:00 +0200
Message-Id: <DK425CY4WGMJ.P7725LJSCUYR@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <brgl@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <andy@kernel.org>, <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v6 3/8] gpio: regmap: Apply default resource callbacks
 for regmap IRQ chip
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.20.0
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-4-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-4-eleanor.lin@realtek.com>

--1a15feb16f330f55b0d82f64f83aaf97aed8b0cb1fdaadb3e3d81b6d4cdb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 8:57 AM CEST, Yu-Chun Lin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> When GPIO regmap creates an IRQ chip on behalf of the user, it also
> takes an ownership of the respective callbacks and driver data.
> With that being done, apply default resource callbacks that keep
> tracking the IRQ requests and releases.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--1a15feb16f330f55b0d82f64f83aaf97aed8b0cb1fdaadb3e3d81b6d4cdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8alRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h9pAF/RlJ1QxpFxZ8N2y387bbs9/OhCxVqOU7E
4vfqQQWLUvp/Xk6TLmHY4Z/ELMsgF7xBAYCCzfwNvUqFOLZ7ewsdp2giirMHHZsQ
Min8V7O30TfRFB6bWVlo/GpZpa67pbhqBOw=
=dRwW
-----END PGP SIGNATURE-----

--1a15feb16f330f55b0d82f64f83aaf97aed8b0cb1fdaadb3e3d81b6d4cdb--
