Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF7C433DB
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B15A6196B
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCTOlj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 Mar 2021 10:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCTOlU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:41:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D65D861967;
        Sat, 20 Mar 2021 14:41:17 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:41:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad9832: kernel-doc fixes
Message-ID: <20210320144115.20137afe@jic23-huawei>
In-Reply-To: <20210315133711.26860-1-dmugil2000@gmail.com>
References: <20210315133711.26860-1-dmugil2000@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Mar 2021 19:07:11 +0530
Mugilraj Dhavachelvan <dmugil2000@gmail.com> wrote:

> Fixes a W=1 warning.
> -Added ``:`` to lock parameter in 'ad9832_state' description.
> -It's a reference comment so removed /**
> 
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>

Great.  Thanks for tidying this up.

Applied to the togreg branch of iio.git and pushed out for testing
to let the autobuilders poke at it.

thanks

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 74308a2e72db..e31ebba47a3c 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -86,7 +86,7 @@
>   * @freq_msg:		tuning word spi message
>   * @phase_xfer:		tuning word spi transfer
>   * @phase_msg:		tuning word spi message
> - * @lock		protect sensor state
> + * @lock:		protect sensor state
>   * @data:		spi transmit buffer
>   * @phase_data:		tuning word spi transmit buffer
>   * @freq_data:		tuning word spi transmit buffer
> @@ -248,7 +248,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	return ret ? ret : len;
>  }
>  
> -/**
> +/*
>   * see dds.h for further information
>   */
>  

