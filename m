Return-Path: <SRS0=vzLs=47=fi.rohmeurope.com=prvs=6318ba554e=Mikko.Koivunen@kernel.org>
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, Daniel Baluta
	<daniel.baluta@nxp.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] iio: light: rpr0521 triggered buffer
Date: Thu, 25 May 2017 13:53:03 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8F7991C83@WILL-MAIL002.REu.RohmEu.com>
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-10-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <40f34b95-b608-93d0-e85b-cd7b5b89b948@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On 21.5.2017 14:34, Jonathan Cameron wrote:=0A=
> On 18/05/17 13:12, Mikko Koivunen wrote:=0A=
>> Set up and use triggered buffer if there is irq defined for device in=0A=
>> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.=
=0A=
>> Trigger consumer reads rpr0521 data to scan buffer.=0A=
>> Depends on previous commits of _scale and _offset.=0A=
>>=0A=
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>=0A=
> Hi Mikko,=0A=
>=0A=
> A few last bits in the final patch of the series.  See inline.=0A=
> The IRQ_NONE one might trigger some nasty issues and ultimately=0A=
> disable the interrupt. =0A=
=0A=
Do you have any pointer for more information about that?=0A=
=0A=
> However, it is the right option if we know=0A=
> it's not our interrupt...=0A=
=0A=
Ok, agree. It's also mandatory for shared interrupt -> changing.=0A=
=0A=
> Jonathan=0A=
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
>>   - Since drdy happens only on measurement data ready and register write=
s=0A=
>>     are cached, the trigger producer doesn't care of suspend/resume stat=
e.=0A=
>> available_scan_masks added=0A=
>> indent fix=0A=
>> checkpatch.pl OK=0A=
>> Lightly re-tested on LeMaker HiKey with AOSP7.1 kernel 4.4.=0A=
>> Builds ok with torvalds/linux feb 27.=0A=
>>=0A=
>>   drivers/iio/light/rpr0521.c |  294 +++++++++++++++++++++++++++++++++++=
+++++++-=0A=
>>   1 file changed, 291 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c=
=0A=
>> index 9d0c2e8..1ef6060 100644=0A=
>> --- a/drivers/iio/light/rpr0521.c=0A=
>> +++ b/drivers/iio/light/rpr0521.c=0A=
>> @@ -9,7 +9,7 @@=0A=
>>    *=0A=
>>    * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).=0A=
>>    *=0A=
>> - * TODO: illuminance channel, buffer=0A=
>> + * TODO: illuminance channel=0A=
>>    */=0A=
>>   =0A=
>>   #include <linux/module.h>=0A=
>> @@ -20,6 +20,10 @@=0A=
>>   #include <linux/acpi.h>=0A=
>>   =0A=
>>   #include <linux/iio/iio.h>=0A=
>> +#include <linux/iio/buffer.h>=0A=
>> +#include <linux/iio/trigger.h>=0A=
>> +#include <linux/iio/trigger_consumer.h>=0A=
>> +#include <linux/iio/triggered_buffer.h>=0A=
>>   #include <linux/iio/sysfs.h>=0A=
>>   #include <linux/pm_runtime.h>=0A=
>>   =0A=
>> @@ -30,6 +34,7 @@=0A=
>>   #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */=0A=
>>   #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */=0A=
>>   #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */=0A=
>> +#define RPR0521_REG_INTERRUPT		0x4A=0A=
>>   #define RPR0521_REG_PS_OFFSET_LSB	0x53=0A=
>>   #define RPR0521_REG_ID			0x92=0A=
>>   =0A=
>> @@ -42,16 +47,29 @@=0A=
>>   #define RPR0521_ALS_DATA1_GAIN_SHIFT	2=0A=
>>   #define RPR0521_PXS_GAIN_MASK		GENMASK(5, 4)=0A=
>>   #define RPR0521_PXS_GAIN_SHIFT		4=0A=
>> +#define RPR0521_PXS_PERSISTENCE_MASK	GENMASK(3, 0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK	BIT(0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK	BIT(1)=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK	BIT(3)=0A=
>>   =0A=
>>   #define RPR0521_MODE_ALS_ENABLE		BIT(7)=0A=
>>   #define RPR0521_MODE_ALS_DISABLE	0x00=0A=
>>   #define RPR0521_MODE_PXS_ENABLE		BIT(6)=0A=
>>   #define RPR0521_MODE_PXS_DISABLE	0x00=0A=
>> +#define RPR0521_PXS_PERSISTENCE_DRDY	0x00=0A=
>> +=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE	BIT(0)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE	0x00=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE	BIT(1)=0A=
>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE	0x00=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE	BIT(3)=0A=
>> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE	0x00=0A=
>>   =0A=
>>   #define RPR0521_MANUFACT_ID		0xE0=0A=
>>   #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */=
=0A=
>>   =0A=
>>   #define RPR0521_DRV_NAME		"RPR0521"=0A=
>> +#define RPR0521_IRQ_NAME		"rpr0521_event"=0A=
>>   #define RPR0521_REGMAP_NAME		"rpr0521_regmap"=0A=
>>   =0A=
>>   #define RPR0521_SLEEP_DELAY_MS	2000=0A=
>> @@ -167,6 +185,9 @@ struct rpr0521_data {=0A=
>>   	bool als_dev_en;=0A=
>>   	bool pxs_dev_en;=0A=
>>   =0A=
>> +	struct iio_trigger *drdy_trigger0;=0A=
>> +	bool drdy_trigger_on;=0A=
>> +=0A=
>>   	/* optimize runtime pm ops - enable/disable device only if needed */=
=0A=
>>   	bool als_ps_need_en;=0A=
>>   	bool pxs_ps_need_en;=0A=
>> @@ -196,6 +217,19 @@ static const struct attribute_group rpr0521_attribu=
te_group =3D {=0A=
>>   	.attrs =3D rpr0521_attributes,=0A=
>>   };=0A=
>>   =0A=
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
>>   static const struct iio_chan_spec rpr0521_channels[] =3D {=0A=
>>   	{=0A=
>>   		.type =3D IIO_PROXIMITY,=0A=
>> @@ -204,6 +238,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>   			BIT(IIO_CHAN_INFO_OFFSET) |=0A=
>>   			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>   		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_PXS,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>   	},=0A=
>>   	{=0A=
>>   		.type =3D IIO_INTENSITY,=0A=
>> @@ -213,6 +254,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>   		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=0A=
>>   			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>   		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_BOTH,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>   	},=0A=
>>   	{=0A=
>>   		.type =3D IIO_INTENSITY,=0A=
>> @@ -222,6 +270,13 @@ static const struct iio_chan_spec rpr0521_channels[=
] =3D {=0A=
>>   		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=0A=
>>   			BIT(IIO_CHAN_INFO_SCALE),=0A=
>>   		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),=0A=
>> +		.scan_index =3D RPR0521_CHAN_INDEX_IR,=0A=
>> +		.scan_type =3D {=0A=
>> +			.sign =3D 'u',=0A=
>> +			.realbits =3D 16,=0A=
>> +			.storagebits =3D 16,=0A=
>> +			.endianness =3D IIO_LE,=0A=
>> +		},=0A=
>>   	},=0A=
>>   };=0A=
>>   =0A=
>> @@ -330,6 +385,150 @@ static int rpr0521_set_power_state(struct rpr0521_=
data *data, bool on,=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> +/* IRQ to trigger handler */=0A=
>> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)=0A=
>> +{=0A=
>> +	struct iio_dev *indio_dev =3D private;=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Sometimes static on floating (hi-z) interrupt line causes interrupt=
.=0A=
>> +	 * Notify trigger0 consumers/subscribers only if trigger has been=0A=
>> +	 * enabled. This is to prevent i2c writes to sensor which is actually=
=0A=
>> +	 * powered off.=0A=
>> +	 */=0A=
>> +	if (data->drdy_trigger_on)=0A=
>> +		iio_trigger_poll(data->drdy_trigger0);=0A=
>> +=0A=
> If this isn't our interrupt we should really be returning IRQ_NONE=0A=
> rather than IRQ_HANDLED.  That will trigger unhandled interrupt=0A=
> messages etc in the log...=0A=
=0A=
Ack. Adding shared irq support.=0A=
=0A=
>> +	return IRQ_HANDLED;=0A=
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
>> +	err =3D regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,=0A=
>> +		&buffer,=0A=
>> +		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */=0A=
>> +	if (!err)=0A=
>> +		iio_push_to_buffers_with_timestamp(indio_dev,=0A=
>> +						   buffer, pf->timestamp);=0A=
>> +	else=0A=
>> +		dev_err(&data->client->dev,=0A=
>> +			"Trigger consumer can't read from sensor.\n");=0A=
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
>> +	else=0A=
>> +		data->drdy_trigger_on =3D enable_drdy;=0A=
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
>>   static int rpr0521_get_gain(struct rpr0521_data *data, int chan,=0A=
>>   			    int *val, int *val2)=0A=
>>   {=0A=
>> @@ -481,6 +680,9 @@ static int rpr0521_read_raw(struct iio_dev *indio_de=
v,=0A=
>>   		if (chan->type !=3D IIO_INTENSITY && chan->type !=3D IIO_PROXIMITY)=
=0A=
>>   			return -EINVAL;=0A=
>>   =0A=
>> +		if (iio_buffer_enabled(indio_dev))=0A=
>> +			return -EBUSY;=0A=
> This is racy.  You need to actually prevent a transition to buffered read=
ing.=0A=
> That means you want to use iio_claim_direct etc to hold the lock over sta=
te=0A=
> transitions whilst the read is going on.=0A=
>=0A=
> (sorry I missed this in earlier versions!)=0A=
=0A=
Oh, you are nudging me away from the 4.4.=0A=
Np. I agree on issue and fix. However iio_device_claim_direct_mode() is=0A=
available only from 4.7 onward and I'm working and testing on top of 4.4.=
=0A=
=0A=
Since buffer preenable has mutex for powering on, I could mostly (not=0A=
fully) tackle this by extending mutex below to include this test. Single=0A=
read happening while in iio_buffer_store_enable() between preenable and=0A=
"currentmode =3D" would cause sensor to power down and not wake up on next=
=0A=
system suspend-resume.=0A=
=0A=
I can't figure out any other 4.4 fix than making similar mutex in driver=0A=
as in iio_device_claim_direct_mode(). So maybe do commit=0A=
without+separate fix commit? I can do second commit and build it but not=0A=
test it currently.=0A=
=0A=
>> +=0A=
>>   		device_mask =3D rpr0521_data_reg[chan->address].device_mask;=0A=
>>   =0A=
>>   		mutex_lock(&data->lock);=0A=
>> @@ -623,6 +825,7 @@ static int rpr0521_init(struct rpr0521_data *data)=
=0A=
>>   static int rpr0521_poweroff(struct rpr0521_data *data)=0A=
>>   {=0A=
>>   	int ret;=0A=
>> +	int tmp;=0A=
>>   =0A=
>>   	ret =3D regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,=0A=
>>   				 RPR0521_MODE_ALS_MASK |=0A=
>> @@ -635,6 +838,16 @@ static int rpr0521_poweroff(struct rpr0521_data *da=
ta)=0A=
>>   	data->als_dev_en =3D false;=0A=
>>   	data->pxs_dev_en =3D false;=0A=
>>   =0A=
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
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> @@ -707,12 +920,78 @@ static int rpr0521_probe(struct i2c_client *client=
,=0A=
>>   	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS=
);=0A=
>>   	pm_runtime_use_autosuspend(&client->dev);=0A=
>>   =0A=
>> +	/*=0A=
>> +	 * If sensor write/read  is needed in _probe after _use_autosuspend,=
=0A=
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
>> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);=0A=
>> +=0A=
>> +		/* Ties irq to trigger producer handler. */=0A=
>> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,=0A=
>> +			rpr0521_drdy_irq_handler,=0A=
>> +			NULL,=0A=
>> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,=0A=
>> +			RPR0521_IRQ_NAME,=0A=
>> +			indio_dev);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",=0A=
>> +				client->irq);=0A=
>> +			goto err_pm_disable;=0A=
>> +			}=0A=
>> +=0A=
>> +		ret =3D iio_trigger_register(data->drdy_trigger0);=0A=
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
>> +		ret =3D iio_triggered_buffer_setup(indio_dev,=0A=
>> +			&iio_pollfunc_store_time,=0A=
>> +			rpr0521_trigger_consumer_handler,=0A=
>> +			&rpr0521_buffer_setup_ops);=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");=0A=
>> +			/* Count on devm to free_irq */=0A=
>> +			goto err_iio_trigger_unregister;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>>   	ret =3D iio_device_register(indio_dev);=0A=
>>   	if (ret)=0A=
>> -		goto err_pm_disable;=0A=
>> +		goto err_iio_triggered_buffer_cleanup;=0A=
>> +=0A=
>> +	if (client->irq) {=0A=
>> +		/* Set trigger0 as current trigger (and inc refcount) */=0A=
>> +		indio_dev->trig =3D iio_trigger_get(data->drdy_trigger0);=0A=
>> +	}=0A=
>>   =0A=
>>   	return 0;=0A=
>>   =0A=
>> +err_iio_triggered_buffer_cleanup:=0A=
>> +	iio_triggered_buffer_cleanup(indio_dev);=0A=
>> +err_iio_trigger_unregister:=0A=
>> +	if (data->drdy_trigger0)=0A=
>> +		iio_trigger_unregister(data->drdy_trigger0);=0A=
>>   err_pm_disable:=0A=
>>   	pm_runtime_disable(&client->dev);=0A=
>>   	pm_runtime_set_suspended(&client->dev);=0A=
>> @@ -726,14 +1005,23 @@ err_poweroff:=0A=
>>   static int rpr0521_remove(struct i2c_client *client)=0A=
>>   {=0A=
>>   	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);=0A=
>> +	struct rpr0521_data *data =3D iio_priv(indio_dev);=0A=
>> +=0A=
>> +	if (indio_dev->trig)=0A=
>> +		iio_trigger_put(indio_dev->trig);=0A=
> There is not guarantee this is the same trigger as that=0A=
> provided by this driver.=0A=
=0A=
It doesn't matter. In that case iio_trigger_write_current() has put the=0A=
default one and has get the new one. Then we just put the new one here.=0A=
=0A=
> So strangely the right option here=0A=
> is to get it as you have done which will set up the default=0A=
> to be sane, but to allow userspace to be responsible for the=0A=
> put by clearing current_trigger if it wants to remove the=0A=
> driver.  As a general rule I'm fairly anti default triggers=0A=
> but I do appreciate they are sometimes all that makes sense...=0A=
=0A=
If defaults are not good habit, then I think it should be fine to not=0A=
get default trigger just and rely on userspace getting it when needed.=0A=
Didn't test it yet, but I think that should be fine with IIO_HAL. Even=0A=
in that case I would _put() it in remove().=0A=
=0A=
> However, if that is the case, then you should have the various=0A=
> validation callbacks provided to ensure this trigger is used=0A=
> only for this device and the device can only use this trigger.=0A=
>=0A=
> You 'could' set indio_dev->trig_readonly which will block=0A=
> out userspace changes...  Perhaps that's what you want to=0A=
> do here.=0A=
>>   =0A=
>>   	iio_device_unregister(indio_dev);=0A=
>>   =0A=
>> +	iio_triggered_buffer_cleanup(indio_dev);=0A=
>> +=0A=
>> +	if (data->drdy_trigger0)=0A=
>> +		iio_trigger_unregister(data->drdy_trigger0);=0A=
>> +=0A=
>>   	pm_runtime_disable(&client->dev);=0A=
>>   	pm_runtime_set_suspended(&client->dev);=0A=
>>   	pm_runtime_put_noidle(&client->dev);=0A=
>>   =0A=
>> -	rpr0521_poweroff(iio_priv(indio_dev));=0A=
>> +	rpr0521_poweroff(data);=0A=
>>   =0A=
>>   	return 0;=0A=
>>   }=0A=
>>=0A=
=0A=
