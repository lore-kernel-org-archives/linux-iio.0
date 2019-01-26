Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B21C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 21:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A39021903
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 21:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFHWFkPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAZVmm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:42:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42211 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAZVml (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 16:42:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so14511402qtq.9
        for <linux-iio@vger.kernel.org>; Sat, 26 Jan 2019 13:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eg1+XsuaihSDL/7UPsB8Obs2S0wAfPbTZnwhY7puDNI=;
        b=CFHWFkPbms58IE+tnJ2wM0qTocHSkUCKbnFIvgT5+4h9duQqIXAVnL4Ao4h0I7FCK5
         2JQT5KYDgWCT/sa4dmdwjlJdaZAu/eyy5feJDj9udMXKAYBRf5NG7WI1DDAbUdS4rvnu
         QU5Q32cvcL2lc+FLkWiDFBC8J4nr5U7hy6HIIenr5MBwK9TEvNp+rBJV5ygihiEwtp2m
         40bOJ13ojvCJHJusqhqwK+dHveg5Bfq9XLrjTZX6Gdu6dfGsa6lZcwcLS8/xDk48/OWx
         xw7cDG2Cb/YC4wt9eXW1lOXyxMnu/EMKfDWuHJZmRBE+MjE43kh64zN7+8rIP49DgFUN
         +dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eg1+XsuaihSDL/7UPsB8Obs2S0wAfPbTZnwhY7puDNI=;
        b=JtQKpTC8eT+NzQ9aRLL5Ii8avIg0ucjFLF79wfKLdU2SGWP6pNodmYWBCnPeaGid1h
         OV/9tBoBqwqhnQN40ejj11pg9Z126WI24RKWxV2T78tAurc911IR8Bq5sLkTt3Hnkvro
         lOsUUgkyRzocAXMYU59QWTPKAPV7TqV6p5ibI6FpXAVnByI+uHYnXUzeAABTSFawf8k5
         k0h+YuyVf5sfumeZWOQWMA3pIaA/l40BS10yxvTafUcTYESuCT6Bmx7pdoaTri6PbkTN
         URh/HJCAZ/xBOsc9uEQK4PN9rhAbWF6NP1SUpEUJsYHK09r+YNuDR3zRaNuuiE3Viw+L
         tiCA==
X-Gm-Message-State: AJcUuke2J7t5plRakVxaCyytKL12nHIWerq1nsCPVswQKQV7PCogoLxC
        rgs9iVtQkhhNonmd6cvEpwI=
X-Google-Smtp-Source: ALg8bN4QBlpFW4ZHmKfJjUzmbzOKkL5qgTjLBQS7X2KOW5CJ7M2EzEG+XmK5r5S7hKfpgcpERAYL2w==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr16395785qtm.213.1548538959953;
        Sat, 26 Jan 2019 13:42:39 -0800 (PST)
Received: from archfcr.localdomain ([177.139.38.48])
        by smtp.gmail.com with ESMTPSA id 5sm98152577qtw.50.2019.01.26.13.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 13:42:39 -0800 (PST)
Date:   Sat, 26 Jan 2019 19:42:31 -0200
From:   Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: iio: adc: Include SPDX Identifier
Message-ID: <20190126214227.GA32372@archfcr.localdomain>
References: <20190126173746.GA7100@archfcr.localdomain>
 <20190126204820.5998bf29@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126204820.5998bf29@archlinux>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi James,

On Sat, Jan 26, 2019 at 08:48:20PM +0000, Jonathan Cameron wrote:
> On Sat, 26 Jan 2019 15:37:53 -0200
> Felipe Cardoso Resende <felipecardoso.fcr@gmail.com> wrote:
> 
> > Remove warning found by checkpatch.pl by including SPDX Identifier
> > 
> > Signed-off-by: Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>
> 
> However much checkpatch moans about this they all need careful individual
> checking and I always prefer to get input from someone who either wrote
> the code or works for the company with the copyright.

I see your point. I took it for granted as the license was explicit in the 
beginning of each file.
> 
> It's particularly fun as one of these is currently inconsistent
> within the file. I've raised it with Analog and they have promised to clean
> these up.  There is also one that has been done already (and indeed moved
> out of staging). If we apply this I'll just drop that one.

I noticed one of them was different from the others, but not that it was 
inconsistent within itself.
> 
> Obviously if they are happy with your change that is great but I will need
> an Ack from one of the current Analog team.

That's alright. I'll wait for an input from them and update this patch if 
necessary.

Thanks,

Felipe
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/adc/ad7192.c     | 3 +--
> >  drivers/staging/iio/adc/ad7192.h     | 5 ++---
> >  drivers/staging/iio/adc/ad7280a.c    | 3 +--
> >  drivers/staging/iio/adc/ad7280a.h    | 5 ++---
> >  drivers/staging/iio/adc/ad7606.c     | 3 +--
> >  drivers/staging/iio/adc/ad7606.h     | 5 ++---
> >  drivers/staging/iio/adc/ad7606_par.c | 3 +--
> >  drivers/staging/iio/adc/ad7606_spi.c | 3 +--
> >  drivers/staging/iio/adc/ad7780.c     | 3 +--
> >  drivers/staging/iio/adc/ad7816.c     | 3 +--
> >  10 files changed, 13 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index acdbc07fd259..b01d4cd6bb82 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
> >   *
> >   * Copyright 2011-2015 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/interrupt.h>
> > diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> > index 7433a43c2611..2a5a55fdd825 100644
> > --- a/drivers/staging/iio/adc/ad7192.h
> > +++ b/drivers/staging/iio/adc/ad7192.h
> > @@ -1,9 +1,8 @@
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> >   * AD7190 AD7192 AD7195 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  #ifndef IIO_ADC_AD7192_H_
> >  #define IIO_ADC_AD7192_H_
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 14f6a3ced060..c10fdce511a6 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7280A Lithium Ion Battery Monitoring System
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/crc8.h>
> > diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> > index ccfb90d20e71..400d47ab3744 100644
> > --- a/drivers/staging/iio/adc/ad7280a.h
> > +++ b/drivers/staging/iio/adc/ad7280a.h
> > @@ -1,9 +1,8 @@
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> >   * AD7280A Lithium Ion Battery Monitoring System
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #ifndef IIO_ADC_AD7280_H_
> > diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> > index 7308fa8fbb4c..b4a28cddfc91 100644
> > --- a/drivers/staging/iio/adc/ad7606.c
> > +++ b/drivers/staging/iio/adc/ad7606.c
> 
> This one isn't even there any more.  Please be careful to check you have
> the right tree to work against, particularly when doing mass changes
> like this.  In this particular case it's iio.git and right now the
> only near up to date version is the testing branch (coincidence of where
> we are in the cycle).
> 
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7606 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/interrupt.h>
> > diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> > index 86188054b60b..3a57bc5539b6 100644
> > --- a/drivers/staging/iio/adc/ad7606.h
> > +++ b/drivers/staging/iio/adc/ad7606.h
> > @@ -1,9 +1,8 @@
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> >   * AD7606 ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #ifndef IIO_ADC_AD7606_H_
> > diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> > index 8bd86e727b02..ec2280f07b78 100644
> > --- a/drivers/staging/iio/adc/ad7606_par.c
> > +++ b/drivers/staging/iio/adc/ad7606_par.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7606 Parallel Interface ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/module.h>
> > diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> > index b76ca5a8c059..0b848da3ac08 100644
> > --- a/drivers/staging/iio/adc/ad7606_spi.c
> > +++ b/drivers/staging/iio/adc/ad7606_spi.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7606 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/module.h>
> > diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..88caa6617c74 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
> >   *
> >   * Copyright 2011 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2.
> >   */
> >  
> >  #include <linux/interrupt.h>
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> > index 5209651a1b25..0ac6b3f32d13 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -1,9 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * AD7816 digital temperature sensor driver supporting AD7816/7/8
> >   *
> >   * Copyright 2010 Analog Devices Inc.
> > - *
> > - * Licensed under the GPL-2 or later.
> 
> This one is inconsistent as the module driver marking is GPL V2 only.
> Hence we should confirm this with Analog.
> 
> >   */
> >  
> >  #include <linux/interrupt.h>
> 
