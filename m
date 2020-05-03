Return-Path: <SRS0=u9I9=6R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E02C28CBC
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3353207DD
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588520376;
	bh=7ugReJw62PCRt6fde0BnQlWhcam2vXexqDlVSZCxoGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UCqLGccNa3nfgEGfKD4NrS5TDN3OG4a6bQDqvkYhTDFMdjudNYXcmcJ8ZAwKHPonZ
	 1Zqn+jBc7uX3w9KwfeF9AQ9L0p/Syd3j0AW2lEH36LaFpTurh32tZRCyJxJImag95j
	 4h0dKyJTLLEWTdqstmQoZBN5wSaNGO9htTnzGKTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgECPjg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 May 2020 11:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgECPjf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 11:39:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2295020757;
        Sun,  3 May 2020 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588520375;
        bh=7ugReJw62PCRt6fde0BnQlWhcam2vXexqDlVSZCxoGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gX2gk/9coEHpqa1waHifo9drHDgjb567olmPj2bOQV554QZegDjUTgHIMo3T4g/4x
         yXRj2ZfDFBQFrleBl2tzmgebwJd/W/PIyyGatMA8tasQu0NPJstqn1MZ11mjw7r+7Q
         PWTcy8iW91FxxyAUj8fEwbmEYBMGv86uYenohJ6U=
Date:   Sun, 3 May 2020 16:39:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v6 3/6] iio: core: register chardev only if needed
Message-ID: <20200503163926.6f840406@archlinux>
In-Reply-To: <20200427131100.50845-4-alexandru.ardelean@analog.com>
References: <20200427131100.50845-1-alexandru.ardelean@analog.com>
        <20200427131100.50845-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 16:10:57 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The final intent is to localize all buffer ops into the
> industrialio-buffer.c file, to be able to add support for multiple buffers
> per IIO device.
> 
> We only need a chardev if we need to support buffers and/or events.
> 
> With this change, a chardev will be created only if an IIO buffer is
> attached OR an event_interface is configured.
> 
> Otherwise, no chardev will be created, and the IIO device will get
> registered with the 'device_add()' call.
> 
> Quite a lot of IIO devices don't really need a chardev, so this is a minor
> improvement to the IIO core, as the IIO device will take up (slightly)
> fewer resources.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 32c489139cd2..51e279c60793 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1682,6 +1682,15 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
> +static const struct file_operations iio_event_fileops = {
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.unlocked_ioctl = iio_event_ioctl_wrapper,

Unfortunately this doesn't exist until the next patch...

> +	.compat_ioctl = compat_ptr_ioctl,
> +	.open = iio_chrdev_open,
> +	.release = iio_chrdev_release,
> +};
> +
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	int ret;
> @@ -1732,11 +1741,18 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else if (indio_dev->event_interface)
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
>  	indio_dev->chrdev.owner = this_mod;
>  
> -	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> +	if (indio_dev->buffer || indio_dev->event_interface)
> +		ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> +	else
> +		ret = device_add(&indio_dev->dev);
> +
>  	if (ret < 0)
>  		goto error_unreg_eventset;
>  
> @@ -1760,7 +1776,10 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> -	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> +	if (indio_dev->buffer || indio_dev->event_interface)
> +		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> +	else
> +		device_del(&indio_dev->dev);
>  
>  	mutex_lock(&indio_dev->info_exist_lock);
>  

