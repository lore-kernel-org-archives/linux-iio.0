Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58650 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755005AbcIJPu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:50:59 -0400
Subject: Re: [PATCH v3 3/3] iio:pressure: initial zpa2326 barometer support
To: Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <cover.1472841954.git.gregor.boirie@parrot.com>
 <53b4bcc7b2d5de2ed61a0aeebf0898fd7b5aa2cb.1472841954.git.gregor.boirie@parrot.com>
 <c9370190-1859-ab66-eaac-8e7e1dbdbf0d@kernel.org>
 <CACRpkdbHm8Shd_ZqFuciUna8g7vi+s9d9pURqL4SCV1NDg3WuA@mail.gmail.com>
 <57CFD0CB.2070508@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b3b4d84e-580b-bedd-7bfd-666a5f2feb61@kernel.org>
Date: Sat, 10 Sep 2016 16:50:54 +0100
MIME-Version: 1.0
In-Reply-To: <57CFD0CB.2070508@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/16 09:33, Gregor Boirie wrote:
> 
> 
> On 09/07/2016 09:54 AM, Linus Walleij wrote:
>> On Sun, Sep 4, 2016 at 6:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> The nasty here is that we need to validate that the trigger is associate
>>> with this device 'before' allowing others to associate.  Could be done I
>>> think in a slightly more than average complexity validate call.
>>>
>>> * If another trigger is used then pollfunc would have to initialize a oneshot
>>> read as you already have it doing.
>> I guess the new function iio_trigger_using_own() would be pretty helpful
>> for this driver too.
> Yes! I was just looking at your patch :) It would allow me to get rid of
> pointer to own trigger stored in iio device's private state.
> Good point.
Have just applied them to the togreg branch (currently exposed as testing).

Help yourselves ;)

Jonathan
>>
>> Do you think we can merge patch 1+2 of that series (adding the function
>> and using it with the ST sensors) and I will squash patch
>> 3 into my pending MPU-3050 driver and then this driver can rely on it
>> as well?
>>
>> The way I see it is that when handling triggers we should always handle
>> our own as well as any external trigger (e.g. HRTimer, or even a trigger
>> from a different sensor...)
>>
>> Yours,
>> Linus Walleij
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

