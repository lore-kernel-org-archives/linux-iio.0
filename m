Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] i2c: core: Add support for best effort block
 read emulation
Date: Tue, 4 Aug 2015 13:51:13 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0ADC68@irsmsx105.ger.corp.intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-2-git-send-email-irina.tirdea@intel.com>
 <55991BE7.6050705@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F2F067FA4@irsmsx105.ger.corp.intel.com>
 <20150801195320.GA1590@katana>
In-Reply-To: <20150801195320.GA1590@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel=
.org] On Behalf Of Wolfram Sang
> Sent: 01 August, 2015 22:53
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-kernel@vger.kernel.org; Pandruvada, Srinivas;=
 Peter Meerwald; linux-iio@vger.kernel.org; linux-
> i2c@vger.kernel.org
> Subject: Re: [PATCH v3 1/8] i2c: core: Add support for best effort block =
read emulation
>=20
>=20
> > > I wonder what devices do if you do a word read beyond their end addre=
ss?
> > > Perhaps in odd cases we should always fall back to byte reads?
> >
> > In my tests I can read beyond the end address, but I cannot be sure if =
this is OK for all
> > devices. This was actually a suggestion from Wolfram for v1, but maybe =
I'm missing
> > something.
> >
> > Wolfram, is it safe to read one byte beyond the end address or should I=
 better use
> > only byte reads for odd lengths?
>=20
> Well, from a device perspective, it is probably better to be safe than
> sorry and fall back to a single byte read. That means, however, that we
> need READ_WORD_DATA and READ_BYTE_DATA to be supported by the adapter.
> Should be OK, I don't think there are adapters which can only read words.
>=20

OK. In this case, I would rather go back to how reading odd lengths was han=
dled in
the first version of this patch: use word reads up to the last byte and rea=
d that last
byte using a byte read. In this way, odd and even lengths are both handled =
as
expected (by first falling back to word reads and then to byte reads).
Also, some adapters have performance issues when using more i2c transaction=
s,
so using word instead of byte reads where is possible could help.
I'll send v4 like this and wait for your feedback.

> > > > + */
> > > > +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_cli=
ent *client,
> > > > +					      u8 command, u8 length, u8 *values)
> > > > +{
> > > > +	u8 i;
> > > > +	int status;
> > > > +
> > > > +	if (length > I2C_SMBUS_BLOCK_MAX)
> > > > +		length =3D I2C_SMBUS_BLOCK_MAX;
> > > > +
> > > > +	if (i2c_check_functionality(client->adapter,
> > > > +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> > > > +		return i2c_smbus_read_i2c_block_data(client, command,
> > > > +						     length, values);
>=20
> I am not very strict with the 80 char limit. I'd think the code is more
> readable if the two statements above would be oneliners. And for some
> other lines later as well.
>=20
Ok.=20
> > > > +	} else if (i2c_check_functionality(client->adapter,
>=20
> No need for else since we return in the above if anyhow.

Ok. Will fix this.
>=20
> > > > +					   I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> > > > +		for (i =3D 0; i < length; i +=3D 2) {
> > > > +			status =3D i2c_smbus_read_word_data(client, command + i);
> > > > +			if (status < 0)
> > > > +				return status;
> > > > +			values[i] =3D status & 0xff;
> > > > +			if ((i + 1) < length)
> > > > +				values[i + 1] =3D status >> 8;
> > > > +		}
> > > > +		if (i > length)
> > > > +			return length;
> > > > +		return i;
> > > > +	} else if (i2c_check_functionality(client->adapter,
> > > > +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> > > > +		for (i =3D 0; i < length; i++) {
> > > > +			status =3D i2c_smbus_read_byte_data(client, command + i);
> > > > +			if (status < 0)
> > > > +				return status;
> > > > +			values[i] =3D status;
> > > > +		}
> > > > +		return i;
> > > > +	}
> > > > +
> > > > +	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%=
d\n",
> > > > +		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
> > > > +		I2C_SMBUS_BYTE_DATA);
>=20
> I don't think the %d printouts are useful. Just say that the adapter
> lacks support for needed transactions. And I think the device which
> reports the error should be the client device, no?
>=20

I actually looked at i2c_smbus_xfer_emulated that is printing a similar mes=
sage along
with the unsupported transaction size. Probably the client should print the=
se kind of
messages anyway, so I will remove the %d printouts. I can remove the dev_er=
r entirely
if you think that is better.

Thanks,
Irina

> Thanks,
>=20
>    Wolfram
