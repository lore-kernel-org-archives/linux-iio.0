Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35470 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbbHATxc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 1 Aug 2015 15:53:32 -0400
Date: Sat, 1 Aug 2015 21:53:20 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] i2c: core: Add support for best effort block read
 emulation
Message-ID: <20150801195320.GA1590@katana>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-2-git-send-email-irina.tirdea@intel.com>
 <55991BE7.6050705@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F2F067FA4@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F067FA4@irsmsx105.ger.corp.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I wonder what devices do if you do a word read beyond their end address?
> > Perhaps in odd cases we should always fall back to byte reads?
>=20
> In my tests I can read beyond the end address, but I cannot be sure if th=
is is OK for all
> devices. This was actually a suggestion from Wolfram for v1, but maybe I'=
m missing
> something.
>=20
> Wolfram, is it safe to read one byte beyond the end address or should I b=
etter use
> only byte reads for odd lengths?

Well, from a device perspective, it is probably better to be safe than
sorry and fall back to a single byte read. That means, however, that we
need READ_WORD_DATA and READ_BYTE_DATA to be supported by the adapter.
Should be OK, I don't think there are adapters which can only read words.

> > > + */
> > > +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_clien=
t *client,
> > > +					      u8 command, u8 length, u8 *values)
> > > +{
> > > +	u8 i;
> > > +	int status;
> > > +
> > > +	if (length > I2C_SMBUS_BLOCK_MAX)
> > > +		length =3D I2C_SMBUS_BLOCK_MAX;
> > > +
> > > +	if (i2c_check_functionality(client->adapter,
> > > +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> > > +		return i2c_smbus_read_i2c_block_data(client, command,
> > > +						     length, values);

I am not very strict with the 80 char limit. I'd think the code is more
readable if the two statements above would be oneliners. And for some
other lines later as well.

> > > +	} else if (i2c_check_functionality(client->adapter,

No need for else since we return in the above if anyhow.

> > > +					   I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> > > +		for (i =3D 0; i < length; i +=3D 2) {
> > > +			status =3D i2c_smbus_read_word_data(client, command + i);
> > > +			if (status < 0)
> > > +				return status;
> > > +			values[i] =3D status & 0xff;
> > > +			if ((i + 1) < length)
> > > +				values[i + 1] =3D status >> 8;
> > > +		}
> > > +		if (i > length)
> > > +			return length;
> > > +		return i;
> > > +	} else if (i2c_check_functionality(client->adapter,
> > > +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> > > +		for (i =3D 0; i < length; i++) {
> > > +			status =3D i2c_smbus_read_byte_data(client, command + i);
> > > +			if (status < 0)
> > > +				return status;
> > > +			values[i] =3D status;
> > > +		}
> > > +		return i;
> > > +	}
> > > +
> > > +	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%d\=
n",
> > > +		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
> > > +		I2C_SMBUS_BYTE_DATA);

I don't think the %d printouts are useful. Just say that the adapter
lacks support for needed transactions. And I think the device which
reports the error should be the client device, no?

Thanks,

   Wolfram


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvSOwAAoJEBQN5MwUoCm23AMQAKFugpEeYzSgiCJZHs9lEhAC
kxobw/tlsE9AVxnrwsBD4BXAVcnBZAHLvBOs/E5FYHvDIouU2YuBFHeAMiT/XXMf
Dqg+UhUcYEAp92XJPwS8t/yP5Z0i8MpeX02MeuS8uROPD53QDE2JBLxZJ22pN9qu
/USBouMWKtdoAvAOfQJmBv+YNnbLEP26+ztLyot7IC/p1f5oiagBLbJe1E+EtLOu
AdvNtisHUDAHA7cMftmxkh8oT9B/KwEE+VAAo4hpomYe5JMk0gRaxFXoJCCOHzrG
meCHM2CVnpxlDUuwxTXw0JsVdvdztQuY4c9/hjnbWyZ72EENzOuTnlSNNIsUs0Lz
fnKYE+wxmad5Sbcm3oF+txI2a45CCCCtzQsz4fh/iqUZf/NMUS85HhpX6K1Iv1Xd
tT5KWlEpku+v3PVNMfKHkaiMweHrPxUoUIGB4qcN1AOVe9Ava0yCeh8VdBkJ/A8F
im4O8SXJPV209er5vYYSFGmuFUlvLXvFTO8NsaZpw4UQ6gY2Til9A3AiSt+912pM
lnifsUL5okfXRwtBMVT/pLmKlmcm1BLTJ/5p2FptdElnkh5QQcXVJ9UoXWCVxaYP
LH9fEbgNqybNHL7e5cJYdC+xb7Zf3gFv4C2qltSp2ne4IPJMrajKA10IZz79MRAu
R3KEO5rCa8kU3sCeqJQ7
=WlbZ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
