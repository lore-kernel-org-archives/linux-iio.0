Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B3C433B4
	for <linux-iio@archiver.kernel.org>; Sun, 11 Apr 2021 14:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F94F610CA
	for <linux-iio@archiver.kernel.org>; Sun, 11 Apr 2021 14:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhDKOVR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhDKOVQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 10:21:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9C2600D4;
        Sun, 11 Apr 2021 14:20:57 +0000 (UTC)
Date:   Sun, 11 Apr 2021 15:21:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
Message-ID: <20210411152120.0c806bba@jic23-huawei>
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:09 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Some devm variants are implemented with devres_alloc() and devres_add()
> manually to only manage a single pointer. This can be simplified with
> devm_add_action_or_reset() which works the same. Simplify these functions.
> 
> Yicong Yang (7):
>   iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
>   iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
>   iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
>   iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
>   iio: core: simplify some devm functions
>   iio: trigger: simplify __devm_iio_trigger_register
>   iio: inkern: simplify some devm functions

Nice set.  Note no rush for a v2 as IIO is effectively closed for the
coming merge window.  Hence these won't hit linux-next now until after
the merge window closes.

Thanks,

Jonathan

> 
>  drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
>  drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
>  drivers/iio/industrialio-core.c                    | 43 ++++++---------
>  drivers/iio/industrialio-trigger.c                 | 18 ++-----
>  drivers/iio/inkern.c                               | 61 ++++++++--------------
>  7 files changed, 78 insertions(+), 132 deletions(-)
> 

