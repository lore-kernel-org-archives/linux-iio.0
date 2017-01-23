Return-Path: <SRS0=QQz1=ZF=gmail.com=marek.vasut@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add Renesas GyroADC bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170121144212.8858-1-marek.vasut@gmail.com>
 <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
 <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com>
 <CAMuHMdUVwQoqQbrsGtbvxK9PoHae3n=UuJYijTMToUsdc=8=mQ@mail.gmail.com>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms+renesas@verge.net.au>,
 Jonathan Cameron <jic23@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d4fc63bf-c455-2ac4-15d2-6f240799d3e9@gmail.com>
Date: Tue, 24 Jan 2017 00:15:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUVwQoqQbrsGtbvxK9PoHae3n=UuJYijTMToUsdc=8=mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/23/2017 09:41 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Jan 23, 2017 at 8:56 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 01/23/2017 06:08 PM, Rob Herring wrote:
>>> On Sat, Jan 21, 2017 at 03:42:11PM +0100, Marek Vasut wrote:
>>>> new file mode 100644
>>>> index 000000000000..081947367135
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> 
>>>> +Required properties:
>>>> +- compatible:       Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>>>
>>> Need to enumerate <chip>.
>>
>> It's enumerated below , the only special-case we handle at this point is
>> the r8a7792 , which has extra interrupt block which we don't use anyway,
>> but the driver disables those interrupts.
> 
> It is not enumerated below. You just give an example for r8a7791.
> 
> Please list all supported/tested compatible values, so checkpatch
> can validate compatible values in DTS patches adding GyroADC device
> nodes.

What about this ?

- compatible:   Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
                The <chip> can be either of:
                r8a7791 - for the GyroADC block present in r8a7791 SoC
                r8a7792 - for the GyroADC with interrupt block present
                          in r8a7792 SoC

-- 
Best regards,
Marek Vasut
