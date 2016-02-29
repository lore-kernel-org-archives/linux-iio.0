Return-Path: <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 29 Feb 2016 08:47:40 +0000
From: jic23@jic23.retrosnub.co.uk
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: convert to common i2c_check_functionality() return
 value
In-Reply-To: <CAKv63usNjZh2zE7h5rj=LXPaP1KN6V4npm73qPAzrQv9nuShCA@mail.gmail.com>
References: <1456553629-15803-1-git-send-email-mranostay@gmail.com>
 <56D1DA4D.2070809@kernel.org>
 <CAKv63usNjZh2zE7h5rj=LXPaP1KN6V4npm73qPAzrQv9nuShCA@mail.gmail.com>
Message-ID: <f5611980d0f94629ccf5fa913449ba41@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On 29.02.2016 08:43, Crt Mori wrote:
> I hope it is not too late to add:
> Acked-by: Crt Mori <cmo@melexis.com>
Sorry, pull request went out yesterday so can't add it now.
I wanted to sneak this into the current cycle to make our lives easier
long term!

Jonathan
> 
> On 27 February 2016 at 18:18, Jonathan Cameron <jic23@kernel.org> 
> wrote:
>> 
>> On 27/02/16 06:13, Matt Ranostay wrote:
>> > Previously most drivers that used a i2c_check_functionality() check
>> > condition required various error codes on failure. This patchset
>> > converts to a standard of -EOPNOTSUPP
>> >
>> > Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> Applied.
>> 
>> Thanks,
>> 
>> Jonathan
>> > ---
>> >  drivers/iio/adc/mcp3422.c                         | 2 +-
>> >  drivers/iio/adc/ti-adc081c.c                      | 2 +-
>> >  drivers/iio/chemical/vz89x.c                      | 2 +-
>> >  drivers/iio/humidity/hdc100x.c                    | 2 +-
>> >  drivers/iio/humidity/htu21.c                      | 2 +-
>> >  drivers/iio/humidity/si7005.c                     | 2 +-
>> >  drivers/iio/humidity/si7020.c                     | 2 +-
>> >  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c         | 2 +-
>> >  drivers/iio/light/bh1750.c                        | 2 +-
>> >  drivers/iio/light/jsa1212.c                       | 2 +-
>> >  drivers/iio/potentiometer/mcp4531.c               | 2 +-
>> >  drivers/iio/pressure/mpl115_i2c.c                 | 2 +-
>> >  drivers/iio/pressure/ms5611_i2c.c                 | 2 +-
>> >  drivers/iio/pressure/ms5637.c                     | 2 +-
>> >  drivers/iio/pressure/t5403.c                      | 2 +-
>> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
>> >  drivers/iio/temperature/mlx90614.c                | 2 +-
>> >  drivers/iio/temperature/tmp006.c                  | 2 +-
>> >  drivers/iio/temperature/tsys01.c                  | 2 +-
>> >  drivers/iio/temperature/tsys02d.c                 | 2 +-
>> >  20 files changed, 20 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>> > index ebad83e..d7b36ef 100644
>> > --- a/drivers/iio/adc/mcp3422.c
>> > +++ b/drivers/iio/adc/mcp3422.c
>> > @@ -339,7 +339,7 @@ static int mcp3422_probe(struct i2c_client *client,
>> >       u8 config;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
>> > index 2c8374f..ecbc121 100644
>> > --- a/drivers/iio/adc/ti-adc081c.c
>> > +++ b/drivers/iio/adc/ti-adc081c.c
>> > @@ -73,7 +73,7 @@ static int adc081c_probe(struct i2c_client *client,
>> >       int err;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>> >       if (!iio)
>> > diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
>> > index b8b8049..652649d 100644
>> > --- a/drivers/iio/chemical/vz89x.c
>> > +++ b/drivers/iio/chemical/vz89x.c
>> > @@ -249,7 +249,7 @@ static int vz89x_probe(struct i2c_client *client,
>> >                               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
>> >               data->xfer = vz89x_smbus_xfer;
>> >       else
>> > -             return -ENOTSUPP;
>> > +             return -EOPNOTSUPP;
>> >
>> >       i2c_set_clientdata(client, indio_dev);
>> >       data->client = client;
>> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> > index a7f61e88..fa47676 100644
>> > --- a/drivers/iio/humidity/hdc100x.c
>> > +++ b/drivers/iio/humidity/hdc100x.c
>> > @@ -274,7 +274,7 @@ static int hdc100x_probe(struct i2c_client *client,
>> >
>> >       if (!i2c_check_functionality(client->adapter,
>> >                               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
>> > index d1636a7..11cbc38 100644
>> > --- a/drivers/iio/humidity/htu21.c
>> > +++ b/drivers/iio/humidity/htu21.c
>> > @@ -192,7 +192,7 @@ static int htu21_probe(struct i2c_client *client,
>> >                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> >               dev_err(&client->dev,
>> >                       "Adapter does not support some i2c transaction\n");
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >       }
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>> > diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
>> > index 98a022f..6297766 100644
>> > --- a/drivers/iio/humidity/si7005.c
>> > +++ b/drivers/iio/humidity/si7005.c
>> > @@ -135,7 +135,7 @@ static int si7005_probe(struct i2c_client *client,
>> >       int ret;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
>> > index 5ab4e06..ffc2ccf 100644
>> > --- a/drivers/iio/humidity/si7020.c
>> > +++ b/drivers/iio/humidity/si7020.c
>> > @@ -121,7 +121,7 @@ static int si7020_probe(struct i2c_client *client,
>> >       if (!i2c_check_functionality(client->adapter,
>> >                                    I2C_FUNC_SMBUS_WRITE_BYTE |
>> >                                    I2C_FUNC_SMBUS_READ_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       /* Reset device, loads default settings. */
>> >       ret = i2c_smbus_write_byte(client, SI7020CMD_RESET);
>> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> > index af400dd..d2eddfd 100644
>> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> > @@ -120,7 +120,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>> >
>> >       if (!i2c_check_functionality(client->adapter,
>> >                                    I2C_FUNC_SMBUS_I2C_BLOCK))
>> > -             return -ENOSYS;
>> > +             return -EOPNOTSUPP;
>> >
>> >       regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
>> >       if (IS_ERR(regmap)) {
>> > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
>> > index 8b41643..b059466 100644
>> > --- a/drivers/iio/light/bh1750.c
>> > +++ b/drivers/iio/light/bh1750.c
>> > @@ -241,7 +241,7 @@ static int bh1750_probe(struct i2c_client *client,
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>> >                               I2C_FUNC_SMBUS_WRITE_BYTE))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
>> > index c4e8c6b..99a6281 100644
>> > --- a/drivers/iio/light/jsa1212.c
>> > +++ b/drivers/iio/light/jsa1212.c
>> > @@ -326,7 +326,7 @@ static int jsa1212_probe(struct i2c_client *client,
>> >       int ret;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
>> > index a3f6687..0db67fe 100644
>> > --- a/drivers/iio/potentiometer/mcp4531.c
>> > +++ b/drivers/iio/potentiometer/mcp4531.c
>> > @@ -159,7 +159,7 @@ static int mcp4531_probe(struct i2c_client *client,
>> >       if (!i2c_check_functionality(client->adapter,
>> >                                    I2C_FUNC_SMBUS_WORD_DATA)) {
>> >               dev_err(dev, "SMBUS Word Data not supported\n");
>> > -             return -EIO;
>> > +             return -EOPNOTSUPP;
>> >       }
>> >
>> >       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> > diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
>> > index 9ea055c..1a29be4 100644
>> > --- a/drivers/iio/pressure/mpl115_i2c.c
>> > +++ b/drivers/iio/pressure/mpl115_i2c.c
>> > @@ -42,7 +42,7 @@ static int mpl115_i2c_probe(struct i2c_client *client,
>> >                        const struct i2c_device_id *id)
>> >  {
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       return mpl115_probe(&client->dev, id->name, &mpl115_i2c_ops);
>> >  }
>> > diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
>> > index 42706a8..fcb2aff 100644
>> > --- a/drivers/iio/pressure/ms5611_i2c.c
>> > +++ b/drivers/iio/pressure/ms5611_i2c.c
>> > @@ -92,7 +92,7 @@ static int ms5611_i2c_probe(struct i2c_client *client,
>> >                                    I2C_FUNC_SMBUS_WRITE_BYTE |
>> >                                    I2C_FUNC_SMBUS_READ_WORD_DATA |
>> >                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
>> > index e8d0e0d..e68052c 100644
>> > --- a/drivers/iio/pressure/ms5637.c
>> > +++ b/drivers/iio/pressure/ms5637.c
>> > @@ -136,7 +136,7 @@ static int ms5637_probe(struct i2c_client *client,
>> >                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> >               dev_err(&client->dev,
>> >                       "Adapter does not support some i2c transaction\n");
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >       }
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>> > diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
>> > index e11cd39..2667e71 100644
>> > --- a/drivers/iio/pressure/t5403.c
>> > +++ b/drivers/iio/pressure/t5403.c
>> > @@ -221,7 +221,7 @@ static int t5403_probe(struct i2c_client *client,
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
>> >           I2C_FUNC_SMBUS_I2C_BLOCK))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       ret = i2c_smbus_read_byte_data(client, T5403_SLAVE_ADDR);
>> >       if (ret < 0)
>> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> > index db35e04..4f502386 100644
>> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> > @@ -278,7 +278,7 @@ static int lidar_probe(struct i2c_client *client,
>> >                               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
>> >               data->xfer = lidar_smbus_xfer;
>> >       else
>> > -             return -ENOTSUPP;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev->info = &lidar_info;
>> >       indio_dev->name = LIDAR_DRV_NAME;
>> > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
>> > index a570c2e..4b645fc 100644
>> > --- a/drivers/iio/temperature/mlx90614.c
>> > +++ b/drivers/iio/temperature/mlx90614.c
>> > @@ -516,7 +516,7 @@ static int mlx90614_probe(struct i2c_client *client,
>> >       int ret;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >       if (!indio_dev)
>> > diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
>> > index e78c106..18c9b43 100644
>> > --- a/drivers/iio/temperature/tmp006.c
>> > +++ b/drivers/iio/temperature/tmp006.c
>> > @@ -205,7 +205,7 @@ static int tmp006_probe(struct i2c_client *client,
>> >       int ret;
>> >
>> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >
>> >       if (!tmp006_check_identification(client)) {
>> >               dev_err(&client->dev, "no TMP006 sensor\n");
>> > diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
>> > index 05c1206..3e60c61 100644
>> > --- a/drivers/iio/temperature/tsys01.c
>> > +++ b/drivers/iio/temperature/tsys01.c
>> > @@ -190,7 +190,7 @@ static int tsys01_i2c_probe(struct i2c_client *client,
>> >                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> >               dev_err(&client->dev,
>> >                       "Adapter does not support some i2c transaction\n");
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >       }
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>> > diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
>> > index 4c1fbd5..ab6fe8f 100644
>> > --- a/drivers/iio/temperature/tsys02d.c
>> > +++ b/drivers/iio/temperature/tsys02d.c
>> > @@ -137,7 +137,7 @@ static int tsys02d_probe(struct i2c_client *client,
>> >                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>> >               dev_err(&client->dev,
>> >                       "Adapter does not support some i2c transaction\n");
>> > -             return -ENODEV;
>> > +             return -EOPNOTSUPP;
>> >       }
>> >
>> >       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>> >
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
