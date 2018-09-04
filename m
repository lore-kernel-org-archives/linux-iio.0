Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46493 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIDXkI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2018 19:40:08 -0400
MIME-Version: 1.0
References: <20180904200434.10442-1-afonsobordado@az8.co> <20180904200434.10442-2-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-2-afonsobordado@az8.co>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Sep 2018 22:13:28 +0300
Message-ID: <CAHp75Vcki7T4d00CFGDSvkAg27wxAO5xnXaX7g9V-N3MzxNrSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: gyro: add device tree support for fxas21002c
To: afonsobordado@az8.co
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 4, 2018 at 10:06 PM Afonso Bordado <afonsobordado@az8.co> wrote:
>
> This patch adds device tree support for the fxas21002c driver, including
> bindings.
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>

> +#ifdef CONFIG_OF

> +#endif

Please, remove this ifdef...

> +               .of_match_table = of_match_ptr(fxas21002c_of_ids),

...and do not use of_match_ptr() macro.

This prevents to use device on embedded ACPI enabled devices,

>         },
>         .probe          = fxas21002c_probe,
>         .id_table       = fxas21002c_id,
> --
> 2.18.0
>
>


-- 
With Best Regards,
Andy Shevchenko
