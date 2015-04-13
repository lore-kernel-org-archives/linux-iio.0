Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/8] iio: accel: mma9551_core: prevent buffer overrun
Date: Mon, 13 Apr 2015 13:48:10 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A4F5D3@irsmsx105.ger.corp.intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
 <1428503857-9081-8-git-send-email-irina.tirdea@intel.com>
 <552667BB.20901@kernel.org>
In-Reply-To: <552667BB.20901@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 09 April, 2015 14:51
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 7/8] iio: accel: mma9551_core: prevent buffer overrun
>=20
> On 08/04/15 15:37, Irina Tirdea wrote:
> > The mma9551 functions that read/write word arrays from the
> > device have a limit for the buffer size given by the device
> > specifications.
> >
> > Check that the requested buffer length is within required limits
> > when transferring word arrays. This will prevent buffer overrun
> > in the mma9551_read/write_*_words functions and also in the
> > mma9551_transfer call when writing into the MBOX response/request
> > structure.
> >
> > Change the prototype for the mma9551_read/write_*_words functions
> > to receive the length of the buffer in words (instead of bytes) since
> > we are using a word buffer. This will prevent users from sending an
> > odd number of bytes for a word array.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
> This is a bit of a mixture of a fix and a refactor.  That leaves
> us with a rather longer fix patch than would be ideal.
>=20
> could you break this into the minimal fix (just check limits and perhaps
> fix the buffer length to be half as long) then a follow up rework patch
> that gets you to the state at the end of this current patch?
>=20
Sure, I'll break this in two patches: the actual fix and the change in func=
tion
signature.
> Thanks,
>=20
> J
> > ---
> >  drivers/iio/accel/mma9551_core.c | 45 ++++++++++++++++++++++++++------=
--------
> >  drivers/iio/accel/mma9553.c      |  7 ++++---
> >  2 files changed, 34 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma95=
51_core.c
> > index 438cfed..5c6f69d 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -373,7 +373,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
> >   * @client:	I2C client
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> > - * @len:	Length of array to read in bytes
> > + * @len:	Length of array to read (in words)
> >   * @buf:	Array of words to read
> >   *
> >   * Read multiple configuration registers (word-sized registers).
> > @@ -388,15 +388,20 @@ int mma9551_read_config_words(struct i2c_client *=
client, u8 app_id,
> >  			     u16 reg, u8 len, u16 *buf)
> >  {
> >  	int ret;
> > -	u8 i, len_words =3D len / sizeof(u16);
> > -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> > +	u8 i;
> > +	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> > +
> > +	if (len > ARRAY_SIZE(be_buf)) {
> > +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> > +		return -EINVAL;
> > +	}
> >
> >  	ret =3D mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
> > -			       reg, NULL, 0, (u8 *) be_buf, len);
> > +			       reg, NULL, 0, (u8 *)be_buf, len * sizeof(u16));
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	for (i =3D 0; i < len_words; i++)
> > +	for (i =3D 0; i < len; i++)
> >  		buf[i] =3D be16_to_cpu(be_buf[i]);
> >
> >  	return 0;
> > @@ -408,7 +413,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
> >   * @client:	I2C client
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> > - * @len:	Length of array to read in bytes
> > + * @len:	Length of array to read (in words)
> >   * @buf:	Array of words to read
> >   *
> >   * Read multiple status registers (word-sized registers).
> > @@ -423,15 +428,20 @@ int mma9551_read_status_words(struct i2c_client *=
client, u8 app_id,
> >  			      u16 reg, u8 len, u16 *buf)
> >  {
> >  	int ret;
> > -	u8 i, len_words =3D len / sizeof(u16);
> > -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> > +	u8 i;
> > +	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> > +
> > +	if (len > ARRAY_SIZE(be_buf)) {
> > +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> > +		return -EINVAL;
> > +	}
> >
> >  	ret =3D mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
> > -			       reg, NULL, 0, (u8 *) be_buf, len);
> > +			       reg, NULL, 0, (u8 *)be_buf, len * sizeof(u16));
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	for (i =3D 0; i < len_words; i++)
> > +	for (i =3D 0; i < len; i++)
> >  		buf[i] =3D be16_to_cpu(be_buf[i]);
> >
> >  	return 0;
> > @@ -443,7 +453,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >   * @client:	I2C client
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> > - * @len:	Length of array to write in bytes
> > + * @len:	Length of array to write (in words)
> >   * @buf:	Array of words to write
> >   *
> >   * Write multiple configuration registers (word-sized registers).
> > @@ -457,14 +467,19 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >  int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
> >  			       u16 reg, u8 len, u16 *buf)
> >  {
> > -	u8 i, len_words =3D len / sizeof(u16);
> > -	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> > +	u8 i;
> > +	__be16 be_buf[(MMA9551_MAX_MAILBOX_DATA_REGS - 1) / 2];
> > +
> > +	if (len > ARRAY_SIZE(be_buf)) {
> > +		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> > +		return -EINVAL;
> > +	}
> >
> > -	for (i =3D 0; i < len_words; i++)
> > +	for (i =3D 0; i < len; i++)
> >  		be_buf[i] =3D cpu_to_be16(buf[i]);
> >
> >  	return mma9551_transfer(client, app_id, MMA9551_CMD_WRITE_CONFIG,
> > -				reg, (u8 *) be_buf, len, NULL, 0);
> > +				reg, (u8 *)be_buf, len * sizeof(u16), NULL, 0);
> >  }
> >  EXPORT_SYMBOL(mma9551_write_config_words);
> >
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index 96e4708..6991b01 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -322,7 +322,8 @@ static int mma9553_read_activity_stepcnt(struct mma=
9553_data *data,
> >  	int ret;
> >
> >  	ret =3D mma9551_read_status_words(data->client, MMA9551_APPID_PEDOMET=
ER,
> > -					MMA9553_REG_STATUS, sizeof(u32), buf);
> > +					MMA9553_REG_STATUS, ARRAY_SIZE(buf),
> > +					buf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"error reading status and stepcnt\n");
> > @@ -395,7 +396,7 @@ static int mma9553_init(struct mma9553_data *data)
> >  	 */
> >  	ret =3D mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMET=
ER,
> >  					MMA9553_REG_CONF_SLEEPMIN,
> > -					sizeof(data->conf),
> > +					sizeof(data->conf) / sizeof(u16),
> >  					(u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> > @@ -428,7 +429,7 @@ static int mma9553_init(struct mma9553_data *data)
> >  					     MMA9553_MASK_CONF_ACT_DBCNTM);
> >  	ret =3D mma9551_write_config_words(data->client, MMA9551_APPID_PEDOME=
TER,
> >  					 MMA9553_REG_CONF_SLEEPMIN,
> > -					 sizeof(data->conf),
> > +					 sizeof(data->conf) / sizeof(u16),
> >  					 (u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >
