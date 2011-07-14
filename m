Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55099 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1GNKF4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 06:05:56 -0400
Message-ID: <4E1EBF82.2040408@cam.ac.uk>
Date: Thu, 14 Jul 2011 11:05:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: Randy Dunlap <rdunlap@xenotime.net>,
	driverdevel <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: staging/iio/meter/ade7753: 406:19: warning: right shift by bigger
 than source value
References: <20110713084909.8ee94a75.rdunlap@xenotime.net> <4E1EB5B2.6000105@cam.ac.uk> <4E1EB88E.30004@analog.com>
In-Reply-To: <4E1EB88E.30004@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/11 10:36, Michael Hennerich wrote:
> On 07/14/2011 11:24 AM, Jonathan Cameron wrote:
>> On 07/13/11 16:49, Randy Dunlap wrote:
>>> static ssize_t ade7753_read_frequency(struct device *dev,
>>>         struct device_attribute *attr,
>>>         char *buf)
>>> {
>>>     int ret, len = 0;
>>>     u8 t;
>>>     int sps;
>>>     ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,    &t);
>>>     if (ret)
>>>         return ret;
>>>
>>>     t = (t>>  11)&  0x3; /// HUH?
>>>
>> Excellent question. Honestly I've passed that line by several times but always whilst
>> working on something else and had no real idea of what it is actually meant to be
>> doing.  Clearly it's garbage.
> Agreed.
> 
>> So time for some datasheet trawling.  The mode register is 16 bit, so I'm guessing that
>> should have been u16 t; and ade7753_spi_read_reg_16.  I think this is a cut and paste
>> bug form the ade7754 driver where the equivalent is an 8 bit register.  Patch below.
>>
>> Michael, do you have access to test hardware for this one?  I might do a more general
>> tidy up of that driver whilst I'm here. Something fun to do before coffee ;)
> At the moment I only have HW for the ADE7758.

On second thoughts, I'm going to leave the rest of this driver be. It basically needs a rewrite
from scratch and that'll have to wait until someone wants it or is very bored.  It's full
of things like incorrect register lengths (no masking), everything comes out unsigned, whether
it is or not etc.

Given my todo list from a read through has:

squish header into file and get rid of magic number writes.
h1os and ch2os are 5 bit registers with integrators, not 8 bit registers.
pga gain is not simple or linear.
vagain is 12 bit and there is an offset of 1.
Lots of other 12 bit registers etc to handle.
IRMSOS is simple offset.

Probably 75%+ of the code is going to change having dealt with them and moved to new abi's.

We probably want to finish taking ade7758 over to new abi first so that we pin down remaining
elements, then get to work on the other meter drivers. (right now ade7758 is in a strange inbetween
world where the ring uses new abi's and the rest the old methods).

> 
>> Thanks,
>>
>> Jonathan
>>
>> Subject: [PATCH] staging:iio:meter:ade7753 should be 16 bit read not 8 bit for mode register.
>>
>> Build tested only.
>>
>> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>> Reported-by: Randy Dunlap<rdunlap@xenotime.net>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>   drivers/staging/iio/meter/ade7753.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>> index 59f47fd..482e16a 100644
>> --- a/drivers/staging/iio/meter/ade7753.c
>> +++ b/drivers/staging/iio/meter/ade7753.c
>> @@ -398,9 +398,9 @@ static ssize_t ade7753_read_frequency(struct device *dev,
>>           char *buf)
>>   {
>>       int ret, len = 0;
>> -    u8 t;
>> +    u16 t;
>>       int sps;
>> -    ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,    &t);
>> +    ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE,&t);
>>       if (ret)
>>           return ret;
>>
> 
> 

