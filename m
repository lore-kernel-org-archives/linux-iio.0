Return-Path: <SRS0=50BM=EE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B50C4363A
	for <linux-iio@archiver.kernel.org>; Thu, 29 Oct 2020 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA11A2072D
	for <linux-iio@archiver.kernel.org>; Thu, 29 Oct 2020 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603983172;
	bh=rxyAndQ7vagGSq6AVQ8qxT4/mEbjClh1DzlOyjtzcq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sSJIYROZhwVmJGH1Tmg0TIz/NAa+/9GWLxkbz/20UXmu1M9rXhnHKYXO7lq0wRUzl
	 zFvZE1enaK82Xh46yzTAG8TEmN4smR9ugSVoMHCZ+2KsTbrfgkvMjDxmV37FQlfvEk
	 sb/mJ8CoBzeMwe69EVQi2zMXBbe9Fny6Xdb8g5YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgJ2Oww (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgJ2Owv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 10:52:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91291206D4;
        Thu, 29 Oct 2020 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603983171;
        bh=rxyAndQ7vagGSq6AVQ8qxT4/mEbjClh1DzlOyjtzcq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LcshFT4PnBJhBjfzFLQDwnsWm1cYzq1SB9CQurkYTizRF1Dz9fqCYmLXWPmu93HRe
         9JyYyEet5Ridq+slnJ0IzC3IkoTrCp7c8Ykpv+V26FznlfVeIMVpmTBcWs96k1OIUr
         vLQkAP8IZpw9ckkaBzUFtCYQJBmHZ1WYOkbKE/L4=
Date:   Thu, 29 Oct 2020 14:52:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     trix@redhat.com, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: apds9960: remove unneeded semicolon
Message-ID: <20201029145241.1151e1ca@archlinux>
In-Reply-To: <CAJCx=g=zFHVevqtmHtP_MJS481aypAGB5PMMdsXdCNB_ZiPwoA@mail.gmail.com>
References: <20201027201436.1597726-1-trix@redhat.com>
        <CAJCx=g=zFHVevqtmHtP_MJS481aypAGB5PMMdsXdCNB_ZiPwoA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Oct 2020 21:36:17 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Tue, Oct 27, 2020 at 1:14 PM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > A semicolon is not needed after a switch statement.
> >  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git. I'll push that out later as
testing for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/iio/light/apds9960.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> > index 9afb3fcc74e6..547e7f9d6920 100644
> > --- a/drivers/iio/light/apds9960.c
> > +++ b/drivers/iio/light/apds9960.c
> > @@ -561,7 +561,7 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
> >                 }
> >         default:
> >                 return -EINVAL;
> > -       };
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.18.1
> >  

