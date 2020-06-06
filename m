Return-Path: <SRS0=GbNs=7T=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A1C433E0
	for <linux-iio@archiver.kernel.org>; Sat,  6 Jun 2020 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B118E207D3
	for <linux-iio@archiver.kernel.org>; Sat,  6 Jun 2020 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591457125;
	bh=Ijxz6nrVlTapeHb7V5fHGePLuao8sVVuail/bq1MCDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JWavfcfhOllheu73zfpDmzxYvgvhKsrXXMmZb8Ya2ijwqiOVldQ/erSzPQTZ4srts
	 hTyaE5CTNc8qz85r4Bq6F7ezpPg0Mk4Uk+sZ/3TdmUX9sVglb1P/Yr/ujBkU4QFRPA
	 3RLkx7rS19FPUdWCSe98wNvzmfPYfSvmUDXj3fYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgFFPZZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgFFPZY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 11:25:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A01A207BC;
        Sat,  6 Jun 2020 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591457124;
        bh=Ijxz6nrVlTapeHb7V5fHGePLuao8sVVuail/bq1MCDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CtPvFsVsK201iwyNxyOlKqs06CLqLP2LTFVWxY/kYYzyZt6Q3sdlg+gZlkVopm4+Y
         qAzl6L3QWqUE68uMxJwAN/32YWduT5A+rVQLF5fR1E55lAoqeIS8L0knfJMuWwf78j
         9A3rubHimjAsJwDGToFAGoj3GfHtUNFytJFTi2A4=
Date:   Sat, 6 Jun 2020 16:25:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: core: add iio_device_set_parent() helper
Message-ID: <20200606162520.5f314bc5@archlinux>
In-Reply-To: <20200603114023.175102-3-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
        <20200603114023.175102-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jun 2020 14:40:19 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> By default, the device allocation will also assign a parent device to the
> IIO device object. In cases where devm_iio_device_alloc() is used,
> sometimes the parent device must be different than the device used to
> manage the allocation.
> 
> In that case, this helper should be used to change the parent, hence the
> requirement to call this between allocation & registration.
> 
> This pattern/requirement is not very common in the IIO space, and it may be
> cleaned up later.
> But until then, assigning the parent manually between allocation &
> registration is slightly easier.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

That does the job nicely.

Applied,

Jonathan

> ---
>  include/linux/iio/iio.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 91a69f4751aa..5784f8c9508f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -649,6 +649,26 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
>  	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
>  }
>  
> +/**
> + * iio_device_set_parent() - assign parent device to the IIO device object
> + * @indio_dev: 		IIO device structure
> + * @parent:		reference to parent device object
> + *
> + * This utility must be called between IIO device allocation
> + * (via devm_iio_device_alloc()) & IIO device registration
> + * (via {devm_}iio_device_register()).
> + * By default, the device allocation will also assign a parent device to
> + * the IIO device object. In cases where devm_iio_device_alloc() is used,
> + * sometimes the parent device must be different than the device used to
> + * manage the allocation.
> + * In that case, this helper should be used to change the parent, hence the
> + * requirement to call this between allocation & registration.
> + **/
> +static inline void iio_device_set_parent(struct iio_dev *indio_dev,
> +					 struct device *parent)
> +{
> +	indio_dev->dev.parent = parent;
> +}
>  
>  /**
>   * iio_device_set_drvdata() - Set device driver data

