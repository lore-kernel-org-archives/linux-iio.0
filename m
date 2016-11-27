Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41489 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbcK0MAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 07:00:25 -0500
Subject: Re: [PATCH v3 0/7] mux controller abstraction and iio/i2c muxes
To: Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
 <b132143c-259b-6ed2-58c5-b223cc2e72df@metafoo.de>
 <3870654b-8cf5-30cb-74cd-c5fb1559adba@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d287dc3b-3605-d85d-1aa6-40f3bdcdc72c@kernel.org>
Date: Sun, 27 Nov 2016 12:00:19 +0000
MIME-Version: 1.0
In-Reply-To: <3870654b-8cf5-30cb-74cd-c5fb1559adba@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/11/16 11:47, Peter Rosin wrote:
> On 2016-11-22 21:58, Lars-Peter Clausen wrote:
>> On 11/21/2016 02:17 PM, Peter Rosin wrote:
>> [...]
>>> I have a piece of hardware that is using the same 3 GPIO pins
>>> to control four 8-way muxes. Three of them control ADC lines
>>> to an ADS1015 chip with an iio driver, and the last one
>>> controls the SDA line of an i2c bus. We have some deployed
>>> code to handle this, but you do not want to see it or ever
>>> hear about it. I'm not sure why I even mention it. Anyway,
>>> the situation has nagged me to no end for quite some time.
>>>
>>> So, after first getting more intimate with the i2c muxing code
>>> and later discovering the drivers/iio/inkern.c file and
>>> writing a couple of drivers making use of it, I came up with
>>> what I think is an acceptable solution; add a generic mux
>>> controller driver (and subsystem) that is shared between all
>>> instances, and combine that with an iio mux driver and a new
>>> generic i2c mux driver. The new i2c mux I called "simple"
>>> since it is only hooking the i2c muxing and the new mux
>>> controller (much like the alsa simple card driver does for ASoC).
>>
>> While abstracting this properly is all nice and good and the way it should
>> be done, but it also adds a lot of complexity and the devicetree adds a lot
>> of restrictions on what can actually be represented.
> 
> This is a characterization without any specifics. But is the
> characterization true? You have two complaints, complexity
> and restrictions with bindings.
> 
>> There is a certain point where the fabric on a PCB becomes so complex that
>> it deserves to be a device on its own (like the audio fabric drivers).
>> Especially when the hardware is built with a certain application in mind and
>> the driver is supposed to impose policy which reflects this application. The
>> latter can often not properly be described with the primitives the
>> devicetree can offer.
>>
>> And I think your setup is very borderline what can be done in a declarative
>> way only and it adds a lot of complexity over a more imperative solution in
>> form of a driver. I think it is worth investigating about having a driver
>> that is specific to your fabric and handles the interdependencies of the
>> discrete components.
> 
> So, there are three "new" concepts:
> 
> 1. Sticking a mux in front of an AD-converter. That's not all that
> novel, nor complex. Quite the opposite, I'd say. In fact, I find it
> a bit amazing that there is no in-kernel support for it.
As ever first person who needs it and has the skills to write it gets to do it ;)
Congratulations Peter ;)
> 
> 2. Reusing the same GPIO-pins to drive different muxes. There are
> obviously chips that work this way (as Jonathan pointed out) and
> these will at some point get used in Linux devices. I guess they
> already are used, but that people handle them in userspace. Or
> something? If this is complex, which I question, it will still need
> support at some point. At least that's what I believe.
> 
> 3. Using the same GPIO pins to mux things handled by different
> subsystems. Right, this is a bit crazy, and I'd rather not have this
> requirement, but this HW is what it is so I'll need to handle it in
> some way. It is also what stops me from falling back to a userspace
> solution, which is probably connected to why #1 and #2 is not supported
> by the kernel; everybody probably does muxing in userspace. Which is
> not necessarily a good idea, nor how it's supposed to be done...
> 
> So, the only thing that's out of the ordinary (as I see it), is #3.
> The question that then needs an answer is how the in-kernel solution
> for #1 and #2 would look if we do not consider #3.
> 
> And I claim that the desired solution to #1 and #2 is pretty close
> to my proposal.
> 
> A. You do not want mux-controller drivers in every subsystem that
> needs them.
Agreed.
> 
> B. You do not want every mux-consumer to know the specifics of how to
> operate every kind of mux; there are muxes that are not controlled
> with GPIO pins...
> 
> C. When you implement muxing in a subsystem, there will in some cases
> be a need to handle parallel muxing, where there is a need to share
> mux-controllers.
> 
> It just feels right to separate out the mux-controller and refer to
> it from where a mux is needed. It solves #1 and #2. And, of course,
> as a bonus #3 is also solved. But my bias is obvious.
> 
> And that leads us to the restrictions with the bindings. And the same
> thing happens; the solution for #2 also solves #3.
> 
> So how do you refer to a mux-controller from where it's needed? My
> first proposal used a dt phandle, for the second round I put them in
> the parent node. It would be super if it was possible for the mux-
> consumer to create the mux-controller device from the same dt
> node that is already bound to the mux-consumer. The problem is that
> the mux-consumer should not hard-code which mux-controller device it
> should create. The best I can think of is some kind of 'mux-compatible'
> attribute, that works like the standard 'compatible' attribute. That
> would simplify the bindings for the normal case (#1) where the mux-
> controller isn't shared (#2 and #3). Maybe it's possible to fix this
> issue somehow? I simply don't know?
As Lars stated, it's marginal.  The question is not at what point do we
'have to' bother with a fabric driver, but rather at what point does it
make a our lives easier.

Take you nastiest mux case described earlier.
The ideal would be to represent the ADC and 3 muxes as (approximately) a
single ADC to userspace that just happens to have somewhere near 23 inputs.

To do that in device tree we need to describe

1 The adc
2 The three muxes
3 The software representation to pull all of these back into a single device.

That last part to my mind trips the balance to the point where a fabric driver
would make sense.  It's not complex.  Just a few lines of code tying all the
elements together without ending up with a fairly fiendish setup to describe in
device tree.

Also just wait until we have muxes stacked on muxes, with cross overs occuring.
Some of the ASoC parts can actually have effective loops if you try all the mux
combinations.

So question is do we have a 'simple case description' in device tree or force
fabric drivers everywhere?  I think I'm in favour of the simple case - which handles
one of your two uses nicely.  The second one to do the the recombining of channels after
the muxes, ends up looking to me like it needs a fabric driver.

Note we are only talking about bindings vs code based description here. I agree
entirely with the concept of a generic mux subsystem.

Jonathan

> 
> Cheers,
> Peter
> 

