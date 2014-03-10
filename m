Return-Path: <knaack.h@gmx.de>
Message-ID: <531E3BE5.3090603@gmx.de>
Date: Mon, 10 Mar 2014 23:25:41 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio: Move ad799x driver out of staging
References: <1394447484-29334-1-git-send-email-lars@metafoo.de> <1394447484-29334-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1394447484-29334-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen schrieb:
> The driver is now at a reasonable quality level. Move it out of staging.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/Kconfig                                     | 11 +++++++++++
>  drivers/iio/adc/Makefile                                    |  1 +
>  drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} |  0
>  drivers/staging/iio/adc/Kconfig                             | 11 -----------
>  drivers/staging/iio/adc/Makefile                            |  3 ---
>  5 files changed, 12 insertions(+), 14 deletions(-)
>  rename drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} (100%)
>
>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
