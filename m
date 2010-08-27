Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:48905 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab0H0PFK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Aug 2010 11:05:10 -0400
Message-ID: <4C77D52A.6090606@cam.ac.uk>
Date: Fri, 27 Aug 2010 16:09:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "Song, Barry" <Barry.Song@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [IIO] Cleanup userspace
References: <4C777E16.6040708@iis.fraunhofer.de> <4C77AC01.3090204@cam.ac.uk> <4C77B68B.4060805@iis.fraunhofer.de> <4C77CA90.2030806@cam.ac.uk> <4C77CC28.6020604@iis.fraunhofer.de>
In-Reply-To: <4C77CC28.6020604@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>>
>> Agreed. These ought to be in there and will be needed
>>
>>> To be compatible with future extensions we could have:
>>>    |- /sys/bus/iio/ii0/buffer0/scan_elements/
>>>       |- accel_x:en    (0 or 1)
>>>       |- accel_x:type  (i.e. s14/16, see *)
>>>       |- accel_x:index
>>>
>>
>>> * s14/16 means signed 14 bits, stored in 16 bits, right aligned. If
>>> it's left aligned we can just modify the scale attribute and give the
>>> 16 bit interpretation in <channel>:raw.
>> That is quite a neat way of doing it though I'm not sure 'type' is the
>> ideal name.  My immediate thought is that type would be 'acceleration'!
>> We definitely want this on list.  We'd also want to drop the precision
>> attribute as that will just confuse things.
> 
> I'm open for any other name.
Lets see if anyone else has a suggestion...
> 
>>> I don't like the index prefix any more, even I had proposed this
>>> once. This is because for devices with more than 10 channels
>>> (adis16400) we have to get a leading 0 in the name to maintain
>>> alphabetical sorting, which is nearly impossible with the current
>>> macros.
>> Does alphabetical sorting really matter? + Doesn't putting 01 etc
>> in the macro give the right name?  I thought it was stringified in the
>> first step (could be wrong, that macro stuff always gives me a headache).
>> We definitely need the prefix or equivalent so this is worth clearing up.
> 
> If it doesn't sort alphabetically, there no point in having a prefix.
> It was thought as a helper for the human user. Currently the number
> is a preprocessor definition and used both as prefix and as number.
> If there's a 0 in front, it will be interpreted as octal number.
Ah. The octal bit hadn't occurred to me.

The prefix isn't for the helper user at all.  It is to tell userspace
code reading from the ring buffer which element is which.  Without it there
is no way userspace can know the order.  Frankly I don't think a human browsing
that directory will care what the ordering in a buffer record is!

Jonathan
