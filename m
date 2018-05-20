Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeETKyG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:54:06 -0400
Date: Sun, 20 May 2018 11:53:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/12] staging: iio: ad2s1200: Add kernel docs to
 driver state
Message-ID: <20180520115359.3efc80fe@archlinux>
In-Reply-To: <38a9e24e5cdbc98afbf4d06f9848c55c26ce37ff.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <38a9e24e5cdbc98afbf4d06f9848c55c26ce37ff.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:21:34 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Add missing kernel docs to the ad2s1200 driver state.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Nice.

Applied,

Jonathan
> ---
> Changes in v4:
>  - Simplified explanation of lock.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 9bdcf0c86217..068aa86e9c11 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -32,6 +32,14 @@
>  /* clock period in nano second */
>  #define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
>  
> +/**
> + * struct ad2s1200_state - driver instance specific data.
> + * @lock:	protects both the GPIO pins and the rx buffer.
> + * @sdev:	spi device.
> + * @sample:	GPIO pin SAMPLE.
> + * @rdvel:	GPIO pin RDVEL.
> + * @rx:		buffer for spi transfers.
> + */
>  struct ad2s1200_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;

