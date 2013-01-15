Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47199 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805Ab3AOXGh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jan 2013 18:06:37 -0500
Message-ID: <50F5E0FC.2020703@kernel.org>
Date: Tue, 15 Jan 2013 23:06:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: iio: STMicroelectronics iio drivers
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <50F5D957.6010603@kernel.org> <50F5DFDE.4050607@kernel.org>
In-Reply-To: <50F5DFDE.4050607@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/15/2013 11:01 PM, Jonathan Cameron wrote:
> On 01/15/2013 10:33 PM, Jonathan Cameron wrote:
>> On 01/15/2013 08:30 AM, Denis CIOCCA wrote:
>>> Hi Jonathan,
>>>
>>> I sent to you the new patches to fix the u8 casting and a little bugfix in the header files (functions within #ifdef).
>>> Thanks,
>>>
>>> Denis
>>>  
>>>
>> Denis,
>>
>> Just been running some build tests on this.  You need to
>> do a lot more testing of the various possible combinations
>> I think. Right now I can't build and so far I'm not entirely
>> sure why.
>>
>>   CHECK   drivers/iio/accel/st_accel_i2c.c
>> drivers/iio/accel/st_accel_i2c.c:38:9: error: undefined identifier 'st_sensors_i2c_configure'
>>   CC [M]  drivers/iio/accel/st_accel_i2c.o
>> drivers/iio/accel/st_accel_i2c.c: In function 'st_accel_i2c_probe':
>> drivers/iio/accel/st_accel_i2c.c:38:2: error: implicit declaration of function 'st_sensors_i2c_configure'
>> make[3]: *** [drivers/iio/accel/st_accel_i2c.o] Error 1
>> make[2]: *** [drivers/iio/accel] Error 2
>> make[1]: *** [drivers/iio] Error 2
>> make: *** [drivers] Error 2
>>
>> For reasons that aren't immediately clear ifdef CONFIG statements don't
>> seem to be working...
> 
> Of course, I had relevant bits compiling as modules.
> 
> I think we should rethink the module structure here so that this mess doesn't occur.
> One core driver with multiple files seems right to me.
> 
> so a make file looking something like.
> obj-$(CONFIG_IIO_ST_SENSORS_CORE) += st_sensors.o
> st_sensors-y := st_sensors_core.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_I2C) += st_sensors_i2c.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_SPI) += st_sensors_spi.o
> st_sensors-$(CONFIG_IIO_ST_SENSORS_TRIGGERED_BUFFER) += st_sensors_trigger.o st_sensors_buffer.o
> 
> and a kconfig where all by the sensors_core entry are boolean.
> 
> Similarly for the drivers.  Thus we end up with 4 modules rather than dozens and
> hopefully the build logic will work fine in all cases.
Ah, can't have two module init's so need separate i2c and spi drivers for each type
+ a core module.  Sorry, didn't think that through until I tried it out.

Anyhow, unify everything under common/st_sensors + deal with the problems different
combinations can give.

Jonathan
> 
> Also note that I think you can't have buffering for accel and not gyro etc.
> 
> 
> 
>>
>> I also suspect we have too many complex build options in here in the first
>> place. It's probably not unreasonable for instance to build in buffered support
>> if buffering is enabled in general for IIO rather than explicitly.
>>
>> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
