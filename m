Return-Path: <lars@metafoo.de>
Message-ID: <4F9E686F.3090703@metafoo.de>
Date: Mon, 30 Apr 2012 12:24:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: add mcp4725 I2C DAC driver
References: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net> <1335719618-28295-2-git-send-email-pmeerw@pmeerw.net> <4F9E5ED3.1010400@cam.ac.uk>
In-Reply-To: <4F9E5ED3.1010400@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/30/2012 11:43 AM, Jonathan Cameron wrote:
> On 4/29/2012 6:13 PM, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
> Mostly fine.   As I explain below you were a little unlucky in which
> driver to base
> on.  Roland's driver is lovely and clean, but is lagging a bit in
> interface terms.
> 
> Sometime soon we'll bring it up to the latest and greatest.
> 
> Sorry about that!
> 
> Anyhow, I've made some suggestions inline.  What you do with them is
> dependent on
> how much time you want to spend on this. I'm happy to see it go into
> staging/iio
> as is, but would want to move to the chan_spec stuff to take it directly
> into drivers/iio/
> without bounchign through staging.
> 
> The only vital change is updating your header locations as some of them
> have moved.
> 
> At somepoint I suspect someone will add regulator support for that
> reference voltage.
> Obviously if it is no use to you there is no reason for you to add it!
> 
> Jonathan
>> ---
>>   drivers/staging/iio/dac/mcp4725.c |  210
>> +++++++++++++++++++++++++++++++++++++
>>   drivers/staging/iio/dac/mcp4725.h |   16 +++
>>   2 files changed, 226 insertions(+)
>>   create mode 100644 drivers/staging/iio/dac/mcp4725.c
>>   create mode 100644 drivers/staging/iio/dac/mcp4725.h
>>
>> diff --git a/drivers/staging/iio/dac/mcp4725.c
>> b/drivers/staging/iio/dac/mcp4725.c
>> new file mode 100644
>> index 0000000..8603c66
>> --- /dev/null
>> +++ b/drivers/staging/iio/dac/mcp4725.c
>> @@ -0,0 +1,210 @@
>> +/*
>> + * mcp4725.c - Support for Microchip MCP4725
>> + *
>> + * Copyright (C) 2012 Peter Meerwald<pmeerw@pmeerw.net>
>> + *
>> + * Based on max517 by Roland Stigge<stigge@antcom.de>
> That's a little unfortuante as Roland's driver is prior to the change
> to doing pretty much everything through iio_chan_spec descriptions
> of the channels and read_raw and write_raw callbacks.
> The reasoning behind this is that it makes it possible for other drivers
> within the kernel to make use of the facilities the device provides.
> Still in a nice simple driver like this it won't take too long.
> 
> Without that change I'm not happy with this going into drivers/iio/dac
> but it could go straight into drivers/staging/iio/dac
>> + *
>> + * This file is subject to the terms and conditions of version 2 of
>> + * the GNU General Public License.  See the file COPYING in the main
>> + * directory of this archive for more details.
>> + *
>> + * driver for the Microchip I2C 12-bit digital-to-analog converter (DAC)
>> + * (7-bit I2C slave address 0x60, the three LSBs can be configured in
>> + * hardware)
>> + *
>> + * writing the DAC value to EEPROM is not supported
>> + */
>> +
>> +#include<linux/module.h>
>> +#include<linux/init.h>
>> +#include<linux/i2c.h>
>> +#include<linux/err.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
> You are lagging a bit.  Please test against the latest staging-next
> branch of:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> 
> Note that the core of IIO is out of staging in that tree so we are happy to
> take drivers directly into the non staging side if they have nothing messy
> or controversial.
> 

Also note that the "Streamline API function naming" patch has been merged now.
So iio_allocate_device is now iio_device_alloc, etc.

>> +
>> +static int mcp4725_remove(struct i2c_client *client)
>> +{

There is iio_device_unregister missing here. Bonus points for also fixing it in
the max517 driver.

>> +    iio_free_device(i2c_get_clientdata(client));
>> +
>> +    return 0;
>> +}
