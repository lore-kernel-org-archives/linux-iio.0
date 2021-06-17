Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B91EC2B9F4
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533E661405
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFQOhW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhFQOhV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB4561406
        for <linux-iio@vger.kernel.org>; Thu, 17 Jun 2021 14:35:13 +0000 (UTC)
Date:   Thu, 17 Jun 2021 15:37:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: IIO now taking changes for the 5.15 cycle.
Message-ID: <20210617153717.62d9d7b5@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I'm usually pretty lax at actually letting people know and burry it
in replies to random emails. So this time lets do things things better.

I've just sent what will probably be my last pull request to Greg
for the 5.14 merge window.  Fixes will go in during the rc cycles
as normal, but anything that isn't a fix is now going to be queued
up for the 5.15 merge window.

As ever, a few series under review have just missed, but we have to
put the cut off somewhere.  For anyone who doesn't know I usually
do this about 10 days before the merge window looks likely to open.
Sometimes a bit before that (so don't cut it too fine!)

Thanks,

Jonathan
