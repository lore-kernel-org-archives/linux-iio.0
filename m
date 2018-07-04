Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:44652 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934466AbeGDMbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 08:31:36 -0400
Date: Wed, 4 Jul 2018 14:31:32 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Javier Martinez Canillas <javier@dowhile0.org>
cc: Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com> <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com> <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com> <alpine.DEB.2.20.1807041332340.9872@fox.voss.local> <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
> On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>

[snip]

> But this discussion isn't really related to your patch. I think is
> correct but just said that (b) wasn't a justification to leave the I2C
> table, points (a) and (c) are though. I won't really be convinced that
> the fallback is the correct thing to do or even a good idea.

I didn't want to annoy you, I just wanted to understand why you think 
fallback is such a bad thing that you call it a bug. And I see, it has its 
drawbacks ;-). Anyway, thanks for taking the time to clarify this,

Niko

[snip]

