Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:45151 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945Ab3AaTMt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 14:12:49 -0500
Message-ID: <510AC28D.3050603@metafoo.de>
Date: Thu, 31 Jan 2013 20:14:21 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: Re: [PATCH V3] iio: gyro: Add itg3200
References: <201301311254.49626.manuel.stahl@iis.fraunhofer.de> <1359634652-25868-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <510A8BF6.2070701@metafoo.de> <201301311937.10124.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201301311937.10124.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 07:37 PM, Manuel Stahl wrote:
> Am Donnerstag, 31. Januar 2013, 16:21:26 schrieb Lars-Peter Clausen:
>> On 01/31/2013 01:17 PM, Manuel Stahl wrote:
>>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>
>> Having at least a short commit message wouldn't hurt. E.g. something along
>> the lines of: "This patch adds support for the InvenSense itg3200. The
>> itg3200 is a three-axis gyro and ..."
> 
> OK, no problem.
>  
>> I get one build warning:
>> 	CC      drivers/iio/gyro/itg3200_core.o
>> 	drivers/iio/gyro/itg3200_core.c:302: warning: initialization from
>> 	incompatible pointer type
> 
> [...]
> 
>>> +static ssize_t itg3200_read_raw(struct iio_dev *indio_dev,
>>
>> This triggers the build warning, the return type should be int.
>>
>>> +		const struct iio_chan_spec *chan,
>>> +		int *val, int *val2, long info)
>>> +{
>>> +	ssize_t ret = 0;
>>
>> What I meant with the comment in my previous mail was make ret int.
> 
> Sorry, I should do more exhaustive tests...
> 
> [...]
> 
>>> +static int itg3200_probe(struct i2c_client *client,
>>> +		const struct i2c_device_id *id)
>>> +{
>>> +	int ret;
>>> +	struct itg3200 *st;
>>> +	struct iio_dev *indio_dev;
>>> +	const unsigned long avail_scan_masks[] = { 0xffffffff, 0x0 };
>>
>> This needs to be static. Right now it is on the stack and well gone after
>> probe has been run.
> 
> Is it OK to make it static inside itg3200_probe() or should it be global?
> 

Does not really matter, but I guess I'd make it global (and add the itg3200
prefix to the variable's name).

- Lars

