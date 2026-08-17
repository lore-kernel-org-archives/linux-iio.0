Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26365285058;
	Mon, 17 Aug 2026 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935261; cv=none; b=GTzC/Mc8IsvVxmyv/LqRiRI1tRoG1oSaCl/1NGQyUOFp/5tCevD/QKyzd4P8143G6XDlqxDL/NwF3/rIPLBGdTkaTfnQPBzjrJwsLEnyf/f0YgMnfJxkkGsXhrYARUatMa36wicEQ+ILWd+Jqk6zJyIQHv11znCxGjKxDG8IEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935261; c=relaxed/simple;
	bh=kg2sIjBJhA4XHx46529T54OBFttW0iChZqu/4i2zjZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZDNfQYT6GvlB6G2jYOPtpge+56vk/40Mk2+ZbInSm06WKPcJnbnszmqjT8tBSul04uMTSwEwaN1X6CmnfM3umvFsvZQSuB2e1Htjqdp1oRmLWPaK9AkhsGg+lAq8tUbjfpMuWAlpngr78Ec910ARC4lgWjTZeA9ceHsdpbxGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icS3rPx+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icS3rPx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5301F000E9;
	Mon, 17 Aug 2026 02:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786935259;
	bh=aSE+R53RZjj2pwacXJZ84bfkyt9e4SbIfWux452Smx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=icS3rPx+L0C4RP4ehIm5dM81RfBnMgfZdEqNHpRyjrocuU+SB/lzIsHxNQ9vlltk5
	 ssqLgOeH36PTIJzfUj6dB1LpfE2kRs4wXopL/YdgPDRiT1its6xQm0BTsmfxxeq2si
	 DKMvjij5BQoB0jNvhNgsMZf4peYYlbZzbXqpTEoIFZEJfHmxKdTwKeAa066VJbsUcM
	 x4fqPjZ06KGVcNjftZ8criRuoq6dYo0elSGIrMs0gmcJJgTQ772Pcfn3+hsJU7Jqbr
	 cprIamGbEXdei7s5kg3DrG2OmY3JO8KZT+5Oy0jwTK9/l9Ctb8TMOsl4lZEj3+oHHc
	 8nRufzjsMQ+AQ==
Date: Mon, 17 Aug 2026 03:54:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Maxwell Doose
 <maxwell@maxwelld.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Tomasz Duszynski <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Message-ID: <20260817035414.496912f4@jic23-huawei>
In-Reply-To: <an7W8VKXrIKzl9xt@ashevche-desk.local>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
	<20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
	<DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
	<CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
	<DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
	<an7OSM04kiviu9xL@ashevche-desk.local>
	<CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
	<an7W8VKXrIKzl9xt@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2026 11:50:57 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Aug 14, 2026 at 10:25:32AM +0200, Joshua Crofts wrote:
> > On Fri, 14 Aug 2026 at 10:16, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote: =20
> > > On Thu, Aug 13, 2026 at 09:47:00PM -0500, Maxwell Doose wrote: =20
> > > > On Thu Aug 13, 2026 at 3:47 PM CDT
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > > > On Thu, Aug 13, 2026 at 8:52=E2=80=AFPM Maxwell Doose <maxwell@ma=
xwelld.cc> wrote: =20
>=20
> ...
>=20
> > > > > Note, that kernel.h shouldn't be there at all, but that is defini=
tely out
> > > > > of scope here. =20
> > > >
> > > > Makes sense. I wonder if it may be worth doing a patch series remov=
ing
> > > > all of the kernel.h inclusions in IIO all at once (or maybe some dr=
ivers
> > > > have a legitimate use for it, but that seems highly unlikely). =20
> > >
> > > Yes, for sure! I have simply had no time to do it myself, but I have =
a low-prio
> > > item in my always grown TODO list. So, if you do that, I will really =
appreciate!
> > > But be careful, the actual patches should care about the whole bunch =
of the
> > > inclusions, and not just about kernel.h. This means each driver shoul=
d be
> > > carefully inspected in accordance with the IWYU principles. =20
> >=20
> > This will be a gruelling task (implementing and reviewing), but perhaps=
 it
> > would be easier to do one sensor type at a time instead of the entire
> > subsystem. =20
Absolutely. One patch per driver for this and not more than 10 ish
drivers in a series or out for review at a tiem.  This stuff is still quite
tricky to review, even with details on why each header change below the ---

Also precursor patches for any significant reordering to put them in alphab=
etical
+ block for IIO headers just to make it easier to read the patch that cleans
up what is included.

I've done some of these as have many others. It's worthy work but slow to
do!  I'd suggest we leave it as a newbie task, but it requires more underst=
anding
than typical for one of those - so if you want to take it on (probably take
a year or more to finish given review bandwidth!) then that would be most
welcome.

>=20
> I would start from the easy cases where kernel.h is just not used at all =
(not
> even as a "proxy" header). Then continue with the rest.

yeah - if there are cheap ones were we can just drop it and now do the
rest of the work then I don't mind seeing those on their own.

Jonathan
>=20
> Joshua, note, it's only about the drivers that have explicit kernel.h
> inclusion. In general the entire IIO needs to be revisited, indeed.
>=20
> $ git grep -n -lw linux/kernel.h -- drivers/iio/ | wc -l
> 234
>=20
> $ git ls-files | grep ^drivers/iio/.*\.c$ | wc -l
> 707
>=20

