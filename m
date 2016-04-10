Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGhQ9Vz7S1H8BO5YqzQFj7VFn36jF6poHK+fRUOyn05KUdgTPg@mail.gmail.com>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
	<1460190283-3296-1-git-send-email-cristina.moraru09@gmail.com>
	<CAGhQ9Vz7S1H8BO5YqzQFj7VFn36jF6poHK+fRUOyn05KUdgTPg@mail.gmail.com>
Date: Sun, 10 Apr 2016 15:10:05 +0200
Message-ID: <CAGhQ9Vz6iLyGsQQEexT2CO4Op5rqnBuHJEDSG45X-Xqe+dGtWw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: max5487: Add support for Maxim digital potentiometers
From: Joachim  Eastwood <manabian@gmail.com>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, peda@axentia.se,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10 April 2016 at 14:47, Joachim  Eastwood <manabian@gmail.com> wrote:
> Hi Cristina,
>
> On 9 April 2016 at 10:24, Cristina Moraru <cristina.moraru09@gmail.com> wrote:
>> Add implementation for Maxim MAX5487, MAX5488, MAX5489
>> digital potentiometers.
>>
>> Datasheet:
>> http://datasheets.maximintegrated.com/en/ds/MAX5487-MAX5489.pdf
>>
>> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
>> CC: Daniel Baluta <daniel.baluta@intel.com>
>> ---
> ...
>> +static int max5487_read_raw(struct iio_dev *indio_dev,
>> +                           struct iio_chan_spec const *chan,
>> +                           int *val, int *val2, long mask)
>> +{
>> +       struct max5487_data *data = iio_priv(indio_dev);
>> +
>> +       if (mask != IIO_CHAN_INFO_SCALE)
>> +               return -EINVAL;
>> +
>> +       *val = 1000 * data->kohms;
>> +       *val2 = MAX5487_MAX_POS;
>
> Newline before return.
>
>> +       return IIO_VAL_FRACTIONAL;
>> +}
>> +
>> +static int max5487_write_raw(struct iio_dev *indio_dev,
>> +                            struct iio_chan_spec const *chan,
>> +                            int val, int val2, long mask)
>> +{
>> +       struct max5487_data *data = iio_priv(indio_dev);
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               if (val < 0 || val > MAX5487_MAX_POS)
>> +                       return -EINVAL;
>> +               return regmap_write(data->regmap, chan->address, val);
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +       return -EINVAL;
>
> To be consistent with your max5487_read_raw() function you could do a:
>        if (mask != IIO_CHAN_INFO_RAW)
>                return -EINVAL;
>
>
>> +static const struct iio_info max5487_info = {
>> +       .read_raw = &max5487_read_raw,
>> +       .write_raw = &max5487_write_raw,
>
> Address operator should be unnecessary on functions.
>
>
>> +       data->regmap = devm_regmap_init_spi(spi, &max5487_regmap_config);
>> +       if (IS_ERR(data->regmap))
>> +               return PTR_ERR(data->regmap);
>
> Nothing wrong with using regmap here, but since you are only using
> simple regmap_write()'s you might as well have used spi_write()
> directly. I am not telling you to switch, but I don't see the point of
> using regmap here.

Looking again: it seem that spi.h doesn't have a function that do
write(cmd, data) which regmap does. So I guess that is one reason for
using regmap. But it wouldn't be hard to create a write(cmd,
data)-function for spi either. Just wrap spi_write() and have a local
buf var. I am a bit surprised that spi.h doesn't have such a function
as it should be quite a common pattern for spi chips.

>
> Which reminds me; for regmap you need to select REGMAP_SPI in your
> Kconfig entry.
>
>
> regards,
> Joachim Eastwood
