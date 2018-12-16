Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF2C43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CE221836
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544969767;
	bh=7vNKac0fWwoR1X+M4hS8Mzqy9qBYfZ9fh+LQrhtXDG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oSP07ewJ6WKLdNwskQ6LnQ7wOFcPvxWIigth9F5qG8b0jf0QlTj+JidFRd6fC9Yd7
	 38MaEKZpV1cXOuYDXLeFG38uAF83V/252EFXu8L6hK60MWXgtsXPzECqtZTufD7IQF
	 0dhfq2Bafd0ancf+3vzqe2WbjGkcJcrhpI1QRQrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbeLPOQH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbeLPOQH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Dec 2018 09:16:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE935217F9;
        Sun, 16 Dec 2018 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544969766;
        bh=7vNKac0fWwoR1X+M4hS8Mzqy9qBYfZ9fh+LQrhtXDG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b0dTm0Gl5m393nE6LwZDxF2bvYS0ZUtJQi/UwJO7FASH2pcDjZeOY84zP0JVGzs7l
         KJsDFfdZvilfXYrp4RJJJTvHGBQlfkZ3NNFH7B/GZhttPMs3TLyhwYd2QveGHkNQO9
         hNxH40nrdpLPe5eo3yAvia59emH1wpTlmG54IzwE=
Date:   Sun, 16 Dec 2018 14:16:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used
 variable ''
Message-ID: <20181216141601.0bc53375@archlinux>
In-Reply-To: <CAA2SeN+6eNer_tMdC97LCuvVN+LqQGFAZidA_O6Ot86XASKfTA@mail.gmail.com>
References: <1544855484-154231-1-git-send-email-yuehaibing@huawei.com>
        <CAA2SeN+6eNer_tMdC97LCuvVN+LqQGFAZidA_O6Ot86XASKfTA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Dec 2018 09:24:57 +0100
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> >
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c: In function 'st_lsm6dsx_shub_read_reg':
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:108:41: warning:
> >  variable 'hub_settings' set but not used [-Wunused-but-set-variable]
> >
> > It never used since introduction in commit c91c1c844ebd ("iio: imu: st_lsm6dsx:
> > add i2c embedded controller support")
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index 8e47dcc..66fbcd9 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -105,12 +105,10 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
> >  static int st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 addr,
> >                                     u8 *data, int len)
> >  {
> > -       const struct st_lsm6dsx_shub_settings *hub_settings;
> >         int err;
> >
> >         mutex_lock(&hw->page_lock);
> >
> > -       hub_settings = &hw->settings->shub_settings;
> >         err = st_lsm6dsx_set_page(hw, true);
> >         if (err < 0)
> >                 goto out;
> >
> >
> >  
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


