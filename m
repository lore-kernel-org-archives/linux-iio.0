Return-Path: <SRS0=nmJT=BK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F7C433E0
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 08:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F6720829
	for <linux-iio@archiver.kernel.org>; Fri, 31 Jul 2020 08:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgGaING (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:13:06 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58065 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbgGaING (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 04:13:06 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AC5E71BF206;
        Fri, 31 Jul 2020 08:13:02 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:13:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     David Lechner <david@lechnology.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v4 3/5] counter: Add character device interface
Message-ID: <20200731081302.GB462779@piout.net>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
 <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
 <a287770b-c263-f1db-bcc4-d901d3ff3c7c@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a287770b-c263-f1db-bcc4-d901d3ff3c7c@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/07/2020 17:49:37-0500, David Lechner wrote:
> And one more thing, there was a nice talk at the Embedded Linux
> Conference last month about lessons learned from designing a userspace
> API for the GPIO subsystem [1]. Unfortunately, there is no video yet,
> but the slides might have some helpful ideas about mistakes to avoid.
> 
> [1]: https://elinux.org/ELC_2020_Presentations
> 

The video is available on the original conference platform for one year
after the event, then it will be made available on youtube.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
