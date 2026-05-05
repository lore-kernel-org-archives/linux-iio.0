Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD748BD30;
	Tue,  5 May 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997738; cv=none; b=TWFOVZzwAibmE8L2RosGh/X0DvF1tR5Wtx90Ijcp8Gz6rdtt6803rp6cArkB2aJW2+t6EKhI/GhoUvVEBnoaWERSlDdpIO5EnNaU9rAIpUXwsI/fSjOnKZ17QseUBen7eiEFeZPQP9wY40OtLY8yGjYR+gBMz/6rvdHd/ASIBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997738; c=relaxed/simple;
	bh=U9r0lM9QL319w7ggAfBoVETiqwCxEdHZUsK4+OoLP+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7FHXl/0HD57ZILr9IM+A4wL4rAykYbgaVEVGDGdbcn5rHnrtnf+RrnE0FIFozyVk/Rrs71a26dnyOpp04aLTZb0qB5EUqCJ6ad5fpFfI8oY0enzsuMjrCTGM8ObYPRIXUAogiYJFPjRlhMwqwsQfswLTBEahRPaq6b6E9pHNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erRYiSis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erRYiSis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27006C2BCB4;
	Tue,  5 May 2026 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997737;
	bh=U9r0lM9QL319w7ggAfBoVETiqwCxEdHZUsK4+OoLP+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=erRYiSis+yvWdejzrlmhbEQ/gb+3M0ziCjtyyG8bEUarcDsGqHUvtxahvsLaXouLk
	 dHBZsIiOAfDL0BYmgXke3xO1PJ7CZJJ2QB7195j4nOfSzg+KkfaosXahWd9+/QTqPV
	 30Aqd3W244kEwe1fTRo2Lf8TC2B9uI+m+xRRrB+lyy7uggSudE0a7enOIWanHjlxxa
	 Ug9JODnftzvxKfxh+CjEsAst7Sqi4UNDw4Ycceyb5dyvxOfNn69QM1hIkUZsCIvtlw
	 cMS9bh2RCWHZE6RPN3a+b1VL7zRohi0MzXB0QCeZiiu0cfeF8H6NwaWWurZSgTj3Ot
	 wkEYKFhIEpHNA==
Date: Tue, 5 May 2026 17:15:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Message-ID: <20260505171529.50eae32a@jic23-huawei>
In-Reply-To: <afnliKBrxlkx1Vmq@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
	<20260430190642.3434650-3-sanjayembedded@gmail.com>
	<20260504172457.4d7c7390@jic23-huawei>
	<AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
	<afmyqE6-XcT-SRt3@ashevche-desk.local>
	<20260505115409.44245db6@jic23-huawei>
	<afnliKBrxlkx1Vmq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 15:41:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 11:54:09AM +0100, Jonathan Cameron wrote:
> > On Tue, 5 May 2026 12:04:40 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Tue, May 05, 2026 at 08:00:23AM +0530, Sanjay Chitroda wrote: =20
> > > > On 4 May 2026 9:54:57=E2=80=AFpm IST, Jonathan Cameron <jic23@kerne=
l.org> wrote:   =20
> > > > >On Fri,  1 May 2026 00:36:39 +0530
> > > > >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:   =20
>=20
> ...
>=20
> > > > >> -AD738X ADC DRIVER (AD7380/1/2/4)
> > > > >> -M:	Michael Hennerich <michael.hennerich@analog.com>
> > > > >> -M:	Nuno S=C3=A1 <nuno.sa@analog.com>   =20
> > > > >Specific maintainer. Why is it going?   =20
> > > >=20
> > > > I'm assuming that to avoid de-bounce issues from *@analog.com domai=
n, we are
> > > > adding linux@analog.com mailing list as primary contact. with that =
in mind,
> > > > this series drops all entries which match the wildcard and have ana=
log domain
> > > > maintainer or reviewer while keeping the rest as unchanged.   =20
> > >=20
> > > But it's removing people behind their will! You really should do this
> > > case-by-case. Some of the people who left the company might still wan=
t to
> > > follow the driver or even maintain it. What you should do is also pay=
 attention
> > > on the Supported vs. Maintained which makes a huge difference on the
> > > responsibility and financial side of the Subject. =20
> >=20
> > Some of this was in response to discussion with on specific person.
> > That one is fine but be very careful beyond that.
> > Probably best to add a link tag back to that discussion as well. =20
>=20
> Or at least mentioning this in the commit message / cover letter.
>=20
> > > Btw, Have you consulted with your Legal department on all this?
> > >  =20
> > > > >> -R:	David Lechner <dlechner@baylibre.com>   =20
> > > >=20
> > > > Additionally, When David is list as reviewer in individual driver e=
ntries, I
> > > > consider as redundant part; All IIO subsystem drivers/iio* already =
covered by
> > > > top level entry, which includes Andy and David as reviewer.
> > > >=20
> > > > Summary of changes in series:
> > > > - analog domain specific entries are dropped and catch with linux@a=
nalog.com
> > > > under ADI IIO section.   =20
> > >=20
> > > No, you should give a good explanation why in each case. Yes, you may=
 combine
> > > the cases when people left the company, but you also need to
> > > - consult with your Legal
> > > - consult with those who left on what they wish
> > >=20
> > > None of them seems done so far. So, again BIG NAK from me on this ser=
ies!
> > > Rework them and even part that drops the entries that already have th=
e same
> > > maintainers as current ADI level ones (assuming adding Nuno in a sepa=
rate
> > > prerequisite patch) is good to go. =20
> >=20
> > I'm not keen on using the top level reviewers as enough to drop an entr=
y.
> > Where Nuno and David have specific driver entries the lifetime of those
> > may well be different to the top level one.  So leave those alone. =20
>=20
> True, but if the people who maintain the certain driver(s) are okay with =
the
> collapse, why not allow that?
Agreed.  Not something to do preemptively though!  I wouldn't propose it
for instance but if they suggested it different question :)

J
>=20
> > The only ones I don't mind falling back to the top level catch alls are
> > those where we are dropping a reviewer / maintainer (and they were aske=
d)
> > + there is nothing else listed - hence the higher level entry is the
> > only source of information.
> >=20
> > A wider scrub is not appropriate.
> >  =20
> > > > - Non analog devices reviewers and maintainer is unchanged for each=
 driver entry.
> > > >=20
> > > > Further, I also agree with adding Nuno S=C3=A1 as a maintainer in t=
he top-level
> > > > ADI IIO entry, so that all drivers are maintained via the mailing l=
ist with
> > > > his oversight.
> > > >    =20
> > > > >> -S:	Supported
> > > > >> -W:	https://wiki.analog.com/resources/tools-software/linux-drive=
rs/iio-adc/ad738x
> > > > >> -W:	https://ez.analog.com/linux-software-drivers
> > > > >> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > > > >> -F:	Documentation/iio/ad7380.rst
> > > > >> -F:	drivers/iio/adc/ad7380.c   =20
>=20

