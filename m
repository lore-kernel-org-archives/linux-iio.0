Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D23E317A;
	Mon,  4 May 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911776; cv=none; b=uIMS70XhW8KKrMB42fKJeeMX0LSzsgyRiseZWdRLiEq//6dpQkQm3t5w/jXutG/eEZsMDlX76NP8YI/jrjaoY+ESjWZeTDw2Pks7QKg+TfAzeWRFrtvUjG++fLfefJ2of7UQJEnXCUue1ZN7zOSWEmYXLx3QHpGMHrHbS6+rB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911776; c=relaxed/simple;
	bh=YaXrA8oKmv+2ypzFhIVGW0cgOsis46fnD7EeWxBbzJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBD91ySuPbGd8Y5Dy5ua3ImoBk/0ZIC4r/T8veiIVC2gbgFB3erAK/rQwmjeZKmjpf8mi2PcBFppOJMtWFN68g7SxxMfHMGiEP22mhejiHPQlOEaFqZDL92hWgJ64OaOnxXezArPs5HxuhJT/J2Hb2yakzNMuCa/VwdUXX37O1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrmYeOhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrmYeOhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2409C2BCC4;
	Mon,  4 May 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777911776;
	bh=YaXrA8oKmv+2ypzFhIVGW0cgOsis46fnD7EeWxBbzJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TrmYeOhQo0Fz1CFPV6Sz+1vOJQBiWoXxqW715/kL4BLhdWwKtiowyj8VOOaZD3inG
	 7CiXyo+L8+RQJk+Q68GVgn0P2XaRuY2lz+pOEjQlAmo5mm9MMOio18vzLw59YD3d5i
	 QeDHIWVKiLo86uZ+MXJ/kMJknSVpmadw2cEVITdZETQ5DXmN5u6ZYE5lsEeN/3TgHn
	 nSXyEdX2XDleuHTLd8M/vzKxTuedyBHR8l7htiHFv7tU46KU0xW3RaS0BIwfs/2Ha0
	 E7CTYDjz/SeBQU6p5l6DafCRZxXgVXlaeoEclT+6h8yzoj44MBzdkvHpo7o+HEzLXb
	 fjLtDtBszyZIw==
Date: Mon, 4 May 2026 17:22:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 lars@metafoo.de, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] MAINTAINERS: Update Analog Devices IIO drivers
 entry
Message-ID: <20260504172247.58e833d8@jic23-huawei>
In-Reply-To: <afhMWfXd6yVUsDDo@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
	<20260430190642.3434650-2-sanjayembedded@gmail.com>
	<d859d9d22fea4af4dd23221d407aff055ad52524.camel@gmail.com>
	<afhMWfXd6yVUsDDo@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 May 2026 10:35:53 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, May 01, 2026 at 10:05:11AM +0100, Nuno S=C3=A1 wrote:
> > On Fri, 2026-05-01 at 00:36 +0530, Sanjay Chitroda wrote: =20
>=20
> > > Lars-Peter Clausen is currently busy and is therefore removed from the
> > > ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.
> > >=20
> > > Add Analog Devices mailing list as contact for the ANALOG DEVICES INC
> > > IIO DRIVERS entry for coverage support. =20
>=20
> ...
>=20
> > > =C2=A0ANALOG DEVICES INC IIO DRIVERS
> > > -M:	Lars-Peter Clausen <lars@metafoo.de> =20
> >=20
> > I honestly got the impression that for the entries that had individual =
maintainers,
> > we would not touch them but maybe I lost track of the discussion. Anw=
=C3=BDways, if we are
> > just relying on this, then I need to put in here given that these day I=
'm the one
> > taking more care of the mainline stuff. =20
>=20
> > > =C2=A0M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > > +L:	linux@analog.com =20
>=20
> My reading of this patch that you, guys (ADI), have a public ML / distrib=
ution
> list that you manage now inside the corp. Whoever is in that list is
> automatically will be a potential reviewer. However, it doesn't prevent
> (and I actually fully support that) that ADI nominates more Designated
> Reviewers and/or Maintainers.

My intent was:
1) This entry one got fleshed out to add the list - given it's a catch all
   that 'should' get added to all ADI related patches (similar to the catch
   all IIO list adding the linux-iio@vger.kernel.org list and myself +
   the 3 reviewers listed there).
2) Any ADI entries that due to stale emails would have no one listed,
   were removed so that this catch all was the source of truth.

I'm very happy if Nuno is willing to be added to the top level ADI IIO
entry now Lars-Peter is off doing other fun things.

I'm also very happy to see any additional individual driver entrees that get
more people on the hook for reviewing :)

Jonathan

>=20
> > > =C2=A0S:	Supported
> > > =C2=A0W:	http://wiki.analog.com/
> > > =C2=A0W:	https://ez.analog.com/linux-software-drivers =20
>=20

