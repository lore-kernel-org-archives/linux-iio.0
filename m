Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FF433BD6
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228828; cv=none; b=pY2nszUFu9uQ7aYBMaz6P0nG7//NqbugvpX6DYq8sy5Jp0ADmCfQPTBI+ZUhPhWyBEEBDRQGXngm5ipNlu65YxFEAiIVUbxs6PEdmcLpJTKJtBH14Fa4JrbIQKha+an7IN7cu8sf93rZ7b+NHrjXJDus8Y/JIDYVZ4LlLmOtHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228828; c=relaxed/simple;
	bh=J/h3jdBkHWaNRKTl1b5vRRph+T08oZfr2Pk80suUSeA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DB24ekBqrlnfohzu60mY5+R+0IxM8CQOOihlEgdgfbX7HOvhzNzrNeR2409zqF7chrJv3VJPXxzOQ/M+Na5O70QhUQjb2gPkOahLV+hMWJ/CcFGJ9eIvcu6avlnNDjzxljDG1DFhy156z2BY2C5IaXIg51tDmZXDNfd1HHTQRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FsQFgx3V; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FsQFgx3V"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784228814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3OiHw5mrVrJeY/RVtkYFzvs08Kl+7ie7z7ZLxL3i8U=;
	b=FsQFgx3VBpgG4JURiDx7McIRoKoQUT9w8XY985IjwmbIKiBJDYplJ6/W08oApTzHopw3xu
	lxMOTpNWah35uiM89c7GQZAEiyitvR85sAS9jCS3/BSh93220ms1q9aqYOcLU5sxKuw7+r
	u0lLeT+KNxggkthiOabJNpdFxkmzkwc=
Date: Thu, 16 Jul 2026 19:06:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <ea6f4eaeb0535d607d77920515e9cb1739266624@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
To: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "Jonathan Cameron"
 <jic23@kernel.org>
Cc: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "David Lechner"
 <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
 <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
 <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
 <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
X-Migadu-Flow: FLOW_OUT

July 16, 2026 at 8:18 PM, "Jorijn van der Graaf" wrote:

...
> > +#define QMC6308_AUTOSUSPEND_DELAY_MS 500
> >  You can call it QMC6308_SLEEP_DELAY_MS to align with other values.
> >=20
>=20I'd prefer to keep AUTOSUSPEND here: it names the mechanism the value
> feeds (pm_runtime_set_autosuspend_delay()) and matches yamaha-yas530
> and ak8974 in this directory.
>
I can find atleast 10 drivers in IIO that uses *_SLEEP_DELAY_MS postfix
for autosuspend delay value. So it's not a strong reason not to use it.
>=20
...
>=20>=20
>=20> Why not use a switch here instead of depending on 'i'. In it's
> >  current form, we would need to keep going back to check what the
> >  scales, odr, osr arrays look like.
> >  I would suggest following the same pattern as the QMC5883L driver.
> >=20
>=20>  The arrays could also be flattened like this if you follow the
> >  above suggestion.
> >  +static const int qmc6308_odr_avail[] =3D { 10, 50, 100, 200 };
> >=20
>=20The arrays are designated-initializer tables indexed by the register
> field code, and the same tables back read_raw(), write_raw() and
> read_avail() - so the value <-> field-code mapping lives in one place
> and the accepted writes stay in lockstep with the advertised
> _available values. Switches would duplicate that mapping per
> direction, and the flattened form only works once the tables stop
> being indexed by field code. I'd prefer to keep the tables, but if
> Jonathan wants the qmc5883l shape for consistency across the two
> drivers I'm fine changing it.
>=20
I=20know what the code is doing here. But I'm emphasizing readability. Yo=
u
are using 'i' with double responsibility. You already have #define
values that you are only ever using as array indecies. Using a switch
here combining with the #define(s) would be more readable and explicit.=
=20

But=20it is more about preferences and following existing conventions
(i.e., the sibling driver). Jonathan, Andy, or David may have more idea
about the "preferred" way to do this.
>=20
...
>=20
> Thanks,
> Jorijn
>

--
Best regards,
Sirat
