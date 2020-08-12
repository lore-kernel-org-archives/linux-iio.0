Return-Path: <SRS0=hUV5=BW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A7CC433E0
	for <linux-iio@archiver.kernel.org>; Wed, 12 Aug 2020 11:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9A72076C
	for <linux-iio@archiver.kernel.org>; Wed, 12 Aug 2020 11:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHLLC2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:02:28 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:44187 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLLC1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 Aug 2020 07:02:27 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4BRRcG0M7Sz9tNn;
        Wed, 12 Aug 2020 13:02:22 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BRRbx2bRCz2xjY;
        Wed, 12 Aug 2020 13:02:05 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.41) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Aug
 2020 13:01:52 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <stable@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: sysfs: Disable irqs before calling iio_trigger_poll()
Date:   Wed, 12 Aug 2020 13:01:51 +0200
Message-ID: <3847827.rc3nFVyU9p@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <a59d204e-aeb0-2649-5e6f-f07815713d1a@metafoo.de>
References: <20200727145714.4377-1-ceggers@arri.de> <4871626.01MspNxQH7@n95hx1g2> <a59d204e-aeb0-2649-5e6f-f07815713d1a@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.41]
X-RMX-ID: 20200812-130211-4BRRbx2bRCz2xjY-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars

On Monday, 3 August 2020, 08:52:54 CEST, Lars-Peter Clausen wrote:
> On 8/3/20 8:44 AM, Christian Eggers wrote:
> > ...
> > is my patch sufficient, or would you prefer a different solution?
> 
> The code in normal upstream is correct, there is no need to patch it
> since iio_sysfs_trigger_work() always runs with IRQs disabled.
> 
> >> Are you using a non-upstream kernel? Maybe a RT kernel?
> > 
> > I use v5.4.<almost-latest>-rt
> 
> That explains it. Have a look at
> 0200-irqwork-push-most-work-into-softirq-context.patch.
> 
> The right fix for this issue is to add the following snippet to the RT
> patchset.
> 
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c
> b/drivers/iio/trigger/iio-trig-sysfs.c
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -161,6 +161,7 @@ static int iio_sysfs_trigger_probe(int id)
>       iio_trigger_set_drvdata(t->trig, t);
> 
>       init_irq_work(&t->work, iio_sysfs_trigger_work);
> +    t->work.flags = IRQ_WORK_HARD_IRQ;
> 
>       ret = iio_trigger_register(t->trig);
>       if (ret)

I can confirm that this works for iio-trig-sysfs on 5.4.54-rt32. Currently I 
do not use iio-trig-hrtimer, but if I remember correctly, the problem was also 
present there.

Do you want to apply your patch for mainline? In contrast to v5.4, 
IRQ_WORK_HARD_IRQ is already available there (moved to smp_types.h). 
Unfortunately I cannot test it on mainline for now, as my BSP stuff is not 
ported yet.

Best regards
Christian




