Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:44360 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeGDLcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 07:32:46 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so4587201ioh.11
        for <linux-iio@vger.kernel.org>; Wed, 04 Jul 2018 04:32:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 4 Jul 2018 13:32:45 +0200
Message-ID: <CABxcv=nSPj6q8-QoPQ99Cc0hk76XM9y1n8XACp_vJwyR+n6cpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 4, 2018 at 1:26 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

[snip]

>> Ok, in my opinion it is an elegant way of not bloating the driver when no
>> explicit handling (e.g. reading DT properties) is needed. Just adding an
>> of_device_id doesn't change any driver functionality then but only maps to
>> an already existing i2c_table_id.
>>
>
> I disagree, in the case of OF for example a compatible string is
> composed of both a vendor a device, the complete tuple is what should
> be matched.
>
> But with the fallback, only the device portion would be used so both
> <foo,bar> and <baz,bar> will match against the i2c device with id
> "bar". It may or may not be correct but the vendor portion is very
> important to disambiguate.
>

And having a compatible = "bar" is also wrong since the compatible
string would lack the vendor prefix. The fact that the I2C (and SPI)
core allowed this was what caused the problem in the first place IMO.

Best regards,
Javier
