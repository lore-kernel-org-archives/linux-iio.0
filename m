Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382AC2B9F2
	for <linux-iio@archiver.kernel.org>; Sat, 22 May 2021 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D7C610C8
	for <linux-iio@archiver.kernel.org>; Sat, 22 May 2021 18:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEVSbY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 May 2021 14:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhEVSbX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:31:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C93061177;
        Sat, 22 May 2021 18:29:57 +0000 (UTC)
Date:   Sat, 22 May 2021 19:31:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] iio: adc: Maxim and TI ADC driver cleanups
Message-ID: <20210522193120.0f5f9be1@jic23-huawei>
In-Reply-To: <20210516172520.1398835-1-jic23@kernel.org>
References: <20210516172520.1398835-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 18:25:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A few random bits of tidying up for a Sunday evening.
> Mostly devm stuff, but other things in here as well that came up whilst
> I was looking.
> 
> Note this was a fairly random selection, so isn't implying there
> aren't similar cleanups to be done in other TI and Maxim drivers.
> (there definitely are plenty more of these if anyone is bored ;)
> 
> Cc: Alexandru Ardelean <aardelean@deviqon.com>

Series applied with the minor tweak to drop spi_set_drvdata in two 
drivers as pointed out by Alex.

Thanks,

Jonathan

> 
> Jonathan Cameron (8):
>   iio: adc: max11100: Use get_unaligned_be16() rather than opencoding.
>   iio: adc: max11100: Use devm_ functions for rest of probe()
>   iio: adc: max1118: Use devm_ managed functions for all of probe
>   iio: adc: max1118: Avoid jumping back and forth between spi and iio
>     structures
>   iio: adc: ti-adc081c: Use devm managed functions for all of probe()
>   iio: adc: ti-adc0832: Use devm managed functions for all of probe()
>   iio: adc: ti-adc108s102: Use devm managed functions for all of probe()
>   iio: adc: ti-adc161s626: Use devm managed functions for all of probe.
> 
>  drivers/iio/adc/max11100.c      | 32 ++++++----------
>  drivers/iio/adc/max1118.c       | 68 ++++++++++++---------------------
>  drivers/iio/adc/ti-adc081c.c    | 43 +++++++--------------
>  drivers/iio/adc/ti-adc0832.c    | 39 ++++++-------------
>  drivers/iio/adc/ti-adc108s102.c | 45 ++++++++--------------
>  drivers/iio/adc/ti-adc161s626.c | 50 +++++++++---------------
>  6 files changed, 94 insertions(+), 183 deletions(-)
> 

