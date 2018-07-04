Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:43448 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbeGDLPX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 07:15:23 -0400
Date: Wed, 4 Jul 2018 13:15:18 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Javier Martinez Canillas <javierm@redhat.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com>
Message-ID: <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com> <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com> <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:

> Hi Andy,
>
> On 07/04/2018 12:19 PM, Andy Shevchenko wrote:
>> Summon Javier to the discussion.
>> For my opinion he is an expert in this topic.
>
> I wouldn't call myself an expert in anything to be honest :)
>
> [snip]
>
>>
>>> The table is not used by the driver, but is necessary to
>>>
>>> a) bind an i2c device declared via i2c_board_info with type field set
>>>    to one of the names of the i2c_device_id table to this driver
>>> b) bind an i2c device declared via DT or ACPI but with no match in of_id/
>>>    acpi_id table but an i2c_device_id table match to this driver (fallback
>>>    matching)
>>> c) create the right modaliases at compile time for this driver to make
>>>    module auto-loading work in case of a) and b)
>>
>
> I think Nikolaus is correct, assuming that the driver can be used on legacy
> platforms that register the I2C devices using board files / platform data.
> In that case you still need a I2C device ID table for (a) and (c) as he said.
>
> I don't buy on (b) though, that's a bug in my opinion. If you register an I2C
> device via DT then you must have a OF device ID entry that matches the device
> and the same for ACPI. You can't rely on the I2C device table to do the match.

Ok, in my opinion it is an elegant way of not bloating the driver when no
explicit handling (e.g. reading DT properties) is needed. Just adding an
of_device_id doesn't change any driver functionality then but only maps to
an already existing i2c_table_id.

>
> I would also remove the struct i2c_device_id .driver_data fields from the I2C
> device ID table, since are not used and just makes reading the code confusing
> (only the struct i2c_device_id .name is used as far as I can see).

Valid point, thanks. I will change that.

>
>> Javier, just a summary of the above. Nikolaus switched one driver to
>> use ->probe_new() hook and left i2c ID table at the same time.
>> My understanding that this table is not anymore in use.
>>
>> But I have to admit I didn't see entire picture of this. Can you shed a light?
>>
>
> So to shed some light, in the past even {OF,ACPI}-only drivers needed an I2C ID
> table because: 1) the .probe callback had a struct i2c_device_id * parameter
> and 2) the I2C core always reported a modalias of the form i2c:<foo> even for
> devices registered via OF.

It could have been a null pointer and device driver binding (and 
auto-loading) done just via driver.name.

Niko

