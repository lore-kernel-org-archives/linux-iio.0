Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48998 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdISOno (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2017 10:43:44 -0400
Date: Tue, 19 Sep 2017 15:43:38 +0100
In-Reply-To: <CAO=notztVut511sG-M0h6+KscSMHduivewGX3beYmnQw8uSKNA@mail.gmail.com>
References: <CAO=notxZP-vOxPnbkB5Wu3yoyncy5-MdxvYxmSNRRcs==4ck7Q@mail.gmail.com> <CACPK8XfHL0+H0-XqgD3VrkB=6xPFk=gWmR4kkxE=ym97AzfL6A@mail.gmail.com> <CAO=notztVut511sG-M0h6+KscSMHduivewGX3beYmnQw8uSKNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: GPIO Configuration for IIO-HWMON Channel
To: Patrick Venture <venture@google.com>, Joel Stanley <joel@jms.id.au>
CC: Rick Altherr <raltherr@google.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <BB1BC7C8-0606-48BE-A5BC-7CD943269639@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 19 September 2017 15:28:42 BST, Patrick Venture <venture@google.com> wrote:
>+linux-iio
>
>On Mon, Sep 18, 2017 at 10:45 PM, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Hey Patrick,
>>
>> On Tue, Sep 19, 2017 at 2:55 AM, Patrick Venture <venture@google.com>
>wrote:
>> > I have a system where there is a GPIO gating whether a line to the
>ADC is
>> > active. I'm routing the ADC channels through iio-hwmon.
>> >
>> > I'm considering that it might be prudent to tell iio-hwmon that it
>needs to
>> > set the GPIO and wait some configurable amount of time before
>trying to read
>> > that channel.
>> >
>> >
>https://github.com/torvalds/linux/blob/master/drivers/hwmon/iio_hwmon.c#L43
>> >
>> > I'm curious if there are strong thoughts about whether that kind of
>thing
>> > belongs in that level or whether it should be pushed to the
>aspeed_adc
>> > driver.
>>
>> That's a tricky one.
>>
>> I'd suggest the code to flip the GPIO should go in the aspeed_adc.c,
>> and failing that in the iio subsystem, not in the hwmon bridge.
>
>Ok, so I can extend the properties of the aspeed_adc to support
>specifying a GPIO per channel, and then add the logic to handle this
>possible per channel configuration.  I had to ask, but I assume
>there's some standard to how these things are specifying in the
>device-tree.  For instance, each fan has its own configuration under
>the aspeed-pwm-tacho driver, so arguably it could be channel@{index}
>to specify for whichever have such a requirement.

Wait up.  No this doesn't belong in the ADC driver unless it is a feature of the ADC itself.

You need to represent the hardware doing the gating explicitly.
>
>>
>> I assume this GPIO needs to be switched at runtime (ie, it's not
>> something that is muxed one way or the other at boottime and left
>> static)?
>
>Correct.
>
>>
>> Is it a case that the GPIO should be asserted while the ADC is
>> sampling, and then deasserted afterwards?
>
>That is also correct.

There is the mux framework (just merged recently) for doing exactly this.

Can send links later but on phone only today.

J

>
>>
>> > Also, please let me know if I'm not reaching the correct people for
>this
>> > particular discussion.
>>
>> You could instead go to the iio list.

That would be better as others such as Peter Rosin who wrote the mux framework may reply.

Jonathan
>>
>> Cheers,
>>
>> Joel

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
