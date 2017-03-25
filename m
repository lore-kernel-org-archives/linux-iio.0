Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42987 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdCYPrg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 11:47:36 -0400
Subject: Re: [PATCH 1/5] iio: xoadc: augment DT bindings a bit
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20170318133358.22314-1-linus.walleij@linaro.org>
 <20170324151235.cb73gokg26qy7fvc@rob-hp-laptop>
 <CACRpkdaZmauodn+xvSudUELCRrO4j7Dj+SM+H4bkkqQMeJ6EoA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <77146a0f-6b24-e65f-f89c-bc49ca115e34@kernel.org>
Date: Sat, 25 Mar 2017 15:47:33 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdaZmauodn+xvSudUELCRrO4j7Dj+SM+H4bkkqQMeJ6EoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 15:25, Linus Walleij wrote:
> On Fri, Mar 24, 2017 at 4:12 PM, Rob Herring <robh@kernel.org> wrote:
>> On Sat, Mar 18, 2017 at 02:33:58PM +0100, Linus Walleij wrote:
> 
>>> -- #address-cells: should be set to <1>
>>> +- #address-cells: should be set to <2>, the first cell is the
>>> +  prescaler (on PM8058) or premux (on PM8921) with two valid bits
>>> +  so legal values are 0x00, 0x01 or 0x02. The second cell
>>> +  is the main analog mux setting (0x00..0x0f). The combination
>>> +  of prescaler/premux and analog mux uniquely addresses a hardware
>>> +  channel on all systems.
>>
>> 64-bits to describe 48 possible combinations... I'd just combine these
>> into 1 cell.
> 
> That was what I did first but it becomes very unintuitive and
> require translation using tables etc from the datasheets. You
> have to shuffle and stuff bits to get that one cell value.
> 
> The addressing is really done in two steps:
> 
> premux -> mux -> channel
> 
> Example:
> 
> Premux 0x02
> Mux 0x08
> 
> I guess I could of course put that into one cell using 4+4 bits
> and form 0x28.
> 
> On the other hand, that is not how the hardware works, because
> there premux/prescaler and analog mux are two separate things.
> 
>>>  - reg: should contain the hardware channel number in the range
>>> -  0 .. 0x0f (4 bits). The hardware only supports 16 channels.
>>> +  0 .. 0xff (8 bits).
>>> +
>>> +  On PM8058 the hardware only supports 16 channels, but we get the same
>>> +  channels repeating with its input divided down by 1 or 3. Channels 00,
>>> +  10, 20, ... f0 are the raw values, 04, 14, 24 .. f4 are "unity" channels
>>> +  divided by 1, and 08, 18, 28 .. f8 are channels divided by 3. Bits 0
>>> +  and 1 of the channel index should always be 0.
>>> +
>>> +  On PM8921 the hardware supports more than 16 channels through a complex
>>> +  routing matrix using a premux, so 00, 10, 20 .. f0 are the basic raw
>>> +  channels while another set of channels appear for 04, 14, 24 .. f4,
>>> +  and again some of the same channels appear again divided down by 3
>>> +  in 08, 18, 28 .. f8. Again bits 0 and 1 of the channel index should
>>> +  always be 0.
>>
>> Now I'm lost...
> 
> That is actually how it looks with the old scheme, which you are
> kind of requesting that I use instead. In a way it's good that I left
> the old documentation in there because it illustrates my problem
> with what you request above: lots of "holes" in that address
> space and very unituitive numbers.
> 
I definitely agree that clarity is probably better than worrying about the
few extra bytes...

Jonathan
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

