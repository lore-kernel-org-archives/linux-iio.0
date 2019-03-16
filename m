Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E04EC43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2666421900
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552749417;
	bh=sED1swGDglN29sRmh+O9lHz6EhAjhJO5bQ/G6J0kinc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g29AGP1YcUo2YkNGv8Wu9l+V3T0jhNjJks4JA476aakh52Jb7XkAV5MsKjr1vrj+m
	 ddZ59LbAlnirqPvTNg4vNfZFQO5h3Siad7m8m5EKjy1M6csOxzRmWY8g9miAvQNW9o
	 uN2u/LC/3mBW8YBZwOsDLEM4PeCdyN0HYXoFmw34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCPPQ4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfCPPQ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 11:16:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E8C218D4;
        Sat, 16 Mar 2019 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552749415;
        bh=sED1swGDglN29sRmh+O9lHz6EhAjhJO5bQ/G6J0kinc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WXO6By0JuzL8S/x+YL/wYfOP0qpQe8d1XdiZ+1ULJaz0omymwvjnFBi/McHgs1zSS
         AJ5ujLYWneenbppRMt/F/6JZ4WrXQwZsAzxxeaBD91zsJADnMUcbvXXW30yftFs5Z7
         ZBME0lSHKYfRj6zjOlXSafYQx9XRGTPmrMeqEISI=
Date:   Sat, 16 Mar 2019 15:16:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp4725: add missing powerdown bits in store
 eeprom
Message-ID: <20190316151651.33f17575@archlinux>
In-Reply-To: <alpine.DEB.2.21.1903101230020.13266@vps.pmeerw.net>
References: <20190306205606.30419-1-jeff.dagenais@gmail.com>
        <20190309182754.5222143b@archlinux>
        <alpine.DEB.2.21.1903101230020.13266@vps.pmeerw.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Mar 2019 12:31:16 +0100 (CET)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> > +Cc Peter.  
>  
> > > When issuing the write DAC register and write eeprom command, the two
> > > powerdown bits (PD0 and PD1) are assumed by the chip to be present in
> > > the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
> > > a different state that the current one. By adding the current state of
> > > the powerdown in the i2c write, the chip will correctly power-on exactly
> > > like as it is at the moment of store_eeprom call.
> > > 
> > > This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
> > > for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
> > > "Write All Memory Command".
> > > 
> > > Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>  
> 
> > sounds fine to me, but I'd like to give Peter a chance to comment.
> > Give me a poke if it turns out Peter is busy and doesn't get back
> > to us in a week or two.  
> 
> I'd suggest whitespace around the + operator, otherwise
> 
Good point, added...
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

Applied to the fixes-togreg branch of iio.git and marked
for stable. It's not super critical as fixes go but
things are currently not quite doing what someone might
expect.

Thanks,

Jonathan

> 
> > > ---
> > >  drivers/iio/dac/mcp4725.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > > index 6ab1f23e5a79..97bb350d1e77 100644
> > > --- a/drivers/iio/dac/mcp4725.c
> > > +++ b/drivers/iio/dac/mcp4725.c
> > > @@ -98,6 +98,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
> > >  
> > >  	inoutbuf[0] = 0x60; /* write EEPROM */
> > >  	inoutbuf[0] |= data->ref_mode << 3;
> > > +	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode+1) << 1) : 0;
> > >  	inoutbuf[1] = data->dac_value >> 4;
> > >  	inoutbuf[2] = (data->dac_value & 0xf) << 4;
> > >    
> >   
> 

