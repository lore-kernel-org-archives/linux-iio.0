Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F237FF45;
	Tue,  5 May 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978458; cv=none; b=AwuSrIhk/WCVm96bOOOda+QabhSVRQGO3Dn9v/rJyKfjxAZCWhp8o/p0OP10g1be/GOCGtdRVrpw2dFHH6l/Lb3pyWrTxznGh2lU+6JZz/vatM23k0hlqyoZUc+3Jki9KY3YwXMg/B1aOOc5SzVzGgBRCHC4aw79uWfigSf5B8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978458; c=relaxed/simple;
	bh=h/Be7nF9EBlrsnPsTlU1laE4YxU7k5B/QMoGvgf8xCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKwWRzAQ00tZWhyfSQ3U4L5XnHWCoufAj9o8Ja/rJ0mRUUhaLsvwa/aRc3Auv5m4Zsl6sQAFQH2yl7j8m2lA8y7Z4FzDiNQg4fGUkdObz3uKvJ/rb+FDudp/dO6Pa8g9qtAL6Dg2+yOX+2VtdvDYYK7G6C8iU1qvRIstvkqHLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj8dXPew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj8dXPew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D61C2BCB9;
	Tue,  5 May 2026 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777978458;
	bh=h/Be7nF9EBlrsnPsTlU1laE4YxU7k5B/QMoGvgf8xCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zj8dXPewUozV7qjteyly2yPmzw+6/Yzig4D3WAnvqCnhvYGl3OcIcHzHd1p+ccgyp
	 vz+sPIQaxtbWz5Gh/gMfOJxORYx8BSPo0O4JAEU6ZIe8U4uBEleFj2R1DERmaNJW/M
	 CYTMdaoFMXjDcreAwYDDdK2+nMFpOWRLtykLxdMEqSH3KzWfWqBJO/LLTHVjnCoB9I
	 veX1jvz9pjtNT+F+QS/cNy2r09D6GnUgI3eay2QhgWUj1KHpuXOplf3RulE0eVtIS1
	 d5+cVmxZhN39+Esp1lZAXYhPucuvBQMyC6oeAx9rdA7ul5RXLpIR18ziS3wOk/nQdo
	 csp7l4miZNH1A==
Date: Tue, 5 May 2026 11:54:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Message-ID: <20260505115409.44245db6@jic23-huawei>
In-Reply-To: <afmyqE6-XcT-SRt3@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
	<20260430190642.3434650-3-sanjayembedded@gmail.com>
	<20260504172457.4d7c7390@jic23-huawei>
	<AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
	<afmyqE6-XcT-SRt3@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 12:04:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 08:00:23AM +0530, Sanjay Chitroda wrote:
> > On 4 May 2026 9:54:57=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.or=
g> wrote: =20
> > >On Fri,  1 May 2026 00:36:39 +0530
> > >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote: =20
>=20
> ...
>=20
> > >> -AD738X ADC DRIVER (AD7380/1/2/4)
> > >> -M:	Michael Hennerich <michael.hennerich@analog.com>
> > >> -M:	Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > >Specific maintainer. Why is it going? =20
> >=20
> > I'm assuming that to avoid de-bounce issues from *@analog.com domain, w=
e are
> > adding linux@analog.com mailing list as primary contact. with that in m=
ind,
> > this series drops all entries which match the wildcard and have analog =
domain
> > maintainer or reviewer while keeping the rest as unchanged. =20
>=20
> But it's removing people behind their will! You really should do this
> case-by-case. Some of the people who left the company might still want to
> follow the driver or even maintain it. What you should do is also pay att=
ention
> on the Supported vs. Maintained which makes a huge difference on the
> responsibility and financial side of the Subject.

Some of this was in response to discussion with on specific person.
That one is fine but be very careful beyond that.
Probably best to add a link tag back to that discussion as well.


>=20
> Btw, Have you consulted with your Legal department on all this?
>=20
> > >> -R:	David Lechner <dlechner@baylibre.com> =20
> >=20
> > Additionally, When David is list as reviewer in individual driver entri=
es, I
> > consider as redundant part; All IIO subsystem drivers/iio* already cove=
red by
> > top level entry, which includes Andy and David as reviewer.
> >=20
> > Summary of changes in series:
> > - analog domain specific entries are dropped and catch with linux@analo=
g.com
> > under ADI IIO section. =20
>=20
> No, you should give a good explanation why in each case. Yes, you may com=
bine
> the cases when people left the company, but you also need to
> - consult with your Legal
> - consult with those who left on what they wish
>=20
> None of them seems done so far. So, again BIG NAK from me on this series!
> Rework them and even part that drops the entries that already have the sa=
me
> maintainers as current ADI level ones (assuming adding Nuno in a separate
> prerequisite patch) is good to go.

I'm not keen on using the top level reviewers as enough to drop an entry.
Where Nuno and David have specific driver entries the lifetime of those
may well be different to the top level one.  So leave those alone.

The only ones I don't mind falling back to the top level catch alls are
those where we are dropping a reviewer / maintainer (and they were asked)
+ there is nothing else listed - hence the higher level entry is the
only source of information.

A wider scrub is not appropriate.

>=20
> > - Non analog devices reviewers and maintainer is unchanged for each dri=
ver entry.
> >=20
> > Further, I also agree with adding Nuno S=C3=A1 as a maintainer in the t=
op-level
> > ADI IIO entry, so that all drivers are maintained via the mailing list =
with
> > his oversight.
> >  =20
> > >> -S:	Supported
> > >> -W:	https://wiki.analog.com/resources/tools-software/linux-drivers/i=
io-adc/ad738x
> > >> -W:	https://ez.analog.com/linux-software-drivers
> > >> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > >> -F:	Documentation/iio/ad7380.rst
> > >> -F:	drivers/iio/adc/ad7380.c =20
>=20

