Return-Path: <SRS0=+rG6=47=cogentembedded.com=nikita.yoush@kernel.org>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Jonathan Cameron <jic23@kernel.org>,
 Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
 <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
 <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com>
 <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
 <20170524203808.34aec03a@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
Date: Thu, 25 May 2017 09:27:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170524203808.34aec03a@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

>>>>> Reset GPIO is active low.
>>>>>
>>>>> Currently driver uses gpiod_set_value(1) to clean reset, which depends
>>>>> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
>>>>>
>>>>> This fixes driver to use _raw version of gpiod_set_value() to enforce
>>>>> active-low semantics despite of what's written in device tree. Allowing
>>>>> device tree to override that only opens possibility for errors and does
>>>>> not add any value.
>>>>>
>>>>> Additionally, use _cansleep version to make things work with i2c-gpio
>>>>> and other sleeping gpio drivers.  
>>>> The reset gpio comes from platform hence it should be handled by DTS.
>>>>
>>>> In driver the gpio should not be raw.
>>>>
>>>> Even the hi8435 is active low but platform may invert signal (f.e. by
>>>> adding trigger on the circuit path).  
>>> I see.  However - isn't this pure theoretic?  Does such case exist?  
>> I assure you that this is frequently used.
>>
>> Simply search google for "simple voltage level shifter"
>> It might be on PNP or NPN transistor, hence logic might be inverted.
>>
>>>
>>> In vast majority of cases, GPIO polarity is chip-specific, not
>>> chip-use-specific.  Thus this knowlege belongs to driver and not to
>>> device tree describing particular chip usage.  Having this always
>>> defined at usage side is IMO major source of errors.  
>> GPIO comes from SoC then "circuit path" and finally chip reset input.
>>
>> What do you propose if h/w circuit path has simple voltage level shifter 
>> on transistor. How to differentiate PNP and NPN cases?
> 
> Hmm. Ah well, I clearly jumped too fast on this set and should have
> left it for a while longer (I rushed a little as I'm away next weekend
> and the cycle is moving towards rc3)
> 
> Sorry about that.
> 
> Anyhow, I am tempted to queue a revert of this patch.  The level
> shifting case hadn't occurred to me (oops).
> 
> Thoughts?

Well here is the full story.

- I found that chip's reset line is active low per datasheet, but device
tree for board I work with states it is active high

- I checked driver code and found that driver depends on this incorrect
setting, it won't work if device tree will state that gpio is active low

- I could revert values in driver code AND in device tree, this way make
device tree be correct (against reality) but make dtb files flashed into
existing systems incompatible with future kernels -  which I disliked

- Thus I thought that I can remove explicit definition of polarity from
device tree (replacing it with neutrally-looking zero), and change
driver to use _raw.  I assumed that there is no real gain to let device
tree override gpio polarity for signal that is per-datasheet always
active low

- Thinking further on this, I realized that for common case signal
polarity is something defined by chip, and thus this knowledge belongs
to chip's driver and not to chip user's device tree. Moreover, device
tree writer could easily be not aware of signal polarity (too many
datasheets are NDA-closed), thus hello copy-pasting, try-and-check and
other counterproductive approaches.

- Then Vladimir pointed real-life case with signal inversion by handmade
level shifter. Although scope of this is likely limited to hw labs,
support for this is wanted and thus some way to override polarity in
chip user's dts be available.  Still, this should be optional, without
requiring dts to always define polarity of each gpio.


It becomes obvious that this topic has global scope, it is not something
to solve within hi8345 driver or within iio.  For patch in question,
possibilities are:
- revert the patch, restore situation with driver depending on wrong
statement in dts, maybe document that in bindings,
- replace patch with code assuming that device tree has correct
definition of reset gpio polarity; break existing device trees (all are
out-of-tree as of today),
- keep the patch, thus not break anything and still stop requiring
device tree to contain wrong statement, but make entire situation
somewhat hacky and loose support for board reverting signal between gpio
provider and hi8435's pin (hopefully no such board exists).

I don't know. Maintainer should decide.

Nikita
