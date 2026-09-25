Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695723645D;
	Fri, 25 Sep 2026 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304553; cv=none; b=H27THmdIVDZVdaCG4BdyrzWuS9vE6PsDGimlp+1e+7phRy7aww5WQzoSyX+pNZMKpa7Wk6HPFzIQL+fdSyo98Cpo+QYSCvqKHDivsamRNkmZ1LgIsxcVpOoETGpXQfsxAj2NA33EpIBrg3hz0/q7UCMbO2IhGyYxLg/De0sUUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304553; c=relaxed/simple;
	bh=f8BJ+zZrHPk8/EEKE+NOiTWqRVxuVHg9nlcERQcno2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3hJVmcV43qKm/02x4TaRfpjys6vxfNqN6yyqVv+4xiHHa8wRINv1wye/4W1vpywugW+nXeFj1196fruAbSC4zf/OCHYz5LdmCMWZmKz2o9rmuPv8EKEANJOx4HP/wyMrmvK2W0gcD6k8zbWy9WSRG0Ao+v1/fKaABv3qWyK6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn1emDuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn1emDuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92921F000FF;
	Fri, 25 Sep 2026 02:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304551;
	bh=L21lKjmK4mTQWxfToY9ppF3C/3pLGPt7eQsVxXI7VlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tn1emDujfI9afPKR2jMv/eYw8xy/zLV+u91gE5WtrBcSztCzt630ET1FQMZ8N3xWH
	 jk4cTFY7LyXFkljIpKSvtI1BzD5ONmzXObHWF3arfaiSCZmY6db8WsZj51Nza0uIA/
	 ya5DoTUkLRjAXubdai8Tf/mbsi/uA9Fnpsiijn6RHJ9amjSjjWG84ZdZ6buKTVOOs9
	 vQmgcXzqMvpO6SyAV3GTA2iSRiDWN43x+F7jsVf3+UCNPvkOiGpU4FDg/rFyDBd2P/
	 zuwe1RB4Jda9slHwZo2sZ3ptuq57J0cUpZx9DeCHCfIJkSZNXPndEPT1CmNoWBlCC/
	 NkKuWC8U7jhyA==
Date: Fri, 25 Sep 2026 03:49:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: st_sensors: add __counted_by_ptr to struct
 st_sensor_settings
Message-ID: <20260925034909.474de9da@jic23-hlaptop>
In-Reply-To: <CAGG=3QXAoU8cPQHFLDPa7KZGPWMEqS9iLXY2KeBt2us=K6Z6hQ@mail.gmail.com>
References: <20260922112111.1970872-1-morbo@google.com>
	<202609230033.E3A658F@keescook>
	<CAGG=3QW+N1FoUL2GOLfU=U1Pj-eb_o99Z_Mq76ocrZ29S-NyZg@mail.gmail.com>
	<CAGG=3QXAoU8cPQHFLDPa7KZGPWMEqS9iLXY2KeBt2us=K6Z6hQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2026 15:06:03 -0700
Bill Wendling <morbo@google.com> wrote:

> On Wed, Sep 23, 2026 at 12:34=E2=80=AFPM Bill Wendling <morbo@google.com>=
 wrote:
> > On Wed, Sep 23, 2026 at 12:52=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote: =20
> > > On Tue, Sep 22, 2026 at 11:21:11AM +0000, Bill Wendling wrote: =20
> > > > Annotate the "ch" pointer member of "struct st_sensor_settings" wit=
h the
> > > > "__counted_by_ptr" attribute. The elements of "ch" are counted by t=
he
> > > > "num_ch" member in the same struct.
> > > >
> > > > All instances of "struct st_sensor_settings" are defined as "static
> > > > const" arrays across the ST sensor core drivers. For pressure senso=
rs,
> > > > "num_ch" is explicitly initialized with the size of the respective
> > > > channel array using "ARRAY_SIZE(...)" during static definition. =20
> > >
> > > I wanted to understand this so, in drivers/iio/accel/st_accel_core.c:
> > >
> > > static const struct st_sensor_settings st_accel_sensors_settings[] =
=3D {
> > > ...
> > >                 .ch =3D (struct iio_chan_spec *)st_accel_12bit_channe=
ls,
> > > ...
> > > }
> > >
> > > static const struct iio_chan_spec st_accel_12bit_channels[] =3D {
> > >         ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
> > >                         BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SC=
ALE),
> > >                         ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE,=
 12, 16,
> > >                         ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
> > >                         st_accel_mount_matrix_ext_info),
> > >         ...
> > >         IIO_CHAN_SOFT_TIMESTAMP(3)
> > > };
> > >
> > > #define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {        =
   \
> > >         .type =3D IIO_TIMESTAMP,                                     =
     \
> > >         .channel =3D -1,                                             =
     \
> > >         .scan_index =3D _si,                                         =
     \
> > >         .scan_type =3D {                                             =
     \
> > >                 .sign =3D 's',                                       =
     \
> > >                 .realbits =3D 64,                                    =
     \
> > >                 .storagebits =3D 64,                                 =
     \
> > >         },                                                           =
   \
> > > }
> > >
> > > So .ch is assigned an array of items which looks to end with a termin=
ation
> > > sentinel. And .num_ch is unassigned:
> > >
> > > $ git grep '\.ch =3D ' drivers/iio/accel/st_accel_core.c | wc -l
> > > 16
> > > $ git grep '\.num_ch =3D ' drivers/iio/accel/st_accel_core.c | wc -l
> > > 0
> > > =20
> > > > For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is=
 not
> > > > explicitly initialized (and thus defaults to 0). This is because th=
ose
> > > > drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNE=
LS"
> > > > rather than using "num_ch" from the settings struct. =20
> > >
> > > Yeah, checks out:
> > >
> > > $ git grep '\.ch =3D ' | cut -d: -f1 | sort | uniq -c
> > >      16 accel/st_accel_core.c
> > >       4 gyro/st_gyro_core.c
> > >       5 magnetometer/st_magn_core.c
> > >       6 pressure/st_pressure_core.c
> > > $ git grep '\.num_ch =3D ' | cut -d: -f1 | sort | uniq -c
> > >       6 pressure/st_pressure_core.c
> > >
> > > Interestingly, the pressure/st_pressure_core.c uses both assigned .nu=
m_ch
> > > _and_ a sentinel.
> > > =20
> > > > Since these structures are static const, both "ch" and "num_ch" are
> > > > fully initialized at compile time and available immediately at boot
> > > > time.  The only accesses to the "ch" field of "st_sensor_settings" =
occur
> > > > when assigning it to "indio_dev->channels" during device probing. =
=20
> > >
> > > Heh, so the bounds check gets laundered. :) Even pressure:
> > >
> > > pressure/st_pressure_core.c:    press_data->num_data_channels =3D pre=
ss_data->sensor_settings->num_ch - 1;
> > > pressure/st_pressure_core.c:    indio_dev->num_channels =3D press_dat=
a->sensor_settings->num_ch;
> > > =20
> > > > Because "sensor_settings->ch" is never dereferenced or accessed as =
an
> > > > array, adding the "__counted_by_ptr" annotation does not cause any
> > > > runtime panics or false-positive bounds checks under KASAN or UBSAN=
. =20
> > >
> > > I would argue that either __counted_by_ptr has no use here ("accident=
ally
> > > safe because no one dereferences .ch" isn't a great justification)
> > > or that the accelerometer, gyroscope, and magnetometer sensors should
> > > have their .num_ch assigned correctly so that the "contract" is corre=
ct,
> > > even if nothing does the deref.
> > > =20
> > This is all very weird. Below is the full output from CodeMender. It
> > might give some insight into this, but perhaps we should just NACK
> > this patch?
> > =20
> After further review, I'm going to NACK this patch as having no
> effect. I think this makes me a real kernel developer now? :-)
>=20
> NACK: Bill Wendling <morbo@google.com>
:)
Patchwork doesn't have a button for Nacked by the submitter!

Rejected it is I guess!

Jonathan

>=20
> -bw

