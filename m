Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60735 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759992AbbJ3USk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Oct 2015 16:18:40 -0400
MIME-Version: 1.0
In-Reply-To: <20151030194150.GD24668@usrtlx11787.corpusers.net>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151030184220.GJ4058@x1> <20151030194150.GD24668@usrtlx11787.corpusers.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 30 Oct 2015 15:18:18 -0500
Message-ID: <CAL_Jsq+d+_JgiEfQpgD29AnD+bM7Nq94-5NTjK=LFHNg162UOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] devicetree: mfd: Add binding for the TI LM3533
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Lee Jones <lee.jones@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Johan Hovold <jhovold@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 30, 2015 at 2:41 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Fri 30 Oct 11:42 PDT 2015, Lee Jones wrote:
>
> Rob, please see the discussion regarding ti,boost-freq-khz below. Should
> we both specify unit at the same time as we use standard units? (This is
> not the first time I have to change this back and forth)
>
>> On Tue, 27 Oct 2015, Bjorn Andersson wrote:
>>
> [..]
>> > +- ti,hwen-gpios:
>> > +   Usage: required
>> > +   Value type: <prop-encoded-array>
>> > +   Definition: reference to gpio pin connected to the HWEN input; as
>> > +               specified in "gpio/gpio.txt"
>>
>> Why have you made this a vendor binding?
>>
>> *-gpios is a generic property.
>>
>
> Because the hwen gpio is a ti lm3533 specific thing, but I get what
> you're saying. Will drop the prefix.

Actually, that is fine. -gpios is common, but the rest is specific to
a binding. But if it is a common function, then a common name would be
fine. Enable gpios are common for example.

>> > +- ti,als-supply:
>> > +   Usage: optional
>> > +   Value type: <prop-encoded-array>
>> > +   Definition: reference to regulator powering the V_als input; as
>> > +               specified in "regulator/regulator.txt"
>>
>> Same goes for *-supply.
>>
>
> Same here
>
>> > +- ti,boost-freq-khz:
>> > +   Usage: required
>> > +   Value type: <u32>
>> > +   Definition: switch-frequency of the boost converter, must be either:
>> > +               500 or 1000
>>
>> Quite a few vendors are using 'boost' now.
>>
>
> The ti,boost-low-freq from the bq25890 binding is the only other
> property I can find that describes the same thing. So I'm not sure I
> follow you here.
>
>> Perhaps we need to create a set of generic bindings.
>>
>> Also, we usually measure DT bindings in HZ, not kHz.

Surprisingly, there are not enough examples to draw much conclusion.

> I thought we had defined frequencies to be in HZ and HZ only, but then
> Rob's comment that I need to actually specify the unit doesn't make any
> sense.

I don't think we decided, but let's decide now. Go with Hz.

Really, I first prefer the property name has units and second having
standardized units. But if there is a common property without units, I
prefer that even more.

> Do we want these properties in a standard unit or do we want them
> specifying the unit? Having both seems excessive.

You mean "freq" would imply the units? No, we want the actual units in
the property.

Rob
