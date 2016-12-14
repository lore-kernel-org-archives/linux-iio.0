Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35199 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbcLNMap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 07:30:45 -0500
MIME-Version: 1.0
In-Reply-To: <a0451d4a-071e-f867-3c1a-77ef8d04733c@jmondi.org>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <1481632629-18826-1-git-send-email-jacopo@jmondi.org> <CAMuHMdUCuBs9Fm+YvsqEc1J_a_2sgg104DDBf39oUD2JQRxXtg@mail.gmail.com>
 <a0451d4a-071e-f867-3c1a-77ef8d04733c@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Dec 2016 13:14:25 +0100
Message-ID: <CAMuHMdXzUiH05qLo1g3UqRvVSR59WS2DxZTop+wc=7EXbNfGmQ@mail.gmail.com>
Subject: Re: [PATCHv2] iio: adc: Add Maxim MAX11100 driver
To: "jacopo@jmondi.org" <jacopo@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jacopo,

On Wed, Dec 14, 2016 at 12:54 PM, jacopo@jmondi.org <jacopo@jmondi.org> wrote:
>>> +struct max11100_state {
>>> +       const struct max11100_chip_desc *desc;
>>> +       struct spi_device *spi;
>>> +       int vref_uv;
>>
>> unsi
>
> Was this a suggestion to turn "vref_uv" into unsigned?

It was a suggestion I started writing, and aborted improperly when noticing
the below ;-)

> As you can see in probe function it can get assigned to -EINVAL when a dummy
> regulator is returned from regulator-core.
> I had to make it signed for this reason

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
