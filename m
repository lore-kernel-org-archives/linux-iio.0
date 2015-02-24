Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>, "Reus, Adriana"
	<adriana.reus@intel.com>
Subject: RE: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in
 trigger handler
Date: Tue, 24 Feb 2015 17:25:36 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A21DD9@irsmsx105.ger.corp.intel.com>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
 <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.02.1502162014280.26763@pmeerw.net>
 <1F3AC3675D538145B1661F571FE1805F19A20D9C@irsmsx105.ger.corp.intel.com>
 <54E8CE8B.7060909@kernel.org>
In-Reply-To: <54E8CE8B.7060909@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 21 February, 2015 20:30
> To: Tirdea, Irina; Peter Meerwald
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, =
Srinivas; Reus, Adriana
> Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers i=
n trigger handler
>=20
> On 20/02/15 12:02, Tirdea, Irina wrote:
> >
> >
> >> -----Original Message-----
> >> From: Peter Meerwald [mailto:pmeerw@pmeerw.net]
> >> Sent: 16 February, 2015 21:26
> >> To: Tirdea, Irina
> >> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.ker=
nel.org; Pandruvada, Srinivas; Reus, Adriana
> >> Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfer=
s in trigger handler
> >>
> >>
> >>> Reading all axis values in one i2c transfer reduces the delays
> >>> introduced by the i2c bus. In case i2c block read is not supported,
> >>> fallback to reading each axis as a separate word.
> >>
> >> see comments inline below
> >>
> > Thanks for the review, Peter!
> >
> >>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> >>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> >>> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> >>> ---
> >>>  drivers/iio/accel/kxcjk-1013.c | 44 ++++++++++++++++++++++++++++++++=
+---------
> >>>  1 file changed, 35 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk=
-1013.c
> >>> index 5f27787..bfa2899 100644
> >>> --- a/drivers/iio/accel/kxcjk-1013.c
> >>> +++ b/drivers/iio/accel/kxcjk-1013.c
> >>> @@ -109,6 +109,8 @@ struct kxcjk1013_data {
> >>>  	int64_t timestamp;
> >>>  	enum kx_chipset chipset;
> >>>  	bool is_smo8500_device;
> >>> +	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
> >>> +			       u8 length, u8 *values);
> >>
> >> probably this could/should be done in the i2c layer or we end up addin=
g a
> >> similar function in every driver?
> >>
> > Actually this is exactly what I did: adding this code in a couple of dr=
ivers :)
> > You are right, this belongs to the i2c core. Will move it there.
> A good idea.  Might be possible to make this a transparent fallback so no
> special handling is needed in drivers at all (e.g. emulate the block read=
 using
> the biggest read that is available) - taking care about the endian fun an=
d
> games that results.
>=20
> Propose it to Wolfram and the i2c list and see what people think of it.
>=20
I'll do the block emulation code first and send it on the i2c list (still c=
hecking some endianness issues).=20
Once I'll have a response for the i2c part, I'll resend these patchsets wit=
h the required fixes.

Thanks,
Irina

> Jonathan
> >
> >>>  };
> >>>
> >>>  enum kxcjk1013_axis {
> >>> @@ -216,6 +218,23 @@ static const struct {
> >>>  				 {800, 0, 0x06},
> >>>  				 {1600, 0, 0x06} };
> >>>
> >>> +static s32 kxcjk1013_read_block_data(const struct i2c_client *client=
,
> >>> +				     u8 command, u8 length, u8 *values)
> >>> +{
> >>> +	s32 data;
> >>> +	u8 i;
> >>> +
> >>> +	for (i =3D 0; i < length; i +=3D 2) {
> >>> +		data =3D i2c_smbus_read_word_data(client, command + i);
> >>> +		if (data < 0)
> >>> +			return data;
> >>> +
> >>> +		values[i] =3D data & 0xFF;
> >>> +		values[i+1] =3D data >> 8;
> >>
> >> this is incorrect; it forces the data to be little endian, however, th=
e
> >> endianness (as specified in the driver's .scan_type) is IIO_CPU -- the
> >> code breaks for big-endian CPUs
> >>
> >> since _read_i2c_block_data() can't do endianness conversion (and the c=
hip
> >> does i2c endianness, i.e. little-endian), the .scan_type should become
> >> IIO_LE and above code is correct again but still ugly :)
> >>
> >> bottom line: change .scan_type to IIO_LE
> >>
> > Good point. Changing the endianess to IIO_LE is correct for either kxcj=
k1013_read_block_data or i2c_smbus_read_i2c_block_data.
> > Will fix this in the next version. Thanks for catching this!
> >
> >>> +	}
> >>> +	return i;
> >>> +}
> >>> +
> >>>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
> >>>  			      enum kxcjk1013_mode mode)
> >>>  {
> >>> @@ -955,18 +974,14 @@ static irqreturn_t kxcjk1013_trigger_handler(in=
t irq, void *p)
> >>>  	struct iio_poll_func *pf =3D p;
> >>>  	struct iio_dev *indio_dev =3D pf->indio_dev;
> >>>  	struct kxcjk1013_data *data =3D iio_priv(indio_dev);
> >>> -	int bit, ret, i =3D 0;
> >>> +	int ret;
> >>>
> >>>  	mutex_lock(&data->mutex);
> >>> -	for (bit =3D 0; bit < AXIS_MAX; bit++) {
> >>> -		ret =3D kxcjk1013_get_acc_reg(data, bit);
> >>> -		if (ret < 0) {
> >>> -			mutex_unlock(&data->mutex);
> >>> -			goto err;
> >>> -		}
> >>> -		data->buffer[i++] =3D ret;
> >>> -	}
> >>> +	ret =3D data->read_block_data(data->client, KXCJK1013_REG_XOUT_L,
> >>> +				    AXIS_MAX * 2, (u8 *) data->buffer);
> >>>  	mutex_unlock(&data->mutex);
> >>> +	if (ret < 0)
> >>> +		goto err;
> >>>
> >>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >>>  					   data->timestamp);
> >>> @@ -1196,6 +1211,11 @@ static int kxcjk1013_probe(struct i2c_client *=
client,
> >>>  	const char *name;
> >>>  	int ret;
> >>>
> >>> +	if (!i2c_check_functionality(client->adapter,
> >>> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> >>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> >>> +		return -ENODEV;
> >>> +
> >>>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> >>>  	if (!indio_dev)
> >>>  		return -ENOMEM;
> >>> @@ -1204,6 +1224,12 @@ static int kxcjk1013_probe(struct i2c_client *=
client,
> >>>  	i2c_set_clientdata(client, indio_dev);
> >>>  	data->client =3D client;
> >>>
> >>> +	if (i2c_check_functionality(client->adapter,
> >>> +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> >>> +		data->read_block_data =3D i2c_smbus_read_i2c_block_data;
> >>> +	else
> >>> +		data->read_block_data =3D kxcjk1013_read_block_data;
> >>> +
> >>>  	pdata =3D dev_get_platdata(&client->dev);
> >>>  	if (pdata)
> >>>  		data->active_high_intr =3D pdata->active_high_intr;
> >>>
> >>
> >> --
> >>
> >> Peter Meerwald
> >> +43-664-2444418 (mobile)
