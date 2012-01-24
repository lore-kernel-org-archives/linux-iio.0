Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46169 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2AXOUk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2012 09:20:40 -0500
Date: 24 Jan 2012 14:20:31 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Marek Vasut <marek.vasut@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Wolfgang Denk <wd@denx.de>,
	Peter Rusko <rusko.peter@prolan.hu>,
	Stefano Babic <sbabic@denx.de>,
	Sascha Hauer <kernel@pengutronix.de>, linux-iio@vger.kernel.org
Subject: Re: [RFC] IIO LRADC for mach-mxs
Message-ID: <Prayer.1.3.4.1201241420310.5758@hermes-2.csi.cam.ac.uk>
In-Reply-To: <20120124131427.GE2609@pengutronix.de>
References: <201201241408.08083.marek.vasut@gmail.com>
 <20120124131427.GE2609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Jan 24 2012, Wolfram Sang wrote:

>On Tue, Jan 24, 2012 at 02:08:07PM +0100, Marek Vasut wrote:
>> Hi guys,
>> 
>> I've been playing with a custom mxs board recently and I'd like to tinker with 
>> ADC. Well, apparently there was some effort but it died silently.
>> 
>> Now, there are two approaches how to go about the MXS IIO LRADC. Firstly though, 
>> here are some hw details:
>> 
>> 1) The ADC has 16 channels in total, some dedicated to particular function
>> 2) The ADC can sample only up to 8 channels at the same time
>> 3) The ADC delay triggers can trigger only up to 4 kinds of sampling for those 
>> up to 8 selected channel
>> 
>> So how should we go about this:
>> 
>> A) Implement functions, to configure and select a channel at probe-time and then 
>> never allow (at runtime) different channel to be selected.
>> 
>> + Channel configuration is static, passed via plat_data
>> + The channels don't need to be reconfigured => when data are demanded, the 
>> channel doesn't need to be reconfigured (if it's not configured in one of those 
>> 8 options) and the user doesn't need to wait for data.
>> - Only 8 channels can be used
>> 
>> B) Allow channel to be configured on-demand -- when it's value is requested, it 
>> is configured (if it's not already) for the particular function.
>> 
>> + All 16 channels can be used
>> - It's clunky and fragile to breakage
>> - It's hard to implement good channel replacement algo (replacement as on the 
>> delay triggers and on those 8 slots)
>> 
>> Which way do you consider better ?
>
>CCing Jonathan and the iio-list (as found in MAINTAINERS). They probably
>have more experience regardings those scenarios?
Thanks Wolfram,

My instinct is always to make anything configurable at runtime where we can even
vaguely conceive of a reason it might be useful.

Having said that, right now special function (e.g. input, hwmon directed channels)
are currently set up via board files (will be device tree the moment anyone has
a need).  I doubt there are many usecases where you'd want to change these functional
elements.

For your channel replacement strategy these special function channels will be in use
if the client is reading form them (e.g. triggered usage). In IIO we only allow for
triggering a whole set of channels off a given trigger.  It's going to get really
ugly otherwise.  Perhaps the following will work? (I am assuming 0-8 channels can be
associated with any of the 4 triggers subject to the condition that the total number
of channels being captured is less than 8).

Register 4 iio devices, each with all 16 channels.  Associate one with each of the
triggers.  Driver then maintains a count on channels enabled and refuses to enable more
than 8 whatever happens.  You don't have a replacement strategy, you simply refuse
to have too many.  We already do this for some of the devices with strange possible
channel sets.

Any in kernel users (hwmon, input etc) will have to be configured to use the iio device
associated with the right trigger.

Does that do the job for you?

The reason for associating the triggers with different iio devices is that a given iio
device can only feed a fixed width scan to the demux unit.  Hence if we have some
channels triggering at one time and others at another, there is no way of handling the
data stream.  Whilst they are on the same hardware they are really acting as separate
devices that just happen to share some pins and control hardware.

(Note I'm being useless and not pushing out the new version of in kernel IIO stuff, but
I should get to that at the weekend if not before - one fiddly issue with preventing
removal of in use devices still to work out.).

Jonathan 

>
>
