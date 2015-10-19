Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5624C9C5.6000002@metafoo.de>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<5624C9C5.6000002@metafoo.de>
Date: Mon, 19 Oct 2015 14:19:00 +0200
Message-ID: <CAGhQ9VyMbSEEtvaT9R1Pdm4FQf0AzGYWHKMkTHn=rfRHecUXtw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer driver
From: Joachim  Eastwood <manabian@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Lars-Peter,

On 19 October 2015 at 12:45, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/18/2015 12:25 AM, Joachim Eastwood wrote:
>> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
>> I2C and SPI bus support. This is a rather simple driver that
>> currently doesn't support all the hardware features of MMA7455L.
>>
>> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>
> Looks pretty good in general.
>
> [...];
>> +
>> +static int mma7455_drdy(struct mma7455_data *mma7455)
>> +{
>> +     unsigned int reg;
>> +     int tries = 10;
>> +     int ret;
>> +
>> +     while (tries-- > 0) {
>> +             ret = regmap_read(mma7455->regmap, MMA7455_REG_STATUS, &reg);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if (reg & MMA7455_STATUS_DRDY)
>> +                     return 0;
>> +
>> +             msleep(20);
>
> I'm not to sure about this, when the IRQ fires the data should either be
> ready or not, no? Are there any corner cases where waiting for up to 200 ms
> will generate valid data, whereas not waiting wont?

At the moment there is no IRQ support and when used in poll mode I
think checking DRDY is the safest thing to do.
'tries' is probably set a bit high here. I can lower it to 3.
Generating a sample at the lowest sample rate (125 Hz) should take
8ms.


>> +     }
>> +
>> +     dev_warn(mma7455->dev, "data not ready\n");
>> +
>> +     return -EIO;
>> +}
>> +
> [...]
>> +static int mma7455_read_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int *val, int *val2, long mask)
>> +{
>> +     struct mma7455_data *mma7455 = iio_priv(indio_dev);
>> +     unsigned int reg = 0;
>> +     int ret;
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             if (iio_buffer_enabled(indio_dev))
>> +                     return -EBUSY;
>> +
>> +             ret = mma7455_drdy(mma7455);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = regmap_bulk_read(mma7455->regmap, chan->scan_index * 2,
>> +                                    &reg, sizeof(s16));
>
> reg is unsigned int while you only read 16 bit. This will cause endianess
> issues. If you read a hardware register from a external peripheral always
> use __{be,le}{8,16,32} according to the hardware layout and then use the
> proper conversion functions {be,le}{8,16,32}_to_cpu() to convert the value
> to CPU endianness.

Ok, will do.

>> +             if (ret)
>> +                     return ret;
>> +
>> +             *val = sign_extend32(reg, 9);
>> +
>> +             return IIO_VAL_INT;
>> +
> [...]
>> +static ssize_t mma7455_show_scale_avail(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     return scnprintf(buf, PAGE_SIZE, "0.%u\n", MMA7455_10BIT_SCALE);
>> +}
>
> It doesn't make sense to have this at the moment when there is only one
> valid scale available.

Ok, I'll remove it.


> [...]
>> +static int __init mma7455_modinit(void)
>> +{
>> +     int ret;
>> +#if IS_ENABLED(CONFIG_I2C)
>> +     ret = i2c_add_driver(&mma7455_i2c_driver);
>> +     if (ret)
>> +             pr_err("failed to register MMA7455L I2C driver: %d\n", ret);
>> +#endif
>> +#if IS_ENABLED(CONFIG_SPI_MASTER)
>> +     ret = spi_register_driver(&mma7455_spi_driver);
>> +     if (ret)
>> +             pr_err("failed to register MMA7455L SPI driver: %d\n", ret);
>> +#endif
>
> I know there are a fair amount of bad examples in the IIO tree for this,
> which do the same thing. But the SPI and the I2C parts should go into
> different modules, otherwise you run into issues if one of them is built-in
> while the other is built as a module. The bmg160 gyro driver is a good
> example on how to do handle this.

Ok, I semi-copied from a ASoC CODEC driver. I'll take a look at how
bmg160 handles it.


Thanks for reviewing, I'll implement the changes in the next version.


regards,
Joachim Eastwood
