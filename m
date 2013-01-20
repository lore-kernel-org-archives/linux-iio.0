Return-Path: <jic23@kernel.org>
Message-ID: <50FBDE85.8040207@kernel.org>
Date: Sun, 20 Jan 2013 12:09:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, jbrenner@taosinc.com,
 amit.kucheria@verdurent.com, pmeerw@pmeerw.net
Subject: Re: [PATCH 0/5] iio:light:tsl2563 cleanup and move out of staging.
References: <1357986924-11471-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Peter,

Are you happy this this modified set?
I always feel a little bit naughty pushing patches on without
any acks or reviewed by tags...

Jonathan

On 01/12/2013 10:35 AM, Jonathan Cameron wrote:
> This series more or less consists of the original move patch after
> some precursors fixing the various bits and bobs Peter found in his
> review.  I also dropped a few other unnecessary bits spotted
> whilst making Peter's changes.
> 
> Jonathan Cameron (5):
>   staging:iio:light:tsl2563 drop unnecessary brackets around constants.
>   staging:iio:light:tsl2563 clean comments up.
>   staging:iio:tsl2563 Simplify exit path on error in
>     read_interrupt_config.
>   staging:iio:tsl2563 drop pointless forward declaration
>   iio:light:tsl2563 move out of staging
> 
>  drivers/iio/light/Kconfig             |  10 +
>  drivers/iio/light/Makefile            |   1 +
>  drivers/iio/light/tsl2563.c           | 887 +++++++++++++++++++++++++++++++++
>  drivers/staging/iio/light/Kconfig     |  10 -
>  drivers/staging/iio/light/Makefile    |   1 -
>  drivers/staging/iio/light/tsl2563.c   | 899 ----------------------------------
>  drivers/staging/iio/light/tsl2563.h   |   9 -
>  include/linux/platform_data/tsl2563.h |   9 +
>  8 files changed, 907 insertions(+), 919 deletions(-)
>  create mode 100644 drivers/iio/light/tsl2563.c
>  delete mode 100644 drivers/staging/iio/light/tsl2563.c
>  delete mode 100644 drivers/staging/iio/light/tsl2563.h
>  create mode 100644 include/linux/platform_data/tsl2563.h
> 
