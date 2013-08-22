Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1064 "EHLO
	smtp-out-238.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753280Ab3HVOPi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 10:15:38 -0400
Message-ID: <52161D55.8090201@metafoo.de>
Date: Thu, 22 Aug 2013 16:16:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Drubin, Daniel" <daniel.drubin@intel.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: Re: working with IIO
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com>
In-Reply-To: <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/22/2013 03:39 PM, Drubin, Daniel wrote:
> [...]
>>> As of now we would like to propose an option for IIO device to allow
>> multiple opens()s. Without that additional option devices will work as today,
>> so that, for example, existing sensor drivers will not have to be modified for
>> reentrancy; but those drivers that need it will signal with that option that
>> they will handle reentrancy themselves.
>>
>> How about implementing a userspace daemon which does the arbitration
>> between multiple users? Doing this in kernel space can get tricky, especially if
>> you want to allow concurrent users with different settings, e.g. sample rate.
>> This is in part due to the majority of the IIO ABI being stateless and this
>> doesn't really mix well with concurrent users. Having a daemon will allow you
>> to implement a stateful API on top of the stateless IIO userspace ABI.
>> If you go the kernel route though I'm pretty sure you'll run into lots of
>> problems without an immediate solution.
> 
> That's the direction in which we are currently advancing. Not because we are afraid of kernel-mode problems - after all they are very similar to what kernel-mode filesystem driver faces when serving multiple processes accessing the same FS, just less complicated (e.g. no writers); but mainly because we want to use existing IIO as framework.
> 

The problem is that the IIO ABI is stateless, so either you need to add some
very crude hacks on-top of it to allow this or you'd have to throw  away the
current ABI and develop a IIOv2. The userspace daemon is in my opinion
preferable to both cases.

> The main drawback that we see in user-mode daemon is performance. Consider sequence of events between the daemon and the caller process:
> 
> - Caller process invokes some sort of RPC via socket/pipe/message queue [system call, context switch]
> - Daemon receives request message [system call]
> - Daemon pushes sample data through IPC [system call, data copy, context switch]
> - Caller pops data off IPC [system call, data copy]
> 
> I.e. there are 4 system calls, 2 context switches and 2 data copies added solely for the purpose of arbitration for EACH client, even for sensors not currently shared.

If done right the overhead should hopefully be negligible. E.g. right now we
do not have mmap support for IIO, but this is something that will be
implemented sooner or later (probably sooner than later). I think we should
take a look at how ALSA does these things. There we also have no in-kernel
multiplexing or mixing and things are handled by a userspace daemon.

> 
> BTW (not directly related), I've read somewhere that on some system IIO did up to 200M samples per second. Is it true? If yes, how such data rate was achieved?

Yes, but not continuous streaming. This is implemented by sampling at 200
MHz, put data into a buffer, stop sampling and then let userspace read the
buffer and after that start again.

- Lars
