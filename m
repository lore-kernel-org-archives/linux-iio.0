Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E4B8413.6070204@analog.com>
Date: Wed, 17 Aug 2011 11:04:19 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 5/6] staging:iio:adc:ad7150: use i2c_smbus commands +
 drop unused poweroff timeout control.
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk> <1313570537-26971-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-6-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
> Minimal changes to code layout as going to do chan spec conversion shortly.
> Otherwise, there are numerous code sharing opportunities in here and abi
> elements that are uterly non compliant.
>
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
> ---
>   drivers/staging/iio/adc/ad7150.c |  279 +++++++++++++++++---------------------
>   1 files changed, 122 insertions(+), 157 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
> index 973fcea..2bea6fe 100644
> --- a/drivers/staging/iio/adc/ad7150.c
> +++ b/drivers/staging/iio/adc/ad7150.c
> @@ -88,47 +88,6 @@ ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
>   };
>
>   /*
> - * ad7150 register access by I2C
> - */
> -
> -static int ad7150_i2c_read(struct ad7150_chip_info *chip, u8 reg, u8 *data, int len)
> -{
> -       struct i2c_client *client = chip->client;
> -       int ret = 0;
> -
> -       ret = i2c_master_send(client,&reg, 1);
> -       if (ret<  0) {
> -               dev_err(&client->dev, "I2C write error\n");
> -               return ret;
> -       }
> -
> -       ret = i2c_master_recv(client, data, len);
> -       if (ret<  0) {
> -               dev_err(&client->dev, "I2C read error\n");
> -               return ret;
> -       }
> -
> -       return ret;
> -}
> -
> -static int ad7150_i2c_write(struct ad7150_chip_info *chip, u8 reg, u8 data)
> -{
> -       struct i2c_client *client = chip->client;
> -       int ret = 0;
> -
> -       u8 tx[2] = {
> -               reg,
> -               data,
> -       };
> -
> -       ret = i2c_master_send(client, tx, 2);
> -       if (ret<  0)
> -               dev_err(&client->dev, "I2C write error\n");
> -
> -       return ret;
> -}
> -
> -/*
>    * sysfs nodes
>    */
>
> @@ -196,16 +155,23 @@ static ssize_t ad7150_store_conversion_mode(struct device *dev,
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
>          u8 cfg;
> -       int i;
> +       int i, ret;
>
> -       ad7150_i2c_read(chip, AD7150_CFG,&cfg, 1);
> +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> +       if (ret<  0)
> +               return ret;
> +       cfg = ret;
>
>          for (i = 0; i<  AD7150_MAX_CONV_MODE; i++) {
>                  if (strncmp(buf, ad7150_conv_mode_table[i].name,
>                                  strlen(ad7150_conv_mode_table[i].name) - 1) == 0) {
>                          chip->conversion_mode = ad7150_conv_mode_table[i].name;
>                          cfg |= 0x18 | ad7150_conv_mode_table[i].reg_cfg;
> -                       ad7150_i2c_write(chip, AD7150_CFG, cfg);
> +                       ret = i2c_smbus_write_byte_data(chip->client,
> +                                                       AD7150_CFG,
> +                                                       cfg);
> +                       if (ret<  0)
> +                               return ret;
>                          return len;
>                  }
>          }
> @@ -234,10 +200,13 @@ static ssize_t ad7150_show_ch1_value(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       u8 data[2];
> +       int ret;
> +
> +       ret = i2c_smbus_read_word_data(chip->client, AD7150_CH1_DATA_HIGH);

Hi Jonathan,

Byte ordering issue here-

SMBus Read Word:  i2c_smbus_read_word_data()
============================================

This operation is very like Read Byte; again, data is read from a
device, from a designated register that is specified through the Comm
byte. But this time, the data is a complete word (16 bits).

S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA

i2c_smbus_read_word_data() and i2c_smbus_write_word_data() assumes the
Low byte first - however the AD7150 transmits and expects the High-byte 
first.

Therefore we need an unconditional swab16() for all smbus word transactions.

return sprintf(buf, "%d\n", swab16(ret));


-Michael

> +       if (ret<  0)
> +               return ret;
>
> -       ad7150_i2c_read(chip, AD7150_CH1_DATA_HIGH, data, 2);
> -       return sprintf(buf, "%d\n", ((int) data[0]<<  8) | data[1]);
> +       return sprintf(buf, "%d\n", ret);
>   }
>
>   static IIO_DEV_ATTR_CH1_VALUE(ad7150_show_ch1_value);
> @@ -248,10 +217,13 @@ static ssize_t ad7150_show_ch2_value(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       u8 data[2];
> +       int ret;
> +
> +       ret = i2c_smbus_read_word_data(chip->client, AD7150_CH1_DATA_HIGH);
> +       if (ret<  0)
> +               return ret;
>
> -       ad7150_i2c_read(chip, AD7150_CH2_DATA_HIGH, data, 2);
> -       return sprintf(buf, "%d\n", ((int) data[0]<<  8) | data[1]);
> +       return sprintf(buf, "%d\n", ret);
>   }
>
>   static IIO_DEV_ATTR_CH2_VALUE(ad7150_show_ch2_value);
> @@ -273,21 +245,28 @@ static ssize_t ad7150_store_threshold_mode(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> +       int ret;
>          u8 cfg;
>
> -       ad7150_i2c_read(chip, AD7150_CFG,&cfg, 1);
> +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> +       if (ret<  0)
> +               return ret;
> +       cfg = ret;
>
>          if (strncmp(buf, "fixed", 5) == 0) {
>                  strcpy(chip->threshold_mode, "fixed");
>                  cfg |= AD7150_CFG_FIX;
> -               ad7150_i2c_write(chip, AD7150_CFG, cfg);
> +               ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> +               if (ret<  0)
> +                       return ret;
>
>                  return len;
>          } else if (strncmp(buf, "adaptive", 8) == 0) {
>                  strcpy(chip->threshold_mode, "adaptive");
>                  cfg&= ~AD7150_CFG_FIX;
> -               ad7150_i2c_write(chip, AD7150_CFG, cfg);
> -
> +               ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
> +               if (ret<  0)
> +                       return ret;
>                  return len;
>          }
>
> @@ -316,19 +295,22 @@ static ssize_t ad7150_store_ch1_threshold(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u16 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou16(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x10000)) {
> -               ad7150_i2c_write(chip, AD7150_CH1_THR_HOLD_H, data>>  8);
> -               ad7150_i2c_write(chip, AD7150_CH1_THR_HOLD_L, data);
> -               chip->ch1_threshold = data;
> -               return len;
> -       }
> +       ret = i2c_smbus_write_word_data(chip->client,
> +                                       AD7150_CH1_THR_HOLD_H,
> +                                       data);
> +       if (ret<  0)
> +               return ret;
>
> -       return -EINVAL;
> +       chip->ch1_threshold = data;
> +
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH1_THRESHOLD(S_IRUGO | S_IWUSR,
> @@ -352,19 +334,22 @@ static ssize_t ad7150_store_ch2_threshold(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u16 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou16(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x10000)) {
> -               ad7150_i2c_write(chip, AD7150_CH2_THR_HOLD_H, data>>  8);
> -               ad7150_i2c_write(chip, AD7150_CH2_THR_HOLD_L, data);
> -               chip->ch2_threshold = data;
> -               return len;
> -       }
> +       ret = i2c_smbus_write_word_data(chip->client,
> +                                       AD7150_CH2_THR_HOLD_H,
> +                                       data);
> +       if (ret<  0)
> +               return ret;
>
> -       return -EINVAL;
> +       chip->ch2_threshold = data;
> +
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH2_THRESHOLD(S_IRUGO | S_IWUSR,
> @@ -388,18 +373,21 @@ static ssize_t ad7150_store_ch1_sensitivity(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
> +       ret = i2c_smbus_write_byte_data(chip->client,
> +                                       AD7150_CH1_SENSITIVITY,
> +                                       data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH1_SENSITIVITY, data);
> -               chip->ch1_sensitivity = data;
> -               return len;
> -       }
> +       chip->ch1_sensitivity = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH1_SENSITIVITY(S_IRUGO | S_IWUSR,
> @@ -423,18 +411,21 @@ static ssize_t ad7150_store_ch2_sensitivity(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
> +       ret = i2c_smbus_write_byte_data(chip->client,
> +                                       AD7150_CH2_SENSITIVITY,
> +                                       data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH2_SENSITIVITY, data);
> -               chip->ch2_sensitivity = data;
> -               return len;
> -       }
> +       chip->ch2_sensitivity = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH2_SENSITIVITY(S_IRUGO | S_IWUSR,
> @@ -458,18 +449,19 @@ static ssize_t ad7150_store_ch1_timeout(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH1_TIMEOUT, data);
> -               chip->ch1_timeout = data;
> -               return len;
> -       }
> +       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CH1_TIMEOUT, data);
> +       if (ret<  0)
> +               return ret;
> +       chip->ch1_timeout = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH1_TIMEOUT(S_IRUGO | S_IWUSR,
> @@ -493,18 +485,19 @@ static ssize_t ad7150_store_ch2_timeout(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH2_TIMEOUT, data);
> -               chip->ch2_timeout = data;
> -               return len;
> -       }
> +       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CH2_TIMEOUT, data);
> +       if (ret<  0)
> +               return ret;
> +       chip->ch2_timeout = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH2_TIMEOUT(S_IRUGO | S_IWUSR,
> @@ -528,19 +521,19 @@ static ssize_t ad7150_store_ch1_setup(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> -
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH1_SETUP, data);
> -               chip->ch1_setup = data;
> -               return len;
> -       }
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> +       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CH1_SETUP, data);
> +       if (ret<  0)
> +               return ret;
> +       chip->ch1_setup = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH1_SETUP(S_IRUGO | S_IWUSR,
> @@ -564,58 +557,25 @@ static ssize_t ad7150_store_ch2_setup(struct device *dev,
>   {
>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>          struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> +       u8 data;
>          int ret;
>
> -       ret = strict_strtoul(buf, 10,&data);
> +       ret = kstrtou8(buf, 10,&data);
> +       if (ret<  0)
> +               return ret;
>
> -       if ((!ret)&&  (data<  0x100)) {
> -               ad7150_i2c_write(chip, AD7150_CH2_SETUP, data);
> -               chip->ch2_setup = data;
> -               return len;
> -       }
> +       ret = i2c_smbus_write_byte_data(chip->client, AD7150_CH2_SETUP, data);
> +       if (ret<  0)
> +               return ret;
> +       chip->ch2_setup = data;
>
> -       return -EINVAL;
> +       return len;
>   }
>
>   static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
>                  ad7150_show_ch2_setup,
>                  ad7150_store_ch2_setup);
>
> -static ssize_t ad7150_show_powerdown_timer(struct device *dev,
> -               struct device_attribute *attr,
> -               char *buf)
> -{
> -       struct iio_dev *dev_info = dev_get_drvdata(dev);
> -       struct ad7150_chip_info *chip = iio_priv(dev_info);
> -
> -       return sprintf(buf, "0x%02x\n", chip->powerdown_timer);
> -}
> -
> -static ssize_t ad7150_store_powerdown_timer(struct device *dev,
> -               struct device_attribute *attr,
> -               const char *buf,
> -               size_t len)
> -{
> -       struct iio_dev *dev_info = dev_get_drvdata(dev);
> -       struct ad7150_chip_info *chip = iio_priv(dev_info);
> -       unsigned long data;
> -       int ret;
> -
> -       ret = strict_strtoul(buf, 10,&data);
> -
> -       if ((!ret)&&  (data<  0x40)) {
> -               chip->powerdown_timer = data;
> -               return len;
> -       }
> -
> -       return -EINVAL;
> -}
> -
> -static IIO_DEV_ATTR_POWERDOWN_TIMER(S_IRUGO | S_IWUSR,
> -               ad7150_show_powerdown_timer,
> -               ad7150_store_powerdown_timer);
> -
>   static struct attribute *ad7150_attributes[] = {
>          &iio_dev_attr_available_conversion_modes.dev_attr.attr,
>          &iio_dev_attr_conversion_mode.dev_attr.attr,
> @@ -629,7 +589,6 @@ static struct attribute *ad7150_attributes[] = {
>          &iio_dev_attr_ch2_setup.dev_attr.attr,
>          &iio_dev_attr_ch1_sensitivity.dev_attr.attr,
>          &iio_dev_attr_ch2_sensitivity.dev_attr.attr,
> -&iio_dev_attr_powerdown_timer.dev_attr.attr,
>          &iio_dev_attr_ch1_value.dev_attr.attr,
>          &iio_dev_attr_ch2_value.dev_attr.attr,
>          NULL,
> @@ -649,8 +608,14 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
>          struct ad7150_chip_info *chip = iio_priv(indio_dev);
>          u8 int_status;
>          s64 timestamp = iio_get_time_ns();
> +       int ret;
> +
> +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
> +
> +       if (ret<  0)
> +               return IRQ_HANDLED;
>
> -       ad7150_i2c_read(chip, AD7150_STATUS,&int_status, 1);
> +       int_status = ret;
>
>          if ((int_status&  AD7150_STATUS_OUT1)&&
>              !(chip->old_state&  AD7150_STATUS_OUT1))
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
