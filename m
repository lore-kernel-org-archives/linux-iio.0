Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55239 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907AbaGHSB3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 14:01:29 -0400
Message-ID: <53BC327A.3070000@kernel.org>
Date: Tue, 08 Jul 2014 19:03:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: BMC150 accel support
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53A6E6D1.7090507@kernel.org> <53A78159.90400@linux.intel.com> <53AFF4A5.2020505@kernel.org> <53B0225F.6030704@linux.intel.com> <53B025EF.5060600@kernel.org> <20140707143600.GA2469@sirena.org.uk> <53BAC744.3070704@kernel.org> <20140708132355.GV30458@sirena.org.uk> <c49bed5a-0737-4376-9429-c070834e71e9@email.android.com>
In-Reply-To: <c49bed5a-0737-4376-9429-c070834e71e9@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 16:27, Jonathan Cameron wrote:
>
>
> On July 8, 2014 2:23:55 PM GMT+01:00, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jul 07, 2014 at 05:13:56PM +0100, Jonathan Cameron wrote:
>>> On 07/07/14 15:36, Mark Brown wrote:
>>
>>>> With regulators the delays are handled transparently in the
>> framework -
>>>> by the time the functions return the operation should have
>> commpleted.
>>>> If there is a need to have a non-blocking interface we'll have to
>> add
>>>> this.  The delays can be queried with _time() functions.
>>
>>> We are looking at a somewhat tangential question here...
>>
>> I don't think so...
>>
>>> Hence rather than picking a given power state (deep sleep or similar)
>>> we want the control to be on capture latency.  Hence userspace
>>> can specify the 'worst case' latency it will accept and the
>>> device will hence enter the lowest power state, between samples,
>>> that it can without failing to meet the requirement.
>>>
>>> What I was wondering is whether there is anything similar
>>> elsewhere that you know of? For example, could we query a
>>> regulator driver to ask it how long it will take to start up
>>> a given output?
>>
>> ...hence my comment that "The delays can be queried with _time()
>> functions - you don't need to implement the delays but you can find out
>> what they will be.
> Ah sounds like I miss interpreted your response!
> Will look into the _time stuff.
>
Right, this will certainly act as a starting point, though will
be a little bit interesting to make it all work together.

Anyhow, no idea when or if anyone will have time to look at the
levels beyond the sensor drivers themselves.

Thanks Mark,

Jonathan
