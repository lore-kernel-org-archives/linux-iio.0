Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30EC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D176222CAF
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 17:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAPRhv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbhAPRhv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 12:37:51 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DADAB22241;
        Sat, 16 Jan 2021 17:37:10 +0000 (UTC)
Date:   Sat, 16 Jan 2021 17:37:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] iio: dac: ad5766: add driver support for AD5766
Message-ID: <20210116173707.7fdd269c@archlinux>
In-Reply-To: <20210115112105.58652-3-cristian.pop@analog.com>
References: <20210115112105.58652-1-cristian.pop@analog.com>
        <20210115112105.58652-3-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 13:21:05 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense DACs
> Digital-to-Analog converters.
> 
> This change adds support for these DACs.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

I spoke too soon.  Please run a W=1 build for future cases. It tends
to pick up on little issues - in this case a plural vs singular
in the docs vs the code.

...
> +/**
> + * struct ad5766_chip_info - chip specific information
> + * @num_channels:	number of channels
> + * @channel:	        channel specification
channels.

Fixed up and pushed out.

thanks,

Jonathan


> + */
> +struct ad5766_chip_info {
> +	unsigned int			num_channels;
> +	const struct iio_chan_spec	*channels;
> +};
