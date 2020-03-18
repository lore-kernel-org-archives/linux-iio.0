Return-Path: <SRS0=l2Gr=5D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A119C10DCE
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA75E2076D
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 06:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584511242;
	bh=Mrp1ZWa1/1//Q7ikRp0WQlifb4RVW51A5g2NkRUbeyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=prvpIIGmA/ztoumsYwftB5UZqVBV0K0RjJsJnOv3WZ1QAw1wzfeoWGLVLIQnqahdC
	 otLkr6mPKcURRGc8dRzrLDzeR0QpPOzkHdyQm2qcqopMATtJxWexowIW5KPuA9GIt3
	 NCVygKI0pWqlf/G119qMOWmA/BSppGloQGkrEAJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgCRGAl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgCRGAl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Mar 2020 02:00:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2B620663;
        Wed, 18 Mar 2020 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584511240;
        bh=Mrp1ZWa1/1//Q7ikRp0WQlifb4RVW51A5g2NkRUbeyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRk7MYaX69a/Zb8xfs5T26yfQsXKT30FRO/ctgQl9JwUfIXvSALOQtGq3ZslH2UBE
         lSk2gl59jhCJxf+x8j+6WVEgZ5/msclaOMn4buewe6oS9Ucr3m9qaJAwdLWxIPGOIb
         ThQ8EINJgHQXYQWbDD7VXQAwPE6HhayJnoDkBrnI=
Date:   Wed, 18 Mar 2020 07:00:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around
 operators
Message-ID: <20200318060038.GB1594471@kroah.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> Add spaces around operator symbols to improve readability. Warning
> flagged by checkpatch script.
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 19a5f244dcae..34ca0d09db85 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -			     in_voltage-voltage_thresh_low_value,
> +			     in_voltage - voltage_thresh_low_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
>  			     AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -			     in_voltage-voltage_thresh_high_value,
> +			     in_voltage - voltage_thresh_high_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,

Did you try building this code?

It catches everyone...

greg k-h
