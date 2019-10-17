Return-Path: <SRS0=D5XV=YK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401FECE58D
	for <linux-iio@archiver.kernel.org>; Thu, 17 Oct 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423D521D7D
	for <linux-iio@archiver.kernel.org>; Thu, 17 Oct 2019 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571348913;
	bh=d/nJw7fU1+wRNnvr2hQLLC8xfixudL9qQDrX2pfZKPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ESUCxIFydWawRNTtmgM1CzAvpqofsaQiIXrKIT9BIeXp3LlluBAMyvrnkibrLvemX
	 k49bLiGOceTvOlFk9+2OwstNcgrlH1blyOe0mIfm+0A1TP/7KxlpKaVE4WumgL15mI
	 pybRM/ioM/u6BsQo+j/bZWY0+4c4Z6viygvps318=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406209AbfJQVsc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391375AbfJQVsc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:48:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BAB20872;
        Thu, 17 Oct 2019 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571348912;
        bh=d/nJw7fU1+wRNnvr2hQLLC8xfixudL9qQDrX2pfZKPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dnzFilSnDnkRzX5e/36JOvouXWceJDuvsOSllorPBhIwoiuqHPazMqZBm1PYjs2SK
         H25T/DVF3a7A1/aIf7PetMIgNoXChfGlJgu2xZHyjda3eWwysTC4BqPPfbullSipwh
         fTSMF54R1Kg74L4d97z4CphPGwZyskiSsJWjbPx8=
Date:   Thu, 17 Oct 2019 22:48:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:mcp320x: Tidy up endian types in type cast.
Message-ID: <20191017224824.1541b5d3@archlinux>
In-Reply-To: <20191013105201.waluu7myfn7bcmmn@wunner.de>
References: <20191013090542.1375572-1-jic23@kernel.org>
        <20191013105201.waluu7myfn7bcmmn@wunner.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 12:52:01 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Oct 13, 2019 at 10:05:42AM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fixes the sparse warning:
> > drivers/iio/adc/mcp320x.c:167:41: warning: incorrect type in argument 1 (different base types)
> > drivers/iio/adc/mcp320x.c:167:41:    expected restricted __be32 const [usertype] *p
> > drivers/iio/adc/mcp320x.c:167:41:    got unsigned int [usertype] *<noident>
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
Applied.

Thanks,

Jonathan

> 
> Thanks,
> 
> Lukas
> 
> 
> > ---
> >  drivers/iio/adc/mcp320x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> > index 38bf10085696..465c7625a55a 100644
> > --- a/drivers/iio/adc/mcp320x.c
> > +++ b/drivers/iio/adc/mcp320x.c
> > @@ -164,7 +164,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
> >  	case mcp3550_60:
> >  	case mcp3551:
> >  	case mcp3553: {
> > -		u32 raw = be32_to_cpup((u32 *)adc->rx_buf);
> > +		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
> >  
> >  		if (!(adc->spi->mode & SPI_CPOL))
> >  			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
> > -- 
> > 2.23.0  

