Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56197 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeGDSxz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 14:53:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so7495613wmv.5
        for <linux-iio@vger.kernel.org>; Wed, 04 Jul 2018 11:53:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javier@dowhile0.org>,
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
 <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
 <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <77df915c-c80e-be5b-3c02-f3a543992783@redhat.com>
Date: Wed, 4 Jul 2018 20:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Andy,

On 07/04/2018 06:11 PM, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 4:44 PM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 07/04/2018 03:24 PM, Nikolaus Voss wrote:
> 
>>> I hope you're still not annoyed...
>> Don't worry for that, it's very hard to get my annoyed :)
> 
> Javier, thanks for your patience and nice explanation!
> 

You are welcome. I'm glad you found it useful!

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
