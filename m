Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3EC433F5
	for <linux-iio@archiver.kernel.org>; Sun, 27 Mar 2022 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiC0Plq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Mar 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiC0Plp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 11:41:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BB2FFF7;
        Sun, 27 Mar 2022 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9826ECE0ED0;
        Sun, 27 Mar 2022 15:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3FFC340EC;
        Sun, 27 Mar 2022 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648395602;
        bh=5UJUIysu5G+FC3sQcWa7rO+707a6q3tbUEAraheZZmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZaEcuvQLDZg4Pn6TSqrqPxuPYSP9+X9i6vgs6r5VwzoG9/nIExmakROQ0zdmVxpy7
         WGX5TAfkCYUjyrnPHxo7o9B6JeAx4wXUxxvl7I1oUrwA3I+ll78LyKeP9uqGECR9/2
         BaVuNU4K6/5crBzMJKLqI89V44TKQIiObLDUxMY4pXLp/aCx1d/1vV7o+KKxLwiKkL
         FzpcDh+3uesTJSnCtbA8Xxt1VNRicQzR30ckq4VHo7FZTkcNJLTV3Hiyrjkowrm9r1
         jkm7CB8i+53Qc8T3f7PF++RMFh3kPXoViOP/t7ZFn2719yQDyA+cP98C21HOSg1n3p
         78WigHtMmlooA==
Date:   Sun, 27 Mar 2022 16:47:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220327164734.4b678562@jic23-huawei>
In-Reply-To: <CAE-0n51=ewQnTctWsmvawb_p3CrE0JgJFwLy+FR6rUPkWmTgHw@mail.gmail.com>
References: <20220318204808.3404542-1-swboyd@chromium.org>
        <20220319152641.49d8b3e1@jic23-huawei>
        <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com>
        <20220322203844.0000466f@Huawei.com>
        <CAE-0n51=ewQnTctWsmvawb_p3CrE0JgJFwLy+FR6rUPkWmTgHw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Mar 2022 17:57:26 -0400
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2022-03-22 13:38:44)
> > On Mon, 21 Mar 2022 19:36:33 +0100
> > Stephen Boyd <swboyd@chromium.org> wrote:  
> > > Quoting Jonathan Cameron (2022-03-19 08:26:41)  
> > > > On Fri, 18 Mar 2022 13:48:08 -0700
> > > > Stephen Boyd <swboyd@chromium.org> wrote:  
> > > > >
> > > > > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > > > > index 0d9bbbb50cb4..a3c8e02f5a56 100644
> > > > > --- a/drivers/iio/proximity/sx9324.c
> > > > > +++ b/drivers/iio/proximity/sx9324.c
> > > > > @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > -     *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > > > +     regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > > > +     if (regval)  
> > > >
> > > > If 0 is reserved then I'd return and error code here to indicate
> > > > we don't know what the gain is rather than carrying on regardless.
> > > > Or is this going to cause problems as it will be an ABI change (error
> > > > return possible when it wasn't really before)?
> > > >  
> > >
> > > That sounds OK to me. The driver is only being introduced now so we can
> > > still fix it to reject a gain of 0. Unless 0 should mean "off", i.e.
> > > hardware gain of 1?  
> > No.  I don't think we want to add that sort of fiddly definition.
> > So error is the way to go - I'd forgotten we only just introduced this
> > so no ABI breakage risk.
> >  
> 
> Ok got it. Does the write_gain function also need to reject values
> greater than 8 and less than or equal to 0?

Ah. Yes, it should indeed as the value is coming from userspace
so we shouldn't trust it to be sensible.

Jonathan
