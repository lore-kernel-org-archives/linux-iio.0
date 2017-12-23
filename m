Return-Path: <SRS0=naJP=DT=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1513984753-3040-1-git-send-email-milan.o.stevanovic@gmail.com>
References: <1513984753-3040-1-git-send-email-milan.o.stevanovic@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 23 Dec 2017 15:13:03 +0100
Message-ID: <CAOFm3uFn+z+ouTNM5HOw3FEgBhW3T4WiPRwtPuwapq_m4wHWKQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: add driver for ti adc081s/adc101s/adc121s
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Milan,

On Sat, Dec 23, 2017 at 12:19 AM, Milan Stevanovic
<milan.o.stevanovic@gmail.com> wrote:
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>

<snip>

May be it is just me, but you may be missing a commit message?

<snip>

> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc081s.c
> @@ -0,0 +1,239 @@
> +/*
> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit ADC driver
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Could you consider using an SPDX tag here as documented by Thomas in
this patch set [1] ?
This is the new thing for this end of of year and a must have for 2018!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
