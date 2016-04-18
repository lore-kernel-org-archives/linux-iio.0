Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60748 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcDRTiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 15:38:21 -0400
Subject: Re: [PATCH 1/5] max44000: Initial commit
To: Mark Brown <broonie@kernel.org>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org> <570BBDFC.6010601@intel.com>
 <57134AFA.3040406@kernel.org> <20160418103212.GQ3217@sirena.org.uk>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571537AB.30005@kernel.org>
Date: Mon, 18 Apr 2016 20:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20160418103212.GQ3217@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/16 11:32, Mark Brown wrote:
> On Sun, Apr 17, 2016 at 09:36:10AM +0100, Jonathan Cameron wrote:
>> On 11/04/16 16:08, Crestez Dan Leonard wrote:
> 
> Please leave blank lines between paragraphs, it makes things much easier
> to read.
> 
>>> Would it be
>>> acceptable to just expand the REGMASK_* into a large or-ing of (1 <<
>>> MAX44000_REG_*)? Then it would be clear in the source what's going on
>>> but binary will be the same.
> 
>> Would be interesting to see but I doubt the optimized code will be that
>> different, and the switch is pretty much the 'standard' way of handling
>> these long register lists cleanly.
> 
>> Often it comes down to doing things the way people expect them to
>> be done as that makes review easier for a tiny possible cost in
>> run time.
> 
> You can also specify ranges of registers if the map mostly has large
> blocks of contiguous registers, a switch statement tends to be easier
> and is probably more efficient for most register maps.
> 
>>>>>> +    .use_single_rw    = 1,
>>>>>> +    .cache_type    = REGCACHE_FLAT,
> 
>>>> This always seems like a good idea, but tends to cause issues.
>>>> FLAT is really only meant for very high performance devices, you
>>>> are probably better with something else here.  If you are doing this
>>>> deliberately to make the below writes actually occur, then please
>>>> add a comment here.
> 
>>> I used REGCACHE_FLAT because my device has a very small number of
>>> registers and I assume it uses less memory. Honestly it would make
>>> sense for regmap to include a REGCACHE_AUTO cache_type and pick the
>>> cache implementation automatically based on number of registers.
> 
>> I've fallen for that one in the past as well.  AUTO would indeed
>> be good if it was easy to do.
> 
> It's extremely easy to do.  Unless you've got a good reason to do
> anything else you should always be using an rbtree.  The core would
> never select anything else.
> 
>>> Yes. It would not work otherwise since the regmap cache is explicitly
>>> initialized with my listed defaults.
>>> As far as I can tell regmap_write will always write to the hardware.
> 
>> Interesting and counter intuitive if true...
> 
> No, if the driver asked to write then we write.  If the driver wants to
> do a read/modify/write cycle it should use regmap_update_bits().
> 
>>> If the device had a reset command I should have used that, right?
>>> What is happening is that I am implementing a reset command in
>>> software.
> 
>> Not necessarily.  Lots of drivers don't - but instead have their interfaces
>> reflect their current state on startup.  Reset's are often there to get
>> the internal state of the device cleaned up if it is in an unknowable state
>> rather than to get the defaults to any particular state.  They are always
>> read from the hardware or a known good cache when queried from userspace
>> anyway.
> 
> That's not entirely it.  Doing a reset is often faster than rewriting
> the entire register map and is more robust against undocumented
> registers or things the driver didn't think about which means that
> the behaviour is going to be more consistent.
Hmm. Fair enough on the undocumented register argument...
> 

