Return-Path: <lars@metafoo.de>
Message-ID: <4F003B47.2060900@metafoo.de>
Date: Sun, 01 Jan 2012 11:53:59 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Pirmin Duss <pirmin.duss@flytec.ch>, linux-iio@vger.kernel.org,
 "J . I . Cameron" <jic23@cam.ac.uk>
Subject: Re: [Patch v2.1] Adds support for the Texas Instruments ADS1110 adc.
References: <Prayer.1.3.4.1112230809290.970@hermes-2.csi.cam.ac.uk> <1324630944-3668-1-git-send-email-pirmin.duss@flytec.ch> <4EFF699B.1000802@kernel.org>
In-Reply-To: <4EFF699B.1000802@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

> On 12/23/2011 09:02 AM, Pirmin Duss wrote:
>> +
> Why the values in this table?  I'm not seeing that field
> used anywhere...  Actually, other than address are these
> different?  If not from a kernel point of view we almost
> certainly don't care, so just have one ads1110 entry in
> here...
>> +static const struct i2c_device_id ads1110_id[] = {
>> +	{ "ads1110-ed0", 0x48 },
>> +	{ "ads1110-ed1", 0x49 },
>> +	{ "ads1110-ed2", 0x50 },
>> +	{ "ads1110-ed3", 0x51 },
>> +	{ "ads1110-ed4", 0x52 },
>> +	{ "ads1110-ed5", 0x53 },
>> +	{ "ads1110-ed6", 0x54 },
>> +	{ "ads1110-ed7", 0x55 },
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, ads1110_id);
>> +
>> +static struct i2c_driver ads1110_driver = {
>> +	.driver = {
>> +		.name = "ads1110",
>> +	},
>> +	.probe = ads1110_probe,
>> +	.remove = __devexit_p(ads1110_remove),
>> +	.id_table = ads1110_id,
>> +};
>> +
>> +static int __init ads1110_init(void)
>> +{
>> +	return i2c_add_driver(&ads1110_driver);
>> +}
>> +
>> +static void __exit ads1110_exit(void)
>> +{
>> +	i2c_del_driver(&ads1110_driver);
>> +}
>> +
>> +MODULE_AUTHOR("Duss Pirmin <pirmin.duss@flytec.ch>");
>> +MODULE_DESCRIPTION("Texas Instruments ads1110 adc driver");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +module_init(ads1110_init);
> I believe convension puts immediately after each relevant function.
>> +module_exit(ads1110_exit);
> 
> There is a whole load of boiler plate removal code from Lars-Peter,
> but I'm not entirely sure on what the status is. Either you should
> provide him with a patch that uses that stuff or if Lars-Peter
> prefers he can just add this to his conversions.
> The core support is in driver-core for next (I think - certainly
> in linux next).

The other patches which remove this kind of boilerplate from IIO drivers have
already been applied to driver-core-next. If the module_i2c_driver macro shows
up in staging-next before this patch is ready, the cleanup can be added
directly to the patch it-self, otherwise we can do it later.

> 
> See  https://lkml.org/lkml/2011/11/16/78
> 
