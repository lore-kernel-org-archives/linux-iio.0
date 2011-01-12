Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:37517 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab1ALLNV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2011 06:13:21 -0500
Message-ID: <4D2D8E86.2000204@cam.ac.uk>
Date: Wed, 12 Jan 2011 11:20:38 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D29C64E.4040806@antcom.de> <4D2A373B.6060901@cam.ac.uk> <4D2C8348.2090606@antcom.de> <4D2CB0D7.8020802@cam.ac.uk> <4D2D77FD.50408@antcom.de>
In-Reply-To: <4D2D77FD.50408@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/11 09:44, Roland Stigge wrote:
> Hi,
> 
> On 01/11/2011 08:34 PM, Jonathan Cameron wrote:
>>> On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
>>>> Pretty clean and nice driver so it was an easy review and should
>>>> be trivial to fix up for a merge.
>>>
>>> Thanks for your review!
>>>
>>> I'm attaching my update. Some notes:
>>>
>>> * I used the attributes out1_* how I found it in the other DAC driver
>>> already available
>> Cool, except for the out12_raw which could easily be the 12th channel.
>> This has to be one of the two options suggested the other day.
>> May require some macro magic. IIRC the relevant macro would be.
>>
>> IIO_DEVICE_ATTR_NAMED(out1and2_raw, out1&2_raw, S_IWUSR, ... 
> 
> Update attached as suggested. :-)
> 
> Thanks!
> 
> Roland

Probably worth sending it to Greg KH in a new thread so that he
picks up on the fact that it is ready to merge. Given the volume
of email he probably gets I doubt he is still reading this thread!
No need to cc that to the list given we have this email.

Thanks,

Jonathan
