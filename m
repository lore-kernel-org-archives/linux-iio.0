Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A53C282E1
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2016206A3
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfDVI4c (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:56:32 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41722 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVI4c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Apr 2019 04:56:32 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id EB1D69E8C5F;
        Mon, 22 Apr 2019 09:56:29 +0100 (BST)
Date:   Mon, 22 Apr 2019 09:56:27 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V2] iio: ad_sigma_delta: Don't put SPI transfer buffer
 on the stack
Message-ID: <20190422095627.4d115944@archlinux>
In-Reply-To: <20190416081916.26287-1-alexandru.ardelean@analog.com>
References: <20190409075821.26104-1-alexandru.ardelean@analog.com>
        <20190416081916.26287-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Apr 2019 11:19:16 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> will not work on some architectures when using DMA.
> 
> This also avoids potential stack corruption, as it makes sure that the
> buffer is in it's own cacheline and (obviously) not on the stack.
> 
> Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alex,

Thanks for the update.

I'm unclear why we can't just use one large buffer for both cases?
i.e put the reg_data usecases in the buf_data buffer (renamed).

Jonathan
> ---
> Changelog v1 -> v2:
> * added ____cacheline_aligned to `buf_data`
> * extended comment about cacheline
> * added fixes tag
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++-----------
>  include/linux/iio/adc/ad_sigma_delta.h |  3 ++-
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index af6cbc683214..02d9049b9218 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ad_sd_set_comm);
>  int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	unsigned int size, unsigned int val)
>  {
> -	uint8_t *data = sigma_delta->data;
> +	uint8_t *data = sigma_delta->reg_data;
>  	struct spi_transfer t = {
>  		.tx_buf		= data,
>  		.len		= size + 1,
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(ad_sd_write_reg);
>  static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
>  	unsigned int reg, unsigned int size, uint8_t *val)
>  {
> -	uint8_t *data = sigma_delta->data;
> +	uint8_t *data = sigma_delta->reg_data;
>  	int ret;
>  	struct spi_transfer t[] = {
>  		{
> @@ -148,24 +148,24 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
>  {
>  	int ret;
>  
> -	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->data);
> +	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->reg_data);
>  	if (ret < 0)
>  		goto out;
>  
>  	switch (size) {
>  	case 4:
> -		*val = get_unaligned_be32(sigma_delta->data);
> +		*val = get_unaligned_be32(sigma_delta->reg_data);
>  		break;
>  	case 3:
> -		*val = (sigma_delta->data[0] << 16) |
> -			(sigma_delta->data[1] << 8) |
> -			sigma_delta->data[2];
> +		*val = (sigma_delta->reg_data[0] << 16) |
> +			(sigma_delta->reg_data[1] << 8) |
> +			sigma_delta->reg_data[2];
>  		break;
>  	case 2:
> -		*val = get_unaligned_be16(sigma_delta->data);
> +		*val = get_unaligned_be16(sigma_delta->reg_data);
>  		break;
>  	case 1:
> -		*val = sigma_delta->data[0];
> +		*val = sigma_delta->reg_data[0];
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -403,12 +403,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	uint8_t *data = sigma_delta->buf_data;
>  	unsigned int reg_size;
>  	unsigned int data_reg;
> -	uint8_t data[16];
>  	int ret;
>  
> -	memset(data, 0x00, 16);
> +	memset(sigma_delta->buf_data, 0x00, sizeof(sigma_delta->buf_data));
>  
>  	reg_size = indio_dev->channels[0].scan_type.realbits +
>  			indio_dev->channels[0].scan_type.shift;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 6e9fb1932dde..d95216ce8a94 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -79,7 +79,8 @@ struct ad_sigma_delta {
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	uint8_t				data[4] ____cacheline_aligned;
> +	uint8_t				reg_data[4] ____cacheline_aligned;
> +	uint8_t				buf_data[16] ____cacheline_aligned;
The usual assumption is that a device is safe against itself, so we can't
get cacheline corruption in a single action from the device to itself.
This does make me wonder why we have two buffers like this at all though!

>  };
>  
>  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,

