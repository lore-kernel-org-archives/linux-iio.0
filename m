Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68F1A5B9E;
	Fri, 20 Feb 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584921; cv=none; b=Cpvkmxu/dhaCsV/6QQ/YT/gcZqmjNlSegDB/AxhXiaMjhBrBvw1uxWI4CNT6YGh2i1fTilCgJ5+SoteRFx4UJoSRtHdfjDf4P8hlelxPkY495r41l/yu1TF2O/NKEr7rBrheGI0IFwceIV8lBLDjaSTXEG1aCdOd84YSyJTCHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584921; c=relaxed/simple;
	bh=ZqqOhwpmFAXlPD43ybfPl+1GeeC49bQa//K0vDr2MsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0uVHSgrMZ3isk6GuhtT158XiBs6eP56DvxXBFVOYYNzCAUWVyckMZQLDWfBK1Wf779PFwX/LNQrenCKGoM8GzjYWxLt6uq4qPG1c4oFVEJHojfPgwvHLTrCO9A0WIZjG6DFAW+o4hfwrxl8ryLjtzexIeQsfQRZHiycr707FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6gLqD1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6gLqD1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1393DC116C6;
	Fri, 20 Feb 2026 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584921;
	bh=ZqqOhwpmFAXlPD43ybfPl+1GeeC49bQa//K0vDr2MsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6gLqD1o4tVut0u2Sd/+47kLZpa+Zx8Oy3bduVxOB3b8BnHaGE1KsySPryF15yIv4
	 AYti2d3/YjoTRzbK2sOrNKic2Ar2lZ7YqBqoXgNmO29FT6CHPBqbXgq/auCu0XUect
	 nLPD7Earp049iUhxnD1HALowRixZldrK27SWPN7tKXfD0ANQ1p80f6OAYZ3rJup3IX
	 lxBhv3DzHeqW+ReJGoyw6Ty+ekUM69E+uwPWFjaQY7cPtNdjFYC5nrk69FH3Ln5A/2
	 kSiNAiphGfFuSSP0pCajOvsde2IjP4Eg83887TKEkFhCEZiMLhnX+CQ5By0X7mka94
	 k4gT1/pUJpMyQ==
Date: Fri, 20 Feb 2026 10:55:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <20260220105507.30a2f7ec@jic23-huawei>
In-Reply-To: <20260218095820.00005750@huawei.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
	<aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
	<aZSD-3WIVwT6XYWX@smile.fi.intel.com>
	<a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
	<aZWI-80-K7xfuEBY@smile.fi.intel.com>
	<20260218095820.00005750@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Feb 2026 09:58:20 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Wed, 18 Feb 2026 11:40:11 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Wed, Feb 18, 2026 at 09:12:03AM +0000, Nuno S=C3=A1 wrote: =20
> > > On Tue, 2026-02-17 at 17:06 +0200, Andy Shevchenko wrote:   =20
> > > > On Tue, Feb 17, 2026 at 01:47:59PM +0000, Nuno S=C3=A1 wrote:   =20
> > > > > On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote:   =20
> >=20
> > ...
> >  =20
> > > > > I'm ok with this but as long as we get some consistency agreed on=
. So far,
> > > > > IIRC, the policy was to check for the NULL case even for the case=
s where that
> > > > > was not possible to happen.   =20
> > > >=20
> > > > Is it kernel-wide policy?   =20
> > >=20
> > > Nope... Just IIO IIRC. Actually, I'm pretty sure we had patches in th=
e past
> > > just adding the check.   =20
> >=20
> > Like you said we need clearer policy.
> >  =20
> > > But again, I'm fine with the above as long as we are consistent from =
now on.   =20
> >=20
> > Exactly!
> > Jonathan, David, others? =20
>=20
> As long as no compilers or static analyzers trip up on it and start spout=
ing false warnings,
> I'm fine with not checking these. I'm not sure I'm bothered about going t=
hrough the tree
> removing the checks though.   This one is so small I don't mind if it get=
s copied
> into new drivers. If this is all that needs tidying up I'll tweak it whil=
st applying.
>=20
Applied.  I also added a link tag to this thread, to say we had
agreed to make it policy in IIO to not have these checks.

Thanks,

Jonathan

> Jonathan
>=20
>=20
> >  =20
>=20

