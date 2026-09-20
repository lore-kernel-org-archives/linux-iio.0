Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBC4A32;
	Sun, 20 Sep 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924658; cv=none; b=bfn2f/0leUKX4bH0suevgjajyI+cusmvLxnswihDdRMKBn1+XYyZlu1/xYOT/k7MD69r8uUmIkqYMKjGj2xYWMTgoqWjLVeG7UAyNOjMiwtAum2qQvN3sOXlxHr6lbMg4nQmZVwT+75fol4f53E8LxudKX0ft7CpQi2QQX3FqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924658; c=relaxed/simple;
	bh=g3fexnJGXjYXfGGECspbILKFwIBZW5jivRReBupv19I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7LU8ID3MvK/QuKaXXmymmNDiTA29gk7dLdKXstSSTdnyfas76KoKFDgKLx5pnP0xsOxm190DqZiLJVOXFeiHaNUFK4QxnGyG7nOotvm9R8Dx4hraazL0Xa2P1FY6VYNMfCuXf15y6+JVC2YV74eYDRNCebbzxFUEQnmsDvlS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcHLfgwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcHLfgwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC51F00893;
	Sun, 20 Sep 2026 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789924656;
	bh=RfR8vIndOoeF9tkn+4g2opkKsK6rIdMgYVfkwTML2ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gcHLfgwz+mxJA7fbi6TqFdIHTJBtCIMHJJ3HmcPSV/1jhiUiE9YYInOkF6u9BQP8z
	 2QVG4D73a4CRB3HJdW+Jnk7AhrNWoGXXq6ibIVogk2jZ0l/z4HShL8XjzR3VOSv7fO
	 5E3tZ9auSgETJYYFCrRAMsJ26Z3xOM9hl9mrUTSfJaUfRPM78NHmLkfmYLKAnwsAyL
	 owixYTx/MtbodVFPWDDT6Jyp7bwBLSOC8LCxrDQEq05QtMz7hutlKUQU8qat/XPMQw
	 /Fk+6N2UHhaa1XBfdmim/rxChY9duc9FMMj8C0Hb+EQDcGaSsmWKj+rXVqVCgIqll0
	 MQkmjqNimGEgQ==
Date: Sun, 20 Sep 2026 18:17:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 6/8] iio: osf: add IIO devices from capability
 reports
Message-ID: <20260920181733.49d5daad@jic23-hlaptop>
In-Reply-To: <CALMSewLE7OOc1jEUnpd82axp6DZKBxZW5bBMLa03EfjzFuaFdw@mail.gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<c88d0ced0bff5cf29e765cd2c280ce3c10c50988.1789753020.git.kimjinseob88@gmail.com>
	<20260920030352.62526119@jic23-hlaptop>
	<CALMSewLa+UF6khnZDNC+kPJz7EXx9PtCud75UE28_4sZb6CSsg@mail.gmail.com>
	<CALMSewLE7OOc1jEUnpd82axp6DZKBxZW5bBMLa03EfjzFuaFdw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 14:07:34 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> > Using an extra lock is one solution I suppose to the risk
> > of this racing with the buffer tear down and the problems
> > around active_scan_mask being freed. Could you use
> >
> >     if (iio_device_try_claim_buffer_mode(indio_dev))
> >
> > and later a release on that to achieve the same result? =20
>=20
> I looked into this against the current IIO core and tested the relevant p=
aths.
>=20
> iio_device_try_claim_buffer_mode() does hold the IIO mode lock, and
> iio_update_buffers() takes the same lock, so it would serialize normal
> buffer reconfiguration.
>=20
> However, the unregister path does not hold that mode lock while
> disabling/deactivating the buffers, and that path can free
> active_scan_mask.

Ah. That seems like a hole we should close. This I think is the
call to iio_disable_all_buffers() in iio_device_unregister()?  The only
potential problem there would be lock inversion wrt to the info_exist_lock.
That shouldn't be a problem as iio_update_buffers() takes them in the same
order as we would be doing here.
So at least a first look, taking mlock inside iio_disable_all_buffers()
would seem like an easy change to make.

It would be a lot more logical if that gap had never existed!
Thanks for the analysis - I'd be surprised if we don't have other
latent bugs around that protection not being there.

Assuming there isn't something I'm missing would you mind sending that
as a separate patch that we can ask folk to test ahead of the main
series.

Thanks,

Jonathan




> Because the OSF receive path can still have an
> admitted buffer push at that point, the mode claim alone does not
> appear to provide the same lifetime guarantee as the existing private
> lock.
>=20
> I therefore kept the private lock for now. I also reran the
> disable/unregister race coverage with KASAN and lockdep enabled; those
> tests pass without diagnostics.
>=20
> Thanks,
>=20
> Jinseob
>=20
> 2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 1:20,=
 Kim Jinseob <kimjinseob88@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > =20
> > > Using an extra lock is one solution I suppose to the risk
> > > of this racing with the buffer tear down and the problems
> > > around active_scan_mask being freed. Could you use
> > >
> > >     if (iio_device_try_claim_buffer_mode(indio_dev))
> > >
> > > and later a release on that to achieve the same result?
> > >
> > > Only the ade9000 is doing similar at the moment so would need
> > > some testing to make sure no lock inversions occur in general
> > > but given you don't take any other locks in here it should be fine. =
=20
> >
> > I think that should be a better fit here. I'll test replacing the
> > private buffer lock and active flag with
> > iio_device_try_claim_buffer_mode() , iio_device_release_buffer_mode(),
> > including the existing buffer disable/unregister race coverage and
> > lockdep checks.
> >
> > If that confirms the expected serialization against buffer
> > reconfiguration, I'll use that approach in the next revision.
> >
> > Thanks,
> >
> > Jinseob
> >
> > 2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 11:=
03, Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1: =20
> > >
> > > On Sat, 19 Sep 2026 03:24:44 +0900
> > > Jinseob Kim <kimjinseob88@gmail.com> wrote:
> > > =20
> > > > Register IIO devices from supported capability descriptors and expo=
se
> > > > signed raw samples, descriptor scales and software buffers. Keep ea=
rly
> > > > capabilities owned by the core until UART and supply setup is compl=
ete,
> > > > and unregister children after the receive producer has stopped.
> > > >
> > > > Validate nonzero descriptor scales and sample/descriptor equality, =
leave
> > > > discovery open after empty or unsupported inventories, and compare
> > > > repeated descriptors independently of order. Fault a bound session =
if a
> > > > descriptor changes meaning, gating cache and buffer publication tog=
ether.
> > > >
> > > > Add initialized active-scan packing and buffer producer quiescence.=
 The
> > > > production implementation is now complete; subsequent patches only =
add
> > > > the existing core and IIO KUnit suites and their build wiring. =20
> > >
> > > No need to talk about what other patches do and that a series is func=
tionally
> > > complete in a patch. If you want to do it, under the --- so it doesn'=
t end
> > > up in the git log.
> > > =20
> > > >
> > > > Assisted-by: LLM
> > > > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com> =20
> > >
> > > A few things inline.  Biggest one is a question (I'm not sure) on
> > > whether you can use a claim on buffered mode (which will hold it in t=
hat
> > > if it succeeds until released) is sufficient to replace the extra loc=
k you
> > > have to block that transition.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
> > > =20
> > > > diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/o=
pensensorfusion/osf_iio.c
> > > > new file mode 100644
> > > > index 000000000000..f4011b8fae14
> > > > --- /dev/null
> > > > +++ b/drivers/iio/opensensorfusion/osf_iio.c =20
> > > ...
> > > =20
> > > > +
> > > > +struct osf_iio_scan_3axis {
> > > > +     s32 values[3];
> > > > +     u32 padding; =20
> > > No needed unless you explicitly write into padding for some reason.
> > > C rules add it anyway and then we don't need to make sure it remains
> > > correct if this structure changes in future. =20
> > > > +     aligned_s64 timestamp;
> > > > +};
> > > > +
> > > > +struct osf_iio_scan_1axis {
> > > > +     s32 value;
> > > > +     u32 padding; =20
> > > As above, unneeded. =20
> > > > +     aligned_s64 timestamp;
> > > > +}; =20
> > >
> > > Given I think these are only used in one place, moving them to there =
would
> > > avoid need for named structure types.
> > > =20
> > > > +
> > > > +#define OSF_MOD_CHAN(_type, _mod, _idx)                           =
   \
> > > > +     {                                                            =
   \
> > > > +             .type =3D (_type),                                   =
     \
> > > > +             .modified =3D 1,                                     =
     \
> > > > +             .channel2 =3D (_mod),                                =
     \
> > > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),      =
     \
> > > > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE=
),   \
> > > > +             .scan_index =3D (_idx),                              =
     \
> > > > +             .scan_type =3D {                                     =
     \
> > > > +                     .sign =3D 's',                               =
     \
> > > > +                     .realbits =3D 32,                            =
     \
> > > > +                     .storagebits =3D 32,                         =
     \
> > > > +                     .endianness =3D IIO_CPU,                     =
     \
> > > > +             },                                                   =
   \
> > > > +     }
> > > > +
> > > > +#define OSF_CHAN(_type, _idx)                                     =
   \ =20
> > >
> > > Given this is not much used, you could use the IIO_NO_MOD modifier as=
 a gate
> > > on setting .modified =3D (_mod !=3D IIO_NO_MOD) ? 1 : 0,
> > > and have just one macro.
> > > =20
> > > > +     {                                                            =
   \
> > > > +             .type =3D (_type),                                   =
     \
> > > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),      =
     \
> > > > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE=
),   \
> > > > +             .scan_index =3D (_idx),                              =
     \
> > > > +             .scan_type =3D {                                     =
     \
> > > > +                     .sign =3D 's',                               =
     \
> > > > +                     .realbits =3D 32,                            =
     \
> > > > +                     .storagebits =3D 32,                         =
     \
> > > > +                     .endianness =3D IIO_CPU,                     =
     \
> > > > +             },                                                   =
   \
> > > > +     }
> > > > +
> > > > +static const struct iio_chan_spec osf_accel_channels[] =3D {
> > > > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_X, 0),
> > > > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Y, 1),
> > > > +     OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Z, 2),
> > > > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > > > +};
> > > > +
> > > > +static const struct iio_chan_spec osf_gyro_channels[] =3D {
> > > > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_X, 0),
> > > > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, 1),
> > > > +     OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, 2),
> > > > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > > > +};
> > > > +
> > > > +static const struct iio_chan_spec osf_mag_channels[] =3D {
> > > > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_X, 0),
> > > > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Y, 1),
> > > > +     OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Z, 2),
> > > > +     IIO_CHAN_SOFT_TIMESTAMP(3),
> > > > +};
> > > > +
> > > > +static const struct iio_chan_spec osf_temp_channels[] =3D {
> > > > +     OSF_CHAN(IIO_TEMP, 0),
> > > > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > +};
> > > > +
> > > > +static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] =3D=
 {
> > > > +     {
> > > > +             .sensor_type =3D OSF_SENSOR_ACCELEROMETER,
> > > > +             .channel_count =3D 3,
> > > > +             .name =3D "osf-accel",
> > > > +             .channels =3D osf_accel_channels,
> > > > +             .num_channels =3D ARRAY_SIZE(osf_accel_channels),
> > > > +     },
> > > > +     {
> > > > +             .sensor_type =3D OSF_SENSOR_GYROSCOPE,
> > > > +             .channel_count =3D 3,
> > > > +             .name =3D "osf-gyro",
> > > > +             .channels =3D osf_gyro_channels,
> > > > +             .num_channels =3D ARRAY_SIZE(osf_gyro_channels),
> > > > +     },
> > > > +     {
> > > > +             .sensor_type =3D OSF_SENSOR_MAGNETOMETER,
> > > > +             .channel_count =3D 3,
> > > > +             .name =3D "osf-magn",
> > > > +             .channels =3D osf_mag_channels,
> > > > +             .num_channels =3D ARRAY_SIZE(osf_mag_channels),
> > > > +     },
> > > > +     {
> > > > +             .sensor_type =3D OSF_SENSOR_TEMPERATURE,
> > > > +             .channel_count =3D 1,
> > > > +             .name =3D "osf-temp",
> > > > +             .channels =3D osf_temp_channels,
> > > > +             .num_channels =3D ARRAY_SIZE(osf_temp_channels),
> > > > +     },
> > > > +};
> > > > +
> > > > +static const struct osf_iio_sensor_spec *
> > > > +osf_iio_find_sensor_spec(u16 sensor_type, u16 channel_count)
> > > > +{
> > > > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(osf_iio_sensor_spec=
s); i++) {
> > > > +             if (osf_iio_sensor_specs[i].sensor_type =3D=3D sensor=
_type &&
> > > > +                 osf_iio_sensor_specs[i].channel_count =3D=3D chan=
nel_count)
> > > > +                     return &osf_iio_sensor_specs[i];
> > > > +     }
> > > > +
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
> > > > +{
> > > > +     if (osf_iio_find_sensor_spec(sensor_type, channel_count))
> > > > +             return true;
> > > > +
> > > > +     return false =20
> > >
> > >         return osf_iio_find_sensor_spec(sensor_type, channel_count) !=
=3D NULL;
> > > =20
> > > > +} =20
> > > =20
> > > > +
> > > > +static int osf_iio_buffer_postenable(struct iio_dev *indio_dev)
> > > > +{
> > > > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > > > +
> > > > +     guard(mutex)(&state->buffer_lock); =20
> > >
> > > These transistions are already guarded by the core, so see the questi=
on later
> > > on whether you can just claim buffered mode in the data handler
> > > to avoid the need for this. That might not work but the way you did
> > > this got me thinking about a more general solution to the problem.
> > > =20
> > > > +     state->buffer_active =3D true;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int osf_iio_buffer_predisable(struct iio_dev *indio_dev)
> > > > +{
> > > > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > > > +
> > > > +     /* Wait for the current push before the IIO core changes its =
buffers. */
> > > > +     guard(mutex)(&state->buffer_lock);
> > > > +     state->buffer_active =3D false;
> > > > +
> > > > +     return 0;
> > > > +} =20
> > >
> > > =20
> > > > +
> > > > +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *valu=
es,
> > > > +                     u16 channel_count)
> > > > +{
> > > > +     struct osf_iio_state *state =3D iio_priv(indio_dev);
> > > > +     s64 timestamp;
> > > > +
> > > > +     if (channel_count !=3D state->spec->channel_count)
> > > > +             return -EPROTO;
> > > > +
> > > > +     guard(mutex)(&state->buffer_lock); =20
> > >
> > > Using an extra lock is one solution I suppose to the risk
> > > of this racing with the buffer tear down and the problems
> > > around active_scan_mask being freed. Could you use
> > >
> > >         if (iio_device_try_claim_buffer_mode(indio_dev))
> > > and later a release on that to achieve the same result?
> > >
> > > Only the ade9000 is doing similar at the moment so would need
> > > some testing to make sure no lock inversions occur in general
> > > but given you don't take any other locks in here it should be fine.
> > >
> > > =20
> > > > +     if (!state->buffer_active || !iio_buffer_enabled(indio_dev))
> > > > +             return 0;
> > > > +
> > > > +     timestamp =3D iio_get_time_ns(indio_dev);
> > > > +
> > > > +     switch (channel_count) {
> > > > +     case 1: {
> > > > +             struct osf_iio_scan_1axis scan =3D {
> > > > +                     .value =3D values[0],
> > > > +             }; =20
> > > As suggested above, this structure type is only used locally here. So
> > > make the definition local as well.
> > >                 struct {
> > >                         s32 value;
> > >                         aligned_s64 timestamp;
> > >                 } scan =3D { };
> > > =20
> > > > +
> > > > +             return iio_push_to_buffers_with_ts(indio_dev, &scan,
> > > > +                                                sizeof(scan), time=
stamp);
> > > > +     }
> > > > +     case 3: {
> > > > +             struct osf_iio_scan_3axis scan =3D {
> > > > +                     .values =3D { }, =20
> > >
> > > Setting values doesn't add anything useful as =3D { }
> > > zeros the whole structure (including any holes - they kernel is
> > > built with specific compiler options to ensure that last bit
> > > as it wasn't required in older c specs).
> > > =20
> > > > +             };
> > > > +             unsigned int channel, index =3D 0; =20
> > >
> > > Please split declarations that assign and ones that don't on to separ=
ate lines.
> > > Ends up a little more readable.
> > >                 unsigned int index =3D 0;
> > >                 unsigned int channel;
> > > =20
> > > > +
> > > > +             /* Pack the active channels; unused storage remains i=
nitialized. */
> > > > +             for_each_set_bit(channel, indio_dev->active_scan_mask=
, channel_count)
> > > > +                     scan.values[index++] =3D values[channel];
> > > > +
> > > > +             return iio_push_to_buffers_with_ts(indio_dev, &scan,
> > > > +                                                sizeof(scan), time=
stamp);
> > > > +     }
> > > > +     default:
> > > > +             return -EPROTO;
> > > > +     }
> > > > +} =20
> > > =20
> > > > diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/ii=
o/opensensorfusion/osf_serdev.c
> > > > index 8a747c01ff9d..3d5e90d83967 100644
> > > > --- a/drivers/iio/opensensorfusion/osf_serdev.c
> > > > +++ b/drivers/iio/opensensorfusion/osf_serdev.c
> > > > @@ -23,7 +23,7 @@ struct osf_serdev {
> > > >       bool vcc_enabled;
> > > >       struct osf_device osf;
> > > >       struct osf_stream stream;
> > > > -     /* Protects the parser and all RX counters. */
> > > > +     /* Protects the parser, all RX counters, and the registration=
 gate. */
> > > >       struct mutex rx_lock; =20
> > >
> > > Just name it 'lock' given it has scope beyond rx.  Do that in earlier=
 patch
> > > though rather than changing it here.
> > > =20
> > > >  }; =20
> > > =20
> > > >
> > > > @@ -139,5 +144,5 @@ static struct serdev_device_driver osf_serdev_d=
river =3D {
> > > >  };
> > > >  module_serdev_device_driver(osf_serdev_driver);
> > > >
> > > > -MODULE_DESCRIPTION("Open Sensor Fusion UART receiver");
> > > > +MODULE_DESCRIPTION("Open Sensor Fusion IIO driver"); =20
> > >
> > > Just have that being slightly missleading in earlier patch to reduce =
churn here.
> > > =20
> > > >  MODULE_LICENSE("GPL"); =20
> > > =20

