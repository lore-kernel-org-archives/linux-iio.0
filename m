Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33113 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbaIYWQ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 25 Sep 2014 18:16:29 -0400
Date: Thu, 25 Sep 2014 17:16:19 -0500
From: Felipe Balbi <balbi@ti.com>
To: Felipe Balbi <balbi@ti.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<pmeerw@pmeerw.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] iio: light: add support for TI's opt3001 light
 sensor
Message-ID: <20140925221619.GA10644@saruman>
Reply-To: <balbi@ti.com>
References: <1409671066-25747-1-git-send-email-balbi@ti.com>
 <54147632.9090204@kernel.org>
 <20140915052137.GA11866@saruman.home>
 <20140916170316.GD19010@saruman.home>
 <20140917150041.GA6903@saruman.home>
 <20140918133631.GA24847@saruman.home>
 <20140919162129.GE26946@saruman.home>
 <20140922140914.GC25620@saruman>
 <20140923140924.GA28592@saruman>
 <20140924143610.GA17997@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <20140924143610.GA17997@saruman>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ping

On Wed, Sep 24, 2014 at 09:36:10AM -0500, Felipe Balbi wrote:
> ping
>=20
> On Tue, Sep 23, 2014 at 09:09:24AM -0500, Felipe Balbi wrote:
> > ping
> >=20
> > On Mon, Sep 22, 2014 at 09:09:14AM -0500, Felipe Balbi wrote:
> > > ping
> > >=20
> > > On Fri, Sep 19, 2014 at 11:21:29AM -0500, Felipe Balbi wrote:
> > > > ping
> > > >=20
> > > > On Thu, Sep 18, 2014 at 08:36:31AM -0500, Felipe Balbi wrote:
> > > > > ping
> > > > >=20
> > > > > On Wed, Sep 17, 2014 at 10:00:41AM -0500, Felipe Balbi wrote:
> > > > > > ping
> > > > > >=20
> > > > > > On Tue, Sep 16, 2014 at 12:03:16PM -0500, Felipe Balbi wrote:
> > > > > > > ping
> > > > > > >=20
> > > > > > > On Mon, Sep 15, 2014 at 12:21:37AM -0500, Felipe Balbi wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > On Sat, Sep 13, 2014 at 05:52:02PM +0100, Jonathan Cameron =
wrote:
> > > > > > > > > On 02/09/14 16:17, Felipe Balbi wrote:
> > > > > > > > > > TI's opt3001 light sensor is a simple and yet powerful
> > > > > > > > > > little device. The device provides 99% IR rejection,
> > > > > > > > > > Automatic full-scale, very low power consumption and
> > > > > > > > > > measurements from 0.01 to 83k lux.
> > > > > > > > > >=20
> > > > > > > > > > This patch adds support for that device using the IIO
> > > > > > > > > > framework.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > > > > > > ---
> > > > > > > > > >=20
> > > > > > > > > > Resending as I saw no changes on the thread.
> > > > > > > > > Hi Felipe,
> > > > > > > > >=20
> > > > > > > > > Sorry for the delay on this, entirely my fault - been bus=
y and forgot
> > > > > > > > > I still had questions about what was going on in here (yu=
p its the
> > > > > > > > > hysteresis bit again!)
> > > > > > > >=20
> > > > > > > > right, this is starting to become way too much headache for=
 such a
> > > > > > > > simple device. Sorry will not help me getting this driver u=
pstream. When
> > > > > > > > I first sent this (August 6), we didn't even have v3.17-rc1=
, now we're
> > > > > > > > about to tag -rc5 and I'm worried this driver will not hit =
v3.18 merge
> > > > > > > > window.
> > > > > > > >=20
> > > > > > > > > Anyhow, I'm afraid I am still a little confused about the=
 meaning you
> > > > > > > > > have assigned to Hysteresis in this driver.
> > > > > > > > >=20
> > > > > > > > > Let me conjecture on what might be going on here (I may b=
e entirely
> > > > > > > > > wrong).
> > > > > > > > >=20
> > > > > > > > > Normally a hysteresis value in IIO is defined as the 'dis=
tance' back
> > > > > > > > > from a threshold that a signal must go before it may retr=
ip the
> > > > > > > > > threshold.
> > > > > > > > > This threshold value is separately controlled. Thus if we=
 have a
> > > > > > > > > rising threshold of 10 and an hysteresis of 2 - to get tw=
o events the
> > > > > > > > > signal must first rise past 10, then drop back below 8 an=
d rise again
> > > > > > > > > past 10.
> > > > > > > > > If it drops below 10 but not 8 and rises again past 10 th=
en we will
> > > > > > > > > not get an event.
> > > > > > > > >=20
> > > > > > > > > So having the same register for both the hysteresis and t=
he threshold
> > > > > > > > > doesn't with this description make much sense.  It would =
mean that you
> > > > > > > > > could only have a threshold of say 10 and a hysteresis of=
 10, thus in
> > > > > > > > > effect meaning the signal would always have to cross 0 be=
fore the next
> > > > > > > > > event whatever the combined threshold / hysteresis value?
> > > > > > > > >=20
> > > > > > > > > Perhaps instead the device is automatically adjusting the=
 threshold
> > > > > > > > > when we cross it and the 'hysteresis' here is with respec=
t to a the
> > > > > > > > > previous threshold?
> > > > > > > > >=20
> > > > > > > > > Thus if we start with a value of 0 and hysteresis is set =
to 2 it will
> > > > > > > > > trigger an event at:
> > > > > > > > >=20
> > > > > > > > > 2, 4, 6, 8, 10 as we rise?
> > > > > > > > >=20
> > > > > > > > > This sort of auto adjustment of levels isn't uncommon in =
light sensors
> > > > > > > > > (where the point of the interrupt is to notify the operat=
ing system
> > > > > > > > > that a 'significant' change has occurred and things like =
screen
> > > > > > > > > brightness may need adjusting.
> > > > > > > > >=20
> > > > > > > > > If so then the current hysteresis interface does not appl=
y, nor does
> > > > > > > > > the Rate of Change (ROC) interface as this is dependent o=
n amount of
> > > > > > > > > change, not how fast it changed.  Hence we needs somethin=
g new to
> > > > > > > > > handle this cleanly. I would suggest a new event type.  P=
erhaps
> > > > > > > > > something with sysfs attr naming along the lines of
> > > > > > > > > What:		/sys/.../iio:deviceX/events/in_light_change_rising=
_en
> > > > > > > > > What:           /sys/.../iio:deviceX/events/in_light_chan=
ge_rising_value
> > > > > > > > >=20
> > > > > > > > > etc?
> > > > > > > >=20
> > > > > > > > will you just tell me what you want ? I really cannot give =
a crap
> > > > > > > > anymore. This has already taken me over a month of my time =
for such a
> > > > > > > > simple little device, not to mention your confusing and con=
tradicting
> > > > > > > > change requests.
> > > > > > > >=20
> > > > > > > > (could you also trim your responses ? it's very annoying to=
 scroll so
> > > > > > > > much)
> > > > > > > >=20
> > > > > > > > > > +#define OPT3001_RESULT		0x00
> > > > > > > > > > +#define OPT3001_CONFIGURATION	0x01
> > > > > > > > > > +#define OPT3001_LOW_LIMIT	0x02
> > > > > > > > > > +#define OPT3001_HIGH_LIMIT	0x03
> > > > > > > > > > +#define OPT3001_MANUFACTURER_ID	0x7e
> > > > > > > > > > +#define OPT3001_DEVICE_ID	0x7f
> > > > > > > > > > +
> > > > > > > > > > +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
> > > > > > > > > > +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
> > > > > > > > > > +
> > > > > > > > > > +#define OPT3001_CONFIGURATION_CT	BIT(11)
> > > > > > > > > > +
> > > > > > > > > > +#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
> > > > > > > > > > +#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
> > > > > > > > > > +#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
> > > > > > > > > > +#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /*=
 also 3 << 9 */
> > > > > > > > > > +
> > > > > > > > >=20
> > > > > > > > > I guess this naming is straight off the datasheet, but it=
 is rather
> > > > > > > > > more cryptic than perhaps it needs to be!  That's kind of=
 an issue
> > > > > > > > > with the datasheet choices rather than what you have here=
 however!
> > > > > > > >=20
> > > > > > > > man, are you nit-picky!! These are named as such to make gr=
epping on
> > > > > > > > documentation easier. It's better to have something that ma=
tches
> > > > > > > > documentation, don't you think ? otherwise, future users/de=
velopers of
> > > > > > > > these driver will need either a shit ton of comments explai=
ning that A
> > > > > > > > maps to B in docs, or will need a fscking crystal ball to r=
ead my mind.
> > > > > > > > Assuming I'll still remember what I meant.
> > > > > > > >=20
> > > > > > > > > > +static int opt3001_remove(struct i2c_client *client)
> > > > > > > > > > +{
> > > > > > > > > > +	struct iio_dev *iio =3D i2c_get_clientdata(client);
> > > > > > > > > > +	struct opt3001 *opt =3D iio_priv(iio);
> > > > > > > > > > +	int ret;
> > > > > > > > > > +	u16 reg;
> > > > > > > > > > +
> > > > > > > > > > +	free_irq(client->irq, iio);
> > > > > > > > > > +	iio_device_unregister(iio);
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3=
001_CONFIGURATION);
> > > > > > > > > > +	if (ret < 0) {
> > > > > > > > > > +		dev_err(opt->dev, "failed to read register %02x\n",
> > > > > > > > > > +				OPT3001_CONFIGURATION);
> > > > > > > > > > +		return ret;
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > > +	reg =3D ret;
> > > > > > > > > > +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_S=
HUTDOWN);
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D i2c_smbus_write_word_swapped(opt->client, OPT=
3001_CONFIGURATION,
> > > > > > > > > > +			reg);
> > > > > > > > > > +	if (ret < 0) {
> > > > > > > > > > +		dev_err(opt->dev, "failed to write register %02x\n",
> > > > > > > > > > +				OPT3001_CONFIGURATION);
> > > > > > > > > > +		return ret;
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > > +	iio_device_free(iio);
> > > > > > > > >
> > > > > > > > > Use the devm_iio_device_alloc and you can drop the need t=
o free it.
> > > > > > > > > I don't really mind, but I'll almost guarantee that someo=
ne will post
> > > > > > > > > a follow up patch doing this if you don't.  As it will be=
 ever so
> > > > > > > > > slightly cleaner, I'll probably take that patch.
> > > > > > > >=20
> > > > > > > > here's the original driver:
> > > > > > > >=20
> > > > > > > > http://www.spinics.net/lists/linux-iio/msg14331.html
> > > > > > > >=20
> > > > > > > > notice that it *WAS* *USING* devm_iio_device_alloc(), until:
> > > > > > > >=20
> > > > > > > > http://www.spinics.net/lists/linux-iio/msg14421.html
> > > > > > > >=20
> > > > > > > > you *SPECIFICALLY* asked for *NON* *DEVM* versions!!
> > > > > > > >=20
> > > > > > > > So figure out what you really want, let me know and I'll co=
de it all up
> > > > > > > > quickly and hopefully still get this into v3.18 merge windo=
w. I sent
> > > > > > > > this driver *very* early to be doubly sure it would hit v3.=
18 and there
> > > > > > > > was a long hiatus from yourself which is now jeopardizing w=
hat I was
> > > > > > > > expecting. That, coupled with your contradicting requests, =
has just put
> > > > > > > > me in a bad mood, even before Monday, hurray.
> > > > > > > >=20
> > > > > > > > cheers
> > > > > > > >=20
> > > > > > > > --=20
> > > > > > > > balbi
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > --=20
> > > > > > > balbi
> > > > > >=20
> > > > > >=20
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

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJJQzAAoJEIaOsuA1yqREZfMP/iVMbzqqxhwFsdieuNb5ZzR4
oS6idboV8TfQWagX7u13Qhb6SEOAtafOvE6eMYT7aqp+5+Y3zvmSdzukB7XvkLSN
9G+RMQdjtMdkOsfqliYN4/MSQeaLihjtziHHNISllLIbY9xlptiCl4nDVlYS0BIF
9aZ/oN9jes28uuI0SUkqAcJLMcS50Aobw/lc/2N5+pUI5wGdoLrks7+XgyMcEiDA
kaMMJz9YjIUwGIBA58qFoPbdxmqUDuzpybNgeHQ4LU/xSwOD2124G1sjw6WqGXph
qQf4uz0OCX+FYxaaFO35sR0FD1IQLSp/SdkmAynDD1gzuXuHHPIwVe58xh1Alu+U
dwRQAl9TM9Ld7Zm/Xca8dv/Z78mfS2vIJKUEYP0CSM/3E3F8dWyBXV9A7Y8/LcRn
ONzEgnnuukDTH7PdkmReq/5BYupXFI9g85AGWVeE8ChtAdoYfyT8ObWJOxPP1oCS
UdImj4HrKaM6xOWYzdSt3JLRBPalBuzJn+l2Hz6Jt7KkAmqIe3L5iWeUxGXh3ZTa
lljm+3IcM40bVUV0tLP5bxLJl0XKodVxDFDD7CslPTgDokFPMv1hPw/aRZXaMlz8
fa3dJM2mNUz8Znwh7J6g3P+6KRiaMEx3HBxjkWzjVwyeIjBc8VaI+7NyVUU2WS8O
ltYRaRiA8m+VBfNj35JB
=LZKb
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
