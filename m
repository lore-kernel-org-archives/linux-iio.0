Return-Path: <SRS0=h9gr=Z5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9CC43603
	for <linux-iio@archiver.kernel.org>; Sat,  7 Dec 2019 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1417227BF
	for <linux-iio@archiver.kernel.org>; Sat,  7 Dec 2019 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575711952;
	bh=UTXCzUZJhwsAARIbqIJIPoIA5mgxgB1miBGr1+OiPSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C0RsP2rIJiLWMDlrJRK05tuXmNLRAtIXUVFMDWFbqC+t8cWAgzcYinq+WVxgsjqoO
	 QkWWJj3Mg8KO2Zf6b0NdbyCO3auLT024invzOwaw75XKM0CL6tZ/KrXhF5zIdNh3Kh
	 mWCcipgbS2G26pp6MieZTcGj+jJ47AIW+sM8UmXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGJpw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 Dec 2019 04:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfLGJpw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 04:45:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646FE2173E;
        Sat,  7 Dec 2019 09:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575711951;
        bh=UTXCzUZJhwsAARIbqIJIPoIA5mgxgB1miBGr1+OiPSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vcZcHmkwjlI4O6nOHijKM1x97zCVpu+S6muePKUPMF8UsAnSxnMKckEqY670zpzbp
         EIBH+pZIXwMZnUylyFCGTvgtS+9nEDSuQKSi+nOnRM3ZdYFtAtLYtu5CBh4hFKTxAf
         BUzjCq/5msd9joVnKtXSr3PWnSqvDuBUtNVvIDPI=
Date:   Sat, 7 Dec 2019 09:45:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Message-ID: <20191207094547.29f10f5d@archlinux>
In-Reply-To: <75b6824b87bc75b968f4dc1a616c68e686068d88.camel@analog.com>
References: <20191202083830.71572-1-linus.walleij@linaro.org>
        <a1be250ce3e9a89e5a352390e16504ce8e017dbe.camel@analog.com>
        <CACRpkdYUz0yrJ_cB9rq1u+KUFUw_DOCwzAec340BgaHV_cdcuA@mail.gmail.com>
        <75b6824b87bc75b968f4dc1a616c68e686068d88.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 09:28:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2019-12-02 at 10:16 +0100, Linus Walleij wrote:
> > On Mon, Dec 2, 2019 at 9:50 AM Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> wrote:
> >   
> > > > +     st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev,
> > > > NULL,  
> > > 
> > > Would it make sense to name the GPIO here?
> > > Maybe name it "lock-detect"?
> > > 
> > > I do realize that this goes into the realm of changing some default
> > > behavior.
> > > And I am not sure how acceptable this is [generally].  
> > 
> > You can't name it in the devm_gpiod_get_optional() call as this
> > indicates the name the GPIO lines have in the device tree.
> > 
> > What you can do is add a call to
> > gpiod_set_consumer_name(gpiod, "name");
> > to explicitly name the line.
> > 
> > This will only affect the name assigned to the line
> > in debugfs and in the userspace tools like "lsgpio".
> >   
> 
> Ack.
> Thanks for the info.
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

J
> 
> 
> > Yours,
> > Linus Walleij  

