Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44604 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0JHLIa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2010 07:08:30 -0400
Message-ID: <4CAEFD00.4090008@cam.ac.uk>
Date: Fri, 08 Oct 2010 12:14:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [RFC PATCH] staging: iio: adc: ad7476 new SPI ADC driver
References: <1286462190-2002-1-git-send-email-michael.hennerich@analog.com> <4CAEEB3A.2070301@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712F35A102B4@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712F35A102B4@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/08/10 12:05, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-10-08:
>> On 10/07/10 15:36, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> New driver handling:         AD7475, AD7476, AD7477, AD7478, AD7466, AD7467,
>>> AD7468, AD7495 SPI micropower and high speed 12-/10-/8-Bit ADCs
>>
>> Hi Michael,
>>
>> Another pretty clean driver. Thanks, it makes reviewing much easier!
>> A few more suggestions this morning.
>>
>> * Might be a cache line issue with having buffer directly allocated
>>   inside the state structure. In summary the issue is that another
>>   element of the structure may be touched whilst dma is occuring into
>>   buffer. With really bad luck this can mean that the value dma'd in is
>>   wiped out with that in the cache before it is read.  If I'm missing a
>>   reason we are fine here, please tell me.
> 
> Hi Jonathan,
> 
> Thanks for your detailed review!
> 
> I remember this conversation on linux-input. It was also around my AD7877
> touch screen driver. I'm not a friend of malloc and free short junks of data
> every time we make a transfer. I'll probably add the ____cacheline_aligned thing
> to the data buffer.
That will do, or just do the allocation once and put a pointer to it in the
structure (which is what a lot of in tree drivers do).
> 
>>  This stuff always gives me a
>>   headache.
>> * Don't (I think) need scan_attrs in chip info structure.
>>   They all seem to be set to the same pointer. Guess you can probably
>>   shift the scan el code off into the ring buffer file.
> 
> Well I did it that way for future usage - I'm going to add support for more
> SPI ADC devices to that driver in future. I remove it until it is actually
> used.
cool.  Best that way or people will start assuming it's necessary even if
their drivers don't need it.
> 
>> * Is platform data vital? Probably not if using the id_table.
> 
> When using id_table together with the regulator framework, we don't need it.
> 
>> * Could use helper to alloc the pollfunc.
> 
> Will do.
> 
>> * I may be imagining issues that don't exist with the bit
>>   about whether the the contents of spi elements is guaranteed
>>   not to be eaten by the bus drivers!  Worth verifying perhaps though?
> 
> I think it is - at least I have done various drivers doing the same here.
> Without any complains yet...
Cool.
> 
> Greetings,
> Michael
> 
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

