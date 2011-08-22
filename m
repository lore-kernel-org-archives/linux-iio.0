Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 22 Aug 2011 12:48:34 +0100
Subject: RE: [PATCH 2/3] iio: capfun: ad7150: remove conversion mode
 handling.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6D06602@LIMKCMBX1.ad.analog.com>
References: <1313757716-20557-1-git-send-email-michael.hennerich@analog.com>
 <1313757716-20557-2-git-send-email-michael.hennerich@analog.com>
 <4E4E67A4.4060908@cam.ac.uk>
In-Reply-To: <4E4E67A4.4060908@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-08-19:
> On 08/19/11 13:41, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The AD7150 family of devices power up in continues conversion mode. We
>> can stay in this mode, unless power consumption becomes a real issue.
>> Actually the event generation as well as the running average relies on
>> continues conversion mode, so we better stay there. Makes sense
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> (rather than ack as I'll handle this patch through the capfun branch)
> - actually I'll sign off all 3 for that reason.

Sure - no problem.
I'll send you more patches shortly when I tested the AD7152 driver.

-Michael

>> ---
>>  drivers/staging/iio/adc/ad7150.c |   94 ----------------------------
>>  ---------- 1 files changed, 0 insertions(+), 94 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad7150.c
>> b/drivers/staging/iio/adc/ad7150.c index fdf4da8..4bc5b20 100644 ---
>> a/drivers/staging/iio/adc/ad7150.c +++
>> b/drivers/staging/iio/adc/ad7150.c @@ -88,93 +88,10 @@ struct
>> ad7150_chip_info {
>>      struct mutex state_lock;
>>  };
>> -struct ad7150_conversion_mode {
>> -    char *name;
>> -    u8 reg_cfg;
>> -};
>> -
>> -static struct ad7150_conversion_mode
>> -ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] =3D {
>> -    { "idle", 0 },
>> -    { "continuous-conversion", 1 },
>> -    { "single-conversion", 2 },
>> -    { "power-down", 3 },
>> -};
>> -
>>  /*
>>   * sysfs nodes
>>   */
>> -#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)                  \
>> -    IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0=
)
>> -#define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store) \
>> -    IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0) - -static
>> ssize_t ad7150_show_conversion_modes(struct device *dev, -           str=
uct
>> device_attribute *attr, -            char *buf) -{ - int i; -        int=
 len =3D 0; -
>> -    for (i =3D 0; i < AD7150_MAX_CONV_MODE; i++) -            len +=3D =
sprintf(buf +
>> len, "%s\n", -                              ad7150_conv_mode_table[i].na=
me); - -     return
>> len; -} - -static
>> IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(ad7150_show_conversion_modes); -
>> -static ssize_t ad7150_show_conversion_mode(struct device *dev,
>> -            struct device_attribute *attr, -                char *buf) =
-{ - struct iio_dev
>> *dev_info =3D dev_get_drvdata(dev); -  struct ad7150_chip_info *chip =3D
>> iio_priv(dev_info); - -      return sprintf(buf, "%s\n",
>> chip->conversion_mode); -} - -static ssize_t
>> ad7150_store_conversion_mode(struct device *dev, -           struct
>> device_attribute *attr, -            const char *buf, -              siz=
e_t len) -{ -        struct
>> iio_dev *dev_info =3D dev_get_drvdata(dev); -  struct ad7150_chip_info
>> *chip =3D iio_priv(dev_info); -        u8 cfg; -       int i, ret; - - r=
et =3D
>> i2c_smbus_read_byte_data(chip->client, AD7150_CFG); -        if (ret < 0=
)
>> -            return ret; -   cfg =3D ret; - -  for (i =3D 0; i < AD7150_=
MAX_CONV_MODE;
>> i++) { -             if (strncmp(buf, ad7150_conv_mode_table[i].name,
>> -                            strlen(ad7150_conv_mode_table[i].name) - 1)=
 =3D=3D -                    0) {
>> -                    chip->conversion_mode =3D ad7150_conv_mode_table[i]=
.name; -                       cfg |=3D
>> 0x18 | ad7150_conv_mode_table[i].reg_cfg; -                  ret =3D
>> i2c_smbus_write_byte_data(chip->client, -                               =
                     AD7150_CFG,
>> -                                                    cfg); -            =
     if (ret < 0) -                          return ret; -                 =
  return len; -           }
>> -    } - -   dev_err(dev, "not supported conversion mode\n"); - -    ret=
urn
>> -EINVAL; -} - -static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
>> -            ad7150_show_conversion_mode, -          ad7150_store_conver=
sion_mode); -
>>  static const u8 ad7150_addresses[][6] =3D {
>>      { AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
>>        AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
>> @@ -542,16 +459,6 @@ static const struct iio_chan_spec
> ad7150_channels[] =3D {
>>      },
>>  };
>> -static struct attribute *ad7150_attributes[] =3D {
>> -    &iio_dev_attr_available_conversion_modes.dev_attr.attr,
>> -    &iio_dev_attr_conversion_mode.dev_attr.attr,
>> -    NULL,
>> -};
>> -
>> -static const struct attribute_group ad7150_attribute_group =3D {
>> -    .attrs =3D ad7150_attributes,
>> -};
>> -
>>  /*
>>   * threshold events
>>   */
>> @@ -636,7 +543,6 @@ static struct attribute_group
> ad7150_event_attribute_group =3D {
>>  };
>>
>>  static const struct iio_info ad7150_info =3D { -      .attrs =3D
>>  &ad7150_attribute_group,    .event_attrs =3D
>>  &ad7150_event_attribute_group,      .driver_module =3D THIS_MODULE,
>>      .read_raw =3D &ad7150_read_raw,
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
