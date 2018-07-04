Return-Path: <SRS0=PsDH=JU=dowhile0.org=javier@kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com> <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 4 Jul 2018 14:09:37 +0200
Message-ID: <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:

[snip]

>>>
>>> Ok, in my opinion it is an elegant way of not bloating the driver when no
>>> explicit handling (e.g. reading DT properties) is needed. Just adding an
>>> of_device_id doesn't change any driver functionality then but only maps
>>> to
>>> an already existing i2c_table_id.
>>>
>>
>> I disagree, in the case of OF for example a compatible string is
>> composed of both a vendor a device, the complete tuple is what should
>> be matched.
>>
>> But with the fallback, only the device portion would be used so both
>> <foo,bar> and <baz,bar> will match against the i2c device with id
>> "bar". It may or may not be correct but the vendor portion is very
>> important to disambiguate.
>
>
> Disambiguation via DT implies there is already a name collision in i2c
> modalias name space, so adding an of_id would work around this collision for

There wouldn't be a name collision between OF modaliases in that case
since the vendor would be different (of:N*T*Cfoo,bar and
of:N*T*Cbaz,bar). So it wouldn't be a problem for DT-only drivers.

> DT enumeration. I2c_board_info driver binding would still be broken. The
> right fix would be to remove the name collision.
>

Yes, for legacy drivers using board files it would be an issue. But
that's unrelated to what I'm saying. What I don't think is correct is
to ignore the vendor prefix since that's part of the compatible string
semantics.

In general, I think that there should be consistency between the
firmware interface used to register the device, how the module alias
uevent is reported to auto-load a driver and how the driver is matched
with the device. So drivers supporting DT should have a n OF table
(and export it with MODULE_DEVICE_TABLE), drivers supporting ACPI
should have a ACPI table and so on.

But this discussion isn't really related to your patch. I think is
correct but just said that (b) wasn't a justification to leave the I2C
table, points (a) and (c) are though. I won't really be convinced that
the fallback is the correct thing to do or even a good idea.

[snip]

>>>
>>> It could have been a null pointer and device driver binding (and
>>> auto-loading) done just via driver.name.
>>>
>>
>> I'm not sure I understood this comment.
>
>
> What I was trying to say is that if the i2c_device_id table information was
> not needed (i.d. only one single id), even the old probe() could be used
> without defining an i2c_device_id table, the i2c_device_id* argument to
> probe() being a nullptr.
>

I see, yes that would work too. I didn't authored the .probe_new
callback so I don't know if other options were discussed. I also can't
remember if the I2C core attempted to probe even without an I2C device
ID table, I thought it didn't but I can be wrong.

> Niko

Best regards,
Javier
