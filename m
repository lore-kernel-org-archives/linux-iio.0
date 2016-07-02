Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbcGBLpY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 Jul 2016 07:45:24 -0400
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
 <20160702110227.GB4604@lukather>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b02394e-b38b-c804-780b-e9707c292486@redhat.com>
Date: Sat, 2 Jul 2016 13:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160702110227.GB4604@lukather>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 02-07-16 13:02, Maxime Ripard wrote:
> On Sat, Jul 02, 2016 at 11:32:07AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 02-07-16 11:12, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
>>> <alexandre.belloni@free-electrons.com> wrote:
>>>> Document the bindings for the Allwinner LRADC.
>>>
>>> We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>>> and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
>>> block.
>>
>> Right, this block is used on many tablets and some dev boards to
>> provide buttons (as in the hid type) and the block is designed for
>> this purpose, giving an irq when the adc level crosses a certain
>> threshold.
>>
>> Sure it can be used in a more generic way, but that is not its
>> primary goal.
>
> We've always had a different view on this, but it's a detail :)
>
>> So any generic purpose adc driver must not break the current
>> use-case (which is already used in mainline kernel dts files
>> in plenty of cases).
>
> Yep.
>
>> I believe that the best way to deal with this is to add an
>> "allwinner,general-purpose-mode" flag to the existing binding
>> (as well as document general purpose mode in the existing
>> binding rather then in a new binding doc).
>>
>> That seems to be the right thing to do purely looking at this
>> from a dt binding pov.
>
> There's a way simpler solution: if there's no child nodes, it's meant
> to be used as an ADC, otherwise, as input.
>
> The logic will have to be a bit more complex than that, since there's
> two channels, and you could only require one for the buttons, leaving
> the other one available as an ADC.
>
> But that doesn't require any new property.

True, if there are no button nodes, then go general-purpose will
work too.

>> For the implementation of this we can simpy have 2 drivers,
>> then both drivers can check the flag and if present return
>> -ENODEV from the existing input driver and likewise if not
>> present return -ENODEV from the iio driver.
>>
>> We may actually use a similar solution for the touchscreen
>> controller which can also be alternatively used as a generic
>> purpose adc.
>
> There's no need to keep both drivers as long as we keep the features
> and bindings.

That is also true.

Regards,

Hans
