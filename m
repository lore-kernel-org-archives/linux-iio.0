Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <55907E2F.3030308@gmx.de>
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
	<1429891112-11888-2-git-send-email-daniel.baluta@intel.com>
	<55907E2F.3030308@gmx.de>
Date: Mon, 29 Jun 2015 10:52:23 +0300
Message-ID: <CAEnQRZBpzEo1xcQJh7-Uo+WL_TOkUKhUR3QtTfXor=yKtwXh4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: magnetometer: Add support for MEMSIC MMC35240 sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 29, 2015 at 2:07 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 24.04.2015 um 17:58:
>> Minimal implementation for MMC35240 3-axis magnetometer
>> sensor. It provides processed readings and possiblity to change
>> the sampling frequency.
>>
>
> Hi Daniel,
> please find a few issues inline, which you could address in a next
> rework patch set. I would have sent a patch for the critical stuff,
> but was obviously too stupid to find a data sheet :-(

Well, there is no public datasheet. We are discussing with the vendor
to make it public.

<snip>

>> +#define MMC35240_CTRL0_REFILL_BIT    BIT(7)
>> +#define MMC35240_CTRL0_RESET_BIT     BIT(6)
>> +#define MMC35240_CTRL0_SET_BIT               BIT(5)
>> +#define MMC35240_CTRL0_CMM_BIT               BIT(1)
>> +#define MMC35240_CTRL0_TM_BIT                BIT(0)
>
> It took me quite some time to figure out TM would stand for take measurement.
> Still no clue about CMM (it's still not used from what I could see). Would be
> great if you could comment them.

CMM = Continuous Measurement Mode. I will add a comment with
the next patches.

>
>> +
>> +/* output resolution bits */
>> +#define MMC35240_CTRL1_BW0_BIT               BIT(0)
>> +#define MMC35240_CTRL1_BW1_BIT               BIT(1)
>> +
>> +#define MMC35240_CTRL1_BW_MASK        (MMC35240_CTRL1_BW0_BIT | \
>> +              MMC35240_CTRL1_BW1_BIT)
>> +#define MMC35240_CTRL1_BW_SHIFT              0
>> +
>> +#define MMC35240_WAIT_CHARGE_PUMP    50000   /* us */
>> +#define MMC53240_WAIT_SET_RESET              1000    /* us */
>> +
>> +enum mmc35240_resolution {
>> +     MMC35240_16_BITS_SLOW = 0, /* 100 Hz */
>> +     MMC35240_16_BITS_FAST,     /* 200 Hz */
>> +     MMC35240_14_BITS,          /* 333 Hz */
>> +     MMC35240_12_BITS,          /* 666 Hz */
>> +};
>> +
>> +enum mmc35240_axis {
>> +     AXIS_X = 0,
>> +     AXIS_Y,
>> +     AXIS_Z,
>> +};
>> +
>> +static const struct {
>> +     int sens[3]; /* sensitivity per X, Y, Z axis */
>> +     int nfo; /* null field output */
>> +} mmc35240_props_table[] = {
>> +     /* 16 bits, 100Hz ODR */
>> +     {
>> +             {1024, 1024, 770},
>> +             32768,
>> +     },
>> +     /* 16 bits, 200Hz ODR */
>> +     {
>> +             {1024, 1024, 770},
>> +             32768,
>> +     },
>> +     /* 14 bits, 333Hz ODR */
>> +     {
>> +             {256, 256, 193},
>> +             8192,
>> +     },
>> +     /* 12 bits, 666Hz ODR */
>> +     {
>> +             {64, 64, 48},
>> +             2048,
>> +     },
>> +};
>> +
>> +struct mmc35240_data {
>> +     struct i2c_client *client;
>> +     struct mutex mutex;
>> +     struct regmap *regmap;
>> +     enum mmc35240_resolution res;
>> +};
>> +
>> +int mmc35240_samp_freq[] = {100, 200, 333, 666};
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 333 666");
>> +
>> +#define MMC35240_CHANNEL(_axis) { \
>> +     .type = IIO_MAGN, \
>> +     .modified = 1, \
>> +     .channel2 = IIO_MOD_ ## _axis, \
>> +     .address = AXIS_ ## _axis, \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>> +}
>> +
>> +static const struct iio_chan_spec mmc35240_channels[] = {
>> +     MMC35240_CHANNEL(X),
>> +     MMC35240_CHANNEL(Y),
>> +     MMC35240_CHANNEL(Z),
>> +};
>> +
>> +static struct attribute *mmc35240_attributes[] = {
>> +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +};
>> +
>> +static const struct attribute_group mmc35240_attribute_group = {
>> +     .attrs = mmc35240_attributes,
>> +};
>> +
>> +static int mmc35240_get_samp_freq_index(struct mmc35240_data *data,
>> +                                     int val, int val2)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(mmc35240_samp_freq); i++)
>> +             if (mmc35240_samp_freq[i] == val)
>> +                     return i;
>> +     return -EINVAL;
>> +}
>> +
>> +static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
>> +{
>> +     int ret;
>> +     u8 coil_bit;
>> +
>> +     /*
>> +      * Recharge the capacitor at VCAP pin, requested to be issued
>> +      * before a SET/RESET command.
>> +      */
>> +     ret = regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
>> +                              MMC35240_CTRL0_REFILL_BIT,
>> +                              MMC35240_CTRL0_REFILL_BIT);
>> +     if (ret < 0)
>> +             return ret;
>> +     usleep_range(MMC35240_WAIT_CHARGE_PUMP, MMC35240_WAIT_CHARGE_PUMP + 1);
>> +
>> +     if (set)
>> +             coil_bit = MMC35240_CTRL0_SET_BIT;
>> +     else
>> +             coil_bit = MMC35240_CTRL0_RESET_BIT;
>> +
>> +     return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
>> +                               MMC35240_CTRL0_REFILL_BIT,
>> +                               coil_bit);
>
> coil_bit is in any case outside the mask of MMC35240_CTRL0_REFILL_BIT.
> Not sure about the whole intention, meaning in which state
> MMC35240_CTRL0_REFILL_BIT is supposed to be (set) when either
> MMC35240_CTRL0_SET_BIT or MMC35240_CTRL0_RESET_BIT is written.

Yes, this is a bug. We have a patch prepared for it. Will send once Jonathan is
ready to accept bugfixes. Together with this:

http://marc.info/?l=linux-iio&m=143489464403101&w=2


>
>> +}
>> +
>> +static int mmc35240_init(struct mmc35240_data *data)
>> +{
>> +     int ret;
>> +     unsigned int reg_id;
>> +
>> +     ret = regmap_read(data->regmap, MMC35240_REG_ID, &reg_id);
>> +     if (ret < 0) {
>> +             dev_err(&data->client->dev, "Error reading product id\n");
>> +             return ret;
>> +     }
>> +
>> +     dev_dbg(&data->client->dev, "MMC35240 chip id %x\n", reg_id);
>> +
>> +     /*
>> +      * make sure we restore sensor characteristics, by doing
>> +      * a RESET/SET sequence
>> +      */
>> +     ret = mmc35240_hw_set(data, false);
>> +     if (ret < 0)
>> +             return ret;
>> +     usleep_range(MMC53240_WAIT_SET_RESET, MMC53240_WAIT_SET_RESET + 1);
>> +
>> +     ret = mmc35240_hw_set(data, true);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /* set default sampling frequency */
>> +     return regmap_update_bits(data->regmap, MMC35240_REG_CTRL1,
>> +                               MMC35240_CTRL1_BW_MASK,
>> +                               data->res << MMC35240_CTRL1_BW_SHIFT);
>> +}
>> +
>> +static int mmc35240_take_measurement(struct mmc35240_data *data)
>> +{
>> +     int ret, tries = 100;
>> +     unsigned int reg_status;
>> +
>> +     ret = regmap_write(data->regmap, MMC35240_REG_CTRL0,
>> +                        MMC35240_CTRL0_TM_BIT);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     while (tries-- > 0) {
>> +             ret = regmap_read(data->regmap, MMC35240_REG_STATUS,
>> +                               &reg_status);
>> +             if (ret < 0)
>> +                     return ret;
>> +             if (reg_status & MMC35240_STATUS_MEAS_DONE_BIT)
>> +                     break;
>
> I would actually return 0 here, as measurement was successful. That
> would mean that getting outside the loop is the error case and would
> make the check obsolete.

You are right, this could also work. Anyhow, I think code is easier to
understand as it is. The check for (tries < 0) makes it very clear, that the
data was not ready.

Getting outside the loop in the error case is harder to understand at a first
glance.

>
>> +             msleep(20);
>> +     }
>> +
>> +     if (tries < 0) {
>> +             dev_err(&data->client->dev, "data not ready\n");
>> +             return -EIO;
>
> Doesn't this qualify more for a timeout error, rather than I/O?

Looking at the IIO drivers, most of them return EIO in such case.
(grep for EIO in drivers/iio/light for example)

<snip>

>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>> +             mutex_lock(&data->mutex);
>> +             ret = regmap_read(data->regmap, MMC35240_REG_CTRL1, &reg);
>> +             mutex_unlock(&data->mutex);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             i = (reg & MMC35240_CTRL1_BW_MASK) >> MMC35240_CTRL1_BW_SHIFT;
>> +             if (i < 0 || i > ARRAY_SIZE(mmc35240_samp_freq))
>
> I would drop i and keep using reg. Has the nice side effect that you don't
> need to check for negative values.

Ok.


<snip>

>> +
>> +static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case MMC35240_REG_CTRL0:
>> +     case MMC35240_REG_CTRL1:
>
> I would regard MMC35240_REG_ID as non-volatile, as well. Or is it because it
> is just accessed once?

Correct, we access it only once.

Hartmut, thanks a lot for your reviews!

thanks,
Daniel.
