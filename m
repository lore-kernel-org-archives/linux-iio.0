Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B264C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91852148D
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCXRtG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:49:06 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39212 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXRtG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 13:49:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 94E7F9E74A6;
        Sun, 24 Mar 2019 17:49:04 +0000 (GMT)
Date:   Sun, 24 Mar 2019 17:49:03 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: ad_sigma_delta: Introduce prepare_channel callback
Message-ID: <20190324174903.77158070@archlinux>
In-Reply-To: <20190319095306.16010-1-alexandru.ardelean@analog.com>
References: <20190319095306.16010-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Mar 2019 11:53:06 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> The prepare channel callback will be called before starting a conversion and
> can be used by the driver to configure the chip according to the selected
> channel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hi Alexandru,

Not without a user....  I.e. I want to see a driver using this before
I apply it. In of itself, it is fine but right now I can't answer the
'why?' question!

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c       |  5 +++++
>  include/linux/iio/adc/ad_sigma_delta.h | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ff5f2da2e1b1..00808838edd8 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -285,6 +285,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  		return -EBUSY;
>  
>  	mutex_lock(&indio_dev->mlock);
> +	ad_sigma_delta_prepare_channel(sigma_delta, chan);
>  	ad_sigma_delta_set_channel(sigma_delta, chan->address);
>  
>  	spi_bus_lock(sigma_delta->spi->master);
> @@ -351,6 +352,10 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	channel = find_first_bit(indio_dev->active_scan_mask,
>  				 indio_dev->masklength);
> +	ret = ad_sigma_delta_prepare_channel(sigma_delta,
> +		&indio_dev->channels[channel]);
> +	if (ret)
> +		goto err_predisable;
>  	ret = ad_sigma_delta_set_channel(sigma_delta,
>  		indio_dev->channels[channel].address);
>  	if (ret)
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 7e84351fa2c0..21ee12543bdd 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -31,6 +31,8 @@ struct iio_dev;
>  
>  /**
>   * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
> + * @prepare_channel: Will be called to prepare and configure a channel, may be
> + *                   NULL.
>   * @set_channel: Will be called to select the current channel, may be NULL.
>   * @set_mode: Will be called to select the current mode, may be NULL.
>   * @postprocess_sample: Is called for each sampled data word, can be used to
> @@ -43,6 +45,8 @@ struct iio_dev;
>   *   be used.
>   */
>  struct ad_sigma_delta_info {
> +	int (*prepare_channel)(struct ad_sigma_delta *,
> +		const struct iio_chan_spec *);
>  	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
>  	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
>  	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
> @@ -81,6 +85,15 @@ struct ad_sigma_delta {
>  	uint8_t				data[4] ____cacheline_aligned;
>  };
>  
> +static inline int ad_sigma_delta_prepare_channel(struct ad_sigma_delta *sd,
> +	const struct iio_chan_spec *chan)
> +{
> +	if (sd->info->prepare_channel)
> +		return sd->info->prepare_channel(sd, chan);
> +
> +	return 0;
> +}
> +
>  static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
>  	unsigned int channel)
>  {

