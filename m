Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869235975;
	Sun, 23 Aug 2026 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447630; cv=none; b=bKvtJLyxYy2+Lo9K3FpFaI3ZfRbV6YKl7t9kXnqQExktceelZG11sVdgK5SK3f/4SAu5mCwINNZZFUdUcH22/bqJLiINigMrUi6fHgr0iaxt3vHQuqpqyWFrAI6NV+gnt8trYavsO4TWk+J1VC9WL0azC3OsWfeWKicvUQQhizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447630; c=relaxed/simple;
	bh=MxhmQkt+HsJw3BIqtR4cvNp0ztd0d/xH6cmHp379Azo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBfdEQWrVF8EJKkKp/eGNkYKlaUIab0qUJEimVkqDmqe3r5EIdIcd8RRu3TrPJKokN5cE1nsL7zM47CAxvMykEKDh6VMNHRTRo5obw4411yb3zIVP9GAY1DdgcKiJsScGwMMlc227MWYylrNhvybiJOMtZS/hYiry9zl8D/85gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPng9N1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPng9N1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3021F000E9;
	Sun, 23 Aug 2026 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787447629;
	bh=j91BtLvWSBR6dvgmtb9YHG09xL+6riHADjvzhuRVzUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SPng9N1p/vB5myfjMiS4BUf4qTvr6b0tUDJUtF2F2Vca+eOm7kbsq/LxBtmxmAdIl
	 x42cif0goIcdaqVMcLgPhMcd0Mj1PXWhOUuGTq0xdXhhF72RlCwxeraauohgmku49x
	 ZmoMkfyhThezEJ9uZ/inv2pCRnqHniCP6g7tFgRyWealeT/4zejuay0hhEAn3rzahn
	 ymJ5XCvG+gh51R3/AHuTU7AsKvGIfNU2i2jYjvrc7fbJAkqY47FTFL4plI4tij2R5v
	 hU0QDJb0jDtBWlu1MrtHlyBL2aiv21rwezbufERjoBYqf3K9h369KTslBMBdzfmPb5
	 hZaEmVU/45U6g==
Date: Sun, 23 Aug 2026 02:13:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Message-ID: <20260823021344.7758fc04@jic23-huawei>
In-Reply-To: <BE1P281MB14260708607A9D4819C4145FCEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-4-075a881db557@tdk.com>
	<20260821012809.169b0b8b@jic23-huawei>
	<BE1P281MB14260708607A9D4819C4145FCEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2026 13:09:49 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >
> >________________________________________
> >From: Jonathan Cameron <jic23@kernel.org>
> >Sent: Friday, August 21, 2026 02:28
> >To: Jean-Baptiste Maneyrol via B4 Relay
> >Cc: Jean-Baptiste Maneyrol; David Lechner; Nuno S=C3=A1; Andy Shevchenko=
; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Jean-Baptiste Ma=
neyrol
> >Subject: Re: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count =
for watermark it
> >
> >On Thu, 20 Aug 2026 21:=E2=80=8A02:=E2=80=8A40 +0200 Jean-Baptiste Maney=
rol via B4 Relay <devnull+jean-baptiste.=E2=80=8Amaneyrol.=E2=80=8Atdk.=E2=
=80=8Acom@=E2=80=8Akernel.=E2=80=8Aorg> wrote: > From: Jean-Baptiste Maneyr=
ol <jean-baptiste.=E2=80=8Amaneyrol@=E2=80=8Atdk.=E2=80=8Acom> > > Optimize=
 data reading
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >
> >ZjQcmQRYFpfptBannerEnd
> >
> >On Thu, 20 Aug 2026 21:02:40 +0200
> >Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.=
com@kernel.org> wrote:
> > =20
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>
> >> Optimize data reading for high frequencies by not reading FIFO
> >> count in case of watermark interrupt. We already know there is
> >> watermark samples in the FIFO and we need to not read more than
> >> watermark samples for timestamping mechanism. Let's just read FIFO
> >> data directly without reading FIFO count in this case. =20
> >
> >Just to check
> >
> >Level interrupt?  Or one that will definitely get triggered again?
> >
> >The thinking on reading as much as possible is that for some devices
> >we need to be very sure we drained them past the threshold or we
> >don't get a fresh interrupt.  So if the threshold is set low (say 1)
> >it could easily reach 2 before we get to handling the interrupt.
> >Races are nasty anyway with those devices anyway but reading as
> >much as possible helped.
> >
> >Do you have data on it being worth skipping the read? If we are
> >at high frequencies I'd assume it is more useful to read more than
> >the minimum just to reduce how often we read the fifo at all.
> >
> >Jonathan =20
>=20
> Hello Jonathan,
>=20
> because of our specific timestamp mechanism, we cannot read as much as we=
 can.
> It was already the case before this patch; we were limiting FIFO read to =
watermark.
> It is required to preserve the timing between the watermark interrupts th=
at
> we are using to compute time elapsed in the chip frame.
>=20
> Here it is only an optimization to avoid reading the FIFO count register.
> Because we know we have at least watermark data since the interrupt occur=
red,
> and we cannot read more otherwise we would break the timing between 2 int=
errupts.
>=20
> With this optimization, I'm able for example to stream data at 1kHz using=
 I2C. Otherwise
> it is not possible on my test platform.

This is good. Capture a little more in the commit message about only reading
this amount anyway and that you know there is always at least this amount.

Thanks for the detailed and really clear responses btw.

Jonathan

>=20
> Hope I'm clear enough here.
>=20
> Thanks,
> JB
>=20
> >
> > =20
> >>
> >> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >> ---
> >>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 33 ++++++++++---=
---------
> >>  1 file changed, 15 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> >> index 1428f18408ce..1410096f6e6d 100644
> >> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> >> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> >> @@ -474,24 +474,21 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm=
42600_state *st,
> >>       st->fifo.nb.accel =3D 0;
> >>       st->fifo.nb.total =3D 0;
> >>
> >> -     /* compute maximum FIFO read size (watermark for max =3D 0 inter=
rupt case) */
> >> -     if (max =3D=3D 0)
> >> -             max =3D st->fifo.watermark.value;
> >> -     max_count =3D max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> >> -
> >> -     /* read FIFO count value */
> >> -     raw_fifo_count =3D (__be16 *)st->buffer;
> >> -     ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
> >> -                            raw_fifo_count, sizeof(*raw_fifo_count));
> >> -     if (ret)
> >> -             return ret;
> >> -     st->fifo.count =3D be16_to_cpup(raw_fifo_count);
> >> -
> >> -     /* check and clamp FIFO count value */
> >> -     if (st->fifo.count =3D=3D 0)
> >> -             return 0;
> >> -     if (st->fifo.count > max_count)
> >> -             st->fifo.count =3D max_count;
> >> +     /* read watermark samples for interrupt case (max =3D 0) or read=
 FIFO count */
> >> +     if (max =3D=3D 0) {
> >> +             st->fifo.count =3D st->fifo.watermark.value *
> >> +                              INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> >> +     } else {
> >> +             raw_fifo_count =3D (__be16 *)st->buffer;
> >> +             ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_=
COUNT,
> >> +                                     raw_fifo_count, sizeof(*raw_fifo=
_count));
> >> +             if (ret)
> >> +                     return ret;
> >> +             max_count =3D max * INV_ICM42600_FIFO_2SENSORS_PACKET_SI=
ZE;
> >> +             st->fifo.count =3D min(be16_to_cpup(raw_fifo_count), max=
_count);
> >> +             if (st->fifo.count =3D=3D 0)
> >> +                     return 0;
> >> +     }
> >>
> >>       /* read all FIFO data in internal buffer */
> >>       ret =3D regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DATA,
> >> =20
>  =20

