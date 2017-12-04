Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38344 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbdLDJCA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 04:02:00 -0500
Received: by mail-wr0-f195.google.com with SMTP id o2so16338792wro.5
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 01:01:59 -0800 (PST)
Subject: Re: [PATCH] iio: accel: bmc150: Add OF device ID table
To: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20171201111058.13483-1-javierm@redhat.com>
 <313108f3-2815-b030-4fa6-614efc31a8a9@redhat.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <4e001d0a-a510-a256-4bf4-09a16616ee34@redhat.com>
Date: Mon, 4 Dec 2017 10:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <313108f3-2815-b030-4fa6-614efc31a8a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hans,

Thanks a lot for your feedback.

On 12/04/2017 09:29 AM, Hans de Goede wrote:
> Hi,
> 
> On 01-12-17 12:10, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> The I2C device ID table entries have the .driver_data field set, but they
>> are not used in the driver so weren't set in the OF device table entries.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
>> index f85014fbaa12..8ffc308d5fd0 100644
>> --- a/drivers/iio/accel/bmc150-accel-i2c.c
>> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
>> @@ -81,9 +81,21 @@ static const struct i2c_device_id bmc150_accel_id[] = {
>>   
>>   MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
>>   
>> +static const struct of_device_id bmc150_accel_of_match[] = {
>> +	{ .compatible = "bosch,bmc150_accel" },
>> +	{ .compatible = "bosch,bmi055_accel" },
> 
> These look a bit weird, there is no reason to mirror the i2c_device_ids

The reason why I changed this is to make sure that module auto-loading will not
regress after the following patch is merged:

https://patchwork.kernel.org/patch/10089425/

It's true that only DT nodes with compatible "bosch,bma250" and "bosch,bma250e"
are used in Device Tree source files in mainline, but I didn't know if others
could be used by out-of-tree DTB.

> here and typically for devicetree / of we only list
> the chip model without some postfix like _accel.
>

Right, I also wondered about that, but then I saw that there's a DT binding for
another chips with the same model but a different function ("bosch,bmc150_magn").

Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt

So I thought it could be a convention for bosch chips.
 
> Also if you're doing this you should probably add a:
> Documentation/devicetree/bindings/iio/accel/bmc150.txt
> file documenting the compatible strings, and Cc:
> devicetree@vger.kernel.org for the next version,
> so that the devicetree maintainers get a chance to review
> this.
>

Indeed, sorry for missing that. I posted patches for several drivers so I forgot
to add the DT binding docs. My main goal was just to prevent the driver to use
the I2C device table to match the driver when the devices are registered via OF
and to have proper OF module aliases in the driver module so udev could autoload
the module.

I preferred someone familiar with the device to write the DT binding document.

>> +	{ .compatible = "bosch,bma255" },
>> +	{ .compatible = "bosch,bma250e" },
>> +	{ .compatible = "bosch,bma222e" },
>> +	{ .compatible = "bosch,bma280" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
>> +
>>   static struct i2c_driver bmc150_accel_driver = {
>>   	.driver = {
>>   		.name	= "bmc150_accel_i2c",
>> +		.of_match_table = bmc150_accel_of_match,
>>   		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
>>   		.pm	= &bmc150_accel_pm_ops,
>>   	},
>>
> 
> Otherwise looks good to me,
> 
> Regards,
> 
> Hans
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
