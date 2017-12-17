Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdLQJos (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 04:44:48 -0500
Date: Sun, 17 Dec 2017 09:44:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 2/7] iio: adc: ina2xx: Clarify size requirement for
 data buffer
Message-ID: <20171217094430.4e4908ca@archlinux>
In-Reply-To: <bbf3bcc5-a23c-4f2d-a6be-a349fea93252@rwthex-w2-a.rwth-ad.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <bbf3bcc5-a23c-4f2d-a6be-a349fea93252@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:47 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> The timestamp is inserted into the buffer after the sample data by
> iio_push_to_buffers_with_timestamp, document the space requirement for
> the timestamp.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied and pushed out as testing for the autobuilders to play with it.
Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 3195f8754c3b..8c8120406f52 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -700,7 +700,8 @@ static const struct iio_chan_spec ina219_channels[] = {
>  static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  {
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> -	unsigned short data[8];
> +	/* data buffer needs space for channel data and timestap */
> +	unsigned short data[4 + sizeof(s64)/sizeof(short)];
>  	int bit, ret, i = 0;
>  	s64 time_a, time_b;
>  	unsigned int alert;

