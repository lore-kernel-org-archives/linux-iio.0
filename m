Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeDUQt6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:49:58 -0400
Date: Sat, 21 Apr 2018 17:49:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/13] staging: iio: ad2s1200: Add kernel docs to
 driver state
Message-ID: <20180421174952.1e3b5ee0@archlinux>
In-Reply-To: <2e083c69b1d249fe05badc94250c39db24d523e0.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <2e083c69b1d249fe05badc94250c39db24d523e0.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:30:03 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Add missing kernel docs to the ad2s1200 driver state.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 357fe3c382b3..f07aab7e7a35 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -33,6 +33,14 @@
>  /* clock period in nano second */
>  #define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
>  
> +/**
> + * struct ad2s1200_state - driver instance specific data
> + * @lock:	protect driver state

This doc for locks needs to be more specific.  From a quick
glance I think it does two things.
1) Ensures that we don't have concurrent accesses changing the
gpio control lines.
2) Protects the rx buffer against concurrent accesses.

It doesn't have anything much to do with the rest of this state
structure.

> + * @sdev:	spi device
> + * @sample:	GPIO pin SAMPLE
> + * @rdvel:	GPIO pin RDVEL
> + * @rx:		buffer for spi transfers
> + */
>  struct ad2s1200_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;

