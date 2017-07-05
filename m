Return-Path: <SRS0=VNTF=6I=fi.rohmeurope.com=prvs=7359d14b42=Mikko.Koivunen@kernel.org>
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, Daniel Baluta
	<daniel.baluta@nxp.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 09/10] iio: light: rpr0521 triggered buffer
Date: Wed, 5 Jul 2017 06:34:58 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8F834404E@WILL-MAIL001.REu.RohmEu.com>
References: <1499086214-1811-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1499086214-1811-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <20170704204821.30384e00@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On 4.7.2017 22:48, Jonathan Cameron wrote:=0A=
> On Mon,  3 Jul 2017 15:50:13 +0300=0A=
> Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com> wrote:=0A=
>=0A=
>> Set up and use triggered buffer if there is irq defined for device in=0A=
>> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.=
=0A=
>> Trigger consumer reads rpr0521 data to scan buffer.=0A=
>> Depends on previous commits of _scale and _offset.=0A=
>>=0A=
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>=0A=
> one side comment inline, but so tiny I'm not even going to bother changin=
g=0A=
> it whilst applying.=0A=
>=0A=
> Very nice.=0A=
>=0A=
> Applied to the togreg branch of iio.git and pushed out as testing=0A=
> for the autobuilders to play with it.=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Jonathan=0A=
=0A=
Ack. And thanks for review, this is much better with all the changes.=0A=
=0A=
>> ---=0A=
>> Patch v2->v3 changes:=0A=
>> .shift =3D 0 removed=0A=
>> reordered functions to remove forward declarations=0A=
>> whitespace changes=0A=
>> refactored some update_bits->write, no "err =3D err || *"-pattern=0A=
>> refactored trigger_consumer_handler=0A=
>> reordered _probe() and _remove()=0A=
>> added int clear on poweroff()=0A=
>> checkpatch.pl OK=0A=
>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.=0A=
>> Builds ok with torvalds/linux feb 27.=0A=
>>=0A=
>> Patch v3->v4 changes:=0A=
>> Moved sensor on/off commands to buffer preenable and postdisable=0A=
>>  - Since drdy happens only on measurement data ready and register writes=
=0A=
>>    are cached, the trigger producer doesn't care of suspend/resume state=
.=0A=
>> available_scan_masks added=0A=
>> indent fix=0A=
>> checkpatch.pl OK=0A=
>> Lightly re-tested on LeMaker HiKey with AOSP7.1 kernel 4.4.=0A=
>> Builds ok with torvalds/linux feb 27.=0A=
>>=0A=
>> Patch v5->v6 changes:=0A=
>> Changed base from kernel 4.4 to 4.9=0A=
>>  - Using iio_device_claim_direct_mode()=0A=
>>  - Using iio_trigger_using_own()=0A=
>>  - Changed trigger/buffer to devm_=0A=
>> Added shared irq support=0A=
>>  - divided trigger producer to top/bottom=0A=
>>  - divided trigger consumer to top/bottom=0A=
>>  - Using irq_timestamp when available=0A=
>> Removed default trigger=0A=
>>=0A=
>> Patch v6->v7 changes:=0A=
>> trigger_poll to trigger_poll_chained=0A=
>>  + some timestamp saving logic changes due that=0A=
>> 2 whitespace fixes=0A=
>>=0A=
>>  drivers/iio/light/rpr0521.c |  336 ++++++++++++++++++++++++++++++++++++=
++++++-=0A=
>>  1 file changed, 329 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c=
=0A=
>> index 9d0c2e8..a6efa126 100644=0A=
>> --- a/drivers/iio/light/rpr0521.c=0A=
>> +++ b/drivers/iio/light/rpr0521.c=0A=
>> @@ -9,7 +9,7 @@=0A=
>>   *=0A=
>>   * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).=0A=
>>   *=0A=
>> - * TODO: illuminance channel, buffer=0A=
>> + * TODO: illuminance channel=0A=
>>   */=0A=
>>  =0A=
>>  #include <linux/module.h>=0A=
>> @@ -20,6 +20,10 @@=0A=
>>  #include <linux/acpi.h>=0A=
>>  =0A=
>>  #include <linux/iio/iio.h>=0A=
>> +#include <linux/iio/buffer.h>=0A=
>> +#include <linux/iio/trigger.h>=0A=
>> +#include <linux/iio/trigger_consumer.h>=0A=
>> +#include <linux/iio/triggered_buffer.h>=0A=
>>  #include <linux/iio/sysfs.h>=0A=
>>  #include <linux/pm_runtime.h>=0A=
>>  =0A=
>> @@ -30,6 +34,7 @@=0A=
>>  #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */=0A=
>>  #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */=0A=
>>  #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */=0A=
>> +#define RPR0521_REG_INTERRUPT		0x4A=0A=
>>  #define RPR0521_REG_PS_OFFSET_LSB	0x53=0A=
>>  #define RPR0521_REG_ID			0x92=0A=
>>  =0A=
>> @@ -42,16 +47,31 @@=0A=
>>  #define RPR0521_ALS_DATA1_GAIN_SHIFT	2=0A=
>>  #define RPR0521_PXS_GAIN_MASK		GENMASK(5, 4)=0A=
>>  #define RPR0521_PXS_GAIN_SHIFT		4=0A=
>> +#define RPR0521_PXS_PERSISTENCE_MASK	GENMASK(3, 0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK	BIT(0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK	BIT(1)=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK	BIT(3)=0A=
>> +#define RPR0521_INTERRUPT_ALS_INT_STATUS_MASK	BIT(6)=0A=
>> +#define RPR0521_INTERRUPT_PS_INT_STATUS_MASK	BIT(7)=0A=
>>  =0A=
>>  #define RPR0521_MODE_ALS_ENABLE		BIT(7)=0A=
>>  #define RPR0521_MODE_ALS_DISABLE	0x00=0A=
>>  #define RPR0521_MODE_PXS_ENABLE		BIT(6)=0A=
>>  #define RPR0521_MODE_PXS_DISABLE	0x00=0A=
>> +#define RPR0521_PXS_PERSISTENCE_DRDY	0x00=0A=
>> +=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE	BIT(0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE	0x00=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE	BIT(1)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE	0x00=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE	BIT(3)=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE	0x00=0A=
>>  =0A=
>>  #define RPR0521_MANUFACT_ID		0xE0=0A=
>>  #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */=
=0A=
>>  =0A=
>>  #define RPR0521_DRV_NAME		"RPR0521"=0A=
>> +#define RPR0521_IRQ_NAME		"rpr0521_event"=0A=
>>  #define RPR0521_REGMAP_NAME		"rpr0521_regmap"=0A=
>>  =0A=
>>  #define RPR0521_SLEEP_DELAY_MS	2000=0A=
>> @@ -167,6 +187,9 @@ struct rpr0521_data {=0A=
>>  	bool als_dev_en;=0A=
>>  	bool pxs_dev_en;=0A=
>>  =0A=
>> +	struct iio_trigger *drdy_trigger0;=0A=
>> +	s64 irq_timestamp;=0A=
>> +=0A=
>>  	/* optimize runtime pm ops - enable/disable device only if needed */=
=0A=
>>  	bool als_ps_need_en;=0A=
>>  	bool pxs_ps_need_en;=0A=
>> @@ -196,6 +219,19 @@ static const struct attribute_group rpr0521_attribu=
te_group =3D {=0A=
>>  	.attrs =3D rpr0521_attributes,=0A=
>>  };=0A=
>>  =0A=
>> +/* Order of the channel data in buffer */=0A=
>> +enum rpr0521_scan_index_order {=0A=
>> +	RPR0521_CHAN_INDEX_PXS,=0A=
>> +	RPR0521_CHAN_INDEX_BOTH,=0A=
>> +	RPR0521_CHAN_INDEX_IR,=0A=
>> +};=0A=
>> +=0A=
>> +static const unsigned long rpr0521_available_scan_masks[] =3D {=0A=
>> +	BIT(RPR0521_CHAN_INDEX_PXS) | BIT(RPR0521_CHAN_INDEX_BOTH) |=0A=
>> +	BIT(RPR0521_CHAN_INDEX_IR),=0A=
>> +	0=0A=
>> +};=0A=
>> +=0A=
>>  static const struct iio_chan_spec rpr0521_channels[] =3D {=0A=
>>  	{=0A=
>>  		.type =3D IIO_PROXIMITY,=0A=
>> @@ -204,6 +240,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>  			BIT(IIO_CHAN_INFO_OFFSET) |=0A=
>>  			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>  		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_PXS,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>  	},=0A=
>>  	{=0A=
>>  		.type =3D IIO_INTENSITY,=0A=
>> @@ -213,6 +256,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=0A=
>>  			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>  		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_BOTH,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>  	},=0A=
>>  	{=0A=
>>  		.type =3D IIO_INTENSITY,=0A=
>> @@ -222,6 +272,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=0A=
>>  			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>  		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_IR,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>  	},=0A=
>>  };=0A=
>>  =0A=
>> @@ -330,6 +387,198 @@ static int rpr0521_set_power_state(struct rpr0521_=
data *data, bool on,=0A=
>>  	return 0;=0A=
>>  }=0A=
>>  =0A=
>> +/* Interrupt register tells if this sensor caused the interrupt or not.=
 */=0A=
>> +static inline bool rpr0521_is_triggered(struct rpr0521_data *data)=0A=
>> +{=0A=
>> +	int ret;=0A=
>> +	int reg;=0A=
>> +=0A=
>> +	ret =3D regmap_read(data->regmap, RPR0521_REG_INTERRUPT, &reg);=0A=
>> +	if (ret < 0)=0A=
>> +		return false;   /* Reg read failed. */=0A=
>> +	if (reg &=0A=
>> +	    (RPR0521_INTERRUPT_ALS_INT_STATUS_MASK |=0A=
>> +	    RPR0521_INTERRUPT_PS_INT_STATUS_MASK))=0A=
>> +		return true;=0A=
>> +	else=0A=
>> +		return false;   /* Int not from this sensor. */=0A=
>> +}=0A=
>> +=0A=
>> +/* IRQ to trigger handler */=0A=
>> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)=0A=
>> +{=0A=
>> +	struct iio_dev *indio_dev =3D private;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	data->irq_timestamp =3D iio_get_time_ns(indio_dev);=0A=
>> +	/*=0A=
>> +	 * We need to wake the thread to read the interrupt reg. It=0A=
>> +	 * is not possible to do that here because regmap_read takes a=0A=
>> +	 * mutex.=0A=
>> +	 */=0A=
>> +=0A=
>> +	return IRQ_WAKE_THREAD;=0A=
>> +}=0A=
>> +=0A=
>> +static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)=0A=
>> +{=0A=
>> +	struct iio_dev *indio_dev =3D private;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	if (rpr0521_is_triggered(data)) {=0A=
>> +		iio_trigger_poll_chained(data->drdy_trigger0);=0A=
>> +		return IRQ_HANDLED;=0A=
>> +	}=0A=
>> +=0A=
>> +	return IRQ_NONE;=0A=
>> +}=0A=
>> +=0A=
>> +static irqreturn_t rpr0521_trigger_consumer_store_time(int irq, void *p=
)=0A=
>> +{=0A=
>> +	struct iio_poll_func *pf =3D p;=0A=
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
>> +=0A=
>> +	/* Other trigger polls store time here. */=0A=
>> +	if (!iio_trigger_using_own(indio_dev))=0A=
>> +		pf->timestamp =3D iio_get_time_ns(indio_dev);=0A=
>> +=0A=
>> +	return IRQ_WAKE_THREAD;=0A=
>> +}=0A=
>> +=0A=
>> +static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)=
=0A=
>> +{=0A=
>> +	struct iio_poll_func *pf =3D p;=0A=
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +	int err;=0A=
>> +=0A=
>> +	u8 buffer[16]; /* 3 16-bit channels + padding + ts */=0A=
>> +=0A=
>> +	/* Use irq timestamp when reasonable. */=0A=
>> +	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {=0A=
>> +		pf->timestamp =3D data->irq_timestamp;=0A=
>> +		data->irq_timestamp =3D 0;=0A=
>> +	}=0A=
>> +	/* Other chained trigger polls get timestamp only here. */=0A=
>> +	if (!pf->timestamp)=0A=
>> +		pf->timestamp =3D iio_get_time_ns(indio_dev);=0A=
>> +=0A=
>> +	err =3D regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,=0A=
>> +		&buffer,=0A=
>> +		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */=0A=
>> +	if (!err)=0A=
>> +		iio_push_to_buffers_with_timestamp(indio_dev,=0A=
>> +						   buffer, pf->timestamp);=0A=
>> +	else=0A=
>> +		dev_err(&data->client->dev,=0A=
>> +			"Trigger consumer can't read from sensor.\n");=0A=
>> +	pf->timestamp =3D 0;=0A=
>> +=0A=
>> +	iio_trigger_notify_done(indio_dev->trig);=0A=
>> +=0A=
>> +	return IRQ_HANDLED;=0A=
>> +}=0A=
>> +=0A=
>> +static int rpr0521_write_int_enable(struct rpr0521_data *data)=0A=
>> +{=0A=
>> +	int err;=0A=
>> +=0A=
>> +	/* Interrupt after each measurement */=0A=
>> +	err =3D regmap_update_bits(data->regmap, RPR0521_REG_PXS_CTRL,=0A=
>> +		RPR0521_PXS_PERSISTENCE_MASK,=0A=
>> +		RPR0521_PXS_PERSISTENCE_DRDY);=0A=
>> +	if (err) {=0A=
>> +		dev_err(&data->client->dev, "PS control reg write fail.\n");=0A=
>> +		return -EBUSY;=0A=
>> +		}=0A=
>> +=0A=
>> +	/* Ignore latch and mode because of drdy */=0A=
>> +	err =3D regmap_write(data->regmap, RPR0521_REG_INTERRUPT,=0A=
>> +		RPR0521_INTERRUPT_INT_REASSERT_DISABLE |=0A=
>> +		RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |=0A=
>> +		RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE=0A=
>> +		);=0A=
>> +	if (err) {=0A=
>> +		dev_err(&data->client->dev, "Interrupt setup write fail.\n");=0A=
>> +		return -EBUSY;=0A=
>> +		}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int rpr0521_write_int_disable(struct rpr0521_data *data)=0A=
>> +{=0A=
>> +	/* Don't care of clearing mode, assert and latch. */=0A=
>> +	return regmap_write(data->regmap, RPR0521_REG_INTERRUPT,=0A=
>> +				RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |=0A=
>> +				RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE=0A=
>> +				);=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Trigger producer enable / disable. Note that there will be trigs onl=
y when=0A=
>> + * measurement data is ready to be read.=0A=
>> + */=0A=
>> +static int rpr0521_pxs_drdy_set_state(struct iio_trigger *trigger,=0A=
>> +	bool enable_drdy)=0A=
>> +{=0A=
>> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trigger);=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +	int err;=0A=
>> +=0A=
>> +	if (enable_drdy)=0A=
>> +		err =3D rpr0521_write_int_enable(data);=0A=
>> +	else=0A=
>> +		err =3D rpr0521_write_int_disable(data);=0A=
>> +	if (err)=0A=
>> +		dev_err(&data->client->dev, "rpr0521_pxs_drdy_set_state failed\n");=
=0A=
>> +=0A=
>> +	return err;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct iio_trigger_ops rpr0521_trigger_ops =3D {=0A=
>> +	.set_trigger_state =3D rpr0521_pxs_drdy_set_state,=0A=
>> +	.owner =3D THIS_MODULE,=0A=
>> +	};=0A=
>> +=0A=
>> +=0A=
>> +static int rpr0521_buffer_preenable(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	int err;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	err =3D rpr0521_set_power_state(data, true,=0A=
>> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +	if (err)=0A=
>> +		dev_err(&data->client->dev, "_buffer_preenable fail\n");=0A=
>> +=0A=
>> +	return err;=0A=
>> +}=0A=
>> +=0A=
>> +static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	int err;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	mutex_lock(&data->lock);=0A=
>> +	err =3D rpr0521_set_power_state(data, false,=0A=
>> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));=0A=
>> +	mutex_unlock(&data->lock);=0A=
>> +	if (err)=0A=
>> +		dev_err(&data->client->dev, "_buffer_postdisable fail\n");=0A=
>> +=0A=
>> +	return err;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops =3D {=
=0A=
>> +	.preenable =3D rpr0521_buffer_preenable,=0A=
>> +	.postenable =3D iio_triggered_buffer_postenable,=0A=
>> +	.predisable =3D iio_triggered_buffer_predisable,=0A=
>> +	.postdisable =3D rpr0521_buffer_postdisable,=0A=
>> +};=0A=
>> +=0A=
>>  static int rpr0521_get_gain(struct rpr0521_data *data, int chan,=0A=
>>  			    int *val, int *val2)=0A=
>>  {=0A=
>> @@ -473,6 +722,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_de=
v,=0A=
>>  {=0A=
>>  	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>>  	int ret;=0A=
>> +	int busy;=0A=
>>  	u8 device_mask;=0A=
>>  	__le16 raw_data;=0A=
>>  =0A=
>> @@ -481,26 +731,30 @@ static int rpr0521_read_raw(struct iio_dev *indio_=
dev,=0A=
>>  		if (chan->type !=3D IIO_INTENSITY && chan->type !=3D IIO_PROXIMITY)=
=0A=
>>  			return -EINVAL;=0A=
>>  =0A=
>> +		busy =3D iio_device_claim_direct_mode(indio_dev);=0A=
>> +		if (busy)=0A=
>> +			return -EBUSY;=0A=
>> +=0A=
>>  		device_mask =3D rpr0521_data_reg[chan->address].device_mask;=0A=
>>  =0A=
>>  		mutex_lock(&data->lock);=0A=
>>  		ret =3D rpr0521_set_power_state(data, true, device_mask);=0A=
>> -		if (ret < 0) {=0A=
>> -			mutex_unlock(&data->lock);=0A=
>> -			return ret;=0A=
>> -		}=0A=
>> +		if (ret < 0)=0A=
>> +			goto rpr0521_read_raw_out;=0A=
>>  =0A=
>>  		ret =3D regmap_bulk_read(data->regmap,=0A=
>>  				       rpr0521_data_reg[chan->address].address,=0A=
>>  				       &raw_data, sizeof(raw_data));=0A=
>>  		if (ret < 0) {=0A=
>>  			rpr0521_set_power_state(data, false, device_mask);=0A=
>> -			mutex_unlock(&data->lock);=0A=
>> -			return ret;=0A=
>> +			goto rpr0521_read_raw_out;=0A=
>>  		}=0A=
>>  =0A=
>>  		ret =3D rpr0521_set_power_state(data, false, device_mask);=0A=
>> +=0A=
>> +rpr0521_read_raw_out:=0A=
>>  		mutex_unlock(&data->lock);=0A=
>> +		iio_device_release_direct_mode(indio_dev);=0A=
>>  		if (ret < 0)=0A=
>>  			return ret;=0A=
>>  =0A=
>> @@ -617,12 +871,15 @@ static int rpr0521_init(struct rpr0521_data *data)=
=0A=
>>  		return ret;=0A=
>>  #endif=0A=
>>  =0A=
>> +	data->irq_timestamp =3D 0;=0A=
>> +=0A=
>>  	return 0;=0A=
>>  }=0A=
>>  =0A=
>>  static int rpr0521_poweroff(struct rpr0521_data *data)=0A=
>>  {=0A=
>>  	int ret;=0A=
>> +	int tmp;=0A=
>>  =0A=
>>  	ret =3D regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,=0A=
>>  				 RPR0521_MODE_ALS_MASK |=0A=
>> @@ -635,6 +892,16 @@ static int rpr0521_poweroff(struct rpr0521_data *da=
ta)=0A=
>>  	data->als_dev_en =3D false;=0A=
>>  	data->pxs_dev_en =3D false;=0A=
>>  =0A=
>> +	/*=0A=
>> +	 * Int pin keeps state after power off. Set pin to high impedance=0A=
>> +	 * mode to prevent power drain.=0A=
>> +	 */=0A=
>> +	ret =3D regmap_read(data->regmap, RPR0521_REG_INTERRUPT, &tmp);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(&data->client->dev, "Failed to reset int pin.\n");=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>>  	return 0;=0A=
>>  }=0A=
>>  =0A=
>> @@ -707,6 +974,61 @@ static int rpr0521_probe(struct i2c_client *client,=
=0A=
>>  	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS)=
;=0A=
>>  	pm_runtime_use_autosuspend(&client->dev);=0A=
>>  =0A=
>> +	/*=0A=
>> +	 * If sensor write/read is needed in _probe after _use_autosuspend,=0A=
>> +	 * sensor needs to be _resumed first using rpr0521_set_power_state().=
=0A=
>> +	 */=0A=
>> +=0A=
>> +	/* IRQ to trigger setup */=0A=
>> +	if (client->irq) {=0A=
>> +		/* Trigger0 producer setup */=0A=
>> +		data->drdy_trigger0 =3D devm_iio_trigger_alloc(=0A=
>> +			indio_dev->dev.parent,=0A=
>> +			"%s-dev%d", indio_dev->name, indio_dev->id);=0A=
>> +		if (!data->drdy_trigger0) {=0A=
>> +			ret =3D -ENOMEM;=0A=
>> +			goto err_pm_disable;=0A=
>> +		}=0A=
>> +		data->drdy_trigger0->dev.parent =3D indio_dev->dev.parent;=0A=
>> +		data->drdy_trigger0->ops =3D &rpr0521_trigger_ops;=0A=
>> +		indio_dev->available_scan_masks =3D rpr0521_available_scan_masks;=0A=
> If I was being really fussy, this has nothing much to do with the trigger=
=0A=
> (semantically anyway) so should probably just be set whatever or at very=
=0A=
> least down by where you setup the buffer.=0A=
=0A=
True. I was probably thinking (incorrectly) trigger producer/consumer as=0A=
more bound together while writing that.=0A=
=0A=
>=0A=
>> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);=0A=
>> +=0A=
>> +		/* Ties irq to trigger producer handler. */=0A=
>> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,=0A=
>> +			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,=0A=
>> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,=0A=
>> +			RPR0521_IRQ_NAME, indio_dev);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",=0A=
>> +				client->irq);=0A=
>> +			goto err_pm_disable;=0A=
>> +			}=0A=
>> +=0A=
>> +		ret =3D devm_iio_trigger_register(indio_dev->dev.parent,=0A=
>> +						data->drdy_trigger0);=0A=
>> +		if (ret) {=0A=
>> +			dev_err(&client->dev, "iio trigger register failed\n");=0A=
>> +			goto err_pm_disable;=0A=
>> +		}=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Now whole pipe from physical interrupt (irq defined by=0A=
>> +		 * devicetree to device) to trigger0 output is set up.=0A=
>> +		 */=0A=
>> +=0A=
>> +		/* Trigger consumer setup */=0A=
>> +		ret =3D devm_iio_triggered_buffer_setup(indio_dev->dev.parent,=0A=
>> +			indio_dev,=0A=
>> +			rpr0521_trigger_consumer_store_time,=0A=
>> +			rpr0521_trigger_consumer_handler,=0A=
>> +			&rpr0521_buffer_setup_ops);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");=0A=
>> +			goto err_pm_disable;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>>  	ret =3D iio_device_register(indio_dev);=0A=
>>  	if (ret)=0A=
>>  		goto err_pm_disable;=0A=
>=0A=
=0A=
