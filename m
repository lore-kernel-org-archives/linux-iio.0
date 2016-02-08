Return-Path: <wsa@the-dreams.de>
Date: Mon, 8 Feb 2016 11:25:00 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Michael Welling <mwelling@ieee.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Andy Gross <agross@codeaurora.org>,
	Pramod Gurav <pramod.gurav@smartplayin.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de,
	Sricharan R <sricharan@codeaurora.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160208102459.GC2220@tetsubishi>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160205172457.GA16778@deathstar>
 <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
 <20160206003245.GA1329@deathstar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <20160206003245.GA1329@deathstar>
List-ID: <linux-iio@vger.kernel.org>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 06:32:45PM -0600, Michael Welling wrote:
> On Fri, Feb 05, 2016 at 09:32:34PM +0200, Daniel Baluta wrote:
> > >> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> > >> +                         struct iio_chan_spec const *chan, int *val,
> > >> +                         int *val2, long mask)
> > >> +{
> > >> +     int ret, idx;
> > >> +     struct ads1015_data *data =3D iio_priv(indio_dev);
> > >> +
> > >> +     mutex_lock(&data->lock);
> > >> +     switch (mask) {
> > >> +     case IIO_CHAN_INFO_RAW:
> > >> +             if (iio_buffer_enabled(indio_dev)) {
> > >> +                     ret =3D -EBUSY;
> > >> +                     break;
> > >> +             }
> > >> +
> > >> +             ret =3D ads1015_set_power_state(data, true);
> > >> +             if (ret < 0)
> > >> +                     break;
> > >
> > > Just tested the driver on a Dragonboard 410C with a robotics mezzanin=
e that I
> > > designed.
> > >
> > > The above ads1015_set_power_state(data, true) is always returning -EI=
NVAL.
> > >
> > > Any ideas why that would be happening?
> > > I think it may be the return from pm_runtime_get_sync?
> >=20
> > Can you confirm that pm_runtime_get_sync fails? Using some printk?
> >=20
> > Also adding printks in suspend/resume function would be helpful. Do
> > you have CONFIG_PM enabled?
> >
>=20
> Indeed it is the pm_runtime_get_sync that fails with a -EINVAL.
>=20
> > >
> > > When I comment out the break the readings come back but are not updat=
ed continually.
> > > If I read in_voltage0-voltage1_raw then in_voltage0_raw the value is =
updated.
> >=20
> > I guess this is normal if set_power_state fails.
>=20
> The hwmod driver works fine BTW.
>=20
> My guess is there is an issue with the qup i2c driver seeing as it has wo=
rked on
> other system without issue.
>=20
> CC'd some the latest developer on the qup i2c driver.
>=20
> I2C guys have any ideas on this?
>=20

Adding some more people who recently worked on this. Might be nice to
know which kernel version you are using.

> >=20
> > thanks,
> > Daniel.

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuGz7AAoJEBQN5MwUoCm2qAEP/2st0VPHVDqIzodwsozYHFYf
M+glFHGfVD1Mk2mF75xx4z30J9ycBJuzhmgp+VF75doOE0LZwypBe1SMorBhAhiu
+cJBv9wZEaprfgawd+g0EgNHM/lWJPzfjf/QBOiBiBh2GfsC/odVa7drlfWZb2fk
hvE64d5NOgDqArDkGtAz3K8s71UTM44Ay8wYIXLgY/AaBqV7odAXHmTjIPMnFojr
wGH+FK0FfUe51FEL2MZLnqlbqN/uzWizeoQh/7IbF8Ftk1UXpS9mXanS1M+AHdQc
Y2DVxGnNGr9A53Umalhex3U23YFHpLoytErYDmqwvK0nicMrHKF6QQQ8GX0O51Ib
6eLcLY8A6pcu5nj9VGPFTO8uwpxIQb97TkUGpO+5VXOw7l/V4hUrU+BOC1dx68bq
ncgmRn1lXAib59DI8VG04pK8wCpMnDL9BotZQIA3qaqVa0BuFY6ZwfqGBvAHhfYF
GJPSlj/NAvIQf0QX9z/8SVbfxl+B25wZ/QcRjZ/bFhYANlK7tY6CL/YcIelYiW5Z
DnS6zJMgcidjNO22mgl5JWCXDme4tvrGyHZNNknz0c/1y6fUjRE9JpsTe5cz7Uqc
Ozofp8xevt4j/rDdr9BtlKFN+6AfbPzAvEH9HY9+qfP6bSPG+3WkYt6JefAE39Kv
rwzUTMYq8W2qmchaUG26
=+gDK
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
