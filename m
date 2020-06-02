Return-Path: <SRS0=PLU2=7P=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE96C433E2
	for <linux-iio@archiver.kernel.org>; Tue,  2 Jun 2020 06:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A8620734
	for <linux-iio@archiver.kernel.org>; Tue,  2 Jun 2020 06:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFBGHA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgFBGG4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Jun 2020 02:06:56 -0400
Received: from sekiro (lfbn-mar-1-685-55.w109-208.abo.wanadoo.fr [109.208.210.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EA120734;
        Tue,  2 Jun 2020 06:06:54 +0000 (UTC)
Date:   Tue, 2 Jun 2020 08:06:50 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH] iio: Kconfig: at91_adc: add COMPILE_TEST dependency to
 driver
Message-ID: <20200602060650.vlfx26qb57sewcjw@sekiro>
References: <20200525102744.131672-1-alexandru.ardelean@analog.com>
 <20200531154017.04fc727f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531154017.04fc727f@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 31, 2020 at 03:40:17PM +0100, Jonathan Cameron wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 25 May 2020 13:27:44 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > Since changes can come from all sort of places, it may make sense to have
> > this symbol as a dependency to make sure that the 'make allmodconfig' &&
> > 'make allyesconfig' build rules cover this driver as well for a
> > compile-build/test.
> >
> > It seemed useful [recently] when trying to apply a change for this.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Makes sense.   Given this sort of change can expose weird an wonderful
> dependencies that were previously hidden, I'll be wanting an
> ack from at91 people.

Agree.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic

> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index c48c00077775..c1f4c0aec265 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -294,7 +294,7 @@ config ASPEED_ADC
> >
> >  config AT91_ADC
> >       tristate "Atmel AT91 ADC"
> > -     depends on ARCH_AT91
> > +     depends on ARCH_AT91 || COMPILE_TEST
> >       depends on INPUT && SYSFS
> >       select IIO_BUFFER
> >       select IIO_TRIGGERED_BUFFER
> 
