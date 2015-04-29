Return-Path: <mfuzzey@parkeon.com>
Message-ID: <554090D7.50208@parkeon.com>
Date: Wed, 29 Apr 2015 10:05:43 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 9/9] iio: mma8452: add support for self test.
References: <20150219141553.27001.18825.stgit@localhost> <20150219141612.27001.62858.stgit@localhost> <54FDA200.7090209@kernel.org>
In-Reply-To: <54FDA200.7090209@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/03/15 14:37, Jonathan Cameron wrote:
> On 19/02/15 14:16, Martin Fuzzey wrote:
>> Add a new attribute to activate the self test mode.
>>
>> When self test is activated, an electrostatic actuation force is
>> applied to the sensor, simulating a small acceleration.
>>
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> The most common option for self tests is to do them on startup
> and spit out an error if they fail to give the expected
> result.  The advantage is that we avoid a little used and
> not terribly well defined (in general!) ABI element.
> This is far from the only part supporting self tests
> so we need to be careful with adding a new ABI.
>
> Would doing it on startup work here?
> Clearly you'd have to apply the self test and define some boundaries
> on the expected result for correct operation (vs not having it on)
> and hope no one starts the device up whilst accelerating a lot.
>
> I guess on this one a warning would be the way to go rather than
> an error as huge real accelerations are more than possible.

The problem with doing it on startup is there is no way for userspace to 
get the result, except by parsing the kernel logs (yuk).
And it would more or less preclude implementing a "maintenance mode" 
test menu.

So, at least for my usecase, doing it *only* on startup wouldn't work (a 
case could be made for having it done on startup *and* on explicit request).

Note that I'm not adding a new *generic* ABI here, but a device specific 
one (there are other devices that have specific attributes too).
I agree that a generic ABI would be better but is it possible to define 
one that would suite all devices?
I don't know enough about the other devices to answer that question.

I'm also not doing a complete test giving a "GO / NO GO" result but 
rather just providing a means of switching the actuator on and letting 
userspace observe the difference via the standard ABI (which avoids the 
problems with defining thresholds etc - or at least pushes them to 
userspace).

But, if we don't (yet?), have a consensus for a self test ABI I'll drop 
this patch for the moment and keep it in my tree for now.

Regards,

Martin
