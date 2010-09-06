Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:38340 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab0IFLoz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2010 07:44:55 -0400
Message-ID: <4C84D563.5040505@cam.ac.uk>
Date: Mon, 06 Sep 2010 12:49:55 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] staging:iio:adis16350 various updates and fixes
References: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk> <4C84ADBD.1080000@iis.fraunhofer.de>
In-Reply-To: <4C84ADBD.1080000@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/10 10:00, Manuel Stahl wrote:
> Am 06.09.2010 00:20, schrieb Jonathan Cameron:
>>
>> Patch 3 puts in event support.  It's complex, but then what the
>> device has some complex abilities. Still if anyone can see any
>> simplifications without breaking the interface I would definitely
>> like to hear them!
> 
>> @@ -36,3 +36,9 @@
>>
>>  #define IIO_EVENT_CODE_IN_HIGH_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a)
>>  #define IIO_EVENT_CODE_IN_LOW_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a + 32)
>> +#define IIO_EVENT_CODE_IN_HIGH_ROC(a) (IIO_EVENT_CODE_ADC_BASE  + a + 64)
>> +#define IIO_EVENT_CODE_IN_LOW_ROC(a) (IIO_EVENT_CODE_ADC_BASE  + a + 96)
>> +#define IIO_EVENT_CODE_IN_SUPPLY_HIGH (IIO_EVENT_CODE_ADC_BASE + 97)
>> +#define IIO_EVENT_CODE_IN_SUPPLY_LOW (IIO_EVENT_CODE_ADC_BASE + 98)
>> +#define IIO_EVENT_CODE_IN_SUPPLY_ROC_HIGH (IIO_EVENT_CODE_ADC_BASE + 99)
>> +#define IIO_EVENT_CODE_IN_SUPPLY_ROC_LOW (IIO_EVENT_CODE_ADC_BASE + 100)
> 
> What about putting some more structure in the event codes.
> Maybe <type_id> <channel> <event_id> each in it's own byte, where
> <type_id> is one of accel, gyro, ...
> <channel> is one of x, y, z
> <event_id> is one of high_thresh, low_thresh, ...
> maybe even a defined bit for high or low, one for thresh or roc, ...
> 
> Then we don't need a big event table, but can figure out all parts independently.
Good idea.  Lets merge this driver and any others in this round as we have it
then propose a change to something more organized that we can then apply to all in
tree drivers at the same time.  This won't effect Analog's drivers much as they
haven't made extensive use of the event interface as yet.

Perhaps we want to open this one up to more general opinions (lkml)?  It's a big
change and we always said we would keep posting them there.
> 
> Could we generate some of the event attributes in sysfs on the fly?
> Like have an attribute alarm0_input, where we can write in a list of
> channels and then only generate the limit attributes for these
> channels.
Not terribly generalizable.  We basically have the same issue we had with
devices with limited scan options (max1363). We have about half of devices
with alarms on every channel and half like this one that have a small finite number
of alarms that we can connect to a given device.  I really don't want to go
towards having two different interfaces for the two cases (like we had for
a while with the scan mode stuff).  The cost here is lots of attributes,
but I don't think it is too bad and I doubt we'll ever have any devices
that are significantly worse than this one... With the macro usage it doesn't
lead to all that much code.

Jonathan
