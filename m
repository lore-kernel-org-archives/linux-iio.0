Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46508 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdBYQV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:21:26 -0500
Subject: Re: [RFC 4/4] iio: trigger: add GPIO trigger
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
 <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
 <3e2653fe-874c-d761-b274-ffe889df18a7@kernel.org>
 <03234803-c75d-bd1a-492b-761c0d5218ff@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com, linus.walleij@linaro.org,
        Gregor Boirie <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <efefd474-4cfc-1e46-0c73-4be584ade7eb@kernel.org>
Date: Sat, 25 Feb 2017 16:21:22 +0000
MIME-Version: 1.0
In-Reply-To: <03234803-c75d-bd1a-492b-761c0d5218ff@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/02/17 16:24, Fabrice Gasnier wrote:
> On 02/18/2017 08:19 PM, Jonathan Cameron wrote:
>> On 17/02/17 16:16, Lars-Peter Clausen wrote:
>>> On 02/17/2017 05:03 PM, Fabrice Gasnier wrote:
>>>> GPIOs can be used to generate triggers for any IIO device.
>>>> Introduce generic GPIO trigger driver. It offers some options
>>>> to tune polarity (e.g. rising/falling edge), and label so trigger
>>>> name may be customized.
>>>> By default, gpio triggers will be named gpiotrigX, where X is gpio
>>>> number as returned by desc_to_gpio() call.
>>>> Rising edge is selected if polarity isn't set.
>>>
>>> If you want to use the GPIO only as an interrupt, just use it as an
>>> interrupt directly, no need to go the route via the GPIO.
>> Absolutely.  The majority of the bindings will then just become standard
>> interrupt bindings and will be effectively handled for you.
>>
>> Please work to extend the existing interrupt trigger driver rather than adding
>> this new one.  That one actually started as a gpio trigger then got
>> generalised into a interrupt trigger later so lets not do that again ;)
> 
> Hi Lars, Jonathan
> 
> Ok, got it.
> I'll drop this and focus on interrupt trigger, if this is worth having DT for it (e.g. patch 1 & 2 of this RFC).
> 
> BTW, I figured out there has been this patch a year ago, on interrupt trigger, to add device tree support:
> http://www.spinics.net/lists/linux-iio/msg23126.html
> Any reason why it hasn't found its way in ?
Gregor being very busy I suspect and not having time to address the reviews.

I 'think' the conclusion then was we needed some representative device that
could exist in devicetree to allow us to specify that a particular interrupt
could be used to trigger sensor capture.

Not a big issue, but probably still needs implementing unless Gregor has had
a chance to look at this.

Jonathan


> 
> Thanks for reviewing,
> Best Regards,
> Fabrice
> 
>>
>> Jonathan
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

