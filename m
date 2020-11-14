Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AD2C5519F
	for <linux-iio@archiver.kernel.org>; Sat, 14 Nov 2020 19:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD9C22265
	for <linux-iio@archiver.kernel.org>; Sat, 14 Nov 2020 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKNTWI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:22:08 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60057 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKNTWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 14:22:07 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 52C8660004;
        Sat, 14 Nov 2020 19:22:02 +0000 (UTC)
Date:   Sat, 14 Nov 2020 20:22:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: adc: at91_adc: use devm_input_allocate_device
Message-ID: <20201114192202.GC5272@piout.net>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
 <20201113212650.507680-8-alexandre.belloni@bootlin.com>
 <20201114171340.2bf0d61e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114171340.2bf0d61e@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/11/2020 17:13:40+0000, Jonathan Cameron wrote:
> On Fri, 13 Nov 2020 22:26:48 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > Use devm_input_allocate_device to allocate the input device to simplify the
> > error and remove paths.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> This one I'm less keen on.  Whilst it's obviously not a problem in
> this particular case I'd ideally like to keep the remove order
> as the exact reverse of probe - that makes it easy to review changes
> quickly.
> 
> Now, you could easily enough make this fine by using devm for the
> other items that happen before this (dev_add_action_or_reset needed
> in a few cases).
> 

Right, I'll drop it for now.

