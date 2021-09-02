Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4DC432BE
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 08:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D27610CC
	for <linux-iio@archiver.kernel.org>; Thu,  2 Sep 2021 08:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhIBI4U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:56:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45897 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhIBI4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 04:56:20 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7B4CD40011;
        Thu,  2 Sep 2021 08:55:20 +0000 (UTC)
Date:   Thu, 2 Sep 2021 10:55:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/16] iio: adc: max1027: Separate the IRQ handler from
 the read logic
Message-ID: <20210902105519.5891a90f@xps13>
In-Reply-To: <SJ0PR03MB6359F29E247EFAA720B30EEA99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-12-miquel.raynal@bootlin.com>
        <SJ0PR03MB6359F29E247EFAA720B30EEA99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

"Sa, Nuno" <Nuno.Sa@analog.com> wrote on Fri, 20 Aug 2021 07:23:33
+0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Wednesday, August 18, 2021 1:12 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: [PATCH 11/16] iio: adc: max1027: Separate the IRQ handler
> > from the read logic
> > 
> > [External]
> > 
> > Create a max1027_read_scan() helper which will make clearer the
> > future IRQ
> > handler updates (no functional change).
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index 83526f3d7d3a..afc3ce69f7ea 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -427,19 +427,18 @@ static int
> > max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
> >  	return 0;
> >  }
> > 
> > -static irqreturn_t max1027_trigger_handler(int irq, void *private)
> > +static int max1027_read_scan(struct iio_dev *indio_dev)
> >  {
> > -	struct iio_poll_func *pf = private;
> > -	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct max1027_state *st = iio_priv(indio_dev);
> >  	unsigned int scanned_chans = fls(*indio_dev-  
> > >active_scan_mask);  
> >  	u16 *buf = st->buffer;
> >  	unsigned int bit;
> > -
> > -	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq,
> > private);
> > +	int ret;
> > 
> >  	/* fill buffer with all channel */
> > -	spi_read(st->spi, st->buffer, scanned_chans * 2);
> > +	ret = spi_read(st->spi, st->buffer, scanned_chans * 2);
> > +	if (ret < 0)
> > +		return ret;
> > 
> >  	/* Only keep the channels selected by the user */
> >  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > @@ -451,6 +450,22 @@ static irqreturn_t max1027_trigger_handler(int
> > irq, void *private)
> > 
> >  	iio_push_to_buffers(indio_dev, st->buffer);
> > 
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t max1027_trigger_handler(int irq, void *private)
> > +{
> > +	struct iio_poll_func *pf = private;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	int ret;
> > +
> > +	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq,
> > private);
> > +  
> 
> This should be more consistent... use 'dev_err()'. I would also
> argue to use the spi dev as the driver state structure holds a
> pointer to it...

I honestly don't see the point of these debug messages (there is
another useless pr_debug in probe). I kept it here as I am just moving
code around without any changes, but if you don't like it (me neither)
I'll add a simple patch dropping them.

Thanks,
Miquèl
