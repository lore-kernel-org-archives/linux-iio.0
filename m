Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E9C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E520714
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587831836;
	bh=0TcllW/fHyxWCvC4FHK/zFdbFPAgeF5m87THJYWwC1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ELl5LEdkWVPvf8T4ChOA9gPWZw7VoyQfAwKbda9Ki1dK5bsKxE5Y3TNXz55EUQy+/
	 Xf+2V3mGO8wCPO2JW5zoo9KMvQZgcHE2tTY2ErUpHRiXlz5HhnU8YvnXXvKrBdwg7N
	 69aSS4t0RiE+afIzKhVpb2qLUjOtCdCadC0eyn0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYQX4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgDYQXz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:23:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F7620704;
        Sat, 25 Apr 2020 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587831835;
        bh=0TcllW/fHyxWCvC4FHK/zFdbFPAgeF5m87THJYWwC1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SQk/2hdQNEHt20fb34muN5e4t+oahfy7KcaegppmV+lO9IDC8GxiyDARxtMIKpqWw
         bAQQA6lCAQlVTFyNvvzfklhZ33pCDkji7BDpb3rkHSIZhz1L3qNUtxUmrF7sVzn0TH
         qKX3FEamTYA4qCzLAyRDLM1hSCa8k81D3KyeEwZk=
Date:   Sat, 25 Apr 2020 17:23:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 02/16] iio: adc: mpc3422: Use get_unaligned_beXX()
Message-ID: <20200425172351.5393b429@archlinux>
In-Reply-To: <20200425171420.5c46ac1a@archlinux>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-2-andriy.shevchenko@linux.intel.com>
        <20200425171420.5c46ac1a@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 17:14:20 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 21 Apr 2020 03:31:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > This makes the driver code slightly easier to read.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Looks good to me.
> 
> Applied
> 
And doesn't build... 

Needs
#include <asm/unaligned.h>

I've added it.

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/mcp3422.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> > index ea24d7c58b12..b247eb209f10 100644
> > --- a/drivers/iio/adc/mcp3422.c
> > +++ b/drivers/iio/adc/mcp3422.c
> > @@ -117,11 +117,11 @@ static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
> >  
> >  	if (sample_rate == MCP3422_SRATE_3) {
> >  		ret = i2c_master_recv(adc->i2c, buf, 4);
> > -		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
> > +		temp = get_unaligned_be24(&buf[0]);
> >  		*config = buf[3];
> >  	} else {
> >  		ret = i2c_master_recv(adc->i2c, buf, 3);
> > -		temp = buf[0] << 8 | buf[1];
> > +		temp = get_unaligned_be16(&buf[0]);
> >  		*config = buf[2];
> >  	}
> >    
> 

