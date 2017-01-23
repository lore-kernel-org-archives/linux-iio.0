Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35631 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAWUlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2017 15:41:32 -0500
MIME-Version: 1.0
In-Reply-To: <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com>
References: <20170121144212.8858-1-marek.vasut@gmail.com> <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
 <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jan 2017 21:41:29 +0100
Message-ID: <CAMuHMdUVwQoqQbrsGtbvxK9PoHae3n=UuJYijTMToUsdc=8=mQ@mail.gmail.com>
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

On Mon, Jan 23, 2017 at 8:56 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 01/23/2017 06:08 PM, Rob Herring wrote:
>> On Sat, Jan 21, 2017 at 03:42:11PM +0100, Marek Vasut wrote:
>>> new file mode 100644
>>> index 000000000000..081947367135
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt

>>> +Required properties:
>>> +- compatible:       Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>>
>> Need to enumerate <chip>.
>
> It's enumerated below , the only special-case we handle at this point is
> the r8a7792 , which has extra interrupt block which we don't use anyway,
> but the driver disables those interrupts.

It is not enumerated below. You just give an example for r8a7791.

Please list all supported/tested compatible values, so checkpatch
can validate compatible values in DTS patches adding GyroADC device
nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
