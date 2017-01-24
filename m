Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36029 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdAXHaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2017 02:30:22 -0500
MIME-Version: 1.0
In-Reply-To: <d4fc63bf-c455-2ac4-15d2-6f240799d3e9@gmail.com>
References: <20170121144212.8858-1-marek.vasut@gmail.com> <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
 <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com> <CAMuHMdUVwQoqQbrsGtbvxK9PoHae3n=UuJYijTMToUsdc=8=mQ@mail.gmail.com>
 <d4fc63bf-c455-2ac4-15d2-6f240799d3e9@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Jan 2017 08:30:15 +0100
Message-ID: <CAMuHMdWr_a6OUAAkS+HnUqUHgQ+H+2Q3WGrX2ou6W1R8X6YfQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Add Renesas GyroADC bindings
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Tue, Jan 24, 2017 at 12:15 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 01/23/2017 09:41 PM, Geert Uytterhoeven wrote:
>> On Mon, Jan 23, 2017 at 8:56 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 01/23/2017 06:08 PM, Rob Herring wrote:
>>>> On Sat, Jan 21, 2017 at 03:42:11PM +0100, Marek Vasut wrote:
>>>>> new file mode 100644
>>>>> index 000000000000..081947367135
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>
>>>>> +Required properties:
>>>>> +- compatible:       Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>>>>
>>>> Need to enumerate <chip>.
>>>
>>> It's enumerated below , the only special-case we handle at this point is
>>> the r8a7792 , which has extra interrupt block which we don't use anyway,
>>> but the driver disables those interrupts.
>>
>> It is not enumerated below. You just give an example for r8a7791.
>>
>> Please list all supported/tested compatible values, so checkpatch
>> can validate compatible values in DTS patches adding GyroADC device
>> nodes.
>
> What about this ?
>
> - compatible:   Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>                 The <chip> can be either of:
>                 r8a7791 - for the GyroADC block present in r8a7791 SoC
>                 r8a7792 - for the GyroADC with interrupt block present
>                           in r8a7792 SoC

No, we need the exact string in the document, cfr. all other Renesas bindings.

"renesas,r8a7791-gyroadc"
"renesas,r8a7792-gyroadc"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
