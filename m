Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41673C9440;
	Mon, 23 Mar 2026 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288526; cv=none; b=ieIgjShnggdsYZ/HZLnwIqRloLQKpGSU9VpxVXyDl9q+Hg1iBSm/GTZKMpY+NRNT+36aIpNBmlGp58S4TU5mtO84jw2OT08gjVxEL2PwB0o2ayqRQ2bn1Z6IYgfkLkQPAfHwbuWXCoIRBASiGi3d9EO0DnRqEm6cxxbuQz4reXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288526; c=relaxed/simple;
	bh=h4l96PV0swKh3/xZqtsIDbG14spzc78TV5rRfckoqHM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LALEbz8Xu2yAfc0hAqLIB1Pwlg7WbKcyXusWLsufNxPfKk4G0zP9yT1j0N7Pd9UwBeqEKJxUy2ua+rRUwkePZSpqax6ckKbxu5A45Qc+Tm3P1pgHkDOuMd4GX4xvwtJ+GaeokvyKEfcj+sT2hUlha58Wic2JjtWeIqNHY65maBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffgmT5gplzHnGgp;
	Tue, 24 Mar 2026 01:54:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9870140086;
	Tue, 24 Mar 2026 01:55:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 17:55:20 +0000
Date: Mon, 23 Mar 2026 17:55:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Archit Anant <architanant5@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages
 during probe
Message-ID: <20260323175519.00003b58@huawei.com>
In-Reply-To: <eaaee132-d5ff-42ff-9f68-5d6736127caf@baylibre.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
	<20260318092715.42538-4-architanant5@gmail.com>
	<20260321182710.1621d1aa@jic23-huawei>
	<CADJHxWADo9rA8vt6EEVLXSBb9EqXvyBg=L_YmusaMdtRnOr0rQ@mail.gmail.com>
	<eaaee132-d5ff-42ff-9f68-5d6736127caf@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Mar 2026 09:39:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/23/26 7:22 AM, Archit Anant wrote:
> > On Sat, Mar 21, 2026 at 11:57=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> >>
> >> On Wed, 18 Mar 2026 14:57:14 +0530
> >> Archit Anant <architanant5@gmail.com> wrote:
> >> =20
> >>> Reading the regulator voltage via regulator_get_voltage() can be a sl=
ow
> >>> operation. =20
> >>
> >> Whilst that might be true, it isn't a reason for this change.
> >> Sysfs reads that would cause it to be read are never a particularly
> >> fast path anyway. So drop this first sentence.
> >> =20
> >>> Since the reference voltages for this ADC are not expected to
> >>> change at runtime, it is inefficient to query the regulator API every
> >>> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> >>>
> >>> Determine the active reference voltage (either VREF or VCC) during
> >>> probe() and cache it in the state structure. This improves the
> >>> performance of ad799x_read_raw() and removes the dependency on the
> >>> regulator pointers during fast-path reads.
> >>>
> >>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> >>> Suggested-by: David Lechner <dlechner@baylibre.com>
> >>> Signed-off-by: Archit Anant <architanant5@gmail.com> =20
> >>
> >> A suggested alternative approach inline.
> >>
> >> Thanks,
> >>
> >> Jonathan
> >> =20
> >>> ---
> >>>  drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
> >>>  1 file changed, 16 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> >>> index 7504bcf627da..ae2ad4bd37cc 100644
> >>> --- a/drivers/iio/adc/ad799x.c
> >>> +++ b/drivers/iio/adc/ad799x.c
> >>> @@ -30,6 +30,7 @@
> >>>  #include <linux/module.h>
> >>>  #include <linux/mutex.h>
> >>>  #include <linux/bitops.h>
> >>> +#include <linux/units.h>
> >>>
> >>>  #include <linux/iio/iio.h>
> >>>  #include <linux/iio/sysfs.h>
> >>> @@ -135,6 +136,9 @@ struct ad799x_state {
> >>>       u16                             config;
> >>>
> >>>       unsigned int                    transfer_size;
> >>> +
> >>> +     int                             vref_uV;
> >>> +
> >>>       IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
> >>>  };
> >>>
> >>> @@ -302,14 +306,7 @@ static int ad799x_read_raw(struct iio_dev *indio=
_dev,
> >>>                       GENMASK(chan->scan_type.realbits - 1, 0);
> >>>               return IIO_VAL_INT;
> >>>       case IIO_CHAN_INFO_SCALE:
> >>> -             if (st->vref)
> >>> -                     ret =3D regulator_get_voltage(st->vref);
> >>> -             else
> >>> -                     ret =3D regulator_get_voltage(st->reg);
> >>> -
> >>> -             if (ret < 0)
> >>> -                     return ret;
> >>> -             *val =3D ret / 1000;
> >>> +             *val =3D st->vref_uV / MILLI;
> >>>               *val2 =3D chan->scan_type.realbits;
> >>>               return IIO_VAL_FRACTIONAL_LOG2;
> >>>       }
> >>> @@ -828,9 +825,20 @@ static int ad799x_probe(struct i2c_client *clien=
t)
> >>>                       ret =3D regulator_enable(st->vref);
> >>>                       if (ret)
> >>>                               goto error_disable_reg;
> >>> +                     ret =3D regulator_get_voltage(st->vref); =20
> >>
> >> For vref I don't think we need to keep the regulator around, so you sh=
ould
> >> be able to use devm_regulator_get_enable_read_voltage() with checking
> >> for -ENODEV to identify it simply isn't there.
> >>
> >> It would need a tiny bit of reordering though or a custom
> >> devm_add_action_or_reset() registered callback to ensure that regulator
> >> disable for vcc happens in reverse sequence of what happens on setup.
> >>
> >> Anyone think there are actually ordering constraints on these regulato=
rs?
> >> Would be fairly unusual for this sort of device, but not impossible.
> >> If not, cleanest option might be; =20
> > ... =20
> >> Then no need to undo anything by hand in remove() and no need to keep
> >> a pointer to any regulators around for later. =20
> >=20
> > I completely agree that devm_regulator_get_enable_read_voltage() is
> > the cleanest approach.
> >=20
> > However, as I noted briefly in the v5 changelog (which I should have
> > highlighted better), the driver currently relies on those regulator
> > pointers (st->reg and st->vref) in the ad799x_suspend() and
> > ad799x_resume() callbacks.
> >=20
> > If we drop the pointers from the state structure, we lose the ability
> > to disable the regulators during system sleep.
> >=20
> > If keeping power management active during suspend is still desired for
> > this driver, I believe we are forced to keep the pointers and use the
> > devm_add_action_or_reset() pattern. =20
>=20
> Yes, this is the best we can do with current regulator APIs.
>=20
> >=20
> > If you prefer, I can drop the manual regulator control from the PM
> > callbacks entirely (or drop the PM callbacks altogether), which would
> > allow us to use the cleaner devm_regulator_get_enable_read_voltage()
> > helper. =20
>=20
> We can't do this unless we can be 100% sure we don't break existing
> users who might be depending on power management working as-is.
Yeah, I missed the use in suspend / resume for some reason.

Not much we can do to improve things :(

Jonathan

>=20
> >=20
> > Let me know which path you prefer for v6!
> >  =20
>=20
>=20
>=20

