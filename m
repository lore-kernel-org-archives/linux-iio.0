Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaHNUS3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 16:18:29 -0400
Date: Thu, 14 Aug 2014 15:17:44 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
Message-ID: <20140814201744.GA4929@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407940605-12270-1-git-send-email-balbi@ti.com>
 <53ECE90A.8010609@kernel.org>
 <20140814170530.GB1445@saruman.home>
 <53ECF070.5040304@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
In-Reply-To: <53ECF070.5040304@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2014 at 06:22:56PM +0100, Jonathan Cameron wrote:
> On 14/08/14 18:05, Felipe Balbi wrote:
> > hi,
> >=20
> > On Thu, Aug 14, 2014 at 05:51:22PM +0100, Jonathan Cameron wrote:
> >> On 13/08/14 15:36, Felipe Balbi wrote:
> >>> TI's opt3001 light sensor is a simple and yet powerful
> >>> little device. The device provides 99% IR rejection,
> >>> Automatic full-scale, very low power consumption and
> >>> measurements from 0.01 to 83k lux.
> >>>
> >>> This patch adds support for that device using the IIO
> >>> framework.
> >>>
> >>> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> Please fix your patch title spelling of light!
> >=20
> > alright done and sent another version too.
> >=20
> >> I'm not keen on the ordering during remove and
> >> your use of hysteresis does not conform to the ABI so please
> >> take a look at that and the other drivers that make use of it.
> >=20
> > see below
> >=20
> >> Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio
> >>
> >> Specifies the hysteresis of threshold that the device is comparing
> >> 	against for the events enabled by
> >> 	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
> >=20
> > this is exactly what the driver is doing, read again
> This is really hard without access to the datasheet.  It appeared you were
> simply enabling hystersis on an event if the threshold was written to tha=
t.
>=20
> The threshold would be the one written by using the value attribute.
>=20
> So right now if you set hystersis to 10 then value will also be set to 10.
>=20
> Hence, if the value reaches 10 once.  An event is triggered.  After that
> for another event the value will have to hit 10 - 10 =3D 0 before again
> passing 10.
>=20
> Is this really what is happening?

yes it is. It's confusing because the same value register is used for
hysteresis and non-hysteresis modes.

> >>> +static int opt3001_read_id(struct opt3001 *opt)
> >>> +{
> >>> +	char manufacturer[2];
> >>> +	u16 device_id;
> >>> +	int ret;
> >>> +
> >>> +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTUR=
ER_ID);
> >>> +	if (ret < 0) {
> >>> +		dev_err(opt->dev, "failed to read register %02x\n",
> >>> +				OPT3001_MANUFACTURER_ID);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	manufacturer[0] =3D ret >> 8;
> >>> +	manufacturer[1] =3D ret & 0xff;
> >> I would be a little 'unusual' but you could use an endian conversion h=
ere :)
> >> Perhaps better to have the clarity of the way you have done it!
> >=20
> > byte ordering is already handled by read_word_swapped, though.
> Fair point.  Not an endian conversion, but rather an evil bit of type
> casting that isn't worth bothering with.

right, so what you wanna do with this ?

> >>> +static int opt3001_remove(struct i2c_client *client)
> >>> +{
> >>> +	struct opt3001 *opt =3D i2c_get_clientdata(client);
> >>> +	int ret;
> >>> +	u16 reg;
> >>> +
> >>
> >> So here you are shutting down the part before removing the userspace i=
nterfaces
> >> (due to using the devm_iio_unregister).  I'm guessing this might creat=
e some
> >> interesting race conditions.  Would prefer to see non devm versions of=
 the
> >> register and irq request to ensure the ordering is exactly what we wou=
ld
> >> expect.
> >=20
> > this will cause no problems whatsoever. The device is *always* shutdown
> > unless I left a continuous transfer running. This is coping with that
> > only situation.
> Hmm. So shutdown in this case is fairly minor and doesn't effect register
> reads for example.  Fair enough.

no, it doesn't.

> > It's also unnecessary to check if we have a continuous
> > transfer running because shutting down something which is already
> > shutdown won't cause any problems with this device.
> >=20
> > Dropping devm_* would just add pointless complexity to the remove
> > function.
>=20
> But make it obviously correct, which it isn't right now.  For the
> cost of about 4 lines of code...

it's more than that since we'll have to add more lines of code to handle
error inside the probe() function. Frankly, it's pretty pointless to go
down that route; if that's really what you want, I'll do it. Coudln't
care less, really.

--=20
balbi

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7RloAAoJEIaOsuA1yqRESDoP/0QxceCs+ZqO+Brx9m1QItb/
hhLYlXbEqnDwgOu4uUexKUqsw+bkXTu2XRg3s/JEm6GIDOCgcjN1WWOtZHRJBmIN
nCBdiVfM88hCSlDz3SdDumFJNST49I6gKuqBfKjAX5sWszR2cJVNv2POuktB2Nul
XcMu1bx3do8nGKbMUpIqVAFgwVCL/pFoJVfPEbARc1t+EW5V3sL6Hy6S2RyyqOBz
4aoeBC+wV1AmV+Hg0vU0QW6L3GznaY65nMEj1JyMAZOO+kN/qHJgaAOPuosXho+4
koaADWA/T8pNE+ozhcalVHKW1EcbHx7IGU0szVn4zqnk08VbYywZUg8SrxBl+XaP
tytbaSBsp7kq7sF1xshTY74YGtxOLcBkiMaWjVvxS7Zu6B3zmhpSztADCTyNiQmm
o0Awjm6tVf8qRzMTsw+snw5f83sB0vurmCksLtLbMVQJ1eGjYqvj+AlsFL6y9T62
8O5kqgbvhZThvJtEEl3nrXoUXdlD1yiBBqBS+HICKabanH7QuzHRZOcdIbL3+I1A
OcQ8VjAMAkV4fucJ6yvaeA4MfWxoSGzRD9sYm5Ej6TUKzA3+ztgTh/v+N0WpxilN
P10DuV7w0XL10YgMKwFEaHB7P97/m0hZrrx81Wvzxn6l2lQDGTLtMnq7DphjRfNo
NBsnXDUici0PhiDOjqWp
=JdOc
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
