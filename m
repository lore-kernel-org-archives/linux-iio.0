Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35035 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785Ab1AMNtv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 08:49:51 -0500
Message-ID: <4D2F04B7.3090607@cam.ac.uk>
Date: Thu, 13 Jan 2011 13:57:11 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <roland.stigge@work-microwave.de>
CC: Roland Stigge <rst@work-microwave.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Fixed documentation
References: <1294924192-28923-1-git-send-email-rst@work-microwave.de> <1294924192-28923-3-git-send-email-rst@work-microwave.de> <4D2EFA35.4040805@work-microwave.de>
In-Reply-To: <4D2EFA35.4040805@work-microwave.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/13/11 13:12, Roland Stigge wrote:
> On 01/13/2011 02:09 PM, Roland Stigge wrote:
>> Removed reference to named versions.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
Given these are all playing with the same text, I'd be tempted
to merge them down into one patch before sending on for neatness
sake. Still, either way:

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Please send on to Greg KH.
> 
> Sorry.
> 
>> ---
>>  drivers/staging/iio/Documentation/sysfs-bus-iio |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
>> index e993fe2..8e5d8d1 100644
>> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
>> @@ -228,9 +228,7 @@ KernelVersion:	2.6.37
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>>  		Raw (unscaled, no bias etc.) output voltage for
>> -		channel Y. In special cases where the channel does not
>> -		correspond to externally available output one of the named
>> -		versions may be used. The number must always be specified and
>> +		channel Y.  The number must always be specified and
>>  		unique if the output corresponds to a single channel.
>>  
>>  What:		/sys/bus/iio/devices/deviceX/outY&Z_raw
> 
> 

