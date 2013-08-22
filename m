Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:45091 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3HVPJH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 11:09:07 -0400
Message-ID: <52162987.501@jic23.retrosnub.co.uk>
Date: Thu, 22 Aug 2013 16:08:55 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "Drubin, Daniel" <daniel.drubin@intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: Re: working with IIO
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com> <52161D55.8090201@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com> <521625C5.4020504@metafoo.de>
In-Reply-To: <521625C5.4020504@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/13 15:52, Lars-Peter Clausen wrote:
> On 08/22/2013 04:45 PM, Drubin, Daniel wrote:
>>
>>
>>> -----Original Message-----
>>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>>> Sent: Thursday, August 22, 2013 5:17 PM
>>> To: Drubin, Daniel
>>> Cc: Jonathan Cameron; Yuniverg, Michael; linux-iio@vger.kernel.org;
>>> Haimovich, Yoav
>>> Subject: Re: working with IIO
>>>
>>> On 08/22/2013 03:39 PM, Drubin, Daniel wrote:
>>>> [...]
>>>>>> As of now we would like to propose an option for IIO device to allow
>>>>> multiple opens()s. Without that additional option devices will work
>>>>> as today, so that, for example, existing sensor drivers will not have
>>>>> to be modified for reentrancy; but those drivers that need it will
>>>>> signal with that option that they will handle reentrancy themselves.
>>>>>
>>>>> How about implementing a userspace daemon which does the arbitration
>>>>> between multiple users? Doing this in kernel space can get tricky,
>>>>> especially if you want to allow concurrent users with different settings,
>>> e.g. sample rate.
>>>>> This is in part due to the majority of the IIO ABI being stateless
>>>>> and this doesn't really mix well with concurrent users. Having a
>>>>> daemon will allow you to implement a stateful API on top of the stateless
>>> IIO userspace ABI.
>>>>> If you go the kernel route though I'm pretty sure you'll run into
>>>>> lots of problems without an immediate solution.
>>>>
>>>> That's the direction in which we are currently advancing. Not because we
>>> are afraid of kernel-mode problems - after all they are very similar to what
>>> kernel-mode filesystem driver faces when serving multiple processes
>>> accessing the same FS, just less complicated (e.g. no writers); but mainly
>>> because we want to use existing IIO as framework.
>>>>
>>>
>>> The problem is that the IIO ABI is stateless, so either you need to add some
>>> very crude hacks on-top of it to allow this or you'd have to throw  away the
>>> current ABI and develop a IIOv2. The userspace daemon is in my opinion
>>> preferable to both cases.
>>
>>  From practical POV we don't have much choice (timeline), since we have to reuse driver that is bound to IIO. From principle standpoint I somehow fail to see a problem. It seems to me that all state handling that an IIO driver needs to do is to keep associations of PIDs to sensor rates, configure sensor to the highest rate in the list and replicate shared data at rates requested by the clients. When a file descriptor is closed (due to process termination or another reasons), the actual sensor is re-configured with next-highest rate among the open FDs.
>
> But you can't track the configured rate per PID with the current API. That's
> why I keep saying that the API is stateless. You can not track state per
> application without inventing a new API.

The fastest way of doing this that I can see would be to allow 
initialization of multiple buffers per device (not actually that
hard to do given we have the multiple stream demux there for other 
reasons) and allow subsampling of the datastream in the demux.  Note 
that there are no assumptions that the triggering will be fixed
frequency, hence it could only be done as a filter on whatever comes up 
rather than explicit frequency requests.

Does v4l handle multiple video streams to userspace at different
frame rates?  That is what we are talking about here effectively.

The few times this has come up before we have always concluded that
it is better done in userspace, but there is some infrastructure in
place now that would make it 'not truly horrible' to do some of the
work in kernel.

Jonathan
