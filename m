Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:37173 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933849Ab3BLSxN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Feb 2013 13:53:13 -0500
Message-ID: <511A8FFF.8020807@metafoo.de>
Date: Tue, 12 Feb 2013 19:54:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, patrick.vasseur@c-s.fr
Subject: Re: [PATCH v2] IIO ADC support for AD7923
References: <201302121710.r1CHAWES027406@localhost.localdomain>
In-Reply-To: <201302121710.r1CHAWES027406@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/2013 06:10 PM, Christophe Leroy wrote:
> This patch adds support for Analog Devices AD7923 ADC in the IIO Subsystem.
> 
> Signed-off-by: Patrick Vasseur <patrick.vasseur@c-s.fr>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good to me except for one small, but important issue.

[...]
> diff -urN linux-next-e347c98/drivers/iio/adc/ad7923.c linux-next-e347c98.new/drivers/iio/adc/ad7923.c
> --- linux-next-e347c98/drivers/iio/adc/ad7923.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-next-e347c98.new/drivers/iio/adc/ad7923.c	2013-02-12 15:16:29.000000000 +0100
[...]
> +
> +struct ad7923_state {
> +	struct spi_device		*spi;
> +	struct spi_transfer		ring_xfer[6];

I think 5 is the max number of transfers, one for each channel and one extra to
read the last result.

> +	struct spi_transfer		scan_single_xfer[2];
> +	struct spi_message		ring_msg;
> +	struct spi_message		scan_single_msg;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	__be16				rx_buf[4] ____cacheline_aligned;
> +	__be16				tx_buf[2];

The tx buffer also needs to be 4 elements.

> +};
[...]
