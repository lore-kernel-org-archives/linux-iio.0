Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258BC433DB
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB2C61940
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 17:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTRM6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 Mar 2021 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTRMT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 13:12:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4429A61940;
        Sat, 20 Mar 2021 17:12:17 +0000 (UTC)
Date:   Sat, 20 Mar 2021 17:12:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     gabriele.mzt@gmail.com, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 0/3] iio: acpi_als: Add sotfware trigger support
Message-ID: <20210320171214.0b948527@jic23-huawei>
In-Reply-To: <20210317074012.2336454-1-gwendal@chromium.org>
References: <20210317074012.2336454-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Mar 2021 00:40:09 -0700
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
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Changes since v7:
>   rebase on iio git testing branch.
> 
> Gwendal Grignou (3):
>   iio: acpi_als: Add timestamp channel
>   iio: acpi_als: Add local variable dev in probe
>   iio: acpi_als: Add trigger support
> 
>  drivers/iio/light/acpi-als.c | 113 +++++++++++++++++++++++------------
>  1 file changed, 76 insertions(+), 37 deletions(-)
> 

