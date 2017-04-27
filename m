Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37486 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933955AbdD0E7y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 00:59:54 -0400
Subject: Re: [PATCH] iio: adc: Derive interface clock speed from fck clock
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20170420154310.32759-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdX4MWKBRKPG6OtRycGFRhOGmR556sR_SWBR3D6Sd+tggA@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <db48a38f-cbca-2396-90b4-9d2426e49095@kernel.org>
Date: Thu, 27 Apr 2017 05:59:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX4MWKBRKPG6OtRycGFRhOGmR556sR_SWBR3D6Sd+tggA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/17 18:30, Geert Uytterhoeven wrote:
> On Thu, Apr 20, 2017 at 5:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> The "if" interface clock speed is actually derived from the "fck"
>> block clock, as in the hardware they are the same clock. Drop the
>> incorrect second "if" clock and get the clock speed from "fck".
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: linux-renesas-soc@vger.kernel.orgPlease include the name of the driver in the patch title.
I've added it.

> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

