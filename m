Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0740963A;
	Tue, 21 Jul 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617531; cv=none; b=lw3adZN0g/5wjvjA7t54CBV67i+bhjVw05rAoacjJ2YkaPfv5eSc8eRndJk0LdJ4UHVLSfzXbCsKVtuFvK26yGd12eTkoyTeth1PTcp9fobGlP46HduK6SV7C42uQoivqFnaSoc/9GanB9cekUvmmWVEjL9Z11ITt4A67R4QtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617531; c=relaxed/simple;
	bh=W7cLLmTQzYKMZyabYOYUsqhrJFQSai3Gbp8IcrgOPnU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=MEzazK/J+CWX1Co2FLVxSo5GQvRnYTh01f77xc39l6ToiS1Zz+IvQzT8DiirgthB+zMVg5N0WFCYKN78tU9P4/AXpTB/Bd/jIAJjcKaS7lF8NXzgtSPPETDiDlk7DThMuUC4tc+TGFni4A4MdlQ4nrOXZsZ9XZ0NJUwhx8i5rRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feu6/VhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feu6/VhT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C0FF51F000E9;
	Tue, 21 Jul 2026 07:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617530;
	bh=W7cLLmTQzYKMZyabYOYUsqhrJFQSai3Gbp8IcrgOPnU=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=feu6/VhTAezrVdkuOzeEOgCj9pCccpQMNPcDL7KexpqjW1jAJDZXHyXkSl4kWI7NF
	 YZWk9w3ioyYBh+2E5lleUIp8jN81VWhO7+X2THNCl9utRITn/5bYlUFNyHWjE75ZsF
	 HYAOQfNK+OWG0pvJ0x+NaUALrt7l07QTt8cdioEbguPg0Eo0IMRwUzok5vZzD63A4w
	 rm+RiZJtzZwq3ThMWtYH5g0RuUdRqy353jon+qSZ4ZVBf0YJw668HEaHJwtbFsSe2C
	 BvBPaI20AXRgsLe0Yn/AEYW5X+xuwoTOp2js50jE5CV0VNcRx76ED9am8GW0TSViwW
	 WlcriOd2YV8pQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a6b65c8e38c734150da226f85416255ee1b94a047a77642ff8ccfee02950;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:05:26 +0200
Message-Id: <DK4245NVH4HT.1LHNN81I03AK2@kernel.org>
Subject: Re: [PATCH v6 2/8] gpio: regmap: Provide default IRQ resource
 request and release callbacks
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <brgl@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <andy@kernel.org>, <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.20.0
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-3-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-3-eleanor.lin@realtek.com>

--a6b65c8e38c734150da226f85416255ee1b94a047a77642ff8ccfee02950
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 8:57 AM CEST, Yu-Chun Lin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> When GPIO regmap based driver supplies its own IRQ domain, it might
> still want to keep track of the IRQ requests and releases, in particular
> to prevent a GPIO, which is used and locked as IRQ, to be requested
> via standard ways. Provide default callbacks for such cases and keep
> struct gpio_chip private to GPIO regmap implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--a6b65c8e38c734150da226f85416255ee1b94a047a77642ff8ccfee02950
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8aNhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gQWQF+KbiV4Z/vg4mLANE6gNrXsywDFfhUv3Qu
6fbWjemHrYWF0hhwgvj8QZUeKLArwrdOAYCua4SBlMuJXLFSn7pK9cilKpgj1Y6I
fNwwnxHQDz5kN08hDTyZPOPJrIL/1a6x2+s=
=i1DQ
-----END PGP SIGNATURE-----

--a6b65c8e38c734150da226f85416255ee1b94a047a77642ff8ccfee02950--
