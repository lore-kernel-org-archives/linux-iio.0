Return-Path: <SRS0=tzPa=5A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7EC10DCE
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 13:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F13205C9
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584277813;
	bh=BclL4q3BTBO/kD7NJIxPs6flg8hZRErwfbM6JXTl1tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LBrpdySNcoehRh/30va5vSDcCFSouaKUB0eDj/24QbmAUbwbUlYDxYv6kwsSGY3CL
	 nq3LgpupTaOHib8XTRbRry8BuQWN2f9ennCSdrXjYWXCODV+0RfVnDOysLh9BcNzPA
	 A0ohmm3n50lH3K0NjOLWVXAG1zNh3elgzKXFza1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgCONKM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Mar 2020 09:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgCONKM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:10:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC24920575;
        Sun, 15 Mar 2020 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584277812;
        bh=BclL4q3BTBO/kD7NJIxPs6flg8hZRErwfbM6JXTl1tg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2DjiD9Q+cU1FfVYaUqZY/fCaI0uuIPqBxb1neauhxLcSqJCaBZNe5N1N+WbfNi8/p
         gK+1oPmPzfJRlt3HfnoEcp74+f30wcDkYccFWIfSgxl0zpfOa9eR8xX1OvXu/nH8IQ
         qU5yHSIErZ9TvqvSv8TQfOrdJwyrjceWBnhhxBUY=
Date:   Sun, 15 Mar 2020 13:10:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: tsl2772: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200315131008.587ba23a@archlinux>
In-Reply-To: <20200315103358.GA4674@onstation.org>
References: <20200311074325.7922-1-tiwai@suse.de>
        <20200311074325.7922-3-tiwai@suse.de>
        <20200315095834.76f50454@archlinux>
        <20200315103358.GA4674@onstation.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 06:33:58 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Sun, Mar 15, 2020 at 09:58:34AM +0000, Jonathan Cameron wrote:
> > On Wed, 11 Mar 2020 08:43:25 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> >   
> > > Since snprintf() returns the would-be-output size instead of the
> > > actual output size, the succeeding calls may go beyond the given
> > > buffer limit.  Fix it by replacing with scnprintf().
> > > 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>  
> > 
> > This one is printing a short well defined list of values.  No way they go
> > anywhere near the smallest possible PAGE_SIZE buffer that it's printing
> > into.
> > 
> > Which is handy given the remaining space isn't adjusted as we add items
> > to the string.  Hence even with scnprintf it would overflow.
> > 
> > Brian, can you take a look at this when you get a moment?  
> 
> I also agree that this won't overflow in practice, however we should fix
> this up. Maybe the scnprintf() calls should be this:
> 
>     offset += scnprintf(buf + offset, PAGE_SIZE - offset, ...);

Agreed.

Jonathan

> 
> Brian
> 
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/light/tsl2772.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > index be37fcbd4654..44a0b56a558c 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> > >  	int offset = 0;
> > >  
> > >  	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
> > > -		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> > > +		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> > >  			chip->tsl2772_device_lux[i].ch0,
> > >  			chip->tsl2772_device_lux[i].ch1);
> > >  		if (chip->tsl2772_device_lux[i].ch0 == 0) {
> > > @@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> > >  		i++;
> > >  	}
> > >  
> > > -	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
> > > +	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
> > >  	return offset;
> > >  }
> > >    

