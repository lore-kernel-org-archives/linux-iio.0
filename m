Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD57476059
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667816; cv=none; b=Woml/H+itcGtQn4x0pwfOmhz5ddBaICTZmX+O4tx9uoam3ghNCaRAX8X2PpbATMgja2c8yPKvwEE0nJJL1q55vy9UiEow+MgsQFKbXiNvny67zZSTs/2hxVJDU17/1CiynkYqVSZahaWA1nTXWadS2nnywbQwBv3T8MJuIpkyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667816; c=relaxed/simple;
	bh=8eYHUHzAkY/OgwWnfZq0oD8eDAGNtrMNfJ8ut/YZz78=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=uYROAla5oxtKpvQxwFgztcC78qdIkguKY8r/ebhhrvhXWy/vpGz6h/NPbRe4dlE762lv1Ilag7tkkG8ZIeBMKydiQNqvWGfoPTYsWnYzQ8wZDSoX0Ylw62wqTAWg96e4N7rRZbhzobs+krTHKAxLi8WObLRnKKPI9kaDA6TTOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=boQIY7/s; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="boQIY7/s"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784667799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOLPulxW3X/dh4G/AjF8dEd6X8PwO1Cj8iafkcy1eic=;
	b=boQIY7/saCQEjEoUnhUTvt2U4KR0lcrtwtkRo6RHv/p/uwJGtPcweKRziahIxTNPWKXcfN
	ya4/jc7e8LK80VGo4cztyyI0vZTNB+nHQG3Cr9lcnS4h4Edxpw0tIVfPKiI05+V83dfgsF
	Y+JSyTtKM4zQN/tRtbJeqp8haa7PoGY=
Date: Tue, 21 Jul 2026 21:03:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <75eddcbf72d7d6a37f3ea213ffd9afc979d34a89@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] iio: update email for Siratul Islam
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Song Qiang" <songqiang1304521@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?="
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <al_bUWguna_K1n7X@ashevche-desk.local>
References: <20260721150314.24545-1-siratul.islam@linux.dev>
 <al_bUWguna_K1n7X@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

July 22, 2026 at 2:49 AM, "Andy Shevchenko" <andriy.shevchenko@intel.com =
mailto:andriy.shevchenko@intel.com?to=3D%22Andy%20Shevchenko%22%20%3Candr=
iy.shevchenko%40intel.com%3E > wrote:


>=20
>=20On Tue, Jul 21, 2026 at 09:03:08PM +0600, Siratul Islam wrote:
>=20
>=20>=20
>=20> Change personal email to the Linux specific one,
> >  to have a single and focused point of interaction.
> >=20
>=20...
>=20
>=20>=20
>=20> .mailmap | 1 +
> >  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml | 2 +-
> >  MAINTAINERS | 2 +-
> >  drivers/iio/proximity/vl53l1x-i2c.c | 4 ++--
> >=20
>=20Shouldn't DT patch be separated?
>=20
checkpatch.pl=20--strict has a warning saying that. But I remember=20
another=20similar patch from a few days ago where Krzysztof suggested all=
 the changes=20
in=20one commit.

Link: https://lore.kernel.org/linux-iio/a509d034-de90-4e46-bd7e-75f61002d=
6ba@kernel.org/

> --=20
>=20With Best Regards,
> Andy Shevchenko
>

--
Best regards,
Sirat
