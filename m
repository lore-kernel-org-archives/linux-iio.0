Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49337 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdCZKXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 06:23:11 -0400
Subject: Re: [PATCH v3 3/4] iio: adc: Add Maxim max9611 ADC driver
To: jacopo <jacopo@jmondi.org>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-4-git-send-email-jacopo+renesas@jmondi.org>
 <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
 <20170325171735.GA5981@w540>
 <834f03d3-36d2-9b86-6b1e-04a23d440e10@kernel.org>
 <20170326100239.GB5981@w540>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b64c24ec-b6b4-7913-e274-18e1daaee861@kernel.org>
Date: Sun, 26 Mar 2017 11:23:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170326100239.GB5981@w540>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/03/17 11:02, jacopo wrote:
> Hi Jonathan,
> 
> On Sat, Mar 25, 2017 at 05:37:52PM +0000, Jonathan Cameron wrote:
>> On 25/03/17 17:21, jacopo wrote:
>>> Hi Jonathan,
>>>     thanks for review
> 
> [snip]
> 
>>>>> +
>>>>> +	indio_dev->dev.parent	= &client->dev;
>>>>> +	indio_dev->dev.of_node	= client->dev.of_node;
>>>>> +	indio_dev->name		= client->dev.of_node->name;
>>>> What's this going to give for the name?  Name in IIO is supposed to
>>>> be an indication of the part rather than anything more explicit.
>>>> That's not easily obtained from device tree directly...
>>>>
>>>
>>> I used the one coming from device tree as otherwise device entries
>>> have the same name, and I wanted to have it to inclued the unit
>>> address (eg. adc@7c and not just adc)
>>> But from you comment I guess it's fine just adc, so I'll change this
>>> back to v1).
>> Should be the part number - so max9611 or similar..
>>
>> You can query the device node details directly if you need to identify
>> which is which.
> 
> That would not help, as I've been suggested to use a generic "adc" in
> node name property.
> 
> I can hard-code "max9611" here. That would not help with the fact that
> two chips will appear in userspace with the same name (and that's why
> I wanted to have the unit address)
This is just a convenience dating way back before device tree.  The one
thing it is still useful for is identifying when a part is different from
what the devicetree suggests - particularly when fairly generic compatibles
are in use but the device has an ID register.  In a lot of consumer
boards these chips get changed to 'newer' (i.e. cheaper) versions that
are more or less compatible without any devicetree changes (or
longer ago without it being reflected in difference in the board file).

If you want to know the device tree node it is easily available via
/sys/bus/iio/device/iio:deviceX/uevent for example.
Having just fired up a beaglebone blue I have:

root@beaglebone:/sys/bus/iio/devices/iio:device0# cat uevent 
MAJOR=243
MINOR=0
DEVNAME=iio:device0
DEVTYPE=iio_device
OF_NAME=mpu9150
OF_FULLNAME=/ocp/i2c@4819c000/mpu9150@68
OF_COMPATIBLE_0=invensense,mpu9150
OF_COMPATIBLE_N=1
root@beaglebone:/sys/bus/iio/devices/iio:device0# cat name
mpu9150

Which is actually lying as it's a 9250 - my fault in this case as I
wrote the relevant bit of the device tree and it's not mainlined yet.

root@beaglebone:/sys/bus/iio/devices/iio:device1# cat uevent 
MAJOR=243
MINOR=1
DEVNAME=iio:device1
DEVTYPE=iio_device
OF_NAME=bmp280
OF_FULLNAME=/ocp/i2c@4819c000/bmp280@76
OF_COMPATIBLE_0=bosch,bmp280
OF_COMPATIBLE_N=1
root@beaglebone:/sys/bus/iio/devices/iio:device1# cat name
bmp280

root@beaglebone:/sys/bus/iio/devices/iio:device2# cat uevent 
MAJOR=243
MINOR=2
DEVNAME=iio:device2
DEVTYPE=iio_device
OF_NAME=adc
OF_FULLNAME=/ocp/tscadc@44e0d000/adc
OF_COMPATIBLE_0=ti,am3359-adc
OF_COMPATIBLE_N=1
root@beaglebone:/sys/bus/iio/devices/iio:device2# cat name
TI-am335x-adc

root@beaglebone:/sys/bus/iio/devices/iio:device3# cat uevent 
MAJOR=243
MINOR=3
DEVNAME=iio:device3
DEVTYPE=iio_device
OF_NAME=ax8975
OF_FULLNAME=/ocp/i2c@4819c000/mpu9150@68/i2c-gate/ax8975@c
OF_COMPATIBLE_0=ak,ak8975
OF_COMPATIBLE_N=1
root@beaglebone:/sys/bus/iio/devices/iio:device3# cat name
ak8975

So all the info you could possibly want in in userspace is
available without using the name attribute - even down to
the complex nature of the path to that ak8975.

At various points in the past submitters have put drivers
in with the devicetree node or other bus related naming
and we haven't always picked up on it in review.
As we can't break userspace ABI not much we can do about it
now unfortunately. 

Mind you, this has reminded me that I need to fix that mpu9150
case above before anyone mainlines the devicetree for the blue.

> 
> Otherwise I can do what Quentin is suggesting in his review of
> AST2400: have different name for each compatible entry, so that this
> will appear as either max9611 or max9612 in userspace
> 
That's ideal. It should be as specific as we can make it.
> Thanks
>    j
> 
>>>
>>> Thanks
>>>   j
>>>
>>>>> +	indio_dev->modes	= INDIO_DIRECT_MODE;
>>>>> +	indio_dev->info		= &indio_info;
>>>>> +	indio_dev->channels	= max9611_channels;
>>>>> +	indio_dev->num_channels	= ARRAY_SIZE(max9611_channels);
>>>>> +
>>>>> +	return devm_iio_device_register(&client->dev, indio_dev);
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id max9611_of_table[] = {
>>>>> +	{.compatible = "maxim,max9611"},
>>>>> +	{.compatible = "maxim,max9612"},
>>>>> +	{ },
>>>>> +};
>>>>> +
>>>>> +MODULE_DEVICE_TABLE(of, max9611_of_table);
>>>>> +
>>>>> +static struct i2c_driver max9611_driver = {
>>>>> +	.driver = {
>>>>> +		   .name = DRIVER_NAME,
>>>>> +		   .owner = THIS_MODULE,
>>>>> +		   .of_match_table = max9611_of_table,
>>>>> +	},
>>>>> +	.probe = max9611_probe,
>>>>> +};
>>>>> +module_i2c_driver(max9611_driver);
>>>>> +
>>>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
>>>>> +MODULE_DESCRIPTION("Maxim max9611/12 current sense amplifier with 12bit ADC");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>>
>>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

