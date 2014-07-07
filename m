Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42177 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbaGGQLq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 12:11:46 -0400
Message-ID: <53BAC744.3070704@kernel.org>
Date: Mon, 07 Jul 2014 17:13:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: BMC150 accel support
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53A6E6D1.7090507@kernel.org> <53A78159.90400@linux.intel.com> <53AFF4A5.2020505@kernel.org> <53B0225F.6030704@linux.intel.com> <53B025EF.5060600@kernel.org> <20140707143600.GA2469@sirena.org.uk>
In-Reply-To: <20140707143600.GA2469@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/14 15:36, Mark Brown wrote:
> On Sun, Jun 29, 2014 at 03:42:55PM +0100, Jonathan Cameron wrote:
>> On 29/06/14 15:27, Srinivas Pandruvada wrote:
>
> Please don't use my Linaro address for upstream things, use my
> kernel.org one (which is the one I always use for mail and is in
> MAINTAINERS).
Will do.
>
> I'm also having a bit of an issue reading the mail due to it not being
> word wrapped.
It does indeed seem to have gotten wrapped at a random, somewhat
longer than normal length... Oops.
>
>> If we are dependent on regulators to leave certain states, do we have access to how long
>> they take to start up?  What about bringing buses up...
>
>> Cc'd Mark Brown on the basis he knows all sorts of hideous corners of the kernel way
>> better than me ;)
>
> With regulators the delays are handled transparently in the framework -
> by the time the functions return the operation should have commpleted.
> If there is a need to have a non-blocking interface we'll have to add
> this.  The delays can be queried with _time() functions.
We are looking at a somewhat tangential question here...

What we have is a device that has various power saving levels.  As
the basic interest of IIO is grabbing data, in a sense it is the
time taken to return from a given level and grab some data that
acts as the controlling variable on how low a power state the
device should go into.

Hence rather than picking a given power state (deep sleep or similar)
we want the control to be on capture latency.  Hence userspace
can specify the 'worst case' latency it will accept and the
device will hence enter the lowest power state, between samples,
that it can without failing to meet the requirement.

What I was wondering is whether there is anything similar
elsewhere that you know of? For example, could we query a
regulator driver to ask it how long it will take to start up
a given output?

This extension beyond the device it self to it's power supplies
and for example bus is more of an idle thought than an actual
plan at this stage.

J  

