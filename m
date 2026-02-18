Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303633D4E6;
	Wed, 18 Feb 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408713; cv=none; b=mfex8kFg0QVd28pIEtFbf2TSsAvu3k/nEviiKNhPr+H/tXdpTzq217cub3XqBpSSDnVxh2bgo0Vr2hv1gmHRodww+njjKqnqF113qV9EygSMSjdjVfvbSzdy2c2OQVMXKU3wMJ3znL2NjPvcMd5v+lMV4YbklBQw7lZSxUqmfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408713; c=relaxed/simple;
	bh=9DayDV9oZ5j5TDoxcfORCRosMUt8klKe6ohZ2kmh+tE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxww+1WzXd6Vj3lowSpvXB106qUlqZ9zbMFDPBlK7ORegkjYkeBpXOxUrEut1P7IkopHZKYFAYrTX8OMxcaAmDdkzCMviZWrwLRGKSTXI3RsfWwLDXu3dyonUvs+bEaQkXrSPEFG1x7dJ8okZdlhprH5WJbNOJxDjcDLJ3IcFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fGBlQ5n7pzHnH5X;
	Wed, 18 Feb 2026 17:57:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id AAAE740570;
	Wed, 18 Feb 2026 17:58:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Feb
 2026 09:58:21 +0000
Date: Wed, 18 Feb 2026 09:58:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alisa-Dariana Roman
	<alisa.roman@analog.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <20260218095820.00005750@huawei.com>
In-Reply-To: <aZWI-80-K7xfuEBY@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
	<aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
	<aZSD-3WIVwT6XYWX@smile.fi.intel.com>
	<a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
	<aZWI-80-K7xfuEBY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 18 Feb 2026 11:40:11 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Feb 18, 2026 at 09:12:03AM +0000, Nuno S=E1 wrote:
> > On Tue, 2026-02-17 at 17:06 +0200, Andy Shevchenko wrote: =20
> > > On Tue, Feb 17, 2026 at 01:47:59PM +0000, Nuno S=E1 wrote: =20
> > > > On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote: =20
>=20
> ...
>=20
> > > > I'm ok with this but as long as we get some consistency agreed on. =
So far,
> > > > IIRC, the policy was to check for the NULL case even for the cases =
where that
> > > > was not possible to happen. =20
> > >=20
> > > Is it kernel-wide policy? =20
> >=20
> > Nope... Just IIO IIRC. Actually, I'm pretty sure we had patches in the =
past
> > just adding the check. =20
>=20
> Like you said we need clearer policy.
>=20
> > But again, I'm fine with the above as long as we are consistent from no=
w on. =20
>=20
> Exactly!
> Jonathan, David, others?

As long as no compilers or static analyzers trip up on it and start spoutin=
g false warnings,
I'm fine with not checking these. I'm not sure I'm bothered about going thr=
ough the tree
removing the checks though.   This one is so small I don't mind if it gets =
copied
into new drivers. If this is all that needs tidying up I'll tweak it whilst=
 applying.

Jonathan


>=20

