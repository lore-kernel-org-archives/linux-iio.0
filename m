Return-Path: <SRS0=1XrH=32=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31FC2D0B1
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDBB21775
	for <linux-iio@archiver.kernel.org>; Thu,  6 Feb 2020 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgBFKmN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:42:13 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51258 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgBFKmL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:42:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id A4B9E9E7505;
        Thu,  6 Feb 2020 10:42:07 +0000 (GMT)
Date:   Thu, 6 Feb 2020 10:42:06 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: ltc2632: expand for ltc2636
 support
Message-ID: <20200206104206.7cab7434@archlinux>
In-Reply-To: <20200202095207.511afbf1@archlinux>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200202095207.511afbf1@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Feb 2020 09:52:07 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 30 Jan 2020 14:15:47 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > The ltc2636 family of devices is register compatible with the ltc2636
> > chips, it just features 8 instead of 2 channels.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > index e0d5fea33031..9d114957a28b 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > @@ -1,4 +1,4 @@
> > -Linear Technology LTC2632 DAC device driver
> > +Linear Technology LTC2632/2636 DAC device driver  
> 
> Whilst we are here, can we clear out the reference to 'driver'.
> It's a binding so describes the hardware, not the driver talking
> to it.
> 
> Linear Technology LTC... DAC
> 
> If that's all that comes up, I can tidy this up when applying.

Applied.

Thanks,
> 
> Jonathan
> 
> >  
> >  Required properties:
> >   - compatible: Has to contain one of the following:
> > @@ -8,6 +8,12 @@ Required properties:
> >  	lltc,ltc2632-h12
> >  	lltc,ltc2632-h10
> >  	lltc,ltc2632-h8
> > +	lltc,ltc2636-l12
> > +	lltc,ltc2636-l10
> > +	lltc,ltc2636-l8
> > +	lltc,ltc2636-h12
> > +	lltc,ltc2636-h10
> > +	lltc,ltc2636-h8
> >  
> >  Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
> >  apply. In particular, "reg" and "spi-max-frequency" properties must be given.  
> 

