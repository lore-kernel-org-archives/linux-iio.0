Return-Path: <knaack.h@gmx.de>
Message-ID: <531E3BDC.4020609@gmx.de>
Date: Mon, 10 Mar 2014 23:25:32 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:ad799x: Move ring functions to the main
 file
References: <1394447484-29334-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1394447484-29334-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen schrieb:
> The ad799x_ring.c file is pretty much only one function these days. No need to
> keep it in a separate file. Since there is then only one user of the header left
> also move everything from the header to the main file.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/Kconfig       |  13 +--
>  drivers/staging/iio/adc/Makefile      |   1 -
>  drivers/staging/iio/adc/ad799x.h      | 121 ----------------------------
>  drivers/staging/iio/adc/ad799x_core.c | 145 +++++++++++++++++++++++++++++++++-
>  drivers/staging/iio/adc/ad799x_ring.c |  84 --------------------
>  5 files changed, 143 insertions(+), 221 deletions(-)
>  delete mode 100644 drivers/staging/iio/adc/ad799x.h
>  delete mode 100644 drivers/staging/iio/adc/ad799x_ring.c
>
>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
