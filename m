Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33978 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1I2UAL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2011 16:00:11 -0400
Message-ID: <4E84D03E.3010505@cam.ac.uk>
Date: Thu, 29 Sep 2011 21:08:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: guenter.roeck@ericsson.com
CC: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH V3] hwmon: ad7314 driver (ported from IIO).
References: <4E849EC4.5070603@cam.ac.uk>  <1317315004-1498-1-git-send-email-jic23@cam.ac.uk> <1317317119.3888.164.camel@groeck-laptop>
In-Reply-To: <1317317119.3888.164.camel@groeck-laptop>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/29/11 18:25, Guenter Roeck wrote:
> Hi Jonathan,
> 
> On Thu, 2011-09-29 at 12:50 -0400, Jonathan Cameron wrote:
>> Currently dropped power down mode support.
>>
>> V3:
>> Guenter's suggestions
>> - typos
>> - DIV_ROUND_NEAREST use
>> - Actually register hwmon driver.
>>
>> V2: Fixes:
>> - messed up use of cache aligned store fixed.
>> - correct output format to be milli degrees.
>> - add documentation file.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Applied to -next, with one other minor update.
> 
>> ---
>>  Documentation/hwmon/ad7314 |   25 ++++++
>>  drivers/hwmon/Kconfig      |   10 +++
>>  drivers/hwmon/Makefile     |    1 +
>>  drivers/hwmon/ad7314.c     |  185 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 221 insertions(+), 0 deletions(-)
>>
> [ ... ]
> 
>> +
>> +static const struct spi_device_id ad7314_id[] = {
>> +	{ "adt7301", adt7301 },
>> +	{ "adt7302", adt7302 },
>> +	{ "ad7314", ad7314 },
>> +	{}
>> +};
> 
> MODULE_DEVICE_TABLE(spi, ad7314_id);
Good point.  I'll kill off the IIO driver tomorrow.

Thanks,

Jonathan
 

