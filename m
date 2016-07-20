Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37832 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbcGTPFz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 11:05:55 -0400
Subject: Re: [PATCH] iio: adc: add ADC12130/ADC12132/ADC12138 ADC driver
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1468854029-22153-1-git-send-email-akinobu.mita@gmail.com>
 <alpine.DEB.2.02.1607182348340.25263@pmeerw.net>
 <CAC5umyjV0cUG3ovfqDy8nyDZYz_yYTwxnp7ti1T_xvz=FjWSNQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <717ff066-7112-4529-c2fe-53ade6e7b134@kernel.org>
Date: Wed, 20 Jul 2016 16:05:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAC5umyjV0cUG3ovfqDy8nyDZYz_yYTwxnp7ti1T_xvz=FjWSNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 17:24, Akinobu Mita wrote:
> 2016-07-19 7:02 GMT+09:00 Peter Meerwald-Stadler <pmeerw@pmeerw.net>:
>>
>>> This adds Texas Instruments' ADC12130/ADC12132/ADC12138 12-bit plus
>>> sign ADC driver.  I have tested with the ADC12138.  The ADC12130 and
>>> ADC12132 are not tested but these are similar to ADC12138 except that
>>> the mode programming instruction is a bit different.
>>
>> minor comments below
>>
>>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>> Cc: Peter Meerwald <pmeerw@pmeerw.net>
>>> ---
>>>  .../devicetree/bindings/iio/adc/ti-adc12138.txt    |  32 ++
>>>  drivers/iio/adc/Kconfig                            |  12 +
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/ti-adc12138.c                      | 541 +++++++++++++++++++++
>>>  4 files changed, 586 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>>>  create mode 100644 drivers/iio/adc/ti-adc12138.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>>> new file mode 100644
>>> index 0000000..3a11d2a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>>> @@ -0,0 +1,32 @@
>>> +* Texas Instruments' ADC12130/ADC12132/ADC12138
>>> +
>>> +Required properties:
>>> + - compatible: Should be one of
>>> +     * "ti,adc12130"
>>> +     * "ti,adc12132"
>>> +     * "ti,adc12138"
>>> + - reg: SPI chip select number for the device
>>> + - interrupts: Should contain interrupt for EOC (end of conversion)
>>> + - clocks: phandle to conversion clock input
>>> + - spi-max-frequency: Definision as per
>>> +     Documentation/devicetree/bindings/spi/spi-bus.txt
>>> + - vref-p-supply: The regulator supply for positive analog voltage reference
>>> +
>>> +Optional properties:
>>> + - vref-n-supply: The regulator supply for negative analog voltage reference
>>> +     If not specified, this is assumed to be analog ground.
>>> + - acquisition-time: The number of conversion clock periods for the S/H's
>>> +     acquisition time.  Should be one of 6, 10, 18, 34.  If not specified,
>>> +     default value of 10 is used.
>>> +
>>> +Example:
>>> +adc@0 {
>>> +     compatible = "ti,adc12138";
>>> +     reg = <0>;
>>> +     interrupts = <28 IRQ_TYPE_EDGE_RISING>;
>>> +     interrupt-parent = <&gpio1>;
>>> +     clocks = <&cclk>;
>>> +     vref-p-supply = <&ldo4_reg>;
>>> +     spi-max-frequency = <5000000>;
>>> +     acquisition-time = <6>;
>>> +};
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index fa0ff29..0783291 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -414,6 +414,18 @@ config TI_ADC0832
>>>         This driver can also be built as a module. If so, the module will be
>>>         called ti-adc0832.
>>>
>>> +config TI_ADC12138
>>> +     tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
>>> +     depends on SPI
>>> +     select IIO_BUFFER
>>> +     select IIO_TRIGGERED_BUFFER
>>> +     help
>>> +       If you say yes here you get support for Texas Instruments ADC12130,
>>> +       ADC12132and ADC12138 chips.
>>
>> space before 'and' missing
> 
> Ugh.
> 
>>> +
>>> +       This driver can also be built as a module. If so, the module will be
>>> +       called ti-adc12138.
>>> +
>>>  config TI_ADC128S052
>>>       tristate "Texas Instruments ADC128S052/ADC122S021/ADC124S021"
>>>       depends on SPI
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 599714b..3ae4ae3 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -40,6 +40,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>> +obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>>>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>>>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>> diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
>>> new file mode 100644
>>> index 0000000..e7bd986
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/ti-adc12138.c
>>> @@ -0,0 +1,541 @@
>>> +/*
>>> + * ADC12130/ADC12132/ADC12138 12-bit plus sign ADC driver
>>> + *
>>> + * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
>>> + *
>>> + * This file is subject to the terms and conditions of version 2 of
>>> + * the GNU General Public License.  See the file COPYING in the main
>>> + * directory of this archive for more details.
>>> + *
>>> + * Datasheet: http://www.ti.com/lit/ds/symlink/adc12138.pdf
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/completion.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +#define ADC12138_MODE_AUTO_CAL                       0x08
>>> +#define ADC12138_MODE_READ_STATUS            0x0c
>>> +#define ADC12138_MODE_ACQUISITION_TIME_6     0x0e
>>> +#define ADC12138_MODE_ACQUISITION_TIME_10    0x4e
>>> +#define ADC12138_MODE_ACQUISITION_TIME_18    0x8e
>>> +#define ADC12138_MODE_ACQUISITION_TIME_34    0xce
>>> +
>>> +#define ADC12138_STATUS_CAL                  BIT(6)
>>> +
>>> +enum {
>>> +     adc12130,
>>> +     adc12132,
>>> +     adc12138,
>>> +};
>>> +
>>> +struct adc12138 {
>>> +     struct spi_device *spi;
>>> +     unsigned int id;
>>> +     /* conversion clock */
>>> +     struct clk *cclk;
>>> +     /* positive analog voltage reference */
>>> +     struct regulator *vref_p;
>>> +     /* negative analog voltage reference */
>>> +     struct regulator *vref_n;
>>> +     struct mutex lock;
>>> +     struct completion complete;
>>> +     unsigned int acquisition_time;
>>
>> unit? ms? µs?
> 
> This is specified by the number of conversion clock (cclk) periods.
> I'll add a comment about it.
> 
>>> +
>>> +     u8 tx_buf[2] ____cacheline_aligned;
>>> +     u8 rx_buf[2];
>>> +};
>>> +
>>> +#define ADC12138_VOLTAGE_CHANNEL(chan)                                       \
>>> +     {                                                               \
>>> +             .type = IIO_VOLTAGE,                                    \
>>> +             .indexed = 1,                                           \
>>> +             .channel = chan,                                        \
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)    \
>>> +                                     | BIT(IIO_CHAN_INFO_OFFSET),    \
>>> +             .scan_index = chan,                                     \
>>> +             .scan_type = {                                          \
>>> +                     .sign = 's',                                    \
>>> +                     .realbits = 13,                                 \
>>> +                     .storagebits = 16,                              \
>>> +                     .shift = 3,                                     \
>>> +                     .endianness = IIO_BE,                           \
>>> +             },                                                      \
>>> +     }
>>> +
>>> +#define ADC12138_VOLTAGE_CHANNEL_DIFF(chan1, chan2, si_offset)               \
>>> +     {                                                               \
>>> +             .type = IIO_VOLTAGE,                                    \
>>> +             .indexed = 1,                                           \
>>> +             .channel = (chan1),                                     \
>>> +             .channel2 = (chan2),                                    \
>>> +             .differential = 1,                                      \
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)    \
>>> +                                     | BIT(IIO_CHAN_INFO_OFFSET),    \
>>> +             .scan_index = (chan1) + (si_offset),                    \
>>> +             .scan_type = {                                          \
>>> +                     .sign = 's',                                    \
>>> +                     .realbits = 13,                                 \
>>> +                     .storagebits = 16,                              \
>>> +                     .shift = 3,                                     \
>>> +                     .endianness = IIO_BE,                           \
>>> +             },                                                      \
>>> +     }
>>> +
>>> +static const struct iio_chan_spec adc12132_channels[] = {
>>> +     ADC12138_VOLTAGE_CHANNEL(0),
>>> +     ADC12138_VOLTAGE_CHANNEL(1),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(0, 1, 2),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(1, 0, 2),
>>> +     IIO_CHAN_SOFT_TIMESTAMP(4),
>>> +};
>>> +
>>> +static const struct iio_chan_spec adc12138_channels[] = {
>>> +     ADC12138_VOLTAGE_CHANNEL(0),
>>> +     ADC12138_VOLTAGE_CHANNEL(1),
>>> +     ADC12138_VOLTAGE_CHANNEL(2),
>>> +     ADC12138_VOLTAGE_CHANNEL(3),
>>> +     ADC12138_VOLTAGE_CHANNEL(4),
>>> +     ADC12138_VOLTAGE_CHANNEL(5),
>>> +     ADC12138_VOLTAGE_CHANNEL(6),
>>> +     ADC12138_VOLTAGE_CHANNEL(7),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(0, 1, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(1, 0, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(2, 3, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(3, 2, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(4, 5, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(5, 4, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(6, 7, 8),
>>> +     ADC12138_VOLTAGE_CHANNEL_DIFF(7, 6, 8),
>>> +     IIO_CHAN_SOFT_TIMESTAMP(16),
>>> +};
>>> +
>>> +static int adc12138_mode_programming(struct adc12138 *adc, u8 mode,
>>> +                                  void *rx_buf, int len)
>>> +{
>>> +     struct spi_transfer xfer = {
>>> +             .tx_buf = adc->tx_buf,
>>> +             .rx_buf = adc->rx_buf,
>>> +             .len = len,
>>> +     };
>>> +     int ret;
>>> +
>>> +     /* Skip disused bits for ADC12130 and ADC12132 */
>>
>> probably 'unused' instead of 'disused'
> 
> OK.
> 
>>> +     if (adc->id != adc12138)
>>> +             mode = (mode & 0xc0) | ((mode & 0x0f) << 2);
>>> +
>>> +     adc->tx_buf[0] = mode;
>>> +
>>> +     ret = spi_sync_transfer(adc->spi, &xfer, 1);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     memcpy(rx_buf, adc->rx_buf, len);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int adc12138_read_status(struct adc12138 *adc)
>>> +{
>>> +     u8 rx_buf[2];
>>> +     int ret;
>>> +
>>> +     ret = adc12138_mode_programming(adc, ADC12138_MODE_READ_STATUS,
>>> +                                     rx_buf, 2);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return (rx_buf[0] << 1) | (rx_buf[1] >> 7);
>>> +}
>>> +
>>> +static int __adc12138_start_conv(struct adc12138 *adc,
>>> +                              struct iio_chan_spec const *channel,
>>> +                              void *data, int len)
>>> +
>>> +{
>>> +     const u8 ch_to_mux[] = { 0, 4, 1, 5, 2, 6, 3, 7 };
>>> +     u8 mode = (ch_to_mux[channel->channel] << 4) |
>>> +               (channel->differential ? 0 : 0x80);
>>> +
>>> +     return adc12138_mode_programming(adc, mode, data, len);
>>> +}
>>> +
>>> +static int adc12138_start_conv(struct adc12138 *adc,
>>> +                            struct iio_chan_spec const *channel)
>>> +{
>>> +     u8 trash;
>>> +
>>> +     return __adc12138_start_conv(adc, channel, &trash, 1);
>>> +}
>>> +
>>> +static int adc12138_start_and_read_conv(struct adc12138 *adc,
>>> +                                     struct iio_chan_spec const *channel,
>>> +                                     __be16 *data)
>>> +{
>>> +     return __adc12138_start_conv(adc, channel, data, 2);
>>> +}
>>> +
>>> +static int adc12138_read_conv_data(struct adc12138 *adc, __be16 *value)
>>> +{
>>> +     /* Issue a read status instruction and read previous conversion data */
>>> +     return adc12138_mode_programming(adc, ADC12138_MODE_READ_STATUS,
>>> +                                      value, sizeof(*value));
>>> +}
>>> +
>>> +static int adc12138_wait_eoc(struct adc12138 *adc, unsigned long timeout)
>>> +{
>>> +     if (!wait_for_completion_timeout(&adc->complete, timeout))
>>> +             return -ETIMEDOUT;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int adc12138_adc_conversion(struct adc12138 *adc,
>>> +                                struct iio_chan_spec const *channel,
>>> +                                __be16 *value)
>>> +{
>>> +     int ret;
>>> +
>>> +     reinit_completion(&adc->complete);
>>> +
>>> +     ret = adc12138_start_conv(adc, channel);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = adc12138_wait_eoc(adc, msecs_to_jiffies(100));
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return adc12138_read_conv_data(adc, value);
>>> +}
>>> +
>>> +static int adc12138_read_raw(struct iio_dev *iio,
>>> +                          struct iio_chan_spec const *channel, int *value,
>>> +                          int *shift, long mask)
>>> +{
>>> +     struct adc12138 *adc = iio_priv(iio);
>>> +     int ret;
>>> +     __be16 data;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW:
>>
>> what if buffered reads have been set up? probably use
>> iio_device_claim_direct_mode()
> 
> Maybe it is safe because the ADC data is always requested and retrieved
> while holding adc12138.lock from adc12138_read_raw() and
> adc12138_trigger_handler().  Is it better to restrict direct mode and
> return -EBUSY while buffer mode is enabled?
> 
> (BTW, I realized that I can use iio_dev->mlock instead of adc12138.lock)
Don't use it for anything other than state change locking.  It has that
well focused task within the subsystem - we are trying to clear out other
uses entirely as there have been more than a few bugs around this.

Much better to have a separate lock for protecting resources controlled
directly by the driver itself.
> 
>>> +             mutex_lock(&adc->lock);
>>> +             ret = adc12138_adc_conversion(adc, channel, &data);
>>> +             mutex_unlock(&adc->lock);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             *value = sign_extend32(be16_to_cpu(data) >> 3, 12);
>>> +
>>> +             return IIO_VAL_INT;
>>> +     case IIO_CHAN_INFO_SCALE:
>>> +             ret = regulator_get_voltage(adc->vref_p);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +             *value = ret;
>>> +
>>> +             if (!IS_ERR(adc->vref_n)) {
>>> +                     ret = regulator_get_voltage(adc->vref_n);
>>> +                     if (ret < 0)
>>> +                             return ret;
>>> +                     *value -= ret;
>>> +             }
>>> +
>>> +             /* convert regulator output voltage to mV */
>>> +             *value /= 1000;
>>> +             *shift = channel->scan_type.realbits - 1;
>>> +
>>> +             return IIO_VAL_FRACTIONAL_LOG2;
>>> +     case IIO_CHAN_INFO_OFFSET:
>>> +             if (!IS_ERR(adc->vref_n)) {
>>> +                     *value = regulator_get_voltage(adc->vref_n);
>>> +                     if (*value < 0)
>>> +                             return *value;
>>> +             } else {
>>> +                     *value = 0;
>>> +             }
>>> +
>>> +             /* convert regulator output voltage to mV */
>>> +             *value /= 1000;
>>> +
>>> +             return IIO_VAL_INT;
>>> +     }
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static const struct iio_info adc12138_info = {
>>> +     .read_raw = adc12138_read_raw,
>>> +     .driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static int adc12138_init(struct adc12138 *adc)
>>> +{
>>> +     int ret;
>>> +     int status;
>>> +     u8 mode;
>>> +     u8 trash;
>>> +
>>> +     reinit_completion(&adc->complete);
>>> +
>>> +     ret = adc12138_mode_programming(adc, ADC12138_MODE_AUTO_CAL, &trash, 1);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* data output at this time has no significance */
>>> +     status = adc12138_read_status(adc);
>>> +     if (status < 0)
>>> +             return status;
>>> +
>>> +     adc12138_wait_eoc(adc, msecs_to_jiffies(100));
>>> +
>>> +     status = adc12138_read_status(adc);
>>> +     if (status & ADC12138_STATUS_CAL) {
>>> +             dev_warn(&adc->spi->dev,
>>> +                     "Auto Cal sequence is still in progress: %#x\n",
>>> +                     status);
>>> +             return -EIO;
>>> +     }
>>> +
>>> +     switch (adc->acquisition_time) {
>>> +     case 6:
>>> +             mode = ADC12138_MODE_ACQUISITION_TIME_6;
>>> +             break;
>>> +     case 10:
>>> +             mode = ADC12138_MODE_ACQUISITION_TIME_10;
>>> +             break;
>>> +     case 18:
>>> +             mode = ADC12138_MODE_ACQUISITION_TIME_18;
>>> +             break;
>>> +     case 34:
>>> +             mode = ADC12138_MODE_ACQUISITION_TIME_34;
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     return adc12138_mode_programming(adc, mode, &trash, 1);
>>> +}
>>> +
>>> +static irqreturn_t adc12138_trigger_handler(int irq, void *p)
>>> +{
>>> +     struct iio_poll_func *pf = p;
>>> +     struct iio_dev *indio_dev = pf->indio_dev;
>>> +     struct adc12138 *adc = iio_priv(indio_dev);
>>> +     __be16 data[20] = { };
>>
>> why { } here?
> 
> To initialize with zero and avoids exposing kernel stack to userspace
> through padding entries.  I could use memset here.
> 
>> why 20?
> 
> When all scan elements are enabled, the sample data requires 40 bytes
> (2 bytes ADC data * 16 channels + 8 bytes timestamp).
> 
> I'll add comments about these.
> 
>>> +     __be16 trash;
>>> +     int ret;
>>> +     int scan_index;
>>> +     int i = 0;
>>> +
>>> +     mutex_lock(&adc->lock);
>>> +
>>> +     for_each_set_bit(scan_index, indio_dev->active_scan_mask,
>>> +                      indio_dev->masklength) {
>>> +             const struct iio_chan_spec *scan_chan =
>>> +                             &indio_dev->channels[scan_index];
>>> +
>>> +             reinit_completion(&adc->complete);
>>> +
>>> +             ret = adc12138_start_and_read_conv(adc, scan_chan,
>>> +                                                i ? &data[i - 1] : &trash);
>>> +             if (ret) {
>>> +                     dev_warn(&adc->spi->dev,
>>> +                              "failed to start conversion\n");
>>> +                     goto out;
>>> +             }
>>> +
>>> +             ret = adc12138_wait_eoc(adc, msecs_to_jiffies(100));
>>> +             if (ret) {
>>> +                     dev_warn(&adc->spi->dev, "wait eoc timeout\n");
>>> +                     goto out;
>>> +             }
>>> +
>>> +             i++;
>>> +     }
>>> +
>>> +     if (i) {
>>> +             ret = adc12138_read_conv_data(adc, &data[i - 1]);
>>> +             if (ret) {
>>> +                     dev_warn(&adc->spi->dev,
>>> +                              "failed to get conversion data\n");
>>> +                     goto out;
>>> +             }
>>> +     }
>>> +
>>> +     iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
>>> +out:
>>> +     mutex_unlock(&adc->lock);
>>> +
>>> +     iio_trigger_notify_done(indio_dev->trig);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

