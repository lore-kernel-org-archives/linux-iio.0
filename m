Return-Path: <wsa@the-dreams.de>
Date: Mon, 9 Mar 2015 17:45:40 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vianney le =?utf-8?Q?Cl=C3=A9ment?= de Saint-Marcq <vianney.leclement@essensium.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
Message-ID: <20150309164536.GB2320@katana>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
 <1424879712-28304-6-git-send-email-vianney.leclement@essensium.com>
 <54FDBDCC.50204@kernel.org>
 <54FDBF2A.6010402@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
In-Reply-To: <54FDBF2A.6010402@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 03:41:30PM +0000, Jonathan Cameron wrote:
> On 09/03/15 15:35, Jonathan Cameron wrote:
> > On 25/02/15 15:55, Vianney le Cl=C3=A9ment de Saint-Marcq wrote:
> >> Add device attributes for getting/setting emissivity, IIR, and FIR
> >> coefficients, and getting the gain (which should not be modified in
> >> order to keep factory calibration).
> >>
> >> The attributes provide raw values whose meaning is described in the
> >> datasheet [1].
> >>
> >> Writing to EEPROM requires an explicit erase by writing zero.  In
> >> addition, it takes 20ms for the erase/write to complete.  During this
> >> time no EEPROM register should be accessed.  Therefore, two msleep()s
> >> are added to the write function and a mutex protects against concurrent
> >> access.
> >>
> >> Since it is not expected to be updated frequently, the configuration
> >> register is read before modifying it rather than caching it.
> >>
> >> [1] http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datasheet=
-5152.aspx
> >>
> >> Signed-off-by: Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.lecleme=
nt@essensium.com>
> >> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> > Wolfram, bit of odd i2c usage inline I'd like you to take quick look at.

What do you mean? The direct calls to i2c_smbus_xfer? Was there any
reason given to use it directly?

> Sorry, this would work better if I cleared Wolfram's old email addresses =
out of
> my address book at somepoint!

How about: right now? ;)

>=20
> >> ---
> >>  drivers/iio/temperature/mlx90614.c | 164 ++++++++++++++++++++++++++++=
++++++++-
> >>  1 file changed, 163 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperat=
ure/mlx90614.c
> >> index 0b36746..ab98fb6 100644
> >> --- a/drivers/iio/temperature/mlx90614.c
> >> +++ b/drivers/iio/temperature/mlx90614.c
> >> @@ -12,14 +12,16 @@
> >>   *
> >>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
> >>   *
> >> - * TODO: sleep mode, configuration EEPROM
> >> + * TODO: sleep mode
> >>   */
> >> =20
> >>  #include <linux/err.h>
> >>  #include <linux/i2c.h>
> >>  #include <linux/module.h>
> >> +#include <linux/delay.h>
> >> =20
> >>  #include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> =20
> >>  #define MLX90614_OP_RAM		0x00
> >>  #define MLX90614_OP_EEPROM	0x20
> >> @@ -53,8 +55,47 @@
> >> =20
> >>  struct mlx90614_data {
> >>  	struct i2c_client *client;
> >> +	struct mutex lock; /* for EEPROM access only */
> >>  };
> >> =20
> >> +/*
> >> + * Erase an address and write word.
> >> + * The mutex must be locked before calling.
> >> + */
> >> +static s32 mlx90614_write_word(const struct i2c_client *client, u8 co=
mmand,
> >> +			       u16 value)
> >> +{
> >> +	/*
> >> +	 * Note: The mlx90614 requires a PEC on writing but does not send us=
 a
> >> +	 * valid PEC on reading.  Hence, we cannot set I2C_CLIENT_PEC in
> >> +	 * i2c_client.flags.  As a workaround, we use i2c_smbus_xfer here.
> >> +	 */
> > That's particularly hideous and someone should shout at whoever impleme=
nted that!
> > Ah well, such is life.  I want a go ahead on doing this from Wolfram ho=
wever.
> > It's the sort of thing that might well get randomly broken in the futur=
e.
> > Alternative is to add another flag that indicates to the i2c core that =
the PEC
> > that comes back will be wrong.
> > =20
> >> +	union i2c_smbus_data data;
> >> +	s32 ret;
> >> +
> >> +	dev_dbg(&client->dev, "Writing 0x%x to address 0x%x", value, command=
);
> >> +
> >> +	data.word =3D 0x0000; /* erase command */
> >> +	ret =3D i2c_smbus_xfer(client->adapter, client->addr,
> >> +			     client->flags | I2C_CLIENT_PEC,
> >> +			     I2C_SMBUS_WRITE, command,
> >> +			     I2C_SMBUS_WORD_DATA, &data);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	msleep(MLX90614_TIMING_EEPROM);
> >> +
> >> +	data.word =3D value; /* actual write */
> >> +	ret =3D i2c_smbus_xfer(client->adapter, client->addr,
> >> +			     client->flags | I2C_CLIENT_PEC,
> >> +			     I2C_SMBUS_WRITE, command,
> >> +			     I2C_SMBUS_WORD_DATA, &data);
> >> +
> >> +	msleep(MLX90614_TIMING_EEPROM);
> >> +
> >> +	return ret;
> >> +}

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/c4wAAoJEBQN5MwUoCm2P/MP/RULs0sW4o8gdvDxFykbHoLe
0dxijbblBwcuUDdmItU6mAU0AfrDAD82GnSC2B54KMnp/dis+HHv7Td/ZxhJg/vs
9THRbgETqsoBSUgMBaT+XgN5D1Ze9FJCD/u6/4pmgQ33MlIzju7LjdcbmFOFEBb8
MPt3CuxYcBTiH7kHfTFIuAAZWwz5QU3XLifD6vcp0m2814BPxbDZKkVheCnn2H5h
nhC0C5yHOnt6KVlFradDFPLE+GdR1dZns6A1YFZHiTXOkfFKiLepKdlj/McGwrJP
WOya3qh51R7A33A91qKz2dd7JI9owJtqkw8on0cBB6jtb6wuc4SIUromIeFQvTwy
8y0XXUy4f9pHc151QEvq1gT+E0+5WHV2uJw0rEGJvHk+hDrjDoQ6qqrxF/KvZc+t
mR3Gt/SGGKBgVqQA3wR312mAjczG7upfYh13MjU8W6EDTLFs0OfKl7xuwn6U2rzq
pqTyZtccwc1xBbkuBqMxeBY6VeGt02ODuIC/PlwKHh6ZUzV3i0RWKE+M/i4cSPLQ
XT6KVwf+NIAQVZrBW/cz7wN7E2Qczj0ZzP5GK4g912pTYEsvth1Qjl7YxKVAzBVR
nZeDGViKw2QVUdHGp4JxPs5UOBhrfq+s/iIghju1J8zrj77qnInAAYHUJWNs0gdD
uBYTaTfF0V0To+1zCIw/
=Jd8c
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
