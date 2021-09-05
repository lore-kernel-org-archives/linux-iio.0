Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22056C433EF
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 10:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C8360FE6
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhIEKJs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Sep 2021 06:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236913AbhIEKJs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:09:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8593360FBF;
        Sun,  5 Sep 2021 10:08:41 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:12:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v2 05/10] iio: adc: at91-sama5d2-adc: add support for
 separate end of conversion registers
Message-ID: <20210905111139.2b5ade8c@jic23-huawei>
In-Reply-To: <7d2607ce-4cfc-63f9-dad2-a5ef5c9538b5@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
        <20210824115441.681253-6-eugen.hristev@microchip.com>
        <7d2607ce-4cfc-63f9-dad2-a5ef5c9538b5@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 06:45:01 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 8/24/21 2:54 PM, Eugen Hristev wrote:
> > Some platforms have separated the end-of-conversion information from the
> > usual ISR/IMR/IER/IDR registers, into EOC_ISR/EOC_IMR/EOC_IER/EOC_IDR.
> > To cope with both variants, helpers are being added, that will make
> > code more clear and more easy to read.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---  
> 
> Hi Jonathan,
> 
> If you can still make changes on your testing branch, I noticed a typo 
> in the shortcommit of this patch : 'at91-sama5d2-adc' instead of 
> 'at91-sama5d2_adc' , grepping through commits in the future might miss 
> this patch, so maybe you can change it ?
Testing is very much rebaseable.  I won't push the tree out as something
I'm not happy to rebase until I have a stable base for it (after rc1).

So dropped v2. I'll get to v3 a bit later today probably.

Jonathan

> 
> Thanks,
> Eugen

