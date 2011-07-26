Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:46869 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1GZJJu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2011 05:09:50 -0400
Message-ID: <4E2E863C.2010706@cam.ac.uk>
Date: Tue, 26 Jul 2011 10:17:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/26/11 10:01, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-07-25:
>> Michael pointed out the issues that not having an explicit direction
>> for channels was causing and the inconsistency of the inX and outX
>> channel naming we got from hmwon.
>>
>> They are stuck with it, but we aren't, so lets fix this now.
>>
>> Interesting question is whether we reset the base units to be volts
>> whilst we are at it? (for voltage channels obviously!)
> 
> What do you mean exactly volts versus milli volts?
Make the in_voltage_scale correspond to conversion to volts instead of
millivolts as now (I think). Err. Looking at it that isn't actually documented...
oops.  I wonder which drivers actually do that and which don't.

> Or given the fact that we have some current converter currently as inX and outX -
We do?  Ouch.  In the 'interesting' drivers or in the clean ones?
> So we need to audit the datasheet to make sure we the (in|out)_(voltage|current)Y_raw
> right?
Probably need to audit everything during the move out of staging anyway. It would be far
from unusual if we found an off by 1000 error somewhere in he drivers.
> 
> 
>> Given there will be a lot of auditing and datasheet reading to do
>> that, I suggest that if we decide to do it, we leave that for when we
>> are moving drivers out of staging.
>>
>> We could roll the doc patch in with the one in the previous series to
>> reduce churn.  If they go together I'll probably do that.
>>
>> Thanks,
>>
>> Jonathan
>>
>> Jonathan Cameron (2):
>>   staging:iio: ABI rework - add in_ or out_ prefix to channnels
>>   staging:iio:Documentation sysfs-bus-iio add in and out prefixes
>>  drivers/staging/iio/Documentation/sysfs-bus-iio |  536
>> +++++++++++----
>> -------
>>  drivers/staging/iio/dac/ad5686.c                |   24 +-
>>  drivers/staging/iio/iio.h                       |   31 ++-
>>  drivers/staging/iio/industrialio-core.c         |   28 +-
>>  4 files changed, 324 insertions(+), 295 deletions(-)
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> 

