Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A84329E5D;
	Tue,  1 Sep 2026 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225541; cv=none; b=JlBT2fWYzWkdhpJDZhJ9L2BX4u/Nk++MFWGLLV4FcPTbMnYEbopk2LgRLvL+0x1UiqO6VNJ1K296X8grEWQi+2ktiLIPFTOM2ilzQ0Qblh76RJuhjtQslCuc4M+2QUB7SKkVPK6SczVoZOh8sZtN5cfRN6eDUoQAEukWYdeF8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225541; c=relaxed/simple;
	bh=amoc/ZyGxFqvGFAPCp1jPJZegzAAj+DNQdmh/2Qzl+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ib45BQQc/Ow+8HZsHJ8Y3Ct5MW2E7qCa3BImHC4nBHPztT1yrEqtm0UKAyLVqJUVx7C20+DCPPowyEK9353GEXUS6YiUbTIJflQq//JiHPBr626HWJrqZ2e5sgDV1eSgeRVPRU4Kgx6hhPko9aIpJ1YP2RJ1vq8oUIgW59hhZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXTX43n3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXTX43n3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2511B1F000E9;
	Tue,  1 Sep 2026 01:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225534;
	bh=VEw+Ox0DghdKeZ8X4o3noEp8fzw25Y32JHB4BzY58wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EXTX43n3Mp30tiy8dMe/16L2DfBWjbn9CXvP5TGjW6VYhMZzLqXGV2KCjnNf7G3c+
	 EzAgGHAubJSyCedCpY9KUZnsCnmPuLXJ6bVCldZFW+989JzUwkwbtY0tFTnrw+Vpf1
	 zA87pqo54fknw1bhvcIofjHM/xOuX37XnSOJSB9hZOTfjYOSTjhishxKVQ2GTQFfGo
	 U9Wgu8Ikd2bFPZBC3kVVxzYP2LBhDu3kh8qlPFxQ9exzOva+dpjJ6KinxPlaam4ceQ
	 vtokMVS1GxwhOnR3tpKvo8DYxda7YMe++e/DUT6V/M6Xo9EAGricAPjH8h1Ex+S9xT
	 9mGn23LBSHCqA==
Date: Tue, 1 Sep 2026 02:18:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Vladislav Leonov <vlad@zlab.su>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Simon Glass <sjg@chromium.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix RV1106 SAR-ADC support
Message-ID: <20260901021846.59b71f5b@jic23-huawei>
In-Reply-To: <5330090.ejJDZkT8p0@diego>
References: <20260823122039.20831-1-vlad@zlab.su>
	<20260831025557.6ee7c42e@jic23-huawei>
	<5330090.ejJDZkT8p0@diego>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Aug 2026 10:17:17 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Jonathan,
>=20
> Am Montag, 31. August 2026, 03:55:57 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Jonathan Cameron:
> > On Sun, 23 Aug 2026 15:20:31 +0300
> > Vladislav Leonov <vlad@zlab.su> wrote:
> >  =20
> > > This series fixes the support for the RV1106 SAR-ADC in the
> > > rockchip_saradc driver and its device tree bindings. =20
> >=20
> > I debated how to apply this.  Technically patch 3 is a fix, 2 is an ena=
bler
> > and 1 is also a fix, but one for something that we just effectively pat=
ched
> > out from running in patch 3.
> >=20
> > So in the end I'm thinking take this the slow path for next cycle.  Sho=
ut
> > if anyone thinks this should go in during the -RCs and whether all 3
> > should do so or just patches 2 and 3 (leaving us without driver support=
 for
> > now).
> >=20
> > Applied to the testing branch of iio.git =20
>=20
> I guess I should shout then ;-) .
>=20
> DT-Binding patches are sort of independent of the driver change and
> are considered API which should not change after the fact.
>=20
> Our DTs (but also ones possibly contained in firmware somewhere) are
> validated against the binding and it seems the correct compartible goes
> from=20
>     "rockchip,rv1106-saradc", " rockchip,rk3588-saradc"
> to
>     "rockchip,rv1106-saradc"
>=20
> As the fixed commit is part of 7.3-rc1, I guess it would be nice to
> have patches 2+3 in 7.3 and patch 1 can wait for 7.4 .
>=20
> We don't need the driver support (dt-nodes just doesn't bind to
> anything), but it would be nice to not proliferate the wrong binding in
> an actual release.

Ah. I should have checked when the original bug went in.
As it's this current cycle, what you say is indeed an easy fix.

Applied 2-3 to the fixes-togreg branch and left 1 in the testing
branch for 7.4.

Thanks

Jonathan

>=20
>=20
> my 2ct :-)
> Heiko
>=20
>=20
>=20

