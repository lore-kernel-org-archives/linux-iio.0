Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33869 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdEBSqL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 14:46:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170420091624.GM3760@verge.net.au>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
 <1491488454-22468-5-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdXkixLn9xdnrhEXW9pCg-4WjOuoPdyxXYeBwRfetMSYsA@mail.gmail.com> <20170420091624.GM3760@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 May 2017 20:46:09 +0200
Message-ID: <CAMuHMdXcYrt9U8AGbUoQdHUBBT+PgK5XNRU1+rVwBJ6SOsL4gg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: salvator-x: Add current sense amplifiers
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Simon,

On Thu, Apr 20, 2017 at 11:16 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 19, 2017 at 10:40:21AM +0200, Geert Uytterhoeven wrote:
>> Hi Jacopo,
>>
>> On Thu, Apr 6, 2017 at 4:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> > [PATCH v5 4/4] arm64: dts: salvator-x: Add current sense amplifiers
>>
>> This should be "arm64: dts: r8a7796: salvator-x: Add current sense amplifiers".
>> Perhaps Simon can just fix that himself while applying?
>
> Done :)

Apparently not...
Resending for board breakout compensation...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
