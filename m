Return-Path: <SRS0=70H6=4J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC4C35656
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA1E24650
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582290891;
	bh=zLeMnqmezs9X0Xy259yO8BM4pOGYsFwjR8qRbebbfLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gKgUCq3WCEoD4H2y9BJbCe5OTBjzUdq1xIVkPWk5+6wGl/jsExtULFd82rY8UbESe
	 r147WqKFU3yIo+XZmhCw97gxag1XVp1YbgbndIu87LWtFG5rthTWivXW0uuD15nNhC
	 cCGT1oRsQzIxZBtQBhhZj7XKntrsraiOPX8J2Rr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUNOv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:14:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNOv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:14:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9652073A;
        Fri, 21 Feb 2020 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582290890;
        bh=zLeMnqmezs9X0Xy259yO8BM4pOGYsFwjR8qRbebbfLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ph+4u/BXZz9G+9Ax45OcrnZ6Q3noZzZboM+ugFYchqZECl91wxBnYOWbCmuD/1iG5
         B60w7GPnuZyJ9MkLPkqRzo50/5nh58WDhZ2js4VxxoU158CB6GgZds6bPvK+HQ8C8N
         pKP/8TvqCJmt7TTZbCDC5ceDquRVMozitmDpU87M=
Date:   Fri, 21 Feb 2020 13:14:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: imu: adis: add a note better explaining
 state_lock
Message-ID: <20200221131446.20363088@archlinux>
In-Reply-To: <20200221114943.2056-3-alexandru.ardelean@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
        <20200221114943.2056-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 13:49:43 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The 'state_lock' mutex was renamed from 'txrx_lock' in a previous patch and
> is intended to be used by ADIS drivers to protect the state of devices
> during consecutive R/W ops.
> The initial patch that introduced this change did not do a good [well, any]
> job at explaining this. This patch adds a comment to the 'state_lock'
> better explaining it's use.

Nice work.

Will pick up in v2.

Thanks,

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/iio/imu/adis.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 11c915b61ae2..a3110c097fa1 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -98,6 +98,17 @@ struct adis {
>  	const struct adis_data	*data;
>  	struct adis_burst	*burst;
>  
> +	/**
> +	 * The state_lock is meant to be used during operations that require
> +	 * a sequence of SPI R/W in order to protect the SPI transfer
> +	 * information (fields 'xfer', 'msg' & 'current_page') between
> +	 * potential concurrent accesses.
> +	 * This lock is used by all "adis_{functions}" that have to read/write
> +	 * registers. These functions also have unlocked variants
> +	 * (see "__adis_{functions}"), which don't hold this lock.
> +	 * This allows users of the ADIS library to group SPI R/W into
> +	 * the drivers, but they also must manage this lock themselves.
> +	 */
>  	struct mutex		state_lock;
>  	struct spi_message	msg;
>  	struct spi_transfer	*xfer;

