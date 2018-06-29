Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36104 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755478AbeF2UT5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jun 2018 16:19:57 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Jun 2018 23:19:55 +0300
Message-ID: <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 29, 2018 at 1:30 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> When trying to instantiate a st_accel_i2c device from an ACPI based
> system, I ran into some problems:
>
> For my device, there is no ACPI match table entry, so rather than
> creating /allocating a new ACPI HID for the device, I wanted to use an
> existing DT table compatible entry via creating an ACPI_DT_NAMESPACE_HID
> /PRP0001 HID ACPI entry (see Documentation/acpi/enumeration.txt).
>
> This did not work because st_accel_i2c.c bails out if there is a ACPI
> node but no ACPI table match instead of looking for a match from one of
> the fallback mechanisms (patch 1).
>
> Patch 2 removes an error message when a ACPI node exists but no table
> entry is found (this doesn't need to be fatal because of the fallback).
>
> Patch 3 syncs the strings in the I2C device table (which is used by the
> I2C core for fallback matching) with the DT compatible strings, so a
> PRP0001 entry can use the same compatible strings as a corresponding
> DT entry. As far as I can see, the old I2C table strings aren't used
> in mainline, so renaming them should be safe.
>

I'm not sure I understand how ->probe_new() is supposed to work
against i2c_id_table, but I don't care for legacy platform data
anyway.

What I would like to point to is device_get_match_data() API which
should simplify / unify the case how you get driver data.

> Nikolaus Voss (3):
>   IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum failed
>   IIO: st_sensors_i2c.c: Don't print error on failed ACPI match
>   IIO: st_accel.h: sync DT and I2C device ID table strings
>
>  drivers/iio/accel/st_accel.h                  | 32 +++++++++----------
>  drivers/iio/accel/st_accel_i2c.c              | 21 ++++++------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  5 ++-
>  3 files changed, 30 insertions(+), 28 deletions(-)
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
