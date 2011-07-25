Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51021 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab1GYKAB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 06:00:01 -0400
Message-ID: <4E2D3EA6.2000506@cam.ac.uk>
Date: Mon, 25 Jul 2011 11:00:06 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Jon Brenner <jbrenner@taosinc.com>,
	Bryan Freed <bfreed@chromium.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Updating the todo list.
References: <4E26D807.6010804@cam.ac.uk> <4E26EDD5.7010604@analog.com> <4E26FC8D.9080809@cam.ac.uk> <4E28303A.5020805@analog.com> <4E2834F5.6050504@cam.ac.uk> <4E2D3D25.4020607@analog.com>
In-Reply-To: <4E2D3D25.4020607@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>>>>>>
>>>>> Yes - that's a good thing todo.
>>>>> In addition we should also make sure that buffers may function in both directions.
>>>> Hmm.. The actual implementation would at least initially be completely separate. I think
>>>> the abi would certainly allow this as is though. Whilst I agree this would be useful, we
>>>> don't have an implementation and it seems non trivial. Last time we talked about it,
>>>> I got the impression quite a lot of bus level stuff had to be added before this
>>>> could actually be useful?
>>> If you think about making the SPI bus more deterministic, then I agree.
>>> However there may be various other use cases.
>>>
>>> 1)
>>> Most ADI precision DACs feature a LDAC (Load DAC) strobe. You could use a
>>> iio-trigger for example a HW timer or PWM with an output strobe, directly connected
>>> to the LDAC strobe, in the iio-trigger handler you could write the next value into the
>>> shadow/shift register of the DAC. This way you get no jitter on the update rate, the only
>>> timing constraint is that the new value is loaded before the next trigger occurs.
>> Hmm.. Interesting use for a trigger.  No reason why not though...
>>> 2)
>>> Think about data sink devices with build in buffers.
>> Those I agree are interesting, but do we have any?
> 
> Not today. But we're planning to create drivers that talk to
> peripheral blocks synthesized in HDL and running on FPGAs
> in combination with FPGA hard and soft-cores running Linux.
> These peripheral blocks will feature buffers/fifos  to bridge
> interrupt service latencies or to reduce the peripheral service frequency.
Sounds interesting.  Right now though I think we just need to sanity check that the abi
will work for this (with extensions, but no changes).  I think it will but could you
take a look and see if there is anything I've missed?
>>> 3)
>>> Don't think about Linux SPI or I2C bus drivers at all.
>> Fair enough.  They are my home territory, so I'll be following your lead on this stuff.
>>> So there can be lot's of cases where IIO user space write-able buffers are useful.
>> Agreed, though I'm not sure the have the same requirements as the read out buffers.  Looks
>> to me exactly the other way around.  Userspace writes lot occasionally and kernel pushes
>> individual (or hardware buffer does).  Nothing wrong with sharing userspace interfaces
>> (specification of contents of buffer etc), but my gut feeling is the implementation may
>> not share much at all.
> 
> A implementation based on kfifo should be sufficient, and is actually pretty straight forward.
Excellent.  I look forward to seeing a driver ;)
