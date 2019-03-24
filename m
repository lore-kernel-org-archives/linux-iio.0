Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BEC43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9199222EC
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCXPI1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:08:27 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38058 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 11:08:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id DFA9D9E76FE;
        Sun, 24 Mar 2019 15:08:25 +0000 (GMT)
Date:   Sun, 24 Mar 2019 15:08:24 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/5] iio: imu: adis: generalize burst mode support
Message-ID: <20190324150824.5f74cf77@archlinux>
In-Reply-To: <20190322204442.4035-2-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
        <20190322204442.4035-2-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 22:44:39 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Some variants in the ADIS16400 family support burst mode. This mechanism is
> implemented in the `adis16400_buffer.c` file.
> 
> Some variants in ADIS16480 are also adding burst mode, which is
> functionally similar to ADIS16400, but with different parameters. To get
> there, a `adis_burst` struct is added to parametrize certain bits of the
> SPI communication to setup: the register that triggers burst-mode, and the
> extra-data-length that needs be accounted for when building the bust-length
> buffer.
> 
> The trigger handler cannot be made generic, since it's very specific to
> each ADIS164XX family.
> 
> A future enhancement of this `adis_burst` mode will be the possibility to
> enable/disable burst-mode. For the ADIS16400 family it's hard-coded to on
> by default. But for ADIS16480 there will be a need to disable this.
This sounds interesting. I'll wait to see why you need to disable it :)
From what I recall there are definitely advantages to turning it off if
you have a disconnected set of channels to read.

Been a long time since I fired one of these up, though I think the one I have
still works so I might move it into a more regular test set.

> 
> When that will be implemented, both ADIS16400 & ADIS16480 will have the
> burst-mode enable-able/disable-able.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400_buffer.c |  7 +++----
>  drivers/iio/imu/adis16400_core.c   |  8 ++++++++
>  include/linux/iio/imu/adis.h       | 14 ++++++++++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
> index 268349eb51c7..199bd72348eb 100644
> --- a/drivers/iio/imu/adis16400_buffer.c
> +++ b/drivers/iio/imu/adis16400_buffer.c
> @@ -22,7 +22,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  	unsigned int burst_length;
>  	u8 *tx;
>  
> -	if (st->variant->flags & ADIS16400_NO_BURST)
> +	if (!adis->burst || !adis->burst->en)
>  		return adis_update_scan_mode(indio_dev, scan_mask);
>  
>  	kfree(adis->xfer);
> @@ -30,8 +30,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	/* All but the timestamp channel */
>  	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
> -	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> -		burst_length += sizeof(u16);
> +	burst_length += adis->burst->extra_len;
>  
>  	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
>  	if (!adis->xfer)
> @@ -42,7 +41,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  		return -ENOMEM;
>  
>  	tx = adis->buffer + burst_length;
> -	tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
> +	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
>  	tx[1] = 0;
>  
>  	adis->xfer[0].tx_buf = tx;
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 34d52863377a..0d799e983d74 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -146,6 +146,11 @@ enum adis16400_chip_variant {
>  	ADIS16448,
>  };
>  
> +static struct adis_burst adis16400_burst = {
> +	.en = true,
> +	.reg_cmd = ADIS16400_GLOB_CMD,
> +};
> +
>  static int adis16334_get_freq(struct adis16400_state *st)
>  {
>  	int ret;
> @@ -973,6 +978,9 @@ static int adis16400_probe(struct spi_device *spi)
>  	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
>  		adis16400_setup_chan_mask(st);
>  		indio_dev->available_scan_masks = st->avail_scan_mask;
> +		st->adis.burst = &adis16400_burst;
> +		if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> +			st->adis.burst->extra_len = sizeof(u16);
>  	}
>  
>  	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index cb6c3ed13459..26141ee87cfb 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -21,6 +21,7 @@
>  #define ADIS_REG_PAGE_ID 0x00
>  
>  struct adis;
> +struct adis_burst;
>  
>  /**
>   * struct adis_data - ADIS chip variant specific data
> @@ -59,6 +60,7 @@ struct adis {
>  	struct iio_trigger	*trig;
>  
>  	const struct adis_data	*data;
> +	struct adis_burst	*burst;
>  
>  	struct mutex		txrx_lock;
>  	struct spi_message	msg;
> @@ -234,6 +236,18 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  
>  #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
>  
> +/**
> + * struct adis_burst - ADIS data for burst transfers
> + * @en			burst mode enabled
> + * @reg_cmd		register command that triggers burst
> + * @extra_len		extra length to account in the SPI RX buffer
> + */
> +struct adis_burst {
> +	bool		en;
> +	unsigned int	reg_cmd;
> +	unsigned int	extra_len;
> +};
> +
>  int adis_setup_buffer_and_trigger(struct adis *adis,
>  	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
>  void adis_cleanup_buffer_and_trigger(struct adis *adis,

