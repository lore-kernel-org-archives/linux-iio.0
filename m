Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48859 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab1BUQJx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2011 11:09:53 -0500
Message-ID: <4D628E66.5090900@cam.ac.uk>
Date: Mon, 21 Feb 2011 16:10:14 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: "'chinyeow.sim.xt@renesas.com'" <chinyeow.sim.xt@renesas.com>,
	"gregkh@suse.de" <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com> <643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/11 20:49, Andrew Chew wrote:
>> As some of the platform not support irq_to_gpio, we pass gpio port
>> by platform data.
> 
> Looks good to me.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
Firstly, please cc linux-iio for patches effecting iio drivers.

Hmm.. It's a bit of a pain that i2c devices don't take platform resources
or we could avoid doing this entirely. I have a vague recollection of this
being suggested in the past, but never happening (might have been for spi
rather than i2c though...) Jean, can you comment on this?

Dmitry isn't going to want that header in the linux/input directory.

What we've done for other drivers that need simple platform data like this
is to use a pointer to an int rather than creating a specific structure for
passing the data. It's clunky but politically a lot simpler than having a
driver with parts in staging and parts not (which won't happen). There were
quite a few cases of this that we had to clean up before the subsystem was
acceptable for staging in the first place.

For more complex cases, we have cases that really need platform data
and have a chunk of of their local header in the tree that is commented to be
moved to linux/iio/ when that exists and people are just cutting
that out as necessary for their local development trees.  We could
add a directory under drivers/staging/iio for these to make this
even clearer.


This whole patch highlights a point I'd originally missed when
reviewing this driver.  The irq is never used as an actual interrupt and
hence should never have been passed like that in the first place.

Andrew, would you be happy with a patch that removed the miss use of the
irq field entirely in favour of Tony's platform data route (with a simple
int rather than the structure)?  The interrupt passing would
go back in if anyone ever added interrupt handling to this driver.

Jonathan

> 
>> Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
>> ---
>>  drivers/staging/iio/magnetometer/ak8975.c |    8 +++++++-
>>  include/linux/input/ak8975.h              |   20 ++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 1 deletions(-)
>>  create mode 100644 include/linux/input/ak8975.h
>>
>> diff --git a/drivers/staging/iio/magnetometer/ak8975.c 
>> b/drivers/staging/iio/magnetometer/ak8975.c
>> index 420f206..80c0f41 100644
>> --- a/drivers/staging/iio/magnetometer/ak8975.c
>> +++ b/drivers/staging/iio/magnetometer/ak8975.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/delay.h>
>>  
>>  #include <linux/gpio.h>
>> +#include <linux/input/ak8975.h>
>>  
>>  #include "../iio.h"
>>  #include "magnet.h"
>> @@ -435,6 +436,7 @@ static int ak8975_probe(struct i2c_client *client,
>>  			const struct i2c_device_id *id)
>>  {
>>  	struct ak8975_data *data;
>> +	struct ak8975_platform_data *pdata;
>>  	int err;
>>  
>>  	/* Allocate our device context. */
>> @@ -452,7 +454,11 @@ static int ak8975_probe(struct 
>> i2c_client *client,
>>  
>>  	/* Grab and set up the supplied GPIO. */
>>  	data->eoc_irq = client->irq;
>> -	data->eoc_gpio = irq_to_gpio(client->irq);
>> +	pdata = client->dev.platform_data;
>> +	if (pdata)
>> +		data->eoc_gpio = pdata->gpio;
>> +	else
>> +		data->eoc_gpio = irq_to_gpio(client->irq);
>>  
>>  	if (!data->eoc_gpio) {
>>  		dev_err(&client->dev, "failed, no valid GPIO\n");
>> diff --git a/include/linux/input/ak8975.h 
>> b/include/linux/input/ak8975.h
>> new file mode 100644
>> index 0000000..25d41eb
>> --- /dev/null
>> +++ b/include/linux/input/ak8975.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * ak8975 platform support
>> + *
>> + * Copyright (C) 2010 Renesas Solutions Corp.
>> + *
>> + * Author: Tony SIM <chinyeow.sim.xt@renesas.com>
>> + *
>> + * This program is free software; you can redistribute it 
>> and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _AK8975_H
>> +#define _AK8975_H
>> +
>> +struct ak8975_platform_data {
>> +	int gpio;
>> +};
>> +
>> +#endif
>> -- 
>> 1.7.2.3
>>
>>
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------

