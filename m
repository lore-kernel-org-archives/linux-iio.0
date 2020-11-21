Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765CC388F9
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA01C22206
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKUQoH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Nov 2020 11:44:07 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:35834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgKUQoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 11:44:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4189A1867;
        Sat, 21 Nov 2020 16:44:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mom16_400890627355
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 16:44:04 +0000 (UTC)
Message-ID: <cbc88878ecfc8e8994bb61e03b55f0384609e6eb.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Date:   Sat, 21 Nov 2020 08:44:03 -0800
In-Reply-To: <20201121161902.5ede1a23@archlinux>
References: <20201116131141.3985-1-vilhelm.gray@gmail.com>
         <20201121161902.5ede1a23@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-11-21 at 16:19 +0000, Jonathan Cameron wrote:
> On Mon, 16 Nov 2020 08:11:41 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Purely for the record, Kamel, would you mind giving an
> Acked-by for this?
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
> >  N:	at91
> >  N:	atmel
> > 
> > +Microchip Timer Counter Block (TCB) Capture Driver
> > +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/counter/microchip-tcb-capture.c
> > +

Alphabetic ordering of section names please
And perhaps rename this to ARM/Microchip etc...

> >  ARM/Microchip Sparx5 SoC support
> >  M:	Lars Povlsen <lars.povlsen@microchip.com>
> >  M:	Steen Hegelund <Steen.Hegelund@microchip.com>
> 


