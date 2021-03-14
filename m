Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DB7C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1BA64E10
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCNQus (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:50:48 -0400
Received: from muru.com ([72.249.23.125]:43152 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhCNQuR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:50:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F2FD380B4;
        Sun, 14 Mar 2021 16:51:02 +0000 (UTC)
Date:   Sun, 14 Mar 2021 18:50:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/8] iio: adc: cpcap-adc: kernel-doc fix - that should be
 _ in structure name
Message-ID: <YE4+xOm8HM72mCdq@atomide.com>
References: <20210314164655.408461-1-jic23@kernel.org>
 <20210314164655.408461-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314164655.408461-6-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

* Jonathan Cameron <jic23@kernel.org> [210314 16:50]:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fixes a W=1 warning.

Reviewed-by: Tony Lindgren <tony@atomide.com>

Thanks,

Tony
