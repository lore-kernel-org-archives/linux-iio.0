Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58038 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252AbbGQMO5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2015 08:14:57 -0400
References: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
            <1436357088-30743-2-git-send-email-daniel.baluta@intel.com>
            <0C20DA6F-E21C-495B-A31B-4EC0DC66EF7A@kernel.org>
            <CAEnQRZB0-iVOa0Jzc-1Bo2BK8HU51SG=Mhs6un2DQCF_qFw_dQ@mail.gmail.com>
In-Reply-To: <CAEnQRZB0-iVOa0Jzc-1Bo2BK8HU51SG=Mhs6un2DQCF_qFw_dQ@mail.gmail.com>
From: jic23@jic23.retrosnub.co.uk
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] DocBook: Add initial documentation for IIO
Date: Fri, 17 Jul 2015 13:14:54 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20150717121454.90E9343115@saturn.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta writes: 

> On Thu, Jul 16, 2015 at 10:31 PM, Jonathan Cameron <jic23@kernel.org> wrote: 
> 
> Thanks for your review Jonathan! I will try to address your
> comments in v2. 
> 
> 
>>>+      The main purpose of the Industrial I/O subsystem (IIO) is to
>>>provide
>>>+      support for devices that in some sense are analog to digital
>>>converts
>>>+      (ADCs). As many actual devices combine some ADCs with digital to
>>>analog
>>>+      converters (DACs), that functionality is also supported.
>>
>> I wonder if we now want to treat DACs at the same level in the docs as ADCs.  Right
>>  now our support is simpler but there are patches adding full buffered support to output devices as well (Lars?)
> 
> I have very few experience with DACs IIO drivers :) but I assume that
> the basic part
> is the same (e.g. set .output = 1) then triggers are independent of
> device type :). 
> 
> Anyhow, the above line only says that IIO also supports DACs and then
> all the examples
> are for ADCs :). Perhaps I can make the examples more clear. 
> 
> <snip> 
> 
>>
>>>+    Usually these sensors are connected via SPI or I2C.
>> Maybe add something about SOC integrated parts as well?
> 
> Like sensors hubs?  We can add this later.
Not so much sensor hubs (though could mention those as well).
A lot of our ADCs are integrated in various (typically arm) SOCs.
These then provide services to other users (battery etc) as needed.
> 
>>>+    <para>
>>>+    The Industrial I/O core offers a way for continuous data capture
>>>+    based on a trigger source. Multiple data channels can be read at
>>>once
>>>+    from <filename>/dev/iio:deviceX</filename> character device node,
>>>+    thus reducing the CPU load.
>>>+    </para>
>> Why reduced load? Also perhaps mention pseudo scans? (Sort of all at the same time)
> 
> Because, the alternative would be to use "polling" on sysfs data
> attributes. This means:
> * 3 userspace read()'s instead of 1.
> * 3 kernel separate register reads instead 1 bulk read. 
> 
> Perhaps I can make this clearer. :)
Also make the point that the interface is binary and scaling / offsets
left to userspace.  Just wants some explanation I think!
> 
> <snip> 
> 
>> Sorry for messy review. Ignoring my daughter down the park:) 
>>
>> Anyhow, a great basis to build on. I like the example driven approach.
>> Might have missed it but perhaps cross refer to the dummy driver?
> 
> Thanks again for your time Jonathan! We are really happy with your
> per weekend review sessions, so you would better stay away from
> your phone while in the park :D.
*laughs*.  My daughter's 9.  She doesn't really need pushing on the swings 
any more. Just keeps coming over to see what I'm doing :) 

Busy with Ballet shows this weekend and holiday next so got to fit
the odd bit in mid week at the moment :)
> 
> thanks,
> Daniel.
