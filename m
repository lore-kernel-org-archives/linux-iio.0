Return-Path: <cristina.mihaela.ciocan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1503191434530.23594@pmeerw.net>
References: <1426768752-20951-1-git-send-email-cristina.ciocan@intel.com>
	<alpine.DEB.2.02.1503191434530.23594@pmeerw.net>
Date: Thu, 19 Mar 2015 18:43:33 +0200
Message-ID: <CAEP+FkX-zUvhZGCgM-mA-fhJ36y4_MraJ3jjm3tKcy1Vg+-dSA@mail.gmail.com>
Subject: Re: [PATCH] iio:light: Add Avago APDS9930 ALS support
From: Cristina Ciocan <cristina.mihaela.ciocan@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Cristina Ciocan <cristina.ciocan@intel.com>, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=e89a8f234d458bab080511a6e682
List-ID: <linux-iio@vger.kernel.org>

--e89a8f234d458bab080511a6e682
Content-Type: text/plain; charset=UTF-8

Hello Peter,

The APDS 9300 device is similar to the ALS component of the APDS 9930,
although there are differences (Lux computation is different, gain handling
is not the same). Moreover, the APDS 9930 can also support proximity,
feature which the 9300 device does not offer. I have not yet managed to
properly test the proximity implementation and this is the reason why I
have only sent upstream the ALS implementation. Therefore, wouldn't the
code get too complicated to mix the 2 devices in one driver ?

Thank you for the review, I will send a second version to fix style issues.

CMD_REG_SETUP clears the type bits and also sets them to transaction_type.
This is because the transaction type can vary, thus we need to clear & set
it accordingly (it differs when R/W bytes vs words).

Kind regards,
Cristina


On Thu, Mar 19, 2015 at 3:41 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:

> Hello Cristina,
>
> > Added IIO driver for Avago's APDS 9930 proximity and ALS sensor. The
> current
> > implementation is for ALS functionality.
> >
> > It offers ACPI/DT support, irq and event handling, raw readings.
>
> can this driver be implemented by extending the apds9300 driver?
> the structure seems similar?
>
> some general comments:
> * not all specifiers are prefixed with apds9930_ or APDS9930_
> * the spelling of APDS9930 is APDS-9930 or APDS 9930 sometimes
> * is the CMD_REG_SETUP macro necessary, i.e. is there a need to mask out
> bits first, are they ever set?
> * style of multi-line comments
>
> regards, p.
>
> > Datasheet for this device can be found at
> >       http://www.avagotech.com/docs/AV02-3190EN.
> >
> > Signed-off-by: Cristina Ciocan <cristina.ciocan@intel.com>
> > ---
> >  drivers/iio/light/Kconfig    |  10 +
> >  drivers/iio/light/Makefile   |   1 +
> >  drivers/iio/light/apds9930.c | 912
> +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 923 insertions(+)
> >  create mode 100644 drivers/iio/light/apds9930.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index cd937d9..abeca21 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -37,6 +37,16 @@ config APDS9300
> >        To compile this driver as a module, choose M here: the
> >        module will be called apds9300.
> >
> > +config APDS9930
> > +     tristate "APDS9930 ambient light sensor"
> > +     depends on I2C
> > +     help
> > +      Say Y here if you want to build a driver for the Avago APDS9930
> > +      ambient light sensor.
> > +
> > +      To compile this driver as a module, choose M here: the
> > +      module will be called apds9930.
> > +
> >  config CM32181
> >       depends on I2C
> >       tristate "CM32181 driver"
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index ad7c30f..535d289 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_ADJD_S311)              += adjd_s311.o
> >  obj-$(CONFIG_AL3320A)                += al3320a.o
> >  obj-$(CONFIG_APDS9300)               += apds9300.o
> > +obj-$(CONFIG_APDS9930)               += apds9930.o
> >  obj-$(CONFIG_CM32181)                += cm32181.o
> >  obj-$(CONFIG_CM3232)         += cm3232.o
> >  obj-$(CONFIG_CM3323)         += cm3323.o
> > diff --git a/drivers/iio/light/apds9930.c b/drivers/iio/light/apds9930.c
> > new file mode 100644
> > index 0000000..47b53d1
> > --- /dev/null
> > +++ b/drivers/iio/light/apds9930.c
> > @@ -0,0 +1,912 @@
> > +/*
> > + * This is a driver for Avago APDS 9930 ALS sensor chip. It
> > + * is inspired from drivers/misc/apds990x.c to use IIO.
> > + *
> > + * The I2C slave address for this device is 0x39.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/pm.h>
> > +#include <linux/mutex.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/property.h>
> > +
> > +#include <linux/iio/types.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/events.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +
> > +#define APDS9930_DRIVER_NAME "apds9930"
> > +#define APDS9930_IRQ_NAME    "apds9930_irq"
> > +#define APDS9930_GPIO_NAME   "apds9930_gpio"
> > +
> > +#define APDS9930_INIT_SLEEP  5 /* sleep for 5 ms before issuing
> commands */
> > +
> > +/* I2C command register - fields and possible field values */
> > +/* CMD bit value must be set to 1 when addressing command register */
> > +#define APDS9930_CMD_SELECT          0x80
> > +/* TYPE possible values */
> > +#define APDS9930_CMD_TYPE_RB         0               /* Repeated byte */
> > +#define APDS9930_CMD_TYPE_AUTO_INC   BIT(5)          /* Auto-increment
> */
> > +#define APDS9930_CMD_TYPE_SPECIAL_FUNC       GENMASK(6, 5)   /* Special
> function */
> > +/* ADDR possible values */
> > +#define APDS9930_CMD_TYPE_ALS                0x6     /* ALS interrupt
> clear */
> > +/* Clear masks */
> > +#define APDS9930_CLEAR_CMD_TYPE_MASK GENMASK(4, 0)
> > +/* Shortcut to clear and set CMD and TYPE fields */
> > +#define CMD_REG_SETUP(reg, transaction_type) {               \
> > +     reg &= APDS9930_CLEAR_CMD_TYPE_MASK;            \
> > +     reg |= APDS9930_CMD_SELECT | transaction_type;  \
> > +}
> > +
> > +/* Register set (rw = read/write, r = read, w = write) */
> > +#define APDS9930_ENABLE_REG  0x00    /* rw-Enable of states and
> interrupts */
> > +#define APDS9930_ATIME_REG   0x01    /* rw-ALS ADC time*/
> > +#define APDS9930_WTIME_REG   0x03    /* rw-Wait time */
> > +#define APDS9930_AILTL_REG   0x04    /* rw-ALS interrupt low threshold
> low
> > +                                      * byte
> > +                                      */
> > +#define APDS9930_AIHTL_REG   0x06    /* rw-ALS interrupt high threshold
> low
> > +                                      * byte
> > +                                      */
> > +#define APDS9930_PERS_REG    0x0C    /* rw-Interrupt persistence
> filters */
> > +#define APDS9930_CONFIG_REG  0x0D    /* rw-Configuration */
> > +#define APDS9930_CONTROL_REG 0x0F    /* rw-Gain control register */
> > +#define APDS9930_ID_REG              0x12    /* r-Device ID */
> > +#define APDS9930_STATUS_REG  0x13    /* r-Device status */
> > +#define APDS9930_CDATAL_REG  0x14    /* r-Ch0 ADC low data register */
> > +#define APDS9930_IRDATAL_REG 0x16    /* r-Ch1 ADC low data register */
> > +
> > +/* Useful bits per register */
> > +
> > +/* Enable register */
> > +#define APDS9930_AIEN                BIT(4)  /* ALS interrupt enable */
> > +/* Persistence register */
> > +#define APDS9930_APERS_SHIFT 0       /* Interrupt persistence */
> > +/* Configuration register */
> > +#define APDS9930_AGL_SHIFT   2       /* ALS gain level */
> > +/* Control register */
> > +#define APDS9930_AGAIN_SHIFT 0       /* ALS gain control */
> > +/* Device ID - possible values */
> > +#define APDS9930_ID          0x39
> > +/* Status register */
> > +#define APDS9930_AINT                BIT(4)  /* ALS interrupt */
> > +
> > +/* Default values (already shifted) for registers content */
> > +#define APDS9930_DISABLE_ALL 0       /* Disable and powerdown */
> > +#define APDS9930_ENABLE_ALL  0x13    /* Set all ALS bits and power on */
> > +#define APDS9930_DEF_ATIME   0xdb    /* 101 ms */
> > +#define APDS9930_DEF_WTIME   0xff    /* 2.7 ms - min wait time */
> > +#define APDS9930_DEF_AGAIN   2       /* 16 x ALS gain */
> > +#define APDS9930_DEF_APERS   0       /* Each over/underflow triggers an
> > +                                      * interrupt
> > +                                      */
> > +
> > +/*
> > + * Interrupt threshold defaults - setting low to maximum will trigger a
> first
> > + * interrupt to allow us to read the data registers status and properly
> set a
> > + * threshold value to match the current environment.
> > + *
> > + * The default high threshold is set only for consistency, since the
> registers
> > + * are checked against in order: first if the value of CDATA is above
> LOW; if
> > + * so, trigger interrupt and do not check the HIGH threshold.
> > + */
> > +#define APDS9930_DEF_ALS_THRESH_LOW  0xffff
> > +#define APDS9930_DEF_ALS_THRESH_HIGH 0x0
> > +
> > +/* Default, open air, coefficients (for Lux computation) */
> > +#define DEF_DF       52      /* Device factor */
> > +/*
> > + * Material-depending coefficients (set to open air values). They are
> scaled for
> > + * computation purposes by 100.
> > + */
> > +#define DEF_LUX_DIVISION_SCALE       10000
> > +#define DEF_GA                       49
> > +#define DEF_B                        186
> > +#define DEF_C                        74
> > +#define DEF_D                        129
> > +
> > +/* Possible ALS gain values (with AGL cleared) */
> > +static const int again_values[] = {1, 8, 16, 120};
> > +#define APDS9930_MAX_AGAIN_INDEX     3
> > +#define APDS9930_AGL_DIVISION_SCALE  6
> > +
> > +/*
> > + * Percentages from the maximum CH0 value that indicate the recorded
> CH0 data is
> > + * too low or too high - for AGAIN adapting purposes.
> > + */
> > +#define APDS9930_CH0_HIGH_PERCENTAGE 90
> > +#define APDS9930_CH0_LOW_PERCENTAGE  10
> > +
> > +/*
> > + * With how much (in percentages) must the CH0 value differ from one
> step to
> > + * another in order to consider a significant change in light and
> trigger an
> > + * interrupt.
> > + */
> > +#define APDS9930_ALS_HYSTERESIS              20
> > +
> > +/*
> > + * Number of consecutive out-of-range measurements needed to trigger a
> gain
> > + * change. We count them and not change the gain each time the CH0 data
> is
> > + * out-of-range because it takes a couple of cycles for system to adapt
> to new
> > + * gain values.
> > + */
> > +#define APDS9930_MAX_COUNTS_FOR_GAIN_CHANGE  2
> > +
> > +/* DT or ACPI device properties names */
> > +#define GA_PROP              "intel,ga"
> > +#define COEF_B_PROP  "intel,coeff-B"
> > +#define COEF_C_PROP  "intel,coeff-B"
> > +#define COEF_D_PROP  "intel,coeff-D"
> > +#define DF_PROP              "intel,df"
> > +#define AGAIN_PROP   "intel,als-gain"
> > +#define ATIME_PROP   "intel,atime"
> > +
> > +struct apds9930_coefficients {
> > +     /* GA, B, C and D coefficients are scaled by 100 for computational
> > +        purposes. */
> > +     int ga;
> > +     int coef_a; /* This is 1, but needs to be set to a scaled value,
> thus if
> > +                    we decide to change the scale, this coefficient
> must also
> > +                    be changed. */
> > +     int coef_b;
> > +     int coef_c;
> > +     int coef_d;
> > +     int df;
> > +};
> > +
> > +struct apds9930_device_data {
> > +     struct apds9930_coefficients coefs;
> > +
> > +     u8 again;       /* AGAIN value (index in again_values[]) */
> > +     u8 atime;       /* ALS integration time */
> > +};
> > +
> > +struct apds9930_threshold {
> > +     u16 low;
> > +     u16 high;
> > +};
> > +
> > +struct apds9930_data {
> > +     struct i2c_client       *client;
> > +     struct mutex            mutex;  /* Protect access to device data */
> > +
> > +     struct apds9930_device_data     device_data;
> > +
> > +#define __coefs      device_data.coefs
> > +#define __again      device_data.again
> > +#define __atime      device_data.atime
> > +
> > +     u8      alsit;
> > +     u16     ch0_max;                /* Maximum possible Ch0 data value
> */
> > +     bool    agl_enabled;
> > +     int     again_change;           /* Number of consecutive
> situations in
> > +                                      * which the gain needed to be
> changed
> > +                                      */
> > +     bool    als_intr_state;
> > +     struct apds9930_threshold       als_thresh;
> > +};
> > +
> > +/*
> > + * Writes data to the register; the next i2c_write call will write to
> the same
> > + * register.
> > + */
> > +static int apds9930_write_byte(struct i2c_client *client, u8 reg, u8
> data)
> > +{
> > +     CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_RB);
> > +
> > +     return i2c_smbus_write_byte_data(client, reg, data);
> > +}
> > +
> > +/*
> > + * Reads data from a register; the next i2c_read call will read from
> the same
> > + * address.
> > + */
> > +static int apds9930_read_byte(struct i2c_client *client, u8 reg, u8
> *data)
> > +{
> > +     int ret;
> > +
> > +     CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_RB);
> > +     ret     = i2c_smbus_read_byte_data(client, reg);
> > +     *data   = ret;
> > +
> > +     return ret;
> > +}
> > +
> > +/* Writes 2 bytes at the given address */
> > +static int apds9930_write_word(struct i2c_client *client, u8 reg, u16
> data)
> > +{
> > +     CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_AUTO_INC);
> > +
> > +     return i2c_smbus_write_word_data(client, reg, data);
> > +}
> > +
> > +/* Reads 2 bytes from the given address */
> > +static int apds9930_read_word(struct i2c_client *client, u8 reg, u16
> *data)
> > +{
> > +     int ret;
> > +
> > +     CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_AUTO_INC);
> > +     ret     = i2c_smbus_read_word_data(client, reg);
> > +     *data   = ret;
> > +
> > +     return ret;
> > +}
> > +
> > +/* ALSIT = 2.73ms * (256 - ATIME), 2.73 = 5591/(2^11) */
> > +static inline u8 atime_to_alsit(u8 atime_val)
> > +{
> > +     return (u8)(((256 - (u32)atime_val) * 5591) >> 11);
> > +}
> > +
> > +/* ATIME = 256 - ALSIT/2.73ms, 1/2.73 = 375/(2^10) */
> > +static inline u8 alsit_to_atime(u8 alsit_val)
> > +{
> > +     return (u8)(256 - (((u32)alsit_val * 375) >> 10));
> > +}
> > +
> > +/* Computes maximum Ch0 data when atime is the given one. */
> > +static inline u16 apds9930_compute_max_ch0(u8 atime_val)
> > +{
> > +     return 1024 * (256 - (u32)atime_val) - 1;
> > +}
> > +
> > +/* Computes the ALS gain value for the next step and updates the
> current one */
> > +static void apds9930_update_again(struct apds9930_data *data, u16 ch0)
> > +{
> > +     int current_index, next_index, err;
> > +
> > +     /* Compute the value for the next measurement */
> > +     current_index   = data->__again;
> > +     next_index      = data->__again;
> > +
> > +     /* CH0 data too high, try to lower the ALS gain if possible */
> > +     if (ch0 >= (data->ch0_max * APDS9930_CH0_HIGH_PERCENTAGE) / 100) {
> > +             if (data->again_change + 1 <
> > +                 APDS9930_MAX_COUNTS_FOR_GAIN_CHANGE)
> > +                     data->again_change++;
> > +             else {
> > +                     data->again_change = 0;
> > +
> > +                     if (next_index == 0 && !(data->agl_enabled)) {
> > +                             err = apds9930_write_byte(
> > +                                             data->client,
> > +                                             APDS9930_CONFIG_REG,
> > +                                             1 << APDS9930_AGL_SHIFT);
> > +                             if (!err)
> > +                                     data->agl_enabled = true;
> > +                     } else if (next_index > 0) {
> > +                             next_index--;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* CH0 data too low, try to increase the ALS gain if possible */
> > +     else if (ch0 <= (data->ch0_max * APDS9930_CH0_LOW_PERCENTAGE) /
> 100) {
> > +             if (data->again_change + 1 <
> > +                 APDS9930_MAX_COUNTS_FOR_GAIN_CHANGE)
> > +                     data->again_change++;
> > +             else {
> > +                     data->again_change = 0;
> > +                     if (data->agl_enabled) {
> > +                             err = apds9930_write_byte(data->client,
> > +
>  APDS9930_CONFIG_REG,
> > +                                                       0);
> > +                             if (!err)
> > +                                     data->agl_enabled = false;
> > +                     } else if (next_index < APDS9930_MAX_AGAIN_INDEX) {
> > +                             next_index++;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (next_index != current_index) {
> > +             /* Update data's index value */
> > +             data->__again = next_index;
> > +
> > +             /* Update AGAIN for the next reading */
> > +             apds9930_write_byte(data->client, APDS9930_CONTROL_REG,
> > +                                 data->__again << APDS9930_AGAIN_SHIFT);
> > +     }
> > +}
> > +
> > +/*
> > + * Update thresholds so as to generate interrupts when the CH0 data
> changes
> > + * significantly since the last update; significantly is quantifies by
> the
> > + * hysteresis factor: if the ALS state changes with more than
> hysteresis %,
> > + * update the thresholds.
> > + */
> > +static void apds9930_update_als_thresholds(struct apds9930_data *data,
> u16 ch0)
> > +{
> > +     data->als_thresh.low    = (ch0*(100 -
> APDS9930_ALS_HYSTERESIS))/100;
> > +     data->als_thresh.high   = min((ch0*(100 +
> APDS9930_ALS_HYSTERESIS))/100,
> > +                                   (int)data->ch0_max);
> > +
> > +     apds9930_write_word(data->client, APDS9930_AILTL_REG,
> > +                         data->als_thresh.low);
> > +     apds9930_write_word(data->client, APDS9930_AIHTL_REG,
> > +                         data->als_thresh.high);
> > +}
> > +
> > +/* Having the channel 0 and channels 1's data, compute the Lux value */
> > +static int apds9930_compute_lux(struct apds9930_data *data, u16 ch0,
> u16 ch1)
> > +{
> > +     long int iac1, iac2, alsit_val, again_val, tmp_iac;
> > +     unsigned long int iac, lux;
> > +     struct apds9930_coefficients cf;
> > +
> > +     /* Lux equation */
> > +     cf              = data->__coefs;
> > +     iac1            = cf.coef_a * ch0 - cf.coef_b * ch1;
> > +     iac2            = cf.coef_c * ch0 - cf.coef_d * ch1;
> > +     tmp_iac         = max(iac1, iac2);
> > +     iac             = (tmp_iac < 0) ? 0 : (unsigned long)tmp_iac;
> > +     alsit_val       = (int)(data->alsit);
> > +     again_val       = again_values[data->__again];
> > +     lux             = (iac * cf.ga * cf.df) / (alsit_val * again_val *
> > +                                                DEF_LUX_DIVISION_SCALE);
> > +
> > +     return data->agl_enabled ? (APDS9930_AGL_DIVISION_SCALE * lux) :
> lux;
> > +}
> > +
> > +static int apds9930_enable_all(struct apds9930_data *data)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&data->mutex);
> > +     ret = apds9930_write_byte(data->client, APDS9930_ENABLE_REG,
> > +                               APDS9930_ENABLE_ALL);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     data->als_intr_state    = true;
> > +err:
> > +     mutex_unlock(&data->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static int apds9930_disable_all(struct apds9930_data *data)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&data->mutex);
> > +     ret = apds9930_write_byte(data->client, APDS9930_ENABLE_REG,
> > +                               APDS9930_DISABLE_ALL);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     data->als_intr_state = false;
> > +err:
> > +     mutex_unlock(&data->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static int apds9930_chip_detect(struct apds9930_data *data)
> > +{
> > +     int ret;
> > +     u8 id;
> > +
> > +     ret = apds9930_read_byte(data->client, APDS9930_ID_REG, &id);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (id != APDS9930_ID)
> > +             ret = -EINVAL;
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Set the coefficients to those specified in properties if they exist,
> > + * otherwise to default values.
> > + */
> > +static void apds9930_set_device_data(struct apds9930_data *data)
> > +{
> > +     struct apds9930_coefficients defaults = {
> > +             .ga     = DEF_GA,
> > +             .coef_a = 100,
> > +             .coef_b = DEF_B,
> > +             .coef_c = DEF_C,
> > +             .coef_d = DEF_D,
> > +             .df     = DEF_DF,
> > +     };
> > +     struct device *dev = &data->client->dev;
> > +
> > +     /*
> > +      * Look for device properties and set them to property value or to
> > +      * default.
> > +      */
> > +     if (device_property_read_u32(dev, GA_PROP, &data->__coefs.ga) !=
> 0)
> > +             data->__coefs.ga = defaults.ga;
> > +
> > +     if (device_property_read_u32(dev, DF_PROP, &data->__coefs.df) != 0)
> > +             data->__coefs.df = defaults.df;
> > +
> > +     if (device_property_read_u32(dev, COEF_B_PROP,
> > +                                  &data->__coefs.coef_b) != 0 ||
> > +         device_property_read_u32(dev, COEF_C_PROP,
> > +                                  &data->__coefs.coef_c) != 0 ||
> > +         device_property_read_u32(dev, COEF_D_PROP,
> > +                                  &data->__coefs.coef_d) != 0) {
> > +             data->__coefs.coef_b    = defaults.coef_b;
> > +             data->__coefs.coef_c    = defaults.coef_c;
> > +             data->__coefs.coef_d    = defaults.coef_d;
> > +     }
> > +     data->__coefs.coef_a = defaults.coef_a;
> > +
> > +     if (device_property_read_u32(dev, ATIME_PROP,
> > +                                  (int *)&data->__atime) != 0)
> > +             data->__atime = APDS9930_DEF_ATIME;
> > +
> > +     if (device_property_read_u32(dev, AGAIN_PROP,
> > +                                  (int *)&data->__again) != 0)
> > +             data->__again = APDS9930_DEF_AGAIN;
> > +
> > +     /*
> > +      * AGAIN can only have the following values (as found in the
> register):
> > +      * 0, 1, 2, 3. Check if we receive invalid data and fall back to
> > +      * defaults if that is the case.
> > +      */
> > +     if (data->__again > APDS9930_MAX_AGAIN_INDEX)
> > +             data->__again = APDS9930_DEF_AGAIN;
> > +}
> > +
> > +static void apds9930_chip_data_init(struct apds9930_data *data)
> > +{
> > +     apds9930_set_device_data(data);
> > +
> > +     /* Init data to default values */
> > +     data->alsit             = atime_to_alsit(data->__atime);
> > +     data->ch0_max           =
> apds9930_compute_max_ch0(APDS9930_DEF_ATIME);
> > +     data->agl_enabled       = false;
> > +     data->again_change      = 0;
> > +     data->als_intr_state    = false;
> > +     data->als_thresh.low    = APDS9930_DEF_ALS_THRESH_LOW;
> > +     data->als_thresh.high   = APDS9930_DEF_ALS_THRESH_HIGH;
> > +}
> > +
> > +/* Basic chip initialization, as described in the datasheet */
> > +static int apds9930_chip_registers_init(struct apds9930_data *data)
> > +{
> > +     struct i2c_client *client = data->client;
> > +     int ret;
> > +
> > +     /* Disable and powerdown device */
> > +     ret = apds9930_disable_all(data);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Set timing registers default values (minimum) */
> > +     ret = apds9930_write_byte(client, APDS9930_ATIME_REG,
> > +                               APDS9930_DEF_ATIME);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret = apds9930_write_byte(client, APDS9930_WTIME_REG,
> > +                               APDS9930_DEF_WTIME);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Reset the configuration register (do not wait long) */
> > +     ret = apds9930_write_byte(client, APDS9930_CONFIG_REG, 0);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Gain selection setting */
> > +     ret = apds9930_write_byte(client, APDS9930_CONTROL_REG,
> > +                               data->__again << APDS9930_AGAIN_SHIFT);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Interrupt threshold default settings */
> > +     ret = apds9930_write_word(client, APDS9930_AILTL_REG,
> > +                               APDS9930_DEF_ALS_THRESH_LOW);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret = apds9930_write_word(client, APDS9930_AIHTL_REG,
> > +                               APDS9930_DEF_ALS_THRESH_HIGH);
> > +
> > +     /* Set ALS persistence filter to default values */
> > +     ret = apds9930_write_byte(client, APDS9930_PERS_REG,
> > +                               APDS9930_DEF_APERS <<
> APDS9930_APERS_SHIFT);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Power the device back on */
> > +     return apds9930_enable_all(data);
> > +}
> > +
> > +static int apds9930_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long mask)
> > +{
> > +     struct apds9930_data *data      = iio_priv(indio_dev);
> > +     struct i2c_client *client       = data->client;
> > +     int ret;
> > +     u16 ch0, ch1, ch;
> > +
> > +     mutex_lock(&data->mutex);
> > +     switch (chan->type) {
> > +     case IIO_LIGHT:
> > +             /* Get Lux value */
> > +             ret = apds9930_read_word(client, APDS9930_CDATAL_REG,
> > +                                      &ch0);
> > +             if (ret < 0)
> > +                     break;
> > +             ret = apds9930_read_word(client, APDS9930_IRDATAL_REG,
> > +                                      &ch1);
> > +             if (ret < 0)
> > +                     break;
> > +
> > +             /* Compute Lux value */
> > +             *val = apds9930_compute_lux(data, ch0, ch1);
> > +             apds9930_update_again(data, ch0);
> > +             ret = IIO_VAL_INT;
> > +             break;
> > +     case IIO_INTENSITY:
> > +             /* Get ch0 or ch1 raw value */
> > +             ret = apds9930_read_word(client, chan->channel ?
> > +                                      APDS9930_IRDATAL_REG :
> > +                                      APDS9930_CDATAL_REG,
> > +                                      &ch);
> > +             if (ret < 0)
> > +                     break;
> > +
> > +             *val    = (int)ch;
> > +             ret     = IIO_VAL_INT;
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +             break;
> > +     }
> > +     mutex_unlock(&data->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Event handling functions */
> > +static int apds9930_read_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir)
> > +{
> > +     struct apds9930_data *data = iio_priv(indio_dev);
> > +
> > +     switch (chan->type) {
> > +     case IIO_INTENSITY:
> > +             return data->als_intr_state;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int apds9930_write_event_config(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir,
> > +                                    int state)
> > +{
> > +     struct apds9930_data *data      = iio_priv(indio_dev);
> > +     struct i2c_client *client       = data->client;
> > +     u8 enable_reg;
> > +     int ret;
> > +
> > +     if (chan->type != IIO_INTENSITY)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&data->mutex);
> > +
> > +     ret = apds9930_read_byte(client, APDS9930_ENABLE_REG, &enable_reg);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     if (state)
> > +             enable_reg |= APDS9930_AIEN; /* enable */
> > +     else
> > +             enable_reg &= ~APDS9930_AIEN; /* disable */
> > +
> > +     ret = apds9930_write_byte(client, APDS9930_ENABLE_REG, enable_reg);
> > +     if (ret == 0)
> > +             data->als_intr_state = (bool)state;
> > +err:
> > +     mutex_unlock(&data->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static int apds9930_read_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int *val, int *val2)
> > +{
> > +     struct apds9930_data *data = iio_priv(indio_dev);
> > +     struct apds9930_threshold thresh;
> > +
> > +     switch (chan->type) {
> > +     case IIO_INTENSITY:
> > +             thresh = data->als_thresh;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             *val = (int)(thresh.high);
> > +             break;
> > +     case IIO_EV_DIR_FALLING:
> > +             *val = (int)(thresh.low);
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +/* IIO device specific data structures */
> > +static const struct iio_info apds9930_info = {
> > +     .driver_module          = THIS_MODULE,
> > +     .read_raw               = apds9930_read_raw,
> > +     .read_event_config      = apds9930_read_event_config,
> > +     .write_event_config     = apds9930_write_event_config,
> > +     .read_event_value       = apds9930_read_event_value,
> > +};
> > +
> > +static const struct iio_event_spec apds9930_als_event_spec[] = {
> > +     {
> > +             /* ALS Ch0 interrupt "above threshold" event */
> > +             .type           = IIO_EV_TYPE_THRESH,
> > +             .dir            = IIO_EV_DIR_RISING,
> > +             .mask_separate  = BIT(IIO_EV_INFO_VALUE) |
> > +                     BIT(IIO_EV_INFO_ENABLE),
> > +     }, {
> > +             /* ALS Ch0 interrupt "below threshold" event */
> > +             .type           = IIO_EV_TYPE_THRESH,
> > +             .dir            = IIO_EV_DIR_FALLING,
> > +             .mask_separate  = BIT(IIO_EV_INFO_VALUE) |
> > +                     BIT(IIO_EV_INFO_ENABLE),
> > +     },
> > +};
> > +
> > +static const struct iio_chan_spec apds9930_channels[] = {
> > +     /* ALS channels */
> > +     {
> > +             /* Lux (processed Ch0 + Ch1) */
> > +             .type                   = IIO_LIGHT,
> > +             .channel                = 0,
> > +             .info_mask_separate     = BIT(IIO_CHAN_INFO_PROCESSED),
> > +     }, {
> > +             /*
> > +              * Ch0 photodiode (visible light + infrared); threshold
> > +              * triggered event
> > +              */
> > +             .type                   = IIO_INTENSITY,
> > +             .channel                = 0,
> > +             .modified               = true,
> > +             .channel2               = IIO_MOD_LIGHT_BOTH,
> > +             .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW),
> > +             .event_spec             = apds9930_als_event_spec,
> > +             .num_event_specs        =
> ARRAY_SIZE(apds9930_als_event_spec),
> > +     }, {
> > +             /* Ch1 photodiode (infrared) */
> > +             .type                   = IIO_INTENSITY,
> > +             .channel                = 1,
> > +             .modified               = true,
> > +             .channel2               = IIO_MOD_LIGHT_IR,
> > +             .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW),
> > +     }
> > +};
> > +
> > +/* Determine what has triggered the interrupt and clear it accordingly
> */
> > +static int apds9930_interrupt_clear(struct apds9930_data *data, u8
> intr_status)
> > +{
> > +     u8 reg = 0x00;
> > +
> > +     if (intr_status & APDS9930_AINT) {
> > +             CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_SPECIAL_FUNC);
> > +             reg |= APDS9930_CMD_TYPE_ALS;
> > +
> > +             return i2c_smbus_read_byte_data(data->client, reg);
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +/* ALS interrupt handler */
> > +static irqreturn_t apds9930_irq_handler(int irq, void *private_data)
> > +{
> > +     struct iio_dev *indio_dev       = private_data;
> > +     struct apds9930_data *data      = iio_priv(indio_dev);
> > +     u8 status, enable_reg;
> > +     u16 ch0;
> > +     int ret;
> > +
> > +     /* Disable ALS function while processing data */
> > +     ret = apds9930_read_byte(data->client, APDS9930_ENABLE_REG,
> > +                              &enable_reg);
> > +     if (ret < 0)
> > +             return IRQ_HANDLED;
> > +     ret = apds9930_write_byte(data->client, APDS9930_ENABLE_REG, 1);
> > +     if (ret < 0)
> > +             return IRQ_HANDLED;
> > +
> > +     /* Read status register to see what caused the interrupt */
> > +     ret = apds9930_read_byte(data->client, APDS9930_STATUS_REG,
> &status);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     ret = apds9930_read_word(data->client, APDS9930_CDATAL_REG, &ch0);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     apds9930_update_again(data, ch0);
> > +
> > +     /* Push event to userspace */
> > +     if (status & APDS9930_AINT) {
> > +             /* Clear interrupt */
> > +             apds9930_interrupt_clear(data, status);
> > +
> > +             iio_push_event(indio_dev,
> > +                            IIO_MOD_EVENT_CODE(IIO_INTENSITY,
> > +                                               0,
> > +                                               IIO_MOD_LIGHT_BOTH,
> > +                                               IIO_EV_TYPE_THRESH,
> > +                                               IIO_EV_DIR_EITHER),
> > +                            iio_get_time_ns());
> > +
> > +             /* Update ALS thresholds to environment */
> > +             apds9930_update_als_thresholds(data, ch0);
> > +     }
> > +
> > +err:
> > +     /* Re-enable ALS converter */
> > +     apds9930_write_byte(data->client, APDS9930_ENABLE_REG, enable_reg);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int apds9930_gpio_probe(struct i2c_client *client,
> > +                            struct apds9930_data *data)
> > +{
> > +     struct device *dev;
> > +     struct gpio_desc *gpio;
> > +     int ret;
> > +
> > +     if (!client)
> > +             return -EINVAL;
> > +
> > +     dev = &client->dev;
> > +
> > +     gpio = devm_gpiod_get_index(dev, APDS9930_GPIO_NAME, 0);
> > +     if (IS_ERR(gpio)) {
> > +             dev_err(dev, "ACPI GPIO get index failed\n");
> > +             return PTR_ERR(gpio);
> > +     }
> > +
> > +     ret = gpiod_direction_input(gpio);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return gpiod_to_irq(gpio);
> > +}
> > +
> > +static int apds9930_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
> > +{
> > +     struct apds9930_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data = iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> > +     data->client = client;
> > +
> > +     mutex_init(&data->mutex);
> > +
> > +     /* Recommended wait time after power on. */
> > +     msleep(APDS9930_INIT_SLEEP);
> > +
> > +     /* Check if the chip is the one we are expecting */
> > +     ret = apds9930_chip_detect(data);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     apds9930_chip_data_init(data);
> > +     ret = apds9930_chip_registers_init(data);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     indio_dev->dev.parent   = &client->dev;
> > +     indio_dev->name         = APDS9930_DRIVER_NAME;
> > +     indio_dev->modes        = INDIO_DIRECT_MODE;
> > +     indio_dev->channels     = apds9930_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(apds9930_channels);
> > +     indio_dev->info         = &apds9930_info;
> > +
> > +     if (client->irq <= 0)
> > +             client->irq = apds9930_gpio_probe(client, data);
> > +
> > +     if (client->irq > 0) {
> > +             ret = devm_request_threaded_irq(&client->dev,
> > +                                             client->irq,
> > +                                             NULL,
> > +                                             apds9930_irq_handler,
> > +                                             IRQF_TRIGGER_FALLING |
> > +                                             IRQF_ONESHOT,
> > +                                             APDS9930_IRQ_NAME,
> > +                                             indio_dev);
> > +             if (ret < 0)
> > +                     goto err;
> > +     }
> > +
> > +     ret = iio_device_register(indio_dev);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     return 0;
> > +err:
> > +     apds9930_disable_all(data);
> > +
> > +     return ret;
> > +}
> > +
> > +static int apds9930_remove(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev       = i2c_get_clientdata(client);
> > +     struct apds9930_data *data      = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     /* Disable interrupts */
> > +     ret = apds9930_disable_all(data);
> > +
> > +     iio_device_unregister(indio_dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct acpi_device_id apds9930_acpi_table[] = {
> > +     {"APDS9930", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, apds9930_acpi_table);
> > +
> > +static const struct i2c_device_id apds9930_ids_table[] = {
> > +     {"apds9930", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, apds9930_ids_table);
> > +
> > +static struct i2c_driver apds9930_iio_driver = {
> > +     .driver = {
> > +             .owner                  = THIS_MODULE,
> > +             .name                   = APDS9930_DRIVER_NAME,
> > +             .acpi_match_table       = ACPI_PTR(apds9930_acpi_table),
> > +     },
> > +     .probe          = apds9930_probe,
> > +     .remove         = apds9930_remove,
> > +     .id_table       = apds9930_ids_table,
> > +};
> > +module_i2c_driver(apds9930_iio_driver);
> > +
> > +MODULE_AUTHOR("Cristina Ciocan <cristina.ciocan@intel.com>");
> > +MODULE_DESCRIPTION("APDS-9930 ALS sensor IIO driver");
> > +MODULE_LICENSE("GPL v2");
> >
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
   Cristina Ciocan

--e89a8f234d458bab080511a6e682
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Peter,<div><br></div><div>The APDS 9300 device is si=
milar to the ALS component of the APDS 9930, although there are differences=
 (Lux computation is different, gain handling is not the same). Moreover, t=
he APDS 9930 can also support proximity, feature which the 9300 device does=
 not offer. I have not yet managed to properly test the proximity implement=
ation and this is the reason why I have only sent upstream the ALS implemen=
tation. Therefore, wouldn&#39;t the code get too complicated to mix the 2 d=
evices in one driver ?=C2=A0</div><div><br></div><div>Thank you for the rev=
iew, I will send a second version to fix style issues.=C2=A0</div><div><br>=
</div><div>CMD_REG_SETUP clears the type bits and also sets them to transac=
tion_type. This is because the transaction type can vary, thus we need to c=
lear &amp; set it accordingly (it differs when R/W bytes vs words).=C2=A0</=
div><div><br></div><div>Kind regards,</div><div>Cristina</div><div><br></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, M=
ar 19, 2015 at 3:41 PM, Peter Meerwald <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:pmeerw@pmeerw.net" target=3D"_blank">pmeerw@pmeerw.net</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Hello Cristina,<br>
<span class=3D""><br>
&gt; Added IIO driver for Avago&#39;s APDS 9930 proximity and ALS sensor. T=
he current<br>
&gt; implementation is for ALS functionality.<br>
&gt;<br>
&gt; It offers ACPI/DT support, irq and event handling, raw readings.<br>
<br>
</span>can this driver be implemented by extending the apds9300 driver?<br>
the structure seems similar?<br>
<br>
some general comments:<br>
* not all specifiers are prefixed with apds9930_ or APDS9930_<br>
* the spelling of APDS9930 is APDS-9930 or APDS 9930 sometimes<br>
* is the CMD_REG_SETUP macro necessary, i.e. is there a need to mask out<br=
>
bits first, are they ever set?<br>
* style of multi-line comments<br>
<br>
regards, p.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Datasheet for this device can be found at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.avagotech.com/docs/AV0=
2-3190EN" target=3D"_blank">http://www.avagotech.com/docs/AV02-3190EN</a>.<=
br>
&gt;<br>
&gt; Signed-off-by: Cristina Ciocan &lt;<a href=3D"mailto:cristina.ciocan@i=
ntel.com">cristina.ciocan@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/light/Kconfig=C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/iio/light/Makefile=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/iio/light/apds9930.c | 912 +++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 3 files changed, 923 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/iio/light/apds9930.c<br>
&gt;<br>
&gt; diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig<br>
&gt; index cd937d9..abeca21 100644<br>
&gt; --- a/drivers/iio/light/Kconfig<br>
&gt; +++ b/drivers/iio/light/Kconfig<br>
&gt; @@ -37,6 +37,16 @@ config APDS9300<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choose =
M here: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called apds9300.<br>
&gt;<br>
&gt; +config APDS9930<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;APDS9930 ambient light sensor&quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 Say Y here if you want to build a driver for the=
 Avago APDS9930<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ambient light sensor.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choose M her=
e: the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 module will be called apds9930.<br>
&gt; +<br>
&gt;=C2=A0 config CM32181<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on I2C<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;CM32181 driver&quot;<br>
&gt; diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile<b=
r>
&gt; index ad7c30f..535d289 100644<br>
&gt; --- a/drivers/iio/light/Makefile<br>
&gt; +++ b/drivers/iio/light/Makefile<br>
&gt; @@ -6,6 +6,7 @@<br>
&gt;=C2=A0 obj-$(CONFIG_ADJD_S311)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D adjd_s311.o<br>
&gt;=C2=A0 obj-$(CONFIG_AL3320A)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +=3D al3320a.o<br>
&gt;=C2=A0 obj-$(CONFIG_APDS9300)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0+=3D apds9300.o<br>
&gt; +obj-$(CONFIG_APDS9930)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D apds9930.o<br>
&gt;=C2=A0 obj-$(CONFIG_CM32181)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +=3D cm32181.o<br>
&gt;=C2=A0 obj-$(CONFIG_CM3232)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D cm323=
2.o<br>
&gt;=C2=A0 obj-$(CONFIG_CM3323)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D cm332=
3.o<br>
&gt; diff --git a/drivers/iio/light/apds9930.c b/drivers/iio/light/apds9930=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..47b53d1<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/light/apds9930.c<br>
&gt; @@ -0,0 +1,912 @@<br>
&gt; +/*<br>
&gt; + * This is a driver for Avago APDS 9930 ALS sensor chip. It<br>
&gt; + * is inspired from drivers/misc/apds990x.c to use IIO.<br>
&gt; + *<br>
&gt; + * The I2C slave address for this device is 0x39.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful, bu=
t<br>
&gt; + * WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU<b=
r>
&gt; + * General Public License for more details.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/i2c.h&gt;<br>
&gt; +#include &lt;linux/pm.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/acpi.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/property.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;linux/iio/types.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/iio/events.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;linux/gpio/consumer.h&gt;<br>
&gt; +<br>
&gt; +#define APDS9930_DRIVER_NAME &quot;apds9930&quot;<br>
&gt; +#define APDS9930_IRQ_NAME=C2=A0 =C2=A0 &quot;apds9930_irq&quot;<br>
&gt; +#define APDS9930_GPIO_NAME=C2=A0 =C2=A0&quot;apds9930_gpio&quot;<br>
&gt; +<br>
&gt; +#define APDS9930_INIT_SLEEP=C2=A0 5 /* sleep for 5 ms before issuing =
commands */<br>
&gt; +<br>
&gt; +/* I2C command register - fields and possible field values */<br>
&gt; +/* CMD bit value must be set to 1 when addressing command register */=
<br>
&gt; +#define APDS9930_CMD_SELECT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80<br=
>
&gt; +/* TYPE possible values */<br>
&gt; +#define APDS9930_CMD_TYPE_RB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Repeated byte */<br>
&gt; +#define APDS9930_CMD_TYPE_AUTO_INC=C2=A0 =C2=A0BIT(5)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Auto-increment */<br>
&gt; +#define APDS9930_CMD_TYPE_SPECIAL_FUNC=C2=A0 =C2=A0 =C2=A0 =C2=A0GENM=
ASK(6, 5)=C2=A0 =C2=A0/* Special function */<br>
&gt; +/* ADDR possible values */<br>
&gt; +#define APDS9930_CMD_TYPE_ALS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x6=C2=A0 =C2=A0 =C2=A0/* ALS interrupt clear */<br>
&gt; +/* Clear masks */<br>
&gt; +#define APDS9930_CLEAR_CMD_TYPE_MASK GENMASK(4, 0)<br>
&gt; +/* Shortcut to clear and set CMD and TYPE fields */<br>
&gt; +#define CMD_REG_SETUP(reg, transaction_type) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg &amp;=3D APDS9930_CLEAR_CMD_TYPE_MASK;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg |=3D APDS9930_CMD_SELECT | transaction_type;=
=C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Register set (rw =3D read/write, r =3D read, w =3D write) */<br>
&gt; +#define APDS9930_ENABLE_REG=C2=A0 0x00=C2=A0 =C2=A0 /* rw-Enable of s=
tates and interrupts */<br>
&gt; +#define APDS9930_ATIME_REG=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /* rw-ALS AD=
C time*/<br>
&gt; +#define APDS9930_WTIME_REG=C2=A0 =C2=A00x03=C2=A0 =C2=A0 /* rw-Wait t=
ime */<br>
&gt; +#define APDS9930_AILTL_REG=C2=A0 =C2=A00x04=C2=A0 =C2=A0 /* rw-ALS in=
terrupt low threshold low<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * byte<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +#define APDS9930_AIHTL_REG=C2=A0 =C2=A00x06=C2=A0 =C2=A0 /* rw-ALS in=
terrupt high threshold low<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * byte<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +#define APDS9930_PERS_REG=C2=A0 =C2=A0 0x0C=C2=A0 =C2=A0 /* rw-Interr=
upt persistence filters */<br>
&gt; +#define APDS9930_CONFIG_REG=C2=A0 0x0D=C2=A0 =C2=A0 /* rw-Configurati=
on */<br>
&gt; +#define APDS9930_CONTROL_REG 0x0F=C2=A0 =C2=A0 /* rw-Gain control reg=
ister */<br>
&gt; +#define APDS9930_ID_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x12=C2=A0 =C2=A0 /* r-Device ID */<br>
&gt; +#define APDS9930_STATUS_REG=C2=A0 0x13=C2=A0 =C2=A0 /* r-Device statu=
s */<br>
&gt; +#define APDS9930_CDATAL_REG=C2=A0 0x14=C2=A0 =C2=A0 /* r-Ch0 ADC low =
data register */<br>
&gt; +#define APDS9930_IRDATAL_REG 0x16=C2=A0 =C2=A0 /* r-Ch1 ADC low data =
register */<br>
&gt; +<br>
&gt; +/* Useful bits per register */<br>
&gt; +<br>
&gt; +/* Enable register */<br>
&gt; +#define APDS9930_AIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 BIT(4)=C2=A0 /* ALS interrupt enable */<br>
&gt; +/* Persistence register */<br>
&gt; +#define APDS9930_APERS_SHIFT 0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Interrupt=
 persistence */<br>
&gt; +/* Configuration register */<br>
&gt; +#define APDS9930_AGL_SHIFT=C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 ALS gain level */<br>
&gt; +/* Control register */<br>
&gt; +#define APDS9930_AGAIN_SHIFT 0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ALS gain =
control */<br>
&gt; +/* Device ID - possible values */<br>
&gt; +#define APDS9930_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x39<br>
&gt; +/* Status register */<br>
&gt; +#define APDS9930_AINT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 BIT(4)=C2=A0 /* ALS interrupt */<br>
&gt; +<br>
&gt; +/* Default values (already shifted) for registers content */<br>
&gt; +#define APDS9930_DISABLE_ALL 0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable a=
nd powerdown */<br>
&gt; +#define APDS9930_ENABLE_ALL=C2=A0 0x13=C2=A0 =C2=A0 /* Set all ALS bi=
ts and power on */<br>
&gt; +#define APDS9930_DEF_ATIME=C2=A0 =C2=A00xdb=C2=A0 =C2=A0 /* 101 ms */=
<br>
&gt; +#define APDS9930_DEF_WTIME=C2=A0 =C2=A00xff=C2=A0 =C2=A0 /* 2.7 ms - =
min wait time */<br>
&gt; +#define APDS9930_DEF_AGAIN=C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 16 x ALS gain */<br>
&gt; +#define APDS9930_DEF_APERS=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Each over/underflow triggers an<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * interrupt=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Interrupt threshold defaults - setting low to maximum will trigger=
 a first<br>
&gt; + * interrupt to allow us to read the data registers status and proper=
ly set a<br>
&gt; + * threshold value to match the current environment.<br>
&gt; + *<br>
&gt; + * The default high threshold is set only for consistency, since the =
registers<br>
&gt; + * are checked against in order: first if the value of CDATA is above=
 LOW; if<br>
&gt; + * so, trigger interrupt and do not check the HIGH threshold.<br>
&gt; + */<br>
&gt; +#define APDS9930_DEF_ALS_THRESH_LOW=C2=A0 0xffff<br>
&gt; +#define APDS9930_DEF_ALS_THRESH_HIGH 0x0<br>
&gt; +<br>
&gt; +/* Default, open air, coefficients (for Lux computation) */<br>
&gt; +#define DEF_DF=C2=A0 =C2=A0 =C2=A0 =C2=A052=C2=A0 =C2=A0 =C2=A0 /* De=
vice factor */<br>
&gt; +/*<br>
&gt; + * Material-depending coefficients (set to open air values). They are=
 scaled for<br>
&gt; + * computation purposes by 100.<br>
&gt; + */<br>
&gt; +#define DEF_LUX_DIVISION_SCALE=C2=A0 =C2=A0 =C2=A0 =C2=A010000<br>
&gt; +#define DEF_GA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A049<br>
&gt; +#define DEF_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 186<br>
&gt; +#define DEF_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 74<br>
&gt; +#define DEF_D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 129<br>
&gt; +<br>
&gt; +/* Possible ALS gain values (with AGL cleared) */<br>
&gt; +static const int again_values[] =3D {1, 8, 16, 120};<br>
&gt; +#define APDS9930_MAX_AGAIN_INDEX=C2=A0 =C2=A0 =C2=A03<br>
&gt; +#define APDS9930_AGL_DIVISION_SCALE=C2=A0 6<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Percentages from the maximum CH0 value that indicate the recorded =
CH0 data is<br>
&gt; + * too low or too high - for AGAIN adapting purposes.<br>
&gt; + */<br>
&gt; +#define APDS9930_CH0_HIGH_PERCENTAGE 90<br>
&gt; +#define APDS9930_CH0_LOW_PERCENTAGE=C2=A0 10<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * With how much (in percentages) must the CH0 value differ from one =
step to<br>
&gt; + * another in order to consider a significant change in light and tri=
gger an<br>
&gt; + * interrupt.<br>
&gt; + */<br>
&gt; +#define APDS9930_ALS_HYSTERESIS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 20<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Number of consecutive out-of-range measurements needed to trigger =
a gain<br>
&gt; + * change. We count them and not change the gain each time the CH0 da=
ta is<br>
&gt; + * out-of-range because it takes a couple of cycles for system to ada=
pt to new<br>
&gt; + * gain values.<br>
&gt; + */<br>
&gt; +#define APDS9930_MAX_COUNTS_FOR_GAIN_CHANGE=C2=A0 2<br>
&gt; +<br>
&gt; +/* DT or ACPI device properties names */<br>
&gt; +#define GA_PROP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;intel,ga&quot;<br>
&gt; +#define COEF_B_PROP=C2=A0 &quot;intel,coeff-B&quot;<br>
&gt; +#define COEF_C_PROP=C2=A0 &quot;intel,coeff-B&quot;<br>
&gt; +#define COEF_D_PROP=C2=A0 &quot;intel,coeff-D&quot;<br>
&gt; +#define DF_PROP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;intel,df&quot;<br>
&gt; +#define AGAIN_PROP=C2=A0 =C2=A0&quot;intel,als-gain&quot;<br>
&gt; +#define ATIME_PROP=C2=A0 =C2=A0&quot;intel,atime&quot;<br>
&gt; +<br>
&gt; +struct apds9930_coefficients {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* GA, B, C and D coefficients are scaled by 100 =
for computational<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 purposes. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ga;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int coef_a; /* This is 1, but needs to be set to =
a scaled value, thus if<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 we decide to change the scale, this coefficient must also<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 be changed. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int coef_b;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int coef_c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int coef_d;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int df;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct apds9930_device_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_coefficients coefs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 again;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* AGAIN valu=
e (index in again_values[]) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 atime;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ALS integr=
ation time */<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct apds9930_threshold {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 low;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 high;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct apds9930_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client=C2=A0 =C2=A0 =C2=A0 =C2=A0*clie=
nt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mutex;=C2=A0 /* Protect access to device data */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_device_data=C2=A0 =C2=A0 =C2=A0de=
vice_data;<br>
&gt; +<br>
&gt; +#define __coefs=C2=A0 =C2=A0 =C2=A0 device_data.coefs<br>
&gt; +#define __again=C2=A0 =C2=A0 =C2=A0 device_data.again<br>
&gt; +#define __atime=C2=A0 =C2=A0 =C2=A0 device_data.atime<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 alsit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16=C2=A0 =C2=A0 =C2=A0ch0_max;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Maximum possible Ch0 data value *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 agl_enabled;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0again_change;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Number of consecutive situations in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * which the=
 gain needed to be changed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 als_intr_state;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_threshold=C2=A0 =C2=A0 =C2=A0 =C2=
=A0als_thresh;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Writes data to the register; the next i2c_write call will write to=
 the same<br>
&gt; + * register.<br>
&gt; + */<br>
&gt; +static int apds9930_write_byte(struct i2c_client *client, u8 reg, u8 =
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_RB);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return i2c_smbus_write_byte_data(client, reg, dat=
a);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Reads data from a register; the next i2c_read call will read from =
the same<br>
&gt; + * address.<br>
&gt; + */<br>
&gt; +static int apds9930_read_byte(struct i2c_client *client, u8 reg, u8 *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_RB);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret=C2=A0 =C2=A0 =C2=A0=3D i2c_smbus_read_byte_da=
ta(client, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*data=C2=A0 =C2=A0=3D ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Writes 2 bytes at the given address */<br>
&gt; +static int apds9930_write_word(struct i2c_client *client, u8 reg, u16=
 data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_AUTO_INC);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return i2c_smbus_write_word_data(client, reg, dat=
a);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Reads 2 bytes from the given address */<br>
&gt; +static int apds9930_read_word(struct i2c_client *client, u8 reg, u16 =
*data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CMD_REG_SETUP(reg, APDS9930_CMD_TYPE_AUTO_INC);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0ret=C2=A0 =C2=A0 =C2=A0=3D i2c_smbus_read_word_da=
ta(client, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*data=C2=A0 =C2=A0=3D ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ALSIT =3D 2.73ms * (256 - ATIME), 2.73 =3D 5591/(2^11) */<br>
&gt; +static inline u8 atime_to_alsit(u8 atime_val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return (u8)(((256 - (u32)atime_val) * 5591) &gt;&=
gt; 11);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ATIME =3D 256 - ALSIT/2.73ms, 1/2.73 =3D 375/(2^10) */<br>
&gt; +static inline u8 alsit_to_atime(u8 alsit_val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return (u8)(256 - (((u32)alsit_val * 375) &gt;&gt=
; 10));<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Computes maximum Ch0 data when atime is the given one. */<br>
&gt; +static inline u16 apds9930_compute_max_ch0(u8 atime_val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 1024 * (256 - (u32)atime_val) - 1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Computes the ALS gain value for the next step and updates the curr=
ent one */<br>
&gt; +static void apds9930_update_again(struct apds9930_data *data, u16 ch0=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int current_index, next_index, err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Compute the value for the next measurement */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0current_index=C2=A0 =C2=A0=3D data-&gt;__again;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0next_index=C2=A0 =C2=A0 =C2=A0 =3D data-&gt;__aga=
in;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* CH0 data too high, try to lower the ALS gain i=
f possible */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ch0 &gt;=3D (data-&gt;ch0_max * APDS9930_CH0_=
HIGH_PERCENTAGE) / 100) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data-&gt;again_ch=
ange + 1 &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS993=
0_MAX_COUNTS_FOR_GAIN_CHANGE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0data-&gt;again_change++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0data-&gt;again_change =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (next_index =3D=3D 0 &amp;&amp; !(data-&gt;agl_enabled)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D apds9930_write_byte(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data-&gt;client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0APDS9930_CONFIG_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A01 &lt;&lt; APDS9930_AGL_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;agl=
_enabled =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else if (next_index &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next_index--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* CH0 data too low, try to increase the ALS gain=
 if possible */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else if (ch0 &lt;=3D (data-&gt;ch0_max * APDS9930=
_CH0_LOW_PERCENTAGE) / 100) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data-&gt;again_ch=
ange + 1 &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS993=
0_MAX_COUNTS_FOR_GAIN_CHANGE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0data-&gt;again_change++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0data-&gt;again_change =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (data-&gt;agl_enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D apds9930_write_byte(data-&gt;cli=
ent,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_CONFIG_REG,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;agl=
_enabled =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else if (next_index &lt; APDS9930_MAX_AGAIN_INDEX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next_index++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (next_index !=3D current_index) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update data&#39;s =
index value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__again =3D =
next_index;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update AGAIN for t=
he next reading */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0apds9930_write_byte(d=
ata-&gt;client, APDS9930_CONTROL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__again &lt;&lt; =
APDS9930_AGAIN_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Update thresholds so as to generate interrupts when the CH0 data c=
hanges<br>
&gt; + * significantly since the last update; significantly is quantifies b=
y the<br>
&gt; + * hysteresis factor: if the ALS state changes with more than hystere=
sis %,<br>
&gt; + * update the thresholds.<br>
&gt; + */<br>
&gt; +static void apds9930_update_als_thresholds(struct apds9930_data *data=
, u16 ch0)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.low=C2=A0 =C2=A0 =3D (ch0*(10=
0 - APDS9930_ALS_HYSTERESIS))/100;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.high=C2=A0 =C2=A0=3D min((ch0=
*(100 + APDS9930_ALS_HYSTERESIS))/100,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)data-&gt;ch0_m=
ax);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_write_word(data-&gt;client, APDS9930_AIL=
TL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.low);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_write_word(data-&gt;client, APDS9930_AIH=
TL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.high);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Having the channel 0 and channels 1&#39;s data, compute the Lux va=
lue */<br>
&gt; +static int apds9930_compute_lux(struct apds9930_data *data, u16 ch0, =
u16 ch1)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0long int iac1, iac2, alsit_val, again_val, tmp_ia=
c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long int iac, lux;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_coefficients cf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Lux equation */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D data-&gt;__coefs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iac1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 cf.coef_a * ch0 - cf.coef_b * ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iac2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 cf.coef_c * ch0 - cf.coef_d * ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp_iac=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D max(=
iac1, iac2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iac=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (tmp_iac &lt; 0) ? 0 : (unsigned long)tmp_iac;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0alsit_val=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (int)(dat=
a-&gt;alsit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0again_val=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D again_val=
ues[data-&gt;__again];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lux=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (iac * <a href=3D"http://cf.ga" target=3D"_blank">cf.ga</a> * cf.df)=
 / (alsit_val * again_val *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 DEF_LUX_DIVISION_SCALE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return data-&gt;agl_enabled ? (APDS9930_AGL_DIVIS=
ION_SCALE * lux) : lux;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_enable_all(struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(data-&gt;client, APDS=
9930_ENABLE_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_ENABLE_ALL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_intr_state=C2=A0 =C2=A0 =3D true;<br=
>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_disable_all(struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(data-&gt;client, APDS=
9930_ENABLE_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DISABLE_ALL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_intr_state =3D false;<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_chip_detect(struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read_byte(data-&gt;client, APDS9=
930_ID_REG, &amp;id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (id !=3D APDS9930_ID)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Set the coefficients to those specified in properties if they exis=
t,<br>
&gt; + * otherwise to default values.<br>
&gt; + */<br>
&gt; +static void apds9930_set_device_data(struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_coefficients defaults =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ga=C2=A0 =C2=A0 =C2=
=A0=3D DEF_GA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.coef_a =3D 100,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.coef_b =3D DEF_B,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.coef_c =3D DEF_C,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.coef_d =3D DEF_D,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.df=C2=A0 =C2=A0 =C2=
=A0=3D DEF_DF,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;data-&gt;client-&gt;d=
ev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Look for device properties and set them to pro=
perty value or to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * default.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(dev, GA_PROP, &amp;d=
ata-&gt;__<a href=3D"http://coefs.ga" target=3D"_blank">coefs.ga</a>) !=3D =
0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__<a href=3D=
"http://coefs.ga" target=3D"_blank">coefs.ga</a> =3D <a href=3D"http://defa=
ults.ga" target=3D"_blank">defaults.ga</a>;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(dev, DF_PROP, &amp;d=
ata-&gt;__coefs.df) !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__coefs.df =
=3D defaults.df;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(dev, COEF_B_PROP,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data-&gt;__coefs.coe=
f_b) !=3D 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_property_read_u32(dev, COEF_=
C_PROP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data-&gt;__coefs.coe=
f_c) !=3D 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_property_read_u32(dev, COEF_=
D_PROP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data-&gt;__coefs.coe=
f_d) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__coefs.coef=
_b=C2=A0 =C2=A0 =3D defaults.coef_b;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__coefs.coef=
_c=C2=A0 =C2=A0 =3D defaults.coef_c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__coefs.coef=
_d=C2=A0 =C2=A0 =3D defaults.coef_d;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;__coefs.coef_a =3D defaults.coef_a;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(dev, ATIME_PROP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (int *)&amp;data-&gt;__at=
ime) !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__atime =3D =
APDS9930_DEF_ATIME;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(dev, AGAIN_PROP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (int *)&amp;data-&gt;__ag=
ain) !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__again =3D =
APDS9930_DEF_AGAIN;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * AGAIN can only have the following values (as f=
ound in the register):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 0, 1, 2, 3. Check if we receive invalid data a=
nd fall back to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * defaults if that is the case.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (data-&gt;__again &gt; APDS9930_MAX_AGAIN_INDE=
X)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__again =3D =
APDS9930_DEF_AGAIN;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apds9930_chip_data_init(struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_set_device_data(data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Init data to default values */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;alsit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D atime_to_alsit(data-&gt;__atime);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;ch0_max=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D apds9930_compute_max_ch0(APDS9930_DEF_ATIME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;agl_enabled=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;again_change=C2=A0 =C2=A0 =C2=A0 =3D 0;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_intr_state=C2=A0 =C2=A0 =3D false;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.low=C2=A0 =C2=A0 =3D APDS9930=
_DEF_ALS_THRESH_LOW;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;als_thresh.high=C2=A0 =C2=A0=3D APDS9930=
_DEF_ALS_THRESH_HIGH;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Basic chip initialization, as described in the datasheet */<br>
&gt; +static int apds9930_chip_registers_init(struct apds9930_data *data)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client =3D data-&gt;client;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable and powerdown device */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_disable_all(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set timing registers default values (minimum) =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_ATIM=
E_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DEF_ATIME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_WTIM=
E_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DEF_WTIME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Reset the configuration register (do not wait =
long) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_CONF=
IG_REG, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Gain selection setting */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_CONT=
ROL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;__again &lt;&lt; APDS993=
0_AGAIN_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Interrupt threshold default settings */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_word(client, APDS9930_AILT=
L_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DEF_ALS_THRESH_LOW);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_word(client, APDS9930_AIHT=
L_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DEF_ALS_THRESH_HIGH);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set ALS persistence filter to default values *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_PERS=
_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APDS9930_DEF_APERS &lt;&lt; APDS9=
930_APERS_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Power the device back on */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return apds9930_enable_all(data);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_read_raw(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *chan, int *val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int *val2, long mask)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data=C2=A0 =C2=A0 =C2=A0 =
=3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D data-&gt;client;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 ch0, ch1, ch;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (chan-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_LIGHT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get Lux value */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read=
_word(client, APDS9930_CDATAL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;ch0);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read=
_word(client, APDS9930_IRDATAL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;ch1);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Compute Lux value =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D apds9930_com=
pute_lux(data, ch0, ch1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0apds9930_update_again=
(data, ch0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D IIO_VAL_INT;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_INTENSITY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get ch0 or ch1 raw=
 value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read=
_word(client, chan-&gt;channel ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 APDS9930_IR=
DATAL_REG :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 APDS9930_CD=
ATAL_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;ch);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val=C2=A0 =C2=A0 =3D=
 (int)ch;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=C2=A0 =C2=A0 =C2=
=A0=3D IIO_VAL_INT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Event handling functions */<br>
&gt; +static int apds9930_read_event_config(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct iio_ch=
an_spec *chan,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum iio_event_type=
 type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum iio_event_dire=
ction dir)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data =3D iio_priv(indio_dev=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (chan-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_INTENSITY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return data-&gt;als_i=
ntr_state;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_write_event_config(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct iio_c=
han_spec *chan,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum iio_event_typ=
e type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum iio_event_dir=
ection dir,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int state)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data=C2=A0 =C2=A0 =C2=A0 =
=3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D data-&gt;client;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 enable_reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (chan-&gt;type !=3D IIO_INTENSITY)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read_byte(client, APDS9930_ENABL=
E_REG, &amp;enable_reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (state)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_reg |=3D APDS9=
930_AIEN; /* enable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_reg &amp;=3D ~=
APDS9930_AIEN; /* disable */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(client, APDS9930_ENAB=
LE_REG, enable_reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;als_intr_sta=
te =3D (bool)state;<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_read_event_value(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct iio_chan_spe=
c *chan,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum iio_event_type type,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum iio_event_direction =
dir,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum iio_event_info info,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *val, int *val2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data =3D iio_priv(indio_dev=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_threshold thresh;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (chan-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_INTENSITY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thresh =3D data-&gt;a=
ls_thresh;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (dir) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_EV_DIR_RISING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D (int)(thresh=
.high);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_EV_DIR_FALLING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D (int)(thresh=
.low);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* IIO device specific data structures */<br>
&gt; +static const struct iio_info apds9930_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read_raw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D apds9930_read_raw,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read_event_config=C2=A0 =C2=A0 =C2=A0 =3D apds99=
30_read_event_config,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.write_event_config=C2=A0 =C2=A0 =C2=A0=3D apds99=
30_write_event_config,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read_event_value=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D a=
pds9930_read_event_value,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_event_spec apds9930_als_event_spec[] =3D {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ALS Ch0 interrupt =
&quot;above threshold&quot; event */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_EV_TYPE_THRESH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dir=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D IIO_EV_DIR_RISING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mask_separate=C2=A0 =
=3D BIT(IIO_EV_INFO_VALUE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(IIO_EV_INFO_ENABLE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ALS Ch0 interrupt =
&quot;below threshold&quot; event */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_EV_TYPE_THRESH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dir=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D IIO_EV_DIR_FALLING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mask_separate=C2=A0 =
=3D BIT(IIO_EV_INFO_VALUE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(IIO_EV_INFO_ENABLE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec apds9930_channels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* ALS channels */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Lux (processed Ch0=
 + Ch1) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_LIGHT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
=C2=A0 =C2=A0 =C2=A0=3D BIT(IIO_CHAN_INFO_PROCESSED),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Ch0 photodiode (vi=
sible light + infrared); threshold<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * triggered event<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_INTENSITY,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modified=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel2=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_MOD_LIGHT_BOTH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
=C2=A0 =C2=A0 =C2=A0=3D BIT(IIO_CHAN_INFO_RAW),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.event_spec=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D apds9930_als_event_spec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_event_specs=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D ARRAY_SIZE(apds9930_als_event_spec),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ch1 photodiode (in=
frared) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_INTENSITY,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modified=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel2=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IIO_MOD_LIGHT_IR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
=C2=A0 =C2=A0 =C2=A0=3D BIT(IIO_CHAN_INFO_RAW),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Determine what has triggered the interrupt and clear it accordingl=
y */<br>
&gt; +static int apds9930_interrupt_clear(struct apds9930_data *data, u8 in=
tr_status)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 reg =3D 0x00;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (intr_status &amp; APDS9930_AINT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMD_REG_SETUP(reg, AP=
DS9930_CMD_TYPE_SPECIAL_FUNC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg |=3D APDS9930_CMD=
_TYPE_ALS;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return i2c_smbus_read=
_byte_data(data-&gt;client, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ALS interrupt handler */<br>
&gt; +static irqreturn_t apds9930_irq_handler(int irq, void *private_data)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D private_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data=C2=A0 =C2=A0 =C2=A0 =
=3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 status, enable_reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable ALS function while processing data */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read_byte(data-&gt;client, APDS9=
930_ENABLE_REG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;enable_reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_write_byte(data-&gt;client, APDS=
9930_ENABLE_REG, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Read status register to see what caused the in=
terrupt */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read_byte(data-&gt;client, APDS9=
930_STATUS_REG, &amp;status);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_read_word(data-&gt;client, APDS9=
930_CDATAL_REG, &amp;ch0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_update_again(data, ch0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Push event to userspace */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (status &amp; APDS9930_AINT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear interrupt */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0apds9930_interrupt_cl=
ear(data, status);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_push_event(indio_=
dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IIO_MOD_EVENT_CODE(IIO_INTENSITY,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0IIO_MOD_LIGHT_BOTH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0IIO_EV_TYPE_THRESH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0IIO_EV_DIR_EITHER),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_get_time_ns());<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update ALS thresho=
lds to environment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0apds9930_update_als_t=
hresholds(data, ch0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Re-enable ALS converter */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_write_byte(data-&gt;client, APDS9930_ENA=
BLE_REG, enable_reg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_gpio_probe(struct i2c_client *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct apds9930_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct gpio_desc *gpio;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!client)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev =3D &amp;client-&gt;dev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio =3D devm_gpiod_get_index(dev, APDS9930_GPIO_=
NAME, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(gpio)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;AC=
PI GPIO get index failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(gpio);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D gpiod_direction_input(gpio);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return gpiod_to_irq(gpio);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_probe(struct i2c_client *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const struct i2c_device_id *id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_alloc(&amp;client-&=
gt;dev, sizeof(*data));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!indio_dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;client =3D client;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-&gt;mutex);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Recommended wait time after power on. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msleep(APDS9930_INIT_SLEEP);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check if the chip is the one we are expecting =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_chip_detect(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_chip_data_init(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_chip_registers_init(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent=C2=A0 =C2=A0=3D &amp;cli=
ent-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D APDS9930_DRIVER_NAME;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D INDIO_DIRECT_MODE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels=C2=A0 =C2=A0 =C2=A0=3D apd=
s9930_channels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(apds993=
0_channels);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D &amp;apds9930_info;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (client-&gt;irq &lt;=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client-&gt;irq =3D ap=
ds9930_gpio_probe(client, data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (client-&gt;irq &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D devm_request_=
threaded_irq(&amp;client-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0client-&gt;irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0apds9930_irq_handler,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0IRQF_TRIGGER_FALLING |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0IRQF_ONESHOT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0APDS9930_IRQ_NAME,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D iio_device_register(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0apds9930_disable_all(data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int apds9930_remove(struct i2c_client *client)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D i2c_get_clientdata(client);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct apds9930_data *data=C2=A0 =C2=A0 =C2=A0 =
=3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Disable interrupts */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D apds9930_disable_all(data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct acpi_device_id apds9930_acpi_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;APDS9930&quot;, 0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(acpi, apds9930_acpi_table);<br>
&gt; +<br>
&gt; +static const struct i2c_device_id apds9930_ids_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;apds9930&quot;, 0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(i2c, apds9930_ids_table);<br>
&gt; +<br>
&gt; +static struct i2c_driver apds9930_iio_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D APDS9930_DRIVER_=
NAME,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.acpi_match_table=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D ACPI_PTR(apds9930_acpi_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D apds=
9930_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D apds=
9930_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.id_table=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D apds9930_=
ids_table,<br>
&gt; +};<br>
&gt; +module_i2c_driver(apds9930_iio_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Cristina Ciocan &lt;<a href=3D"mailto:cristina.ci=
ocan@intel.com">cristina.ciocan@intel.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;APDS-9930 ALS sensor IIO driver&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt;<br>
<br>
--<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Peter Meerwald<b=
r>
<a href=3D"tel:%2B43-664-2444418" value=3D"+436642444418">+43-664-2444418</=
a>=C2=A0(mobile)<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><font style=3D"background-c=
olor:rgb(255,255,255)" color=3D"#4c1130">=C2=A0 </font><font style=3D"backg=
round-color:rgb(255,255,255)" color=3D"#741b47">=C2=A0<font face=3D"trebuch=
et ms, sans-serif">Cristina Ciocan =C2=A0=C2=A0</font></font></div></div>
</div>

--e89a8f234d458bab080511a6e682--
