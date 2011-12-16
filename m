Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-03.vtx.ch ([194.38.175.92]:37681 "EHLO smtp-03.vtx.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab1LPJmm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 16 Dec 2011 04:42:42 -0500
Message-ID: <4EEB12A8.3030504@flytec.ch>
Date: Fri, 16 Dec 2011 10:43:04 +0100
From: Duss Pirmin <pirmin.duss@flytec.ch>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Add support for ads1110
References: <4EE9FB74.6010402@flytec.ch> <4EEA1B54.5060607@metafoo.de>
In-Reply-To: <4EEA1B54.5060607@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

Am 12/15/2011 05:07 PM, schrieb Lars-Peter Clausen:
> On 12/15/2011 02:51 PM, Duss Pirmin wrote:
> Hi,
>
> It looks like your driver is based on a rather old version of IIO. Please
> try to always submit IIO patches against Gregs staging-next[1] tree.
I wrote it against 3.0.4, as this is the Kernel of the target we us it 
for. I will adapt it to staging-next.
>
> Also it looks like your mail program messed up the patch. (Replaced tabs
> with space, inserted line breaks).
I will check the settings of my Thunderbird.
>> +
>> +struct ads1110_conversion_mode {
>> +  char *name;
>> +  u8 reg_cfg;
>> +};
>> +
>> +static struct ads1110_conversion_mode
>> +ads1110_conv_mode_table[ADS1110_MAX_CONV_MODE] = {
>> +  { "continuous-conversion", 0 },
>> +  { "single-conversion", 1 },
>> +};
> This should probably not user controllable. You probably want to do a single
> conversion when reading from sysfs and use continuous conversion when using
> a triggered buffer.
>> +static int ads1110_i2c_read_config(struct ads1110_chip_info *chip, u8 *data)
>> +{
>> +    struct i2c_client *client = chip->client;
>> +    int ret = 0;
>> +    u8 tmp[3];        // read three bytes ; first two are data third is the
>> config
> Please use C style comments.
Ok.
>> +
>> +static IIO_DEV_ATTR_START_CONVERSION(S_IWUSR,
>> +        NULL,
>> +        ads1110_store_start_conversion);
> This should probably not be a sysfs attribute, but be set on demand.
>> +
>> +/*
>> + * attributes for ysfs
>> + */
>> +
>> +static struct attribute *ads1110_attributes[] = {
>> +&iio_dev_attr_available_conversion_modes.dev_attr.attr,
>> +&iio_dev_attr_available_data_rates.dev_attr.attr,
>> +&iio_dev_attr_available_gains.dev_attr.attr,
>> +&iio_dev_attr_value.dev_attr.attr,
>> +&iio_dev_attr_conversion_mode.dev_attr.attr,
>> +&iio_dev_attr_data_rate.dev_attr.attr,
>> +&iio_dev_attr_gain.dev_attr.attr,
>> +&iio_dev_attr_start_conversion.dev_attr.attr,
>> +  NULL,
>> +};
> Please use channel_spec. Most of the attributes can probably be expresses
> through it. For those which can not please take a look at
> Documentation/sysfs-bus-iio and see which already existing attribute names
> match your use case. E.g. your "data_rate" should probably be
> "sampling_frequency".
Ok.
>> +
>> +static const struct iio_info ads1110_info = {
>> +  .attrs =&ads1110_attribute_group,
>> +  .num_interrupt_lines = 1,
>> +  .event_attrs =&ads1110_event_attribute_group,
>> +  .driver_module = THIS_MODULE,
>> +};
>> +
>> +/*
>> + * device probe and remove
>> + */
>> +
>> +static int __devinit ads1110_probe(struct i2c_client *client,
>> +        const struct i2c_device_id *id)
>> +{
>> +    int ret = 0, regdone = 0;
>> +    struct ads1110_chip_info *chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>> +    if (chip == NULL) {
>> +        ret = -ENOMEM;
>> +        goto error_ret;
>> +    }
>> +
>> +    // this is only used for device removal purposes
>> +    i2c_set_clientdata(client, chip);
>> +
>> +    chip->client = client;
>> +
>> +    chip->indio_dev = iio_allocate_device(0);
>> +    if (chip->indio_dev == NULL) {
>> +        ret = -ENOMEM;
>> +        goto error_free_chip;
>> +    }
>> +
> Make your ads1110_chip_info the private part of the iio_device.
> indio_dev = iio_allocate_device(sizeof(*chip));
> chip = iio_priv(indio_dev);
Copied and adapted this code from ad7150.c in 3.0.4, will change this.
>> +error_free_dev:
>> +    if (regdone)
>> +        iio_device_unregister(chip->indio_dev);
>> +    else
>> +        iio_free_device(chip->indio_dev);
> You have to call both device_unregister and free_device with the current
> version of IIO.
OK.
>> +static const struct i2c_device_id ads1110_id[] = {
>> +    { "ads1110-ed0", 0x48 },
>> +    { "ads1110-ed1", 0x49 },
>> +    { "ads1110-ed2", 0x50 },
>> +    { "ads1110-ed3", 0x51 },
>> +    { "ads1110-ed4", 0x52 },
>> +    { "ads1110-ed5", 0x53 },
>> +    { "ads1110-ed6", 0x54 },
>> +    { "ads1110-ed7", 0x55 },
> Are these really different parts, or is it just the same part with a
> different I2C address controlled by some external pins?
Each is an different part. no pins to control the I2C address.


