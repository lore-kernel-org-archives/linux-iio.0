Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC10C433E0
	for <linux-iio@archiver.kernel.org>; Tue, 29 Dec 2020 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA8B20825
	for <linux-iio@archiver.kernel.org>; Tue, 29 Dec 2020 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL2Rjz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2Rjz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:39:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180F920825;
        Tue, 29 Dec 2020 17:39:13 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:39:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     gabriele.mzt@gmail.com, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: acpi_als: Add sotfware trigger support
Message-ID: <20201229173910.378e559f@archlinux>
In-Reply-To: <20201229015300.3037816-1-gwendal@chromium.org>
References: <20201229015300.3037816-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Dec 2020 17:52:57 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Some devices (chromebooks) present the ACPI ALS device but do not have
> ability to notify when a new sample is present.
> Add support for software trigger (hrtimer/sysfs-trigger) to allow
> retrieving samples using iio buffers.
> 
> The first path fully adds timestamp channel, the second adds a local
> variable in probe routine and the last one adds trigger support.
> 
> This patch assumes the patch "iio: set default trig->dev.parent" is
> applied.
I'm asking for a rebase of that series.  Otherwise this looks good to me

Thanks,

Jonathan

> 
> 
> Gwendal Grignou (3):
>   iio: acpi_als: Add timestamp channel
>   iio: acpi_als: Add local variable dev in probe
>   iio: acpi_als: Add trigger support
> 
>  drivers/iio/light/acpi-als.c | 121 +++++++++++++++++++++++------------
>  1 file changed, 81 insertions(+), 40 deletions(-)
> 

