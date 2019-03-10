Return-Path: <SRS0=Fqd7=RN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F06C43381
	for <linux-iio@archiver.kernel.org>; Sun, 10 Mar 2019 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85808207E0
	for <linux-iio@archiver.kernel.org>; Sun, 10 Mar 2019 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="VQEX5Hnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfCJLbR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:31:17 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:42760 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfCJLbR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Mar 2019 07:31:17 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 46442E08ED; Sun, 10 Mar 2019 12:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1552217476; bh=i9LjFhq/VTTmTGGBvpJ1bPtHNegx6xo7FBC2j0A2IqE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VQEX5Hnrbs7XXi5w4o6eVGzTUuhUg0A+1599ynm2qcDg+zJH3UC6qRfTPT8NKPyWl
         YmKBufBW2yZp04M2OEHYegfxMFGZJsKO8DIOOvl0s1e2E/CXLQXq+FdjTvsIBLppG1
         LM4u45SHPhi4Q0T1d7HFqPYlwVgFDY+LBvCe4W2g=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2CA83E04DC;
        Sun, 10 Mar 2019 12:31:16 +0100 (CET)
Date:   Sun, 10 Mar 2019 12:31:16 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Jonathan Cameron <jic23@kernel.org>
cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp4725: add missing powerdown bits in store
 eeprom
In-Reply-To: <20190309182754.5222143b@archlinux>
Message-ID: <alpine.DEB.2.21.1903101230020.13266@vps.pmeerw.net>
References: <20190306205606.30419-1-jeff.dagenais@gmail.com> <20190309182754.5222143b@archlinux>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> +Cc Peter.
 
> > When issuing the write DAC register and write eeprom command, the two
> > powerdown bits (PD0 and PD1) are assumed by the chip to be present in
> > the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
> > a different state that the current one. By adding the current state of
> > the powerdown in the i2c write, the chip will correctly power-on exactly
> > like as it is at the moment of store_eeprom call.
> > 
> > This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
> > for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
> > "Write All Memory Command".
> > 
> > Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

> sounds fine to me, but I'd like to give Peter a chance to comment.
> Give me a poke if it turns out Peter is busy and doesn't get back
> to us in a week or two.

I'd suggest whitespace around the + operator, otherwise

Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

> > ---
> >  drivers/iio/dac/mcp4725.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > index 6ab1f23e5a79..97bb350d1e77 100644
> > --- a/drivers/iio/dac/mcp4725.c
> > +++ b/drivers/iio/dac/mcp4725.c
> > @@ -98,6 +98,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
> >  
> >  	inoutbuf[0] = 0x60; /* write EEPROM */
> >  	inoutbuf[0] |= data->ref_mode << 3;
> > +	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode+1) << 1) : 0;
> >  	inoutbuf[1] = data->dac_value >> 4;
> >  	inoutbuf[2] = (data->dac_value & 0xf) << 4;
> >  
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
