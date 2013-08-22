Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-235.synserver.de ([212.40.185.235]:1085 "EHLO
	smtp-out-208.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752123Ab3HVNPd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 09:15:33 -0400
Message-ID: <52160F47.2030403@metafoo.de>
Date: Thu, 22 Aug 2013 15:16:55 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Drubin, Daniel" <daniel.drubin@intel.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: Re: working with IIO
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com>
In-Reply-To: <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/22/2013 01:30 PM, Drubin, Daniel wrote:
> Hi Jonathan,
> 
> I am Daniel and I work with Michael.
> 
> [...]
>>> This limitation is really painful for our design that is striving to
>>> achieve better performance moving some of sensors logic to Kernel mode.
>>> Now please Jonathan, could you explain the ratio behind this
>>> limitation?
>>
>> Simplicity and hence speed plus where all this evolved from which was data
>> logging. Technically there is nothing stopping us having a separate buffer per
>> user as we already allow multiple buffers to be fed from the same device for
>> different purposes. This is how the bridge to input functions (not yet in
>> mainline)
>>
>> What is your application which needs multiple simultaneous buffered users?
> 
> We need multiple higher level clients to be able to configure the same sensor for different rates and receive data at different rates, independently of each other. I.e. device will sense at maximum of configured rates, and clients will poll data as if their configured rates. This is mainly for Android, where there are multiple sensor frameworks independent of each other.
> 
>> As a quick thought I would not necessarily be against having the ability to
>> request additional chrdevs each with their own buffers. A bit fiddly to retrofit
>> though as not breaking abi would mean we need to keep the existing
>> interfaces as they are.
> 
> We actually thought about registering multiple "virtual" sensors for the same physical device in order to stick it into existing IIO, but that has limited use for us (in particular, we will have to only pre-register statically those multiple virtual sensors).
> 
>>> And in general - could you share with us your plans of future
>>> modifications to  iio
> [...]
>> Of course feel free to propose any changes you would like!
> 
> As of now we would like to propose an option for IIO device to allow multiple opens()s. Without that additional option devices will work as today, so that, for example, existing sensor drivers will not have to be modified for reentrancy; but those drivers that need it will signal with that option that they will handle reentrancy themselves.

How about implementing a userspace daemon which does the arbitration between
multiple users? Doing this in kernel space can get tricky, especially if you
want to allow concurrent users with different settings, e.g. sample rate.
This is in part due to the majority of the IIO ABI being stateless and this
doesn't really mix well with concurrent users. Having a daemon will allow
you to implement a stateful API on top of the stateless IIO userspace ABI.
If you go the kernel route though I'm pretty sure you'll run into lots of
problems without an immediate solution.

- Lars

