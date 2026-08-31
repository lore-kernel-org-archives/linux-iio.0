Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC83CF95E;
	Mon, 31 Aug 2026 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164263; cv=none; b=VZlGwLIV5P13R7eLNh4giI/+XrZM7GvxWiMfFmx/UCMUgzW6oKp5OlC7+uJqe1YmuaN4mWSDLBs6wz1Nz8azVldp2oO1WgatL9QUtjp4kWrxU2Yl0cRcTIEIwAE3EFRaN5E7UiVlTT6tkRC+g7PLpuzVQuz7cdJBeNf4N0sexX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164263; c=relaxed/simple;
	bh=2ycgMH4YJMa6HV8tboy5Bk6EQZIJW3yQvgGMEFF97pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iihyLc+5hSpBWkQQeuMPAYlRlP+MYxRCjUTO+P2g9LW1fE+jk1+yHM/i2Fp7ghcQzrc477egzc6tnHkR5lxwHJhXEjIDHQMqroqCTcJdk4MKO28NA6B0JVgC4o2yOrWtmLTRrgkJaiEWlUBMyF1CteyMPfzck1lt4ZL2QHEoH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yRaPNrA4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yRaPNrA4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=n0oCvf1fmqu014f3i21FkaEwfd+AIiy8ZD6OncmIF9c=; b=yRaPNrA40oj+waTkRbZd89GD0o
	cvG0YR6TeYkX7+4FfW2Ezf3DW6rE7R4cMPwZznSoqLmfjEfRgAV3q2rQ8ccyoPyGFDRCV4QnHpZ4w
	7xn6fQ6RcmtGCFmh8LaZCFQpfeZszWx1Weo2wNddolJ/6A5BRbJGypZ4UDSgfGNl2A3JlNrCGxaJW
	/Q83tn31R+EVlmNmZ4BSkP3oeC/hopDgCUf/9hu68Bd/Lno1vSOwLRXKecKu8ZfhCUGKod+bWPxCw
	7exQzTwKOpXFbW6BNefw6sEbQDJLDIHm5p8i2kfdwBcnKtRz55qhSbo8vvhsS1c439pPQ33WyXXle
	WRCvGs5w==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vladislav Leonov <vlad@zlab.su>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Simon Glass <sjg@chromium.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix RV1106 SAR-ADC support
Date: Mon, 31 Aug 2026 10:17:17 +0200
Message-ID: <5330090.ejJDZkT8p0@diego>
In-Reply-To: <20260831025557.6ee7c42e@jic23-huawei>
References:
 <20260823122039.20831-1-vlad@zlab.su> <20260831025557.6ee7c42e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Jonathan,

Am Montag, 31. August 2026, 03:55:57 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Jonathan Cameron:
> On Sun, 23 Aug 2026 15:20:31 +0300
> Vladislav Leonov <vlad@zlab.su> wrote:
>=20
> > This series fixes the support for the RV1106 SAR-ADC in the
> > rockchip_saradc driver and its device tree bindings.
>=20
> I debated how to apply this.  Technically patch 3 is a fix, 2 is an enabl=
er
> and 1 is also a fix, but one for something that we just effectively patch=
ed
> out from running in patch 3.
>=20
> So in the end I'm thinking take this the slow path for next cycle.  Shout
> if anyone thinks this should go in during the -RCs and whether all 3
> should do so or just patches 2 and 3 (leaving us without driver support f=
or
> now).
>=20
> Applied to the testing branch of iio.git

I guess I should shout then ;-) .

DT-Binding patches are sort of independent of the driver change and
are considered API which should not change after the fact.

Our DTs (but also ones possibly contained in firmware somewhere) are
validated against the binding and it seems the correct compartible goes
from=20
    "rockchip,rv1106-saradc", " rockchip,rk3588-saradc"
to
    "rockchip,rv1106-saradc"

As the fixed commit is part of 7.3-rc1, I guess it would be nice to
have patches 2+3 in 7.3 and patch 1 can wait for 7.4 .

We don't need the driver support (dt-nodes just doesn't bind to
anything), but it would be nice to not proliferate the wrong binding in
an actual release.


my 2ct :-)
Heiko



