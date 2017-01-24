Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33450 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAXSTu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2017 13:19:50 -0500
MIME-Version: 1.0
In-Reply-To: <129f7b91-67ee-624c-7b57-cd1ed1499270@gmail.com>
References: <20170121144212.8858-1-marek.vasut@gmail.com> <20170123170827.tkatb2aizjhbfifo@rob-hp-laptop>
 <63b3660b-6ce0-134c-ef79-c06430c735c5@gmail.com> <CAMuHMdUVwQoqQbrsGtbvxK9PoHae3n=UuJYijTMToUsdc=8=mQ@mail.gmail.com>
 <d4fc63bf-c455-2ac4-15d2-6f240799d3e9@gmail.com> <CAMuHMdWr_a6OUAAkS+HnUqUHgQ+H+2Q3WGrX2ou6W1R8X6YfQw@mail.gmail.com>
 <129f7b91-67ee-624c-7b57-cd1ed1499270@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Jan 2017 19:19:47 +0100
Message-ID: <CAMuHMdUJ1mPtTHknc+D-98xz6=FbtKTTETBqswgae=9UnJUbDg@mail.gmail.com>
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

On Tue, Jan 24, 2017 at 5:39 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 01/24/2017 08:30 AM, Geert Uytterhoeven wrote:
>> On Tue, Jan 24, 2017 at 12:15 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> What about this ?
>>>
>>> - compatible:   Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>>>                 The <chip> can be either of:
>>>                 r8a7791 - for the GyroADC block present in r8a7791 SoC
>>>                 r8a7792 - for the GyroADC with interrupt block present
>>>                           in r8a7792 SoC
>>
>> No, we need the exact string in the document, cfr. all other Renesas bindings.
>>
>> "renesas,r8a7791-gyroadc"
>> "renesas,r8a7792-gyroadc"
>
> This ?
>
> - compatible:   Should be "<soc-specific>", "renesas,rcar-gyroadc".
>                 The <soc-specific> should be one of:
>                 renesas,r8a7791-gyroadc - for the GyroADC block present
>                                           in r8a7791 SoC
>                 renesas,r8a7792-gyroadc - for the GyroADC with interrupt
>                                           block present in r8a7792 SoC

Yes. I had expected that double quotes were mandatory, but apparently
checkpatch doesn't require that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
