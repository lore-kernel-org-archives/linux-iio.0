Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848E3603EF;
	Fri, 24 Jul 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928732; cv=none; b=dbQSAN08BA5bPuV4W9tpHgb0zozaRUZHFBtz1ZTXB2LDEbli8b28/rChXQEnUTeP4OdWQLc5Jsmqj1bhsZaqJmoiSpk96s94h8a9FvGQURboLORSwcN013iDafTJLJFuXQz5K7OU9rmNQ9uz94XV6FNTW1mzJeGrkvFWe15pNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928732; c=relaxed/simple;
	bh=0SoReVqPG8OARZk3PKxhC9ElIHsbHT70s0BWq+efhYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdLu/gapnSOb1ARdlvRpgD40+Jq606nMt27uazc7sT3jkomzarz9e6kDVtLnZBjswPPpGk/ZnutXqMKD4GqYf5e9vsF+AWtdsFz77F3UQ+9r8pjv7oHn4V40ju+dld9b6RrmLS4Clkr9bz2R6gzzWC9jhX1WhsEUy8pPW6amqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsrG/i62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsrG/i62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7342D1F000E9;
	Fri, 24 Jul 2026 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784928730;
	bh=gfkC5Hgbwc7M1k5qZ5mj/SEyy6byTNhChcQuDHwZrXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YsrG/i62boOuWezgB+3hMCRv6Cbk0GDNTz0RDbZ8bivCoJdvgQTz9kFM5baq8IyQW
	 1EZg50maocEvl3quH8ENgSvaRWdMjE5gVtcruTGmk7aTtiassr2AVDT2a5BK2QW0WL
	 B8GFpeHUt+7/RrpjcdG59vHhGt7PK3KIL6XHISMd0Ved7HOd0jWItbJB1Gtfz6xNor
	 RWzHU21o5Ue6aKa/qxpz29JvkY7OMy42gGttpGwpDOM0dyI5fZoixbPRmy10J4qaJo
	 adbXxdzBSh1X4OPbUEXMJ6gkUx00ojQXHiU7aXJ8UZ4KEcwT6EssEA93A8pYWDqSwD
	 YlYkr/R//VzTw==
Date: Fri, 24 Jul 2026 22:32:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v11 00/11] iio: adc: Add support for AVIA HX710B ADC
Message-ID: <20260724223205.25184e92@jic23-huawei>
In-Reply-To: <CAMB+xkbpgDxv1Lt=qxqKyeEhXyxRpZ3Y1v7ZDaMGKUqAa1hDxg@mail.gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
	<20260614220400.106dd636@jic23-huawei>
	<CAMB+xkbpgDxv1Lt=qxqKyeEhXyxRpZ3Y1v7ZDaMGKUqAa1hDxg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2026 05:51:25 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Mon, Jun 15, 2026 at 2:34=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu,  4 Jun 2026 00:18:48 +0530
> > Piyush Patle <piyushpatle228@gmail.com> wrote:
> > =20
> > > The HX710B is a 24-bit ADC from AVIA Semiconductor, related to the
> > > HX711 already supported in this driver.  Unlike the HX711 (which has
> > > selectable gain and two input channels), the HX710B has a fixed gain
> > > of 128 and two operating modes selected by the trailing PD_SCK pulse
> > > count after each conversion:
> > >
> > >   25 pulses (1 trailing): differential input at 10 SPS
> > >   26 pulses (2 trailing): DVDD-AVDD supply monitor at 40 SPS
> > >   27 pulses (3 trailing): differential input at 40 SPS
> > >
> > > This series first extends the existing HX711 binding and driver with
> > > preparatory refactoring, then adds HX710B support on top.
> > >
> > > The differential input is exposed as a single IIO channel with
> > > IIO_CHAN_INFO_SAMP_FREQ, allowing userspace to select 10 or 40 SPS
> > > without needing two separate channels for the same physical input.
> > > The supply monitor is a second channel at fixed 40 SPS.
> > >
> > > This revision is rebased onto current mainline.  Note that
> > > iio_device_claim_direct_mode() / iio_device_release_direct_mode() were
> > > removed from the IIO core since v10, so 11/11 now uses the replacement
> > > iio_device_claim_direct() / iio_device_release_direct() API.
> > >
> > > Tested on a PocketBeagle2 (TI AM625): the avia,hx710b node probes and
> > > the driver registers its two IIO channels.
> > >
> > > Changes from v10:
> > >   - 02/11: Retitled to "add VSUP and DVDD supply properties"; the
> > >     commit message now documents both supplies (the patch already
> > >     added both; only the title/text were out of sync). [Jonathan]
> > >   - 04/11: Reworded commit message so DVDD is no longer described as
> > >     HX710B-specific (it is added for both parts in 02/11). The
> > >     compatible match now uses "contains: const: avia,hx710b" so the
> > >     constraints still apply if the compatible is later used as a
> > >     fallback. dvdd-supply is now required for HX710B (in the HX710B
> > >     branch only, so existing HX711 device trees are unaffected) and
> > >     added to the HX710B example. [Jonathan, Conor, Sashiko]
> > >   - 11/11: Kconfig title and file header use "similar" instead of
> > >     "compatible". Simplified the tail of hx711_set_hx710b_channel()
> > >     to "return hx711_wait_for_ready()". Dropped an unrelated
> > >     reindentation of the iio_push_to_buffers_with_timestamp() call.
> > >     Converted hx710b_write_raw() to the new
> > >     iio_device_claim_direct() API (see above). [Jonathan]
> > >
> > > The Reviewed-by (Andy Shevchenko) and Acked-by (Conor Dooley) tags on
> > > 02/11 and 04/11 are carried over although those patches changed; plea=
se
> > > re-confirm if you disagree with the reworked constraints. =20
> > As the only comments I had (well mostly sashiko) were on the 710b patch
> > at the end and some patches were queued from previous patches, I now ha=
ve
> > patches 1-3 and 5-10 applied to the testing branch of iio.git. =20
>=20
> Thanks a lot for picking those up, and for the reviews through the
> series.
>=20
> Two questions, mostly to make sure I do the right thing next:
>=20
> Looking at mainline I currently only see 01/11 ("dt-bindings: iio: adc:
> hx711: clean up existing binding text") and 05/11 ("iio: adc: hx711:
> move scale computation to per-device storage") under my name.  I assume
> the rest are still sitting in testing/togreg and will flow in at the
> next merge window rather than anything having gone missing, is that
> right?  Just checking I'm reading the tree correctly, no rush from my
> side.

Exactly that - assuming nothing odd happens they should go into mainline
in the next merge window.=20

>=20
> For the two that weren't applied, 04/11 (dt-bindings HX710B) and 11/11
> (driver HX710B support): would you prefer I resend just those two as a
> standalone v12 based on the testing branch, once I've worked through
> the remaining comments from you and Sashiko?  That seemed cleaner than
> reposting all eleven, but happy to send the full series again if you'd
> rather have it that way.

Go for the togreg branch (it's a little behind but should have all your
work on it) and make sure to have a Based-on entry in the cover letter.
I'm not sure if Sashiko will find the right thing test on but worth a go.


>=20
> If there is anything still outstanding on 04/11 or 11/11 beyond what
> was raised on v11, please do point me at it and I'll fold it in.

Not that I know of, but we'll see on v11 :)

Jonathan

>=20
> Thanks,
> Piyush
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > >
> > > Patches 01/11, 03/11, and 05/11 are unchanged from v10.
> > >
> > > Piyush Patle (11):
> > >   dt-bindings: iio: adc: hx711: clean up existing binding text
> > >   dt-bindings: iio: adc: hx711: add VSUP and DVDD supply properties
> > >   dt-bindings: iio: adc: hx711: add RATE GPIO property
> > >   dt-bindings: iio: adc: hx711: add HX710B support
> > >   iio: adc: hx711: move scale computation to per-device storage
> > >   iio: adc: hx711: introduce hx711_chip_info structure
> > >   iio: adc: hx711: pass trailing pulse count into hx711_read
> > >   iio: adc: hx711: split variable assignments in hx711_read and
> > >     hx711_reset
> > >   iio: adc: hx711: localize loop iterators in hx711_read
> > >   iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
> > >   iio: adc: hx711: add support for HX710B
> > >
> > >  .../bindings/iio/adc/avia-hx711.yaml          |  82 ++++-
> > >  drivers/iio/adc/Kconfig                       |   8 +-
> > >  drivers/iio/adc/hx711.c                       | 343 +++++++++++++++-=
--
> > >  3 files changed, 359 insertions(+), 74 deletions(-)
> > > =20
> > =20

