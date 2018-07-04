Return-Path: <SRS0=UZJs=JU=loewensteinmedical.de=nikolaus.voss@kernel.org>
Date: Wed, 4 Jul 2018 11:09:53 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Xiongfeng Wang <xiongfeng.wang@linaro.org>, linux-iio@vger.kernel.org,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nv@vosn.de
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 9:37 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>
>>> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>
>>>> struct i2c_device_id argument of probe() is not used, so use probe_new()
>>>> instead.
>>>>
>>>
>>> This makes...
>>>
>>>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>>>
>>>
>>> ...this table obsolete IIUC. At least that's what I did when switched
>>> to ->probe_new() in some drivers.
>>>
>>> If I'm mistaken (again? :-) ) I would hear from someone to point me
>>> how it can be used after a switch.
>>
>>
>> It is still used by the i2c-core in i2c_device_match() if DT and ACPI
>> matching fails.
>
>> And it is used to create the corresponding modaliases for
>> driver loading.
>
> My question is "How?!"
> I don't really see any points to match against it after switching to
> ->probe_new().
>
> Could you point me to the code path in i2c (or OF?) core for that?

As written above in i2c-core-base.c: i2c_device_match() -> 
i2c_match_id(driver->id_table,...

This is used for driver matching before probe() or probe_new() of the 
device driver can be called. probe_new() actually is a function signature 
change only.

Niko
