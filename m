Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbaIWOJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Sep 2014 10:09:36 -0400
Date: Tue, 23 Sep 2014 09:09:24 -0500
From: Felipe Balbi <balbi@ti.com>
To: Felipe Balbi <balbi@ti.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<pmeerw@pmeerw.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] iio: light: add support for TI's opt3001 light
 sensor
Message-ID: <20140923140924.GA28592@saruman>
Reply-To: <balbi@ti.com>
References: <1409671066-25747-1-git-send-email-balbi@ti.com>
 <54147632.9090204@kernel.org>
 <20140915052137.GA11866@saruman.home>
 <20140916170316.GD19010@saruman.home>
 <20140917150041.GA6903@saruman.home>
 <20140918133631.GA24847@saruman.home>
 <20140919162129.GE26946@saruman.home>
 <20140922140914.GC25620@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <20140922140914.GC25620@saruman>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ping

On Mon, Sep 22, 2014 at 09:09:14AM -0500, Felipe Balbi wrote:
> ping
>=20
> On Fri, Sep 19, 2014 at 11:21:29AM -0500, Felipe Balbi wrote:
> > ping
> >=20
> > On Thu, Sep 18, 2014 at 08:36:31AM -0500, Felipe Balbi wrote:
> > > ping
> > >=20
> > > On Wed, Sep 17, 2014 at 10:00:41AM -0500, Felipe Balbi wrote:
> > > > ping
> > > >=20
> > > > On Tue, Sep 16, 2014 at 12:03:16PM -0500, Felipe Balbi wrote:
> > > > > ping
> > > > >=20
> > > > > On Mon, Sep 15, 2014 at 12:21:37AM -0500, Felipe Balbi wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Sat, Sep 13, 2014 at 05:52:02PM +0100, Jonathan Cameron wrot=
e:
> > > > > > > On 02/09/14 16:17, Felipe Balbi wrote:
> > > > > > > > TI's opt3001 light sensor is a simple and yet powerful
> > > > > > > > little device. The device provides 99% IR rejection,
> > > > > > > > Automatic full-scale, very low power consumption and
> > > > > > > > measurements from 0.01 to 83k lux.
> > > > > > > >=20
> > > > > > > > This patch adds support for that device using the IIO
> > > > > > > > framework.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > > > > ---
> > > > > > > >=20
> > > > > > > > Resending as I saw no changes on the thread.
> > > > > > > Hi Felipe,
> > > > > > >=20
> > > > > > > Sorry for the delay on this, entirely my fault - been busy an=
d forgot
> > > > > > > I still had questions about what was going on in here (yup it=
s the
> > > > > > > hysteresis bit again!)
> > > > > >=20
> > > > > > right, this is starting to become way too much headache for suc=
h a
> > > > > > simple device. Sorry will not help me getting this driver upstr=
eam. When
> > > > > > I first sent this (August 6), we didn't even have v3.17-rc1, no=
w we're
> > > > > > about to tag -rc5 and I'm worried this driver will not hit v3.1=
8 merge
> > > > > > window.
> > > > > >=20
> > > > > > > Anyhow, I'm afraid I am still a little confused about the mea=
ning you
> > > > > > > have assigned to Hysteresis in this driver.
> > > > > > >=20
> > > > > > > Let me conjecture on what might be going on here (I may be en=
tirely
> > > > > > > wrong).
> > > > > > >=20
> > > > > > > Normally a hysteresis value in IIO is defined as the 'distanc=
e' back
> > > > > > > from a threshold that a signal must go before it may retrip t=
he
> > > > > > > threshold.
> > > > > > > This threshold value is separately controlled. Thus if we hav=
e a
> > > > > > > rising threshold of 10 and an hysteresis of 2 - to get two ev=
ents the
> > > > > > > signal must first rise past 10, then drop back below 8 and ri=
se again
> > > > > > > past 10.
> > > > > > > If it drops below 10 but not 8 and rises again past 10 then w=
e will
> > > > > > > not get an event.
> > > > > > >=20
> > > > > > > So having the same register for both the hysteresis and the t=
hreshold
> > > > > > > doesn't with this description make much sense.  It would mean=
 that you
> > > > > > > could only have a threshold of say 10 and a hysteresis of 10,=
 thus in
> > > > > > > effect meaning the signal would always have to cross 0 before=
 the next
> > > > > > > event whatever the combined threshold / hysteresis value?
> > > > > > >=20
> > > > > > > Perhaps instead the device is automatically adjusting the thr=
eshold
> > > > > > > when we cross it and the 'hysteresis' here is with respect to=
 a the
> > > > > > > previous threshold?
> > > > > > >=20
> > > > > > > Thus if we start with a value of 0 and hysteresis is set to 2=
 it will
> > > > > > > trigger an event at:
> > > > > > >=20
> > > > > > > 2, 4, 6, 8, 10 as we rise?
> > > > > > >=20
> > > > > > > This sort of auto adjustment of levels isn't uncommon in ligh=
t sensors
> > > > > > > (where the point of the interrupt is to notify the operating =
system
> > > > > > > that a 'significant' change has occurred and things like scre=
en
> > > > > > > brightness may need adjusting.
> > > > > > >=20
> > > > > > > If so then the current hysteresis interface does not apply, n=
or does
> > > > > > > the Rate of Change (ROC) interface as this is dependent on am=
ount of
> > > > > > > change, not how fast it changed.  Hence we needs something ne=
w to
> > > > > > > handle this cleanly. I would suggest a new event type.  Perha=
ps
> > > > > > > something with sysfs attr naming along the lines of
> > > > > > > What:		/sys/.../iio:deviceX/events/in_light_change_rising_en
> > > > > > > What:           /sys/.../iio:deviceX/events/in_light_change_r=
ising_value
> > > > > > >=20
> > > > > > > etc?
> > > > > >=20
> > > > > > will you just tell me what you want ? I really cannot give a cr=
ap
> > > > > > anymore. This has already taken me over a month of my time for =
such a
> > > > > > simple little device, not to mention your confusing and contrad=
icting
> > > > > > change requests.
> > > > > >=20
> > > > > > (could you also trim your responses ? it's very annoying to scr=
oll so
> > > > > > much)
> > > > > >=20
> > > > > > > > +#define OPT3001_RESULT		0x00
> > > > > > > > +#define OPT3001_CONFIGURATION	0x01
> > > > > > > > +#define OPT3001_LOW_LIMIT	0x02
> > > > > > > > +#define OPT3001_HIGH_LIMIT	0x03
> > > > > > > > +#define OPT3001_MANUFACTURER_ID	0x7e
> > > > > > > > +#define OPT3001_DEVICE_ID	0x7f
> > > > > > > > +
> > > > > > > > +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
> > > > > > > > +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
> > > > > > > > +
> > > > > > > > +#define OPT3001_CONFIGURATION_CT	BIT(11)
> > > > > > > > +
> > > > > > > > +#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
> > > > > > > > +#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> > > > > > > > +#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
> > > > > > > > +#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* als=
o 3 << 9 */
> > > > > > > > +
> > > > > > >=20
> > > > > > > I guess this naming is straight off the datasheet, but it is =
rather
> > > > > > > more cryptic than perhaps it needs to be!  That's kind of an =
issue
> > > > > > > with the datasheet choices rather than what you have here how=
ever!
> > > > > >=20
> > > > > > man, are you nit-picky!! These are named as such to make greppi=
ng on
> > > > > > documentation easier. It's better to have something that matches
> > > > > > documentation, don't you think ? otherwise, future users/develo=
pers of
> > > > > > these driver will need either a shit ton of comments explaining=
 that A
> > > > > > maps to B in docs, or will need a fscking crystal ball to read =
my mind.
> > > > > > Assuming I'll still remember what I meant.
> > > > > >=20
> > > > > > > > +static int opt3001_remove(struct i2c_client *client)
> > > > > > > > +{
> > > > > > > > +	struct iio_dev *iio =3D i2c_get_clientdata(client);
> > > > > > > > +	struct opt3001 *opt =3D iio_priv(iio);
> > > > > > > > +	int ret;
> > > > > > > > +	u16 reg;
> > > > > > > > +
> > > > > > > > +	free_irq(client->irq, iio);
> > > > > > > > +	iio_device_unregister(iio);
> > > > > > > > +
> > > > > > > > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_=
CONFIGURATION);
> > > > > > > > +	if (ret < 0) {
> > > > > > > > +		dev_err(opt->dev, "failed to read register %02x\n",
> > > > > > > > +				OPT3001_CONFIGURATION);
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	reg =3D ret;
> > > > > > > > +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTD=
OWN);
> > > > > > > > +
> > > > > > > > +	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT3001=
_CONFIGURATION,
> > > > > > > > +			reg);
> > > > > > > > +	if (ret < 0) {
> > > > > > > > +		dev_err(opt->dev, "failed to write register %02x\n",
> > > > > > > > +				OPT3001_CONFIGURATION);
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	iio_device_free(iio);
> > > > > > >
> > > > > > > Use the devm_iio_device_alloc and you can drop the need to fr=
ee it.
> > > > > > > I don't really mind, but I'll almost guarantee that someone w=
ill post
> > > > > > > a follow up patch doing this if you don't.  As it will be eve=
r so
> > > > > > > slightly cleaner, I'll probably take that patch.
> > > > > >=20
> > > > > > here's the original driver:
> > > > > >=20
> > > > > > http://www.spinics.net/lists/linux-iio/msg14331.html
> > > > > >=20
> > > > > > notice that it *WAS* *USING* devm_iio_device_alloc(), until:
> > > > > >=20
> > > > > > http://www.spinics.net/lists/linux-iio/msg14421.html
> > > > > >=20
> > > > > > you *SPECIFICALLY* asked for *NON* *DEVM* versions!!
> > > > > >=20
> > > > > > So figure out what you really want, let me know and I'll code i=
t all up
> > > > > > quickly and hopefully still get this into v3.18 merge window. I=
 sent
> > > > > > this driver *very* early to be doubly sure it would hit v3.18 a=
nd there
> > > > > > was a long hiatus from yourself which is now jeopardizing what =
I was
> > > > > > expecting. That, coupled with your contradicting requests, has =
just put
> > > > > > me in a bad mood, even before Monday, hurray.
> > > > > >=20
> > > > > > cheers
> > > > > >=20
> > > > > > --=20
> > > > > > balbi
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > --=20
> > > > > balbi
> > > >=20
> > > >=20
> > > >=20
> > > > --=20
> > > > balbi
> > >=20
> > >=20
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

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIX8UAAoJEIaOsuA1yqREOyEP/3qPhmi6t88OVmZtMNV6jAg+
NcxA6qSb+MpbeNVWlcJFnFDI+YpaSKJEvsUswiuXpePWirxS9BVVoTHOwsL1hFB7
yaxk1d7WtKKIxWwFRwKB5EwC5m4I1nd+4+KSju3X14oYx/YI9j3Lp13W7b5ka7mb
x6BKneuwyhBfrcoGh2Vgq6NShndNLb/OL6OIT4WEAI/HjfqXfrNai5Q6D+u69rGb
bVXbgUBH3QHSqXRbbu0vzLQ0PjfUQqJE0tFCjtpKZDeV0lW1Dv42ntfBRQcdXSR2
OjJq9KVDjWv81F6GsYafwPfJRPhBBA9zlLi1Yuf2xkGLKWLV4It7W8kYUSts5I99
5dvLuN5Q5XNs2R+70IUV/rVhybHpBgZcJ5RXEjU4sznzKTHIt6KNrmf3qT8yQvC/
QuyjRqPGV5TEfeaYv2umUMUHdr9LENkRAxVE+opuiBlh0nNTRctr8sU4L/AU3nxU
9dYFGZL9Np9LTDUUyyqkZxZSnBWjyJHmSyDiHMvC7p6a+PhGcdhIOUbbdOIJuAG9
fS/H367YoHtDRfwGAoYC2jfEw2sUnV+cPNy6mfBcd8F+VuOvglmDXnvjCVJKw9e2
3eyaPj/tF0rfvSJeNTnaXA+Kv538ZQxDWTuV9oK8cGNcS9nLpI8+K4gT+HV/RVXY
b1yMj90H/FRr46OuCgY0
=OFLb
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
