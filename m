Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52387 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbcDQIgQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 04:36:16 -0400
Subject: Re: [PATCH 1/5] max44000: Initial commit
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org> <570BBDFC.6010601@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Mark Brown <broonie@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57134AFA.3040406@kernel.org>
Date: Sun, 17 Apr 2016 09:36:10 +0100
MIME-Version: 1.0
In-Reply-To: <570BBDFC.6010601@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 16:08, Crestez Dan Leonard wrote:
> On 04/10/2016 04:12 PM, Jonathan Cameron wrote:
>> On 07/04/16 20:48, Peter Meerwald-Stadler wrote:
>>>
>>>> This just adds support for reporting illuminance with default settings.
>>>>
>>>> All default registers are written on probe because the device otherwise
>>>> lacks a reset function.
>>>
>>> comments below
>> Mostly fine, but a few corners need cleaning up.
>>
>> Also, I'm not keep on the brute force write everything.  The driver should
>> cope with any values in those registers and deal with refreshing the
>> cache etc so that it can do so.  Writing a bunch of defaults is rather a
>> brittle approach.
> 
> But if the hardware is not in the expected state the driver won't
> report correct values, at least not without reading scaling factors.
Exactly, I'd expect the driver to be reading those scaling factors.

If the device comes up in an entirely random state on power up then
writing the whole register set is fair enough.
> It's not clear what you mean by brittle?
Liable to miss some set of circumstances due to an assumption that
you know what the value of every register is.  It's not a problem now
as you will have gained a good understanding of the device writing
the whole driver - it might result in subtle accidental breakage
if someone tries to make a small change in the future though.

This point isn't that important though as the device isn't all that
complicated so such problems should be easy enough to spot...
> 
>>>> +struct max44000_data {
>>>> +    struct mutex lock;
>>>> +    struct i2c_client *client;
>> This client pointer isn't used outside probe and remove where it is easily
>> available anyway.  Hence don't keep a copy in here.
> 
> Ok, will remove
> 
>>>> +static bool max44000_readable_reg(struct device *dev, unsigned int reg)
>>>> +{
>>>> +    return (1 << reg) & MAX44000_REGMASK_READABLE;
>> See above.  This is a really nasty and hard to review way of doing this.
>> switch (reg) {
>>         REG1:
>>         REG2:
>>         REG3:
>>       return true;
>>         default:
>>            return false;
>>
>> may be more code, but it's easy to tell if it is right.
> 
> Won't a switch result in larger executable code?
Possibly depending on how clever the compiler is feeling.  Not much
more code though I would expect. It's all well described so the
compiler ought to do a good job of optimizing it.
> Would it be
> acceptable to just expand the REGMASK_* into a large or-ing of (1 <<
> MAX44000_REG_*)? Then it would be clear in the source what's going on
> but binary will be the same.
Would be interesting to see but I doubt the optimized code will be that
different, and the switch is pretty much the 'standard' way of handling
these long register lists cleanly.

Often it comes down to doing things the way people expect them to
be done as that makes review easier for a tiny possible cost in
run time.
> 
>>>> +static const struct reg_default max44000_reg_defaults[] = {
>>>> +    { MAX44000_REG_CFG_MAIN,    0x24 },
>>>> +    /* Upper 4 bits are not documented but start as 1 on powerup
>> Multiline comment syntax please.
> 
> Ok, I will fix this in all the patches.
> 
>>>> +    .use_single_rw    = 1,
>>>> +    .cache_type    = REGCACHE_FLAT,
>> This always seems like a good idea, but tends to cause issues.
>> FLAT is really only meant for very high performance devices, you
>> are probably better with something else here.  If you are doing this
>> deliberately to make the below writes actually occur, then please
>> add a comment here.
> 
> I used REGCACHE_FLAT because my device has a very small number of
> registers and I assume it uses less memory. Honestly it would make
> sense for regmap to include a REGCACHE_AUTO cache_type and pick the
> cache implementation automatically based on number of registers.
I've fallen for that one in the past as well.  AUTO would indeed
be good if it was easy to do.

>>>> +static int max44000_force_write_defaults(struct max44000_data *data)
>>>> +{
>>>> +    int i, ret;
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(max44000_reg_defaults); ++i) {
>>>> +        ret = regmap_write(data->regmap,
>>>> +                   max44000_reg_defaults[i].reg,
>>>> +                   max44000_reg_defaults[i].def);
>> Silly question, but if the cached value matches the values you are trying
>> to write here will this work?
> 
> Yes. It would not work otherwise since the regmap cache is explicitly
> initialized with my listed defaults.
> As far as I can tell regmap_write will always write to the hardware.
Interesting and counter intuitive if true...
Taking the rbtree cache If it's not volatile it looks to try
writing in regcache which if it gets a match on the value being in the tree
calls regcache_set_val which checks the cache and will fall through having
written nothing if it thinks it has a match.

Taking FLAT - yeah it doesn't check the cache at all on a write - merely
blindly updates it.

I've cc'd Mark Brown in case he has any comments on this.
> 
>> There is a regcache_mark_dirty call that will ensure all registers in the
>> cache are read..
> 
> The regcache_mark_dirty function is used to notify the cache that the
> device has been reset to the known default values. I attempted to do
> something like:
>     regcache_mark_dirty()
>     regcache_sync()
> 
> This doesn't work because this explicitly avoid overwriting known defaults.
Hmm. I've clearly misunderstood this then.  It has no mention of expecting the
hardware to be in any particular state.
> 
>> If you then need any particular values they should be explicitly written
>> on the assumption you have no idea what the state is.  Brute force writing
>> all the defaults is nasty and doesn't give any information as to what
>> is happening.
> 
> If the device had a reset command I should have used that, right?
> What is happening is that I am implementing a reset command in
> software.
Not necessarily.  Lots of drivers don't - but instead have their interfaces
reflect their current state on startup.  Reset's are often there to get
the internal state of the device cleaned up if it is in an unknowable state
rather than to get the defaults to any particular state.  They are always
read from the hardware or a known good cache when queried from userspace
anyway.
> 
> I can skip writing values like REG_TRIM_* which are used for
> calibration and are not exposed by the driver. This would allow these
> values to be configured externally using something like i2cset at
> boot time. Is that what you mean?
> 
> I could also skip initializing scaling parameters but then stuff like
> in_illuminance_scale would persist after rmmod/insmod. This seems
> undesirable.
Why?  Any userspace should be setting these to the values it wants
not relying on what it 'thinks' the defaults are.

I'm not that fussed about all this, it just seems clunky to need to do
such a wholesale write of registers so if the regmap core can be made
to do that it would definitely be preferable.  You can definitely force
it as a patch to the default set but that seems ugly too.

Jonathan

> -- 
> Regards,
> Leonard

