Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:38244 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeGBGuW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2018 02:50:22 -0400
Date: Mon, 2 Jul 2018 08:41:23 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
In-Reply-To: <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Jun 2018, Andy Shevchenko wrote:

> I'm not sure I understand how ->probe_new() is supposed to work
> against i2c_id_table, but I don't care for legacy platform data
> anyway.
>
> What I would like to point to is device_get_match_data() API which
> should simplify / unify the case how you get driver data.

This driver doesn't need any driver data/ platform_data beyond the 
i2c_id_table name (which has already been matched when probe()/ 
probe_new() is called), so strictly neither of_match_table nor 
apci_match_table would be necessary, because i2c DT/ ACPI enumeration also 
matches against i2c_table names.

But thanks for the hint ;-).

Niko

