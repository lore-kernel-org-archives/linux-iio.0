Return-Path: <SRS0=9Qmd=ZP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60019C432C0
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3188C20720
	for <linux-iio@archiver.kernel.org>; Sat, 23 Nov 2019 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574527634;
	bh=d0s+PMR43Kc41FVK7iy1WTImeEmP+arfu8kFbrvd6m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A1kWYDY8p5dCC2j95uGXjN0nvQUryhMdJmW/PdOPYkKVJXXb9DhV7HRetW7TNmKiI
	 gqmfvb3+o5cU14Qdbv4fcY5MxaWjMNfejas/W0RoepaY7+N/nLxGRnUwEN/fWsY7Vf
	 a6qXSQ25Puc9hcv26hniA9uXU9zpcIqTJe4DxgCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKWQrN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfKWQrN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 11:47:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F792070E;
        Sat, 23 Nov 2019 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574527632;
        bh=d0s+PMR43Kc41FVK7iy1WTImeEmP+arfu8kFbrvd6m0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mhZo3Kyol+bWAylkqEJs5DxMyBusCzd7BfWQHuqckXPYsbKX4xSxBZIw5xsH+Fv8F
         ncw7WiNIoIcI+KfnYEunb43jNyCenyVAcyVKwwHp/2zLZsOKkjWHQaXTmC3UTp6AnP
         d2cOkkb9CrjnEmqKhrezwqwOoXUzUsdR9SQVKYvQ=
Date:   Sat, 23 Nov 2019 16:47:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <mranostay@gmail.com>
Cc:     Chris Lesiak <chris.lesiak@licor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE
 channel reporting
Message-ID: <20191123164709.49b2d70b@archlinux>
In-Reply-To: <CAKzfze9iEi2ZWjWO=OE5Jm+rRrjyE5O6K34pJXfRCMvOt3qLbA@mail.gmail.com>
References: <20191121203932.17249-1-chris.lesiak@licor.com>
        <CAKzfze9iEi2ZWjWO=OE5Jm+rRrjyE5O6K34pJXfRCMvOt3qLbA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Nov 2019 18:52:26 -0800
Matt Ranostay <mranostay@gmail.com> wrote:

> On Thu, Nov 21, 2019 at 12:39 PM Chris Lesiak <chris.lesiak@licor.com>
> wrote:
> 
> > The IIO_HUMIDITYRELATIVE channel was being incorrectly reported back
> > as percent when it should have been milli percent. This is via an
> > incorrect scale value being returned to userspace.
> >
> >  
> **sigh** another failure by me to follow the iio ABI.
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> 
> > Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c
> > b/drivers/iio/humidity/hdc100x.c
> > index 066e05f92081..ff6666ac5d68 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -229,7 +229,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
> >                         *val2 = 65536;
> >                         return IIO_VAL_FRACTIONAL;
> >                 } else {
> > -                       *val = 100;
> > +                       *val = 100000;
> >                         *val2 = 65536;
> >                         return IIO_VAL_FRACTIONAL;
> >                 }
> > --
> > 2.21.0
> >
> >  

