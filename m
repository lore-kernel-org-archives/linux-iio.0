Return-Path: <SRS0=q/Pt=RY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C74C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508C02183E
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaq3k+6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCUVMp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:12:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43574 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUVMp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Mar 2019 17:12:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so223090lja.10
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2019 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdD0Quw0v8tIMv5BVqFh2r3gegeWLxflzCU8bWF6LOg=;
        b=vaq3k+6FM0ziMHX7HM9nw/x56bGVY3G0RNnYnsrWOGf2mQYOpl7UnWIeCxXSjLa0vw
         sDdSxhF7W02Ph64OdUMr9CZYu61Ov83r00HaFkcLftYJdSFkWwA346dEfaTQXgx9t/LT
         fF7R0txQvwQKYOOWkqSIPAD2F0FkWay99ASLBc5RsJvtqEpk4ixn/jzq2s2wKHZ6+QDH
         cqrxttjIJBu1nzPmii/f3VB1/E0FyeVZ44TX1MTuVNwPEHL8Gl6lmSjW2fEjkEjS8SHK
         IRvkeKJ/kJ7LvwGPOGo0hU8Abn+tuBzvO2Jl4MdilrgX8ftAmM2BXb56nDr/wCT4ymwo
         wlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdD0Quw0v8tIMv5BVqFh2r3gegeWLxflzCU8bWF6LOg=;
        b=hJZQ17+/emI5c5040wTsVAUi7vMUJJNJnnVFod0oUH/m/IA0XEI2RmDa9XFQlCaSEF
         BGUQDXmBsF5AKGXxCL091vzEVdFl7XQF/9h0wL5VnwnYoQqfoRVVdJKfqfk92cEGDfj8
         nHnXwfqQFDEGSP7Wth7mP2HKniWTG2Z+CxkHRwilNWESeWfIrPb67AT9U9LKhGKk/9Jx
         3e17AQ2bO0DWb4xcwhRyzfctvNCsYYYhAApxUrJ8o4VWqP5Irk+NxVxzbiXPBwuJXBUq
         o3bl64noi6Wrfqfz/NFaN85Eh83tsDUbvW/5rgWZdyWtKeuhKgMkOpqWHpnkDWiyg5Xu
         Y4Zg==
X-Gm-Message-State: APjAAAVIjPHGhFUemwT3TLIdd6BKaTDyuIlv7mzRDbxklILpV+dLm6VJ
        3gFLiKQqA7XSu7lo3gPsd+s=
X-Google-Smtp-Source: APXvYqy1KbMcrW6BoHp0g+bVOtyiuHqNm97yuzFWadchOZoq/vCfvq+7HOGwzxJN8Xu9daBIIR37Lw==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr3168278ljl.7.1553202763452;
        Thu, 21 Mar 2019 14:12:43 -0700 (PDT)
Received: from ubuntu ([95.161.223.243])
        by smtp.gmail.com with ESMTPSA id u18sm1054110ljd.77.2019.03.21.14.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:12:42 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:12:41 +0300
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
Subject: Re: [PATCH 3/3] staging: iio: ad7780: Add parentheses to macros
Message-ID: <20190321211240.GA22504@ubuntu>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-4-git-send-email-vladimir.petrigo@gmail.com>
 <20190320074217.GE2202@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320074217.GE2202@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 20, 2019 at 10:42:17AM +0300, Dan Carpenter wrote:
> On Sun, Mar 17, 2019 at 11:53:12PM +0300, Vladimir Petrigo wrote:
> > - Fix CHECK Macro argument 'wordsize' may be better as '(wordsize)' to avoid precedence issues
> > - Fix CHECK Macro argument reuse 'bits' - possible side-effects?
> > 
> > Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7780.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> > index c4a8578..2dfd6f8 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -142,7 +142,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
> >  };
> >  
> >  #define AD7780_CHANNEL(bits, wordsize) \
> > -	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
> > +	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, (bits), 32, ((wordsize) - (bits)))
>                                             ^^^^^^
> These parentheses are not required.
> 
> This doesn't fix the "argument reuse" issue...  It's not a reall issue
> though, and it isn't like this a core macro so it doesn't really matter
> too much.
> 
> regards,
> dan carpenter
> 
Thank you for the reply. I'll get rid of that parentheses in the v2

Best regards,
Vladimir Petrigo
