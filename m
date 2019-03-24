Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E0C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A23222EC
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCXPKG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:10:06 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38076 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPKG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 11:10:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 156489E76FE;
        Sun, 24 Mar 2019 15:10:03 +0000 (GMT)
Date:   Sun, 24 Mar 2019 15:10:02 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 3/5] iio: imu: adis16400: move burst logic to ADIS lib
Message-ID: <20190324151002.449ee707@archlinux>
In-Reply-To: <20190322204442.4035-3-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
        <20190322204442.4035-3-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 22:44:40 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> This change has been done separately, so that it's easier to visualize the
> changed logic in the adis_scan_update() function.
> 
> Most of the function in this `adis16400_update_scan_mode()` that deals with
> burst-mode will be re-used in the ADIS16480, but with different parameters.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Bit of fuzz in here when applying.  Otherwise all looks fine.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/Makefile           |  1 -
>  drivers/iio/imu/adis16400.h        | 16 --------
>  drivers/iio/imu/adis16400_buffer.c | 59 ------------------------------
>  drivers/iio/imu/adis16400_core.c   |  2 +-
>  drivers/iio/imu/adis_buffer.c      | 40 ++++++++++++++++++++
>  5 files changed, 41 insertions(+), 77 deletions(-)
>  delete mode 100644 drivers/iio/imu/adis16400_buffer.c
> 
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 5fd87701259f..c9f85126fbe1 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -5,7 +5,6 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  adis16400-y             := adis16400_core.o
> -adis16400-$(CONFIG_IIO_BUFFER) += adis16400_buffer.o
>  obj-$(CONFIG_ADIS16400) += adis16400.o
>  obj-$(CONFIG_ADIS16460) += adis16460.o
>  obj-$(CONFIG_ADIS16480) += adis16480.o
> diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
> index 93b6c0c41fdd..7e2e0dbaa2e1 100644
> --- a/drivers/iio/imu/adis16400.h
> +++ b/drivers/iio/imu/adis16400.h
> @@ -194,20 +194,4 @@ enum {
>  	ADIS16400_SCAN_TIMESTAMP,
>  };
>  
> -#ifdef CONFIG_IIO_BUFFER
> -
> -ssize_t adis16400_read_data_from_ring(struct device *dev,
> -				      struct device_attribute *attr,
> -				      char *buf);
> -
> -
> -int adis16400_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *scan_mask);
> -
> -#else /* CONFIG_IIO_BUFFER */
> -
> -#define adis16400_update_scan_mode NULL
> -
> -#endif /* CONFIG_IIO_BUFFER */
> -
>  #endif /* SPI_ADIS16400_H_ */
> diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
> deleted file mode 100644
> index 199bd72348eb..000000000000
> --- a/drivers/iio/imu/adis16400_buffer.c
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/interrupt.h>
> -#include <linux/mutex.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/bitops.h>
> -#include <linux/export.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -
> -#include "adis16400.h"
> -
> -int adis16400_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *scan_mask)
> -{
> -	struct adis16400_state *st = iio_priv(indio_dev);
> -	struct adis *adis = &st->adis;
> -	unsigned int burst_length;
> -	u8 *tx;
> -
> -	if (!adis->burst || !adis->burst->en)
> -		return adis_update_scan_mode(indio_dev, scan_mask);
> -
> -	kfree(adis->xfer);
> -	kfree(adis->buffer);
> -
> -	/* All but the timestamp channel */
> -	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
> -	burst_length += adis->burst->extra_len;
> -
> -	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
> -	if (!adis->xfer)
> -		return -ENOMEM;
> -
> -	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
> -	if (!adis->buffer)
> -		return -ENOMEM;
> -
> -	tx = adis->buffer + burst_length;
> -	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
> -	tx[1] = 0;
> -
> -	adis->xfer[0].tx_buf = tx;
> -	adis->xfer[0].bits_per_word = 8;
> -	adis->xfer[0].len = 2;
> -	adis->xfer[1].rx_buf = adis->buffer;
> -	adis->xfer[1].bits_per_word = 8;
> -	adis->xfer[1].len = burst_length;
> -
> -	spi_message_init(&adis->msg);
> -	spi_message_add_tail(&adis->xfer[0], &adis->msg);
> -	spi_message_add_tail(&adis->xfer[1], &adis->msg);
> -
> -	return 0;
> -}
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 0d799e983d74..265c0a46597f 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -887,7 +887,7 @@ static const struct iio_info adis16400_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &adis16400_read_raw,
>  	.write_raw = &adis16400_write_raw,
> -	.update_scan_mode = adis16400_update_scan_mode,
> +	.update_scan_mode = adis_update_scan_mode,
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
>  
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 36607d52fee0..a2fa6e75b13e 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -20,6 +20,43 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> +static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask)
> +{
> +	struct adis *adis = iio_device_get_drvdata(indio_dev);
> +	unsigned int burst_length;
> +	u8 *tx;
> +
> +	/* All but the timestamp channel */
> +	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
> +	burst_length += adis->burst->extra_len;
> +
> +	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
> +	if (!adis->xfer)
> +		return -ENOMEM;
> +
> +	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
> +	if (!adis->buffer)
> +		return -ENOMEM;
> +
> +	tx = adis->buffer + burst_length;
> +	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
> +	tx[1] = 0;
> +
> +	adis->xfer[0].tx_buf = tx;
> +	adis->xfer[0].bits_per_word = 8;
> +	adis->xfer[0].len = 2;
> +	adis->xfer[1].rx_buf = adis->buffer;
> +	adis->xfer[1].bits_per_word = 8;
> +	adis->xfer[1].len = burst_length;
> +
> +	spi_message_init(&adis->msg);
> +	spi_message_add_tail(&adis->xfer[0], &adis->msg);
> +	spi_message_add_tail(&adis->xfer[1], &adis->msg);
> +
> +	return 0;
> +}
> +
>  int adis_update_scan_mode(struct iio_dev *indio_dev,
>  	const unsigned long *scan_mask)
>  {
> @@ -32,6 +69,9 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  	kfree(adis->xfer);
>  	kfree(adis->buffer);
>  
> +	if (adis->burst && adis->burst->en)
> +		return adis_update_scan_mode_burst(indio_dev, scan_mask);
> +
>  	scan_count = indio_dev->scan_bytes / 2;
>  
>  	adis->xfer = kcalloc(scan_count + 1, sizeof(*adis->xfer), GFP_KERNEL);

