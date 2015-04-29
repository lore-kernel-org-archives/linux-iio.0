Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dogaru,
 Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH v2 14/17] iio: accel: mma9551_core: use size in words
 for word buffers
Date: Wed, 29 Apr 2015 12:20:55 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A5E887@irsmsx105.ger.corp.intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
 <1428939664-12503-15-git-send-email-irina.tirdea@intel.com>
 <553D36C9.3070004@kernel.org>
In-Reply-To: <553D36C9.3070004@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 26 April, 2015 22:05
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad
> Subject: Re: [PATCH v2 14/17] iio: accel: mma9551_core: use size in words=
 for word buffers
>=20
> On 13/04/15 16:41, Irina Tirdea wrote:
> > Change the prototype for the mma9551_read/write_*_words functions
> > to receive the length of the buffer in words (instead of bytes) since
> > we are using a word buffer. This will prevent users from sending an
> > odd number of bytes for a word array.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Lots of merge issues by this point in the series so I'll hold this one at
> least until the fixes filter through.
>=20
> Remind me if I seem to have forgotten (it wouldn't be the first time :)
>=20
Sure, I'll keep an eye on when the fixes will be merged in togreg branch.

Thanks,
Irina

> Jonathan
> > ---
> >  drivers/iio/accel/mma9551_core.c | 27 ++++++++++++---------------
> >  drivers/iio/accel/mma9553.c      |  9 ++++++---
> >  2 files changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma95=
51_core.c
> > index 2fd2a99..583660b 100644
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
> > @@ -388,20 +388,19 @@ int mma9551_read_config_words(struct i2c_client *=
client, u8 app_id,
> >  			     u16 reg, u8 len, u16 *buf)
> >  {
> >  	int ret, i;
> > -	int len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> >
> > -	if (len_words > ARRAY_SIZE(be_buf)) {
> > +	if (len > ARRAY_SIZE(be_buf)) {
> >  		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> >  		return -EINVAL;
> >  	}
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
> > @@ -413,7 +412,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
> >   * @client:	I2C client
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> > - * @len:	Length of array to read in bytes
> > + * @len:	Length of array to read (in words)
> >   * @buf:	Array of words to read
> >   *
> >   * Read multiple status registers (word-sized registers).
> > @@ -428,20 +427,19 @@ int mma9551_read_status_words(struct i2c_client *=
client, u8 app_id,
> >  			      u16 reg, u8 len, u16 *buf)
> >  {
> >  	int ret, i;
> > -	int len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> >
> > -	if (len_words > ARRAY_SIZE(be_buf)) {
> > +	if (len > ARRAY_SIZE(be_buf)) {
> >  		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> >  		return -EINVAL;
> >  	}
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
> > @@ -453,7 +451,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >   * @client:	I2C client
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> > - * @len:	Length of array to write in bytes
> > + * @len:	Length of array to write (in words)
> >   * @buf:	Array of words to write
> >   *
> >   * Write multiple configuration registers (word-sized registers).
> > @@ -468,19 +466,18 @@ int mma9551_write_config_words(struct i2c_client =
*client, u8 app_id,
> >  			       u16 reg, u8 len, u16 *buf)
> >  {
> >  	int i;
> > -	int len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[(MMA9551_MAX_MAILBOX_DATA_REGS - 1) / 2];
> >
> > -	if (len_words > ARRAY_SIZE(be_buf)) {
> > +	if (len > ARRAY_SIZE(be_buf)) {
> >  		dev_err(&client->dev, "Invalid buffer size %d\n", len);
> >  		return -EINVAL;
> >  	}
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
> > index 8bfc618..06c8707 100644
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
> > @@ -397,7 +398,8 @@ static int mma9553_init(struct mma9553_data *data)
> >  	ret =3D
> >  	    mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
> >  				      MMA9553_REG_CONF_SLEEPMIN,
> > -				      sizeof(data->conf), (u16 *) &data->conf);
> > +				      sizeof(data->conf) / sizeof(u16),
> > +				      (u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"failed to read configuration registers\n");
> > @@ -430,7 +432,8 @@ static int mma9553_init(struct mma9553_data *data)
> >  	ret =3D
> >  	    mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
> >  				       MMA9553_REG_CONF_SLEEPMIN,
> > -				       sizeof(data->conf), (u16 *) &data->conf);
> > +				       sizeof(data->conf) / sizeof(u16),
> > +				       (u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"failed to write configuration registers\n");
> >
