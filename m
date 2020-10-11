Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D9CC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6742222F
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602436328;
	bh=ub/quG4quutxLNFN4hsKbiPh4RVFdcfrM76BxqCiyVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W34QmgajkDvZsZbkZkdfXwsdUWQrkswkT6yMAhmxCUT94nKOyrOXBp00aN4qs039k
	 cRF2mcIv+T0sRjP4JNYltXi/8E31WtAkNwdovseIJM5Yqe2syCM1Sc//P1d7FfgqS8
	 j3OtNeXyRW6QxLZbfXTPqyAWkwAgoj4y4aiR9BXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgJKRMI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 13:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRMI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:12:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36142222A;
        Sun, 11 Oct 2020 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436327;
        bh=ub/quG4quutxLNFN4hsKbiPh4RVFdcfrM76BxqCiyVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EgnbAd62YulB5EJh2jXpH5x9kxckWes6TPyvFZ67EQ1rRelSjTU2oHGnZf5/aDiTG
         t4pURJvyeqc2DkWz8AL4x47dYe7myvgpVnyGD9H+Ac6sBEgJKWW7R6b6NcSJztwtP0
         M+eTzfjl7AzqEbfXuDN/zzuob2Sf0BL3pNvX6rgI=
Date:   Sun, 11 Oct 2020 18:11:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adis16240: add blank
 line before struct definition
Message-ID: <20201011181158.7541d290@archlinux>
In-Reply-To: <alpine.DEB.2.22.394.2010111303540.2716@hadrien>
References: <20201011104800.GA29412@ubuntu204>
        <alpine.DEB.2.22.394.2010111303540.2716@hadrien>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 13:06:06 +0200 (CEST)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 11 Oct 2020, Deepak R Varma wrote:
> 
> > Add a blank line before starting structure definition as per coding
> > style guidelines. Issue reported by checkpatch script.
> >
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>  
> 
> Acked-by: Julia Lawall <julia.lawall@inria.fr>

Hi Deepak / Julia.

Applied to the togreg branch of iio.git.  Initially I'll be pushing that
out as testing, so that various systems that run build tests can check
we haven't missed anything.   Clearly they won't be finding anything in
this particular patch, but there are other things in that branch that
may be more problematic.

Given timing wrt to the merge window, these won't go upstream until
next cycle.  I will probably send Greg KH a pull request in a few
weeks time (after rc1) including this patch.

Thanks,

Jonathan


> 
> > ---
> >  drivers/staging/iio/accel/adis16240.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > index 5064adce5f58..8d3afc6dc755 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -426,6 +426,7 @@ static int adis16240_probe(struct spi_device *spi)
> >
> >  	return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> > +
> >  static const struct of_device_id adis16240_of_match[] = {
> >  	{ .compatible = "adi,adis16240" },
> >  	{ },
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20201011104800.GA29412%40ubuntu204.
> >  

