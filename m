Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39522 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1CYPSL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2011 11:18:11 -0400
Message-ID: <4D8CB281.3070908@cam.ac.uk>
Date: Fri, 25 Mar 2011 15:19:29 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Experimenting with channel specification structures.
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <201103251603.58220.arnd@arndb.de>
In-Reply-To: <201103251603.58220.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/11 15:03, Arnd Bergmann wrote:
> On Thursday 24 March 2011, Jonathan Cameron wrote:
>> Advantages I can see from this experiement
>>
>> 1) Simple drivers are more consise.
>> 2) It is infact possible to do this for a lot of cases (I had
>> my doubts ;)
>> 3) It gives us many of the rigid constraints that the many
>>    attribute macros now handle in a nice clean form.
> 
> Very nice!
> 
>> Disadvantages:
>>
>> 1) The core code is rather more complex than I'd like.
> 
> Yes, but I think not overly so. Moving complexity from the drivers
> into the core should almost always be worth it in the long run.
> 
> Remember that people who write the drivers should not need to
> worry about many of the complexities of kernel hacking, such
> as sysfs attributes or character devices. The more of that you
> can do in the core, the less work you have helping your downstream
> developers.
My current downstream developers are going to moan about this change ;)
> 
>> 2) There are cases I haven't yet worked out how to handle properly
>>    - for example, our lis3l02dq used to output accel_mag_value
>>    as the threshold value is shared across all high and low threshold
>>    interrupts.  Right now I have no way of specifying this level
>>    of control for the events lines.
>>    Also the use of shared event handlers is clunky to say the least.
>>    This may go away when we rethink the event system though.
> 
> I think reworking the way that event buffers work is quite
> central here, although mostly orthogonal to the rework of the
> internal API.
Next on the list.
> 
>> 3) Putting hard requirements on numeric formatting of some
>>    parameters is a pain. If nothing else I need to write a fixed point
>>    input function.
> 
> Yes, but at least you only need to write it once ;-)
hmph.
> 
>> p.s. Despite Arnd's original thread going to lkml I've kept this
>> on list for now (+ Arnd of course!) because I want to pin it down
>> a bit more before throwing it out more generally. 
> 
> Fair enough.
> 
> 	Arnd
> 

