Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbaIRNhA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Sep 2014 09:37:00 -0400
Date: Thu, 18 Sep 2014 08:36:31 -0500
From: Felipe Balbi <balbi@ti.com>
To: Felipe Balbi <balbi@ti.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<pmeerw@pmeerw.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] iio: light: add support for TI's opt3001 light
 sensor
Message-ID: <20140918133631.GA24847@saruman.home>
Reply-To: <balbi@ti.com>
References: <1409671066-25747-1-git-send-email-balbi@ti.com>
 <54147632.9090204@kernel.org>
 <20140915052137.GA11866@saruman.home>
 <20140916170316.GD19010@saruman.home>
 <20140917150041.GA6903@saruman.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <20140917150041.GA6903@saruman.home>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ping

On Wed, Sep 17, 2014 at 10:00:41AM -0500, Felipe Balbi wrote:
> ping
>=20
> On Tue, Sep 16, 2014 at 12:03:16PM -0500, Felipe Balbi wrote:
> > ping
> >=20
> > On Mon, Sep 15, 2014 at 12:21:37AM -0500, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Sat, Sep 13, 2014 at 05:52:02PM +0100, Jonathan Cameron wrote:
> > > > On 02/09/14 16:17, Felipe Balbi wrote:
> > > > > TI's opt3001 light sensor is a simple and yet powerful
> > > > > little device. The device provides 99% IR rejection,
> > > > > Automatic full-scale, very low power consumption and
> > > > > measurements from 0.01 to 83k lux.
> > > > >=20
> > > > > This patch adds support for that device using the IIO
> > > > > framework.
> > > > >=20
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > ---
> > > > >=20
> > > > > Resending as I saw no changes on the thread.
> > > > Hi Felipe,
> > > >=20
> > > > Sorry for the delay on this, entirely my fault - been busy and forg=
ot
> > > > I still had questions about what was going on in here (yup its the
> > > > hysteresis bit again!)
> > >=20
> > > right, this is starting to become way too much headache for such a
> > > simple device. Sorry will not help me getting this driver upstream. W=
hen
> > > I first sent this (August 6), we didn't even have v3.17-rc1, now we're
> > > about to tag -rc5 and I'm worried this driver will not hit v3.18 merge
> > > window.
> > >=20
> > > > Anyhow, I'm afraid I am still a little confused about the meaning y=
ou
> > > > have assigned to Hysteresis in this driver.
> > > >=20
> > > > Let me conjecture on what might be going on here (I may be entirely
> > > > wrong).
> > > >=20
> > > > Normally a hysteresis value in IIO is defined as the 'distance' back
> > > > from a threshold that a signal must go before it may retrip the
> > > > threshold.
> > > > This threshold value is separately controlled. Thus if we have a
> > > > rising threshold of 10 and an hysteresis of 2 - to get two events t=
he
> > > > signal must first rise past 10, then drop back below 8 and rise aga=
in
> > > > past 10.
> > > > If it drops below 10 but not 8 and rises again past 10 then we will
> > > > not get an event.
> > > >=20
> > > > So having the same register for both the hysteresis and the thresho=
ld
> > > > doesn't with this description make much sense.  It would mean that =
you
> > > > could only have a threshold of say 10 and a hysteresis of 10, thus =
in
> > > > effect meaning the signal would always have to cross 0 before the n=
ext
> > > > event whatever the combined threshold / hysteresis value?
> > > >=20
> > > > Perhaps instead the device is automatically adjusting the threshold
> > > > when we cross it and the 'hysteresis' here is with respect to a the
> > > > previous threshold?
> > > >=20
> > > > Thus if we start with a value of 0 and hysteresis is set to 2 it wi=
ll
> > > > trigger an event at:
> > > >=20
> > > > 2, 4, 6, 8, 10 as we rise?
> > > >=20
> > > > This sort of auto adjustment of levels isn't uncommon in light sens=
ors
> > > > (where the point of the interrupt is to notify the operating system
> > > > that a 'significant' change has occurred and things like screen
> > > > brightness may need adjusting.
> > > >=20
> > > > If so then the current hysteresis interface does not apply, nor does
> > > > the Rate of Change (ROC) interface as this is dependent on amount of
> > > > change, not how fast it changed.  Hence we needs something new to
> > > > handle this cleanly. I would suggest a new event type.  Perhaps
> > > > something with sysfs attr naming along the lines of
> > > > What:		/sys/.../iio:deviceX/events/in_light_change_rising_en
> > > > What:           /sys/.../iio:deviceX/events/in_light_change_rising_=
value
> > > >=20
> > > > etc?
> > >=20
> > > will you just tell me what you want ? I really cannot give a crap
> > > anymore. This has already taken me over a month of my time for such a
> > > simple little device, not to mention your confusing and contradicting
> > > change requests.
> > >=20
> > > (could you also trim your responses ? it's very annoying to scroll so
> > > much)
> > >=20
> > > > > +#define OPT3001_RESULT		0x00
> > > > > +#define OPT3001_CONFIGURATION	0x01
> > > > > +#define OPT3001_LOW_LIMIT	0x02
> > > > > +#define OPT3001_HIGH_LIMIT	0x03
> > > > > +#define OPT3001_MANUFACTURER_ID	0x7e
> > > > > +#define OPT3001_DEVICE_ID	0x7f
> > > > > +
> > > > > +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
> > > > > +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
> > > > > +
> > > > > +#define OPT3001_CONFIGURATION_CT	BIT(11)
> > > > > +
> > > > > +#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
> > > > > +#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> > > > > +#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
> > > > > +#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 <<=
 9 */
> > > > > +
> > > >=20
> > > > I guess this naming is straight off the datasheet, but it is rather
> > > > more cryptic than perhaps it needs to be!  That's kind of an issue
> > > > with the datasheet choices rather than what you have here however!
> > >=20
> > > man, are you nit-picky!! These are named as such to make grepping on
> > > documentation easier. It's better to have something that matches
> > > documentation, don't you think ? otherwise, future users/developers of
> > > these driver will need either a shit ton of comments explaining that A
> > > maps to B in docs, or will need a fscking crystal ball to read my min=
d.
> > > Assuming I'll still remember what I meant.
> > >=20
> > > > > +static int opt3001_remove(struct i2c_client *client)
> > > > > +{
> > > > > +	struct iio_dev *iio =3D i2c_get_clientdata(client);
> > > > > +	struct opt3001 *opt =3D iio_priv(iio);
> > > > > +	int ret;
> > > > > +	u16 reg;
> > > > > +
> > > > > +	free_irq(client->irq, iio);
> > > > > +	iio_device_unregister(iio);
> > > > > +
> > > > > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIG=
URATION);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(opt->dev, "failed to read register %02x\n",
> > > > > +				OPT3001_CONFIGURATION);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	reg =3D ret;
> > > > > +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> > > > > +
> > > > > +	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFI=
GURATION,
> > > > > +			reg);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(opt->dev, "failed to write register %02x\n",
> > > > > +				OPT3001_CONFIGURATION);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	iio_device_free(iio);
> > > >
> > > > Use the devm_iio_device_alloc and you can drop the need to free it.
> > > > I don't really mind, but I'll almost guarantee that someone will po=
st
> > > > a follow up patch doing this if you don't.  As it will be ever so
> > > > slightly cleaner, I'll probably take that patch.
> > >=20
> > > here's the original driver:
> > >=20
> > > http://www.spinics.net/lists/linux-iio/msg14331.html
> > >=20
> > > notice that it *WAS* *USING* devm_iio_device_alloc(), until:
> > >=20
> > > http://www.spinics.net/lists/linux-iio/msg14421.html
> > >=20
> > > you *SPECIFICALLY* asked for *NON* *DEVM* versions!!
> > >=20
> > > So figure out what you really want, let me know and I'll code it all =
up
> > > quickly and hopefully still get this into v3.18 merge window. I sent
> > > this driver *very* early to be doubly sure it would hit v3.18 and the=
re
> > > was a long hiatus from yourself which is now jeopardizing what I was
> > > expecting. That, coupled with your contradicting requests, has just p=
ut
> > > me in a bad mood, even before Monday, hurray.
> > >=20
> > > cheers
> > >=20
> > > --=20
> > > balbi
> >=20
> >=20
> >=20
> > --=20
> > balbi
>=20
>=20
>=20
> --=20
> balbi



--=20
balbi

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGt/fAAoJEIaOsuA1yqRExq0P/1HQY6lwjlyCx/cPLl1PY2aK
bxFKnXvnRKkuCZzxXnT7ncue/tj1cy+uEIPM0oPAqnLQVA+bXZCBTrRDxIJKh5OG
Kjwq83exGPYl4ZTDZHUn4ZHkydyZ7CG8tcx7RtP/rZONl0aOMYR8kyP+q8+Tau7u
hV8QthHvj37iExQZJlKOgvVknfmAiq7skJ3Db6lkCI4E68nR0DhiDRdeABuKb9TW
On+a909tbycC2gurs4tLutMzeZ18OWJVTj57MKkoth9zPTCPpnx8qpgPo0sxgpyq
RB4l+aV40dlco925M7iiKtV7ocger02j0g6GZetZAuk0T3a2QY4iKUhX/jxDloIl
aiwo26e8D0reWMQys1wmsVm+dxsZeZ7ZLzhhezBFoRLNwgXhiN6DProeUJhhTcKW
Q3hAvDZq+XMWUvbDLdUb+cd2IkJyOZTfaFxpcUFMWYybGuJO7Q71/tBFMQa7BS8H
I9X/Enh1fo5/L6bU43BHj89PsVGrizVvnCEhQDIUalQI9kgWqObMzkoQwObUf75L
kA6sHxlThWPI2Vh2/g9dUXTmH6kMjHvoIf2YC7QkRqF/Nv2hhzQOC58lhXrlBJCk
HbognX0uThROPEhMYFcmRWq6FPf+7srd/HhspnaCLjjAkjXrNSxr40yJudv24t/L
kA4pq/24lr9wpusZFr7T
=VW0m
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
