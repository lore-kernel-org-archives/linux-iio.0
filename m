Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46223 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbEGXd4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:56 -0400
Message-ID: <554BF193.7000208@kernel.org>
Date: Fri, 08 May 2015 00:13:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 9/9] iio: mma8452: add support for self test.
References: <20150219141553.27001.18825.stgit@localhost> <20150219141612.27001.62858.stgit@localhost> <54FDA200.7090209@kernel.org> <554090D7.50208@parkeon.com>
In-Reply-To: <554090D7.50208@parkeon.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/15 09:05, Martin Fuzzey wrote:
> On 09/03/15 14:37, Jonathan Cameron wrote:
>> On 19/02/15 14:16, Martin Fuzzey wrote:
>>> Add a new attribute to activate the self test mode.
>>>
>>> When self test is activated, an electrostatic actuation force is
>>> applied to the sensor, simulating a small acceleration.
>>>
>>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>> The most common option for self tests is to do them on startup
>> and spit out an error if they fail to give the expected
>> result.  The advantage is that we avoid a little used and
>> not terribly well defined (in general!) ABI element.
>> This is far from the only part supporting self tests
>> so we need to be careful with adding a new ABI.
>>
>> Would doing it on startup work here?
>> Clearly you'd have to apply the self test and define some boundaries
>> on the expected result for correct operation (vs not having it on)
>> and hope no one starts the device up whilst accelerating a lot.
>>
>> I guess on this one a warning would be the way to go rather than
>> an error as huge real accelerations are more than possible.
> 
>The problem with doing it on startup is there is no way for userspace to get the result, except by parsing the kernel logs (yuk).
Agreed.  The ability to report hardware failures in a more coherent
way is something a lot of people have been asking for for ages, but
I don't think anyone has yet come up with a better option.
> And it would more or less preclude implementing a "maintenance mode"
> test menu.
You could remove and reprobe the device, but that would be hideous!
Seems like a good usecase for lots of devices.
> 
> So, at least for my usecase, doing it *only* on startup wouldn't work
> (a case could be made for having it done on startup *and* on explicit
> request).
The both option sounds sensible.
> 
> Note that I'm not adding a new *generic* ABI here, but a device
> specific one (there are other devices that have specific attributes
> too). I agree that a generic ABI would be better but is it possible
> to define one that would suite all devices? I don't know enough about
> the other devices to answer that question.
Hmm.. Interesting question. Mostly device specific ABIs exist for the
really unusual elements (and often they end up becoming common in the
future!).
> 
> I'm also not doing a complete test giving a "GO / NO GO" result but
> rather just providing a means of switching the actuator on and
> letting userspace observe the difference via the standard ABI (which
> avoids the problems with defining thresholds etc - or at least pushes
> them to userspace).
I wonder how generic an ABI we can come up with. 
Ultimately you tend to have some 'magic setting' that leads to a known
change in the value read.  There might be more than one of these, but
that's about it.  Doesn't sound implausible to have a generic ABI for this
to me...

Lars, quite a few Analog parts have self tests.  What do you think of
such an interface?
> 
> But, if we don't (yet?), have a consensus for a self test ABI I'll
> drop this patch for the moment and keep it in my tree for now.

You are convincing me that this is a lot more interesting than it
seems at first glance :)
> 
> Regards,
> 
> Martin
