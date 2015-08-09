Return-Path: <wsa@the-dreams.de>
Date: Sun, 9 Aug 2015 09:31:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v4 1/8] i2c: core: Add support for best effort block read
 emulation
Message-ID: <20150809073135.GB1526@katana>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
 <1438697056-2946-2-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
In-Reply-To: <1438697056-2946-2-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 05:04:09PM +0300, Irina Tirdea wrote:
> There are devices that need to handle block transactions
> regardless of the capabilities exported by the adapter.
> For performance reasons, they need to use i2c read blocks
> if available, otherwise emulate the block transaction with word
> or byte transactions.
>=20
> Add support for a helper function that would read a data block
> using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
> I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.
>=20
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

We are close, but I think there is one optimization left to do.

> +/**
> + * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @length: Size of data block; SMBus allows at most 32 bytes

Please refer to I2C_SMBUS_BLOCK_MAX instead of 32. The new SMBus specs
increased this amount to 256. (Yes, we don't support that yet.)

> + * @values: Byte array into which data will be read; big enough to hold
> + *	the data returned by the slave.  SMBus allows at most 32 bytes.
> + *
> + * This executes the SMBus "block read" protocol if supported by the ada=
pter.
> + * If block read is not supported, it emulates it using either word or b=
yte
> + * read protocols depending on availability.
> + *
> + * The addresses of the I2C slave device that are accessed with this fun=
ction
> + * must be mapped to a linear region, so that a block read will have the=
 same
> + * effect as a byte read. Before using this function you must double-che=
ck
> + * if the I2C slave does support exchanging a block transfer with a byte
> + * transfer.
> + */
> +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *c=
lient,
> +					      u8 command, u8 length, u8 *values)
> +{
> +	u8 i;
> +	int status;
> +
> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		length =3D I2C_SMBUS_BLOCK_MAX;
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BL=
OCK))
> +		return i2c_smbus_read_i2c_block_data(client, command, length, values);
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_WORD_D=
ATA |
> +				    I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +		for (i =3D 0; (i + 2) <=3D length; i +=3D 2) {
> +			status =3D i2c_smbus_read_word_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status & 0xff;
> +			values[i + 1] =3D status >> 8;
> +		}
> +		if (i < length) {
> +			status =3D i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status;
> +			i++;
> +		}
> +		return i;
> +	}
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE_D=
ATA)) {
> +		for (i =3D 0; i < length; i++) {
> +			status =3D i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] =3D status;
> +		}
> +		return i;
> +	}

We have two very similar blocks for transferring READ_BYTE_DATA now.
What about this pseudo code:

	if (check_func(I2C_BLOCK))
		return i2c_smbus_read_i2c_block_data(...);

	if (!check_func(I2C_READ_BYTE_DATA)
		return -EOPNOTSUPP;

	if (check_func(I2C_READ_WORD_DATA)
		read_as_many_words_as_possible;

	read_all_the_remaining_bytes;


> +	dev_err(&client->adapter->dev, "Unsupported transactions\n");

Again, if you want to keep this one, it should be the client device
reporting the error.

Thanks,

   Wolfram


--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxwHXAAoJEBQN5MwUoCm2loAQALKaH0C1g5pJuv1pcJHHILl2
eGQjcXO92tQSMQcy5uvz9P1auAwnBDeqLz/7OYGNvNrZKm6xQzzbWsZiDPkh2/KT
4V7i10gGgIOy0GxlI/crGvMqXBugu6+8LlQse4bEFl7pNd175OBsx12+nBvut5Iz
kA9AvIgIuWws4QYaP9DiQB7rEjaiw4zmfEA3Pu/NzTXRqvXbBQYNznOfvMUW7ppg
vlAFQmH1Bj+nckEYAK4tSeEoOZfZc1SjC9SxGbWfr3A+pIhYxBIBffdSOSQ746fh
heQiplgB8SqDNLRCp/ezlHBWAQEiadPG0YM9TID9hStDLS7zaBlWak1kextJGAa3
a+h0Y2KMY6MjCQ+T1xG05N1figM/opbhX0a6LdbMVgdKuj2UqLXZ0vYOYtnG+s/d
ClpnEolDgsdVg034P04pKHd44M4rTyC/z462EoupzZ75k0yGnGieagfyExk+JUjE
l8L3iogctOL/nt/+YLutzAEioJ9uOD770Y8WU8VTDt2uaiF7JPbvS+5o/knFxsTM
RjHxfuCFj8BZpuySnJ3cTRvKy9lKGiAiBR4FBQydwyeCWUIzLvMzz1Wk3Hp+9zQj
ra6C2XaM/Q6LE5xcFs1fXnnWgeUXz4wHkqxe6kPyej6K/YopO2el2vr98KG+lEOS
r1z/8yGtOWW3xwvmHc0R
=490i
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
