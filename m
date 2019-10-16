Return-Path: <SRS0=LfIq=YJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434BFA3728
	for <linux-iio@archiver.kernel.org>; Wed, 16 Oct 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356F2064B
	for <linux-iio@archiver.kernel.org>; Wed, 16 Oct 2019 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbfJPRc7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:32:59 -0400
Received: from muru.com ([72.249.23.125]:37598 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388899AbfJPRc7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Oct 2019 13:32:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DD3F48107;
        Wed, 16 Oct 2019 17:25:24 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:24:47 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: cpcap-adc: Fix missing IRQF_ONESHOT as only
 threaded handler.
Message-ID: <20191016172447.GT5607@atomide.com>
References: <20191013162133.1999362-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013162133.1999362-1-jic23@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

* jic23@kernel.org <jic23@kernel.org> [191013 16:24]:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Coccinelle noticed:
> CHECK   drivers/iio/adc/cpcap-adc.c
> drivers/iio/adc/cpcap-adc.c:1009:9-34: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT
> 
> As far as I can see this is a simple case of it should be specified
> but isn't.

Acked-by: Tony Lindgren <tony@atomide.com>
