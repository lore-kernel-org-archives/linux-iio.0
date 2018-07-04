Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34553 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbeGDNoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 09:44:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so13108643wmc.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Jul 2018 06:44:21 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local>
 <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
 <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
 <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com>
 <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
 <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
 <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
 <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
Date: Wed, 4 Jul 2018 15:44:17 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/2018 03:24 PM, Nikolaus Voss wrote:
> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>> On Wed, Jul 4, 2018 at 2:31 PM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>>>>
>>>> On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
>>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>
>>>
>>> [snip]
>>>
>>>> But this discussion isn't really related to your patch. I think is
>>>> correct but just said that (b) wasn't a justification to leave the I2C
>>>> table, points (a) and (c) are though. I won't really be convinced that
>>>> the fallback is the correct thing to do or even a good idea.
>>>
>>>
>>> I didn't want to annoy you, I just wanted to understand why you think
>>> fallback is such a bad thing that you call it a bug. And I see, it has its
>>> drawbacks ;-). Anyway, thanks for taking the time to clarify this,
>>>
>>
>> Oh, I'm not annoyed, sorry if I sounded that way. What I tried to say
>> is that I've a strong opinion on this and won't be convinced otherwise
>> :)
>>
>> So for me is a bug because that would mean that either an entry is
>> missing in an OF device table or a DTS has a node with a compatible
>> string without a vendor prefix.
> 
> Yes, I see your point (and your strong opinion :-)), but AFAIK vendor 
> prefix is not mandatory... At least for vendor-agnostic drivers like 

The latest Device Tree specification [0] says about the compatible string:

"The recommended format is 'manufacturer,model', where manufacturer is a
string describing the name of the manufacturer (such as a stock ticker
symbol), and model specifies the model number".

> "regulator-fixed" (very popular in dts files). My point is not bloating

I don't think the "regulator-fixed" is a good example. Since the Device Tree
should describe the hardware. The "regulator-fixed" is a convenient way to
describe a fixed voltage regulator but I think is more of an exception.

I'm pretty sure that the DT maintainers wouldn't ack a DT binding with a
compatible string that doesn't have a manufacture prefix nowadays.

> drivers with large redundant (from a driver-functional view) tables when 
> one table could be enough for a properly working driver. Having three 

You need the OF table anyways for module autoload since the I2C core will report
a OF module alias. You can only do the I2C fallback trick if your driver can't
be build as a module. But even in that case you would be ignoring the vendor.

> different names for exactly the same isn't very beautiful IMO.
>

I agree with you on that. But abusing a table used by another firmware interface
isn't beautiful either. So I think the best is to have consistency and always
use the same table for the same firmware interface.

> I hope you're still not annoyed...
> 

Don't worry for that, it's very hard to get my annoyed :)

> Niko
> 

[0]: https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
