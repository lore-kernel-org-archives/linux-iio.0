Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC6C433B4
	for <linux-iio@archiver.kernel.org>; Sun, 18 Apr 2021 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964AB61245
	for <linux-iio@archiver.kernel.org>; Sun, 18 Apr 2021 10:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhDRKGF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Apr 2021 06:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDRKGF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:06:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EA861090;
        Sun, 18 Apr 2021 10:05:34 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:06:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <tduszyns@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH drivers/iio 0/3] convert sysfs
 sprintf/snprintf/scnprintf to sysfs_emit
Message-ID: <20210418110605.5bbcdc8b@jic23-huawei>
In-Reply-To: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
References: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 16:39:08 +0800
Tian Tao <tiantao6@hisilicon.com> wrote:

> Use the generic sysfs_emit() function to take place of
> sprintf/snprintf/scnprintf, to avoid buffer overrun.
> 
> Tian Tao (3):
>   iio:chemical:sps30:  Convert sysfs sprintf/snprintf family to
>     sysfs_emit
>   iio: light: Convert sysfs sprintf/snprintf family to sysfs_emit
>   iio: trigger: stm32-timer: Convert sysfs sprintf/snprintf family to
>     sysfs_emit
> 
>  drivers/iio/chemical/sps30.c              | 6 +++---
>  drivers/iio/light/veml6030.c              | 2 +-
>  drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Series applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilders see if they can find anything we missed.

This won't got upstream until after the merge window so plenty of time
for others to take a look if they want to.

Thanks,

Jonathan

> 

