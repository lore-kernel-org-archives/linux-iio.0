Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56846 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaGHP1d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jul 2014 11:27:33 -0400
In-Reply-To: <20140708132355.GV30458@sirena.org.uk>
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53A6E6D1.7090507@kernel.org> <53A78159.90400@linux.intel.com> <53AFF4A5.2020505@kernel.org> <53B0225F.6030704@linux.intel.com> <53B025EF.5060600@kernel.org> <20140707143600.GA2469@sirena.org.uk> <53BAC744.3070704@kernel.org> <20140708132355.GV30458@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: accel: BMC150 accel support
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 08 Jul 2014 16:27:27 +0100
To: Mark Brown <broonie@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <c49bed5a-0737-4376-9429-c070834e71e9@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On July 8, 2014 2:23:55 PM GMT+01:00, Mark Brown <broonie@kernel.org> wrote:
>On Mon, Jul 07, 2014 at 05:13:56PM +0100, Jonathan Cameron wrote:
>> On 07/07/14 15:36, Mark Brown wrote:
>
>> >With regulators the delays are handled transparently in the
>framework -
>> >by the time the functions return the operation should have
>commpleted.
>> >If there is a need to have a non-blocking interface we'll have to
>add
>> >this.  The delays can be queried with _time() functions.
>
>> We are looking at a somewhat tangential question here...
>
>I don't think so...
>
>> Hence rather than picking a given power state (deep sleep or similar)
>> we want the control to be on capture latency.  Hence userspace
>> can specify the 'worst case' latency it will accept and the
>> device will hence enter the lowest power state, between samples,
>> that it can without failing to meet the requirement.
>> 
>> What I was wondering is whether there is anything similar
>> elsewhere that you know of? For example, could we query a
>> regulator driver to ask it how long it will take to start up
>> a given output?
>
>...hence my comment that "The delays can be queried with _time()
>functions - you don't need to implement the delays but you can find out
>what they will be.
Ah sounds like I miss interpreted your response! 
Will look into the _time stuff.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
