Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48216 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbbKORqf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 12:46:35 -0500
Subject: Re: [PATCH 1/2] iio: st_sensors: support active-low interrupts
To: Linus Walleij <linus.walleij@linaro.org>
References: <1447445896-12655-1-git-send-email-linus.walleij@linaro.org>
 <56485F18.7000608@kernel.org>
 <CACRpkdYi9t_NBjWfBf4qr3XMx7zA62UkBRO-VF1fCUjuX48K_A@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5648C4F8.5020603@kernel.org>
Date: Sun, 15 Nov 2015 17:46:32 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdYi9t_NBjWfBf4qr3XMx7zA62UkBRO-VF1fCUjuX48K_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/15 16:26, Linus Walleij wrote:
> On Sun, Nov 15, 2015 at 11:31 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>>> This patch requires the previously sent patch to switch the
>>> driver to request_any_context_irq().
>>
>> Really requires or will create some fuzz without it?  Looks like
>> the latter so if we end up discussing that one for a while
>> I might reorder.  Mind you early in this cycle anyway so
>> no rush on this one!
> 
> I can put all three patches in a series and put this before that
> patch, no problem.
Might be wise as we can get this one sorted anyway whilst seeing
if we can get some input on the other one from others...

> 
>> p.s. If anyone fancies adding support for the venerable
>> lis3l02dq as well so we can kill off my ancient driver
>> in staging that would be great! (I know I should do it
>> myself probably but I can always hope someone else will
>> get there first ;)
> 
> They are all so similar that I could probably code up
> support from the datasheet.
> 
> However I have no hardware to test on...
> 
> Who submitted that driver in the first place?
<tries to look innocent>... That would be me ;)

Back at the dawn of time for IIO - this was one of our original 
drivers (the sca3000 was to and that's still in staging too - 
that one is a seriously odd beast).

Technically I still have a board with one lis3l02dq on it
somewhere around, but I haven't booted it in a few years and
it has darned silly connectors so wiring it up to something else
would be 'interesting'. Not to mention, if I recall correctly
this chip only gives level interrupts and the board only
has edge triggered ones.  Were some nasty games to discover
if new data had turned up whilst you were reading the old stuff.

I'm almost tempted to drop the driver entirely on the basis
the only boards I know ever had one have been unavailable for
a long time and I'm the maintainer of those anyway and given
complete lack of patches for the last 5 years may have the only
ones that even work (probably) any more...

I can always bring it back up if I ever actually make the board
boot again.

p.s. Now it will turn out there are hundreds of people using 
intel research stargate 2 imb400 sensor boards....
(they were also compatible and sold by CrossBow for their
imote 2 boards but those went all .net for no apparent reason.

It was interesting hardware.  The camera board for instance
had no pull ups on the i2c bus so the tinyos driver that was
the only documentation effectively simply never read back or
checked for acks from the sensor.  Gives you an idea of the
fun.  Still these were very small boards that well predated
the gumstix etc.

Ah, the glory days when I regularly fired up actual hardware!

Jonathan

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

