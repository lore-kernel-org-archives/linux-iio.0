Return-Path: <SRS0=pZW2=6O=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E9C47247
	for <linux-iio@archiver.kernel.org>; Thu, 30 Apr 2020 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6D20870
	for <linux-iio@archiver.kernel.org>; Thu, 30 Apr 2020 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD3USC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:18:02 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38437 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3USC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 16:18:02 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5960D240005;
        Thu, 30 Apr 2020 20:18:00 +0000 (UTC)
Date:   Thu, 30 Apr 2020 22:17:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads8344: optimize consumption
Message-ID: <20200430201759.GY51277@piout.net>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
 <20200416205428.437503-3-alexandre.belloni@bootlin.com>
 <20200418161322.71b2b353@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418161322.71b2b353@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 18/04/2020 16:13:22+0100, Jonathan Cameron wrote:
> On Thu, 16 Apr 2020 22:54:28 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > Set the clock mode only once, at probe time and then keep the ADC powered
> > down between conversions.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Looks fine to me. I'd like to be lazy and not take this until the fix is
> in my upstream (even though I suspect the merge would be fine).
> 
> Give me a poke if I seem to have forgotten this after that is true!
> 

It now landed in your upstream but I guess you want to take Gregory's
patch as a fix first. To be honest I don't think any of the fixes are
urgent as it seems we are the only users of the particular ADC.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
