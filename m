Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34660 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab1ALPhY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2011 10:37:24 -0500
Message-ID: <4D2DCC69.3060200@cam.ac.uk>
Date: Wed, 12 Jan 2011 15:44:41 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Roland Stigge <stigge@antcom.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D29C64E.4040806@antcom.de> <4D2A373B.6060901@cam.ac.uk> <4D2C8348.2090606@antcom.de> <4D2CB0D7.8020802@cam.ac.uk> <4D2D77FD.50408@antcom.de> <4D2D8E86.2000204@cam.ac.uk> <20110112153413.GA21087@kroah.com>
In-Reply-To: <20110112153413.GA21087@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/11 15:34, Greg KH wrote:
> On Wed, Jan 12, 2011 at 11:20:38AM +0000, Jonathan Cameron wrote:
>> On 01/12/11 09:44, Roland Stigge wrote:
>>> Hi,
>>>
>>> On 01/11/2011 08:34 PM, Jonathan Cameron wrote:
>>>>> On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
>>>>>> Pretty clean and nice driver so it was an easy review and should
>>>>>> be trivial to fix up for a merge.
>>>>>
>>>>> Thanks for your review!
>>>>>
>>>>> I'm attaching my update. Some notes:
>>>>>
>>>>> * I used the attributes out1_* how I found it in the other DAC driver
>>>>> already available
>>>> Cool, except for the out12_raw which could easily be the 12th channel.
>>>> This has to be one of the two options suggested the other day.
>>>> May require some macro magic. IIRC the relevant macro would be.
>>>>
>>>> IIO_DEVICE_ATTR_NAMED(out1and2_raw, out1&2_raw, S_IWUSR, ... 
>>>
>>> Update attached as suggested. :-)
>>>
>>> Thanks!
>>>
>>> Roland
>>
>> Probably worth sending it to Greg KH in a new thread so that he
>> picks up on the fact that it is ready to merge. Given the volume
>> of email he probably gets I doubt he is still reading this thread!
>> No need to cc that to the list given we have this email.
> 
> Heh, I'm still here reading this :)
> 
> Roland sent me an updated version, I'll queue that up after .38-rc1 is
> out.
> 
> thanks,
> 
> greg k-h
Thanks. I'm seriously impressed at the number of mails you
must read every day :)

Jonathan
 

