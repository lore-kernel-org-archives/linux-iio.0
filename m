Return-Path: <SRS0=q/Pt=RY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE7C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2713218D4
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwrDkqHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCUVOU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:14:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45751 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfCUVOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Mar 2019 17:14:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so215890ljd.12
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2019 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ee7GV1lN08oSnn/9/EkKWR68iiKyfYvmUccZDArh63w=;
        b=uwrDkqHi22quAaWrz//ktfrTfPjW4Y+wtShhnFQmJtgxb7x3+6SOopJ9HiVRkriP0g
         y4xRZ8DN8T4iBRL7HUXOmmg4sV+PH05KmCiGIWoWCtnGUv0LuZY6zTTmXIqRqWD/tDuF
         blXSgMlpApZXiYHre3b2lB98Lheu/LmwnAeTPh3piUAwCDJSowKj10M9JWNEieKGMlcB
         lHDMiV6NwBXDmCL5xm4JcXesZKMlMCw+URT/+iSWEFzkmAcIrQt/XbvLGu34JVcy3PUX
         MY4BPMGKMNixBxuTnO1ptJfrSAO2OmOMoKxEl0KJ2JY01R78d5NNz1QbBxf4Ofkp00rU
         YWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ee7GV1lN08oSnn/9/EkKWR68iiKyfYvmUccZDArh63w=;
        b=S5+m3iKUlROqipLptdqIlzD8F3aZeCB+F8sqgtwE9ZNUOHYo0wdKdPOrerEicjMgZs
         tyY1aDVlnYk8cgzB2l6Cd1MoZw4NIdvK+BMvFRz9oigVEz9Jta6YeYvoTbHqUAA6fURk
         k2KWSGimvLub+xhOqkj4bl+De0RuM4MmRNcAG+3VFbMChLrirckVEIoH0ZyFv3Cz6EqN
         7/kZM2UvXBDfFvgwj3QOqwnuGTOGaQtsAfRxX9aQPZoXnnODSk00DhOH9UT5yLoUPTGS
         rWm1zG2D941Ap9zPRTVbQQGN9UF2aHOPQtblRvFhUqzHshs3XEtqDMdIIvLH68RxvFlQ
         Dh8A==
X-Gm-Message-State: APjAAAUfU1aIBA0OOLfAliE6p2Mifp/Qqu6zVvBCVpEIea5uCNdhEWIM
        tKYYypCfF8M04c18a7tmuSM=
X-Google-Smtp-Source: APXvYqw8oZfbixX27nXVUMZoyKurwMNm3WA3u30V1nT6YD7VCzkRHWu8BDrUNCXs1HuALGCHmtwZKA==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr3249939lja.34.1553202857778;
        Thu, 21 Mar 2019 14:14:17 -0700 (PDT)
Received: from ubuntu ([95.161.223.243])
        by smtp.gmail.com with ESMTPSA id e18sm781400ljb.12.2019.03.21.14.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:14:17 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:14:15 +0300
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] staging: iio: ad7280a: Add parentheses to macros
Message-ID: <20190321211414.GB22504@ubuntu>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-3-git-send-email-vladimir.petrigo@gmail.com>
 <20190320073805.GD2202@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320073805.GD2202@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 20, 2019 at 10:38:06AM +0300, Dan Carpenter wrote:
> On Sun, Mar 17, 2019 at 11:53:11PM +0300, Vladimir Petrigo wrote:
> > Fix CHECK Macro argument 'c' may be better as '(c)' to
> > avoid precedence issues
> > 
> > Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c
> > b/drivers/staging/iio/adc/ad7280a.c index d9df126..98cf876
> > 100644 --- a/drivers/staging/iio/adc/ad7280a.c +++
> > b/drivers/staging/iio/adc/ad7280a.c @@ -97,9 +97,9 @@
> >  #define AD7280A_NUM_CH (AD7280A_AUX_ADC_6 - \
> >  					AD7280A_CELL_VOLTAGE_1
> > + 1)
> > 
> > -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d *
> > AD7280A_CELLS_PER_DEV) + c) -#define
> > AD7280A_CALC_TEMP_CHAN_NUM(d, c) ((d *
> > AD7280A_CELLS_PER_DEV) + \ - c - AD7280A_CELLS_PER_DEV)
> > +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) *
> > AD7280A_CELLS_PER_DEV) + (c)) +#define
> > AD7280A_CALC_TEMP_CHAN_NUM(d, c) (((d) *
> > AD7280A_CELLS_PER_DEV) + \ + (c) - AD7280A_CELLS_PER_DEV)
> > 
> >  #define AD7280A_DEVADDR_MASTER 0 define
> >  #AD7280A_DEVADDR_ALL 0x1F
> 
> I don't know how this diff got added to the commit message, but
> obviously we don't want that.
> 
> regards,
> dan carpenter
> 
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index d9df126..98cf876 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -97,9 +97,9 @@
> >  #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
> >  					AD7280A_CELL_VOLTAGE_1 + 1)
> >  
> > -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
> > -#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
> > -					     c - AD7280A_CELLS_PER_DEV)
> > +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + (c))
> > +#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> > +					     (c) - AD7280A_CELLS_PER_DEV)
> >  
> >  #define AD7280A_DEVADDR_MASTER		0
> >  #define AD7280A_DEVADDR_ALL		0x1F
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
Yes, something went wrong, will fix that in the v2.

Best regards,
Vladimir Petrigo
