Return-Path: <SRS0=aw/O=QS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FCC169C4
	for <linux-iio@archiver.kernel.org>; Mon, 11 Feb 2019 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E00217FA
	for <linux-iio@archiver.kernel.org>; Mon, 11 Feb 2019 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549915726;
	bh=+9/DpXA9vFb8cXHHnmqK3ASxqSo1tiG+NCjb/X6xLwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eSRY5RifZ8n3/1ZKpxoHAbCIYgStx1+ok2YEUNI4gTyRdbeJl0XgXtfSCb6W9qqFc
	 EhIqJfsHTXq+K75g+gBklt/yrtx1zYYSOMEc01AsZ3p3v4Nxy9Qf8vBVqoX3i5Cejx
	 y8ovwTGyl6URzqTMN969d+ec6S8jzhx5wUf7AHK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfBKUIp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfBKUIp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Feb 2019 15:08:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5CA217FA;
        Mon, 11 Feb 2019 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549915724;
        bh=+9/DpXA9vFb8cXHHnmqK3ASxqSo1tiG+NCjb/X6xLwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tYxOuvYuMmpp1NxosW/Dp8gFhrsVEgTyIX2+wDx8en2WwK0VOETx/8A46N0MawS/r
         pelofyyHPRPNq+uAc9cLpwKvlZFWYP/b+mEZr5PJvk3sJVhnc6oKd8JrOWEgvdqCza
         BeY6ma9YmFM0fbmQ8X+iZzl9AVR2smMxQLjusivg=
Date:   Mon, 11 Feb 2019 20:08:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>
Subject: Re: [PATCH] iio:chemical:sps30 Suppress some switch fallthrough
 warnings.
Message-ID: <20190211200839.0b625f50@archlinux>
In-Reply-To: <20190209201209.GA19661@arch>
References: <20190209193934.64038cf4@archlinux>
        <20190209201209.GA19661@arch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Feb 2019 21:12:10 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Sat, Feb 09, 2019 at 07:39:34PM +0000, Jonathan Cameron wrote:
> > Fixes warnings reported on linux-next but marking one path
> > and adding an explicit return in the other.
> >  
> 
> Looks good.
> 
> Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Thanks,

Applied to the togreg branch of iio.git.

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andreas Brauchli <a.brauchli@elementarea.net>
> > ---
> > I'd like to get this one into linux-next fairly quick so it anyone
> > has time to do a quick sanity check it would be much appreciated!
> >
> >  drivers/iio/chemical/sps30.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index 375df5060ed5..edbb956e81e8 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
> >  	case SPS30_READ_AUTO_CLEANING_PERIOD:
> >  		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
> >  		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
> > +		/* fall through */
> >  	case SPS30_READ_DATA_READY_FLAG:
> >  	case SPS30_READ_DATA:
> >  	case SPS30_READ_SERIAL:
> > @@ -295,6 +296,8 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
> >  				*val2 = 10000;
> >
> >  				return IIO_VAL_INT_PLUS_MICRO;
> > +			default:
> > +				return -EINVAL;
> >  			}
> >  		default:
> >  			return -EINVAL;
> > --
> > 2.20.1
> >  

