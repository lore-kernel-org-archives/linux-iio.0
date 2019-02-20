Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B9C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B32020C01
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550662780;
	bh=nKe5OxFGPEEdeg4FSILn38n1AbI/2H7u9qAXI8g4rJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IySMMZo8PHvcAJCS/KZLt5RGRAUH1Y/6xoUUl/Ljmp6971NGButZWiRYgC1R34/TV
	 trNdaPdqAOQ5ZtyPtGMxw1MUdCbnrnDOwao3fcqQhfpt6Pnihroxt1UuQ6iMsjidCq
	 RkANp41A8+qtsK8Gxgz8KIFalh0/JS2aPq5C9ZvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfBTLjj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfBTLjj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 06:39:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6692089F;
        Wed, 20 Feb 2019 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550662778;
        bh=nKe5OxFGPEEdeg4FSILn38n1AbI/2H7u9qAXI8g4rJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ebNWFKTyw98pdtQuZ0iCNPuXLdRf/X3/PaeUkc8v2szmpLrPfMLgugeRIhtPhaw+C
         +V9sjtAkvbf+HkaGxt/pyO/hvVGtQdOeMHiba30G58Cw2pty1jmPr03j2/+jrU74PI
         gWs5pOiN6I/52sRI2kDCeYl8WjXvIzitPeLOyTDc=
Date:   Wed, 20 Feb 2019 11:39:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     Leonard Pollak <leonardp@tr-host.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] Staging: iio: meter: fixed typo
Message-ID: <20190220113934.68c85449@archlinux>
In-Reply-To: <BY1PR0301MB090177F0A5F558A90D7A87088E660@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <20190213101952.29816-1-leonardp@tr-host.de>
        <BY1PR0301MB090177F0A5F558A90D7A87088E660@BY1PR0301MB0901.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Feb 2019 10:25:18 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> > -----Original Message-----
> > From: leonard.pollak@tr-host.de [mailto:leonard.pollak@tr-host.de] On Behalf Of Leonard Pollak
> > Sent: Mittwoch, 13. Februar 2019 11:20
> > To: jic23@kernel.org; lars@metafoo.de; pmeerw@pmeerw.net; Hennerich, Michael <Michael.Hennerich@analog.com>
> > Cc: linux-iio@vger.kernel.org; Leonard Pollak <leonardp@tr-host.de>
> > Subject: [PATCH] Staging: iio: meter: fixed typo
> > 
> > This patch fixes an obvious typo, which will cause erroneously returning the Peak
> > Voltage instead of the Peak Current.
> > 
> > Signed-off-by: Leonard Pollak <leonardp@tr-host.de>  
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Applied to the fixes-togreg branch of iio.git, marked for stable.

Will probably not go upstream until after the coming merge window.
It's been broken a 'while' so I'm not going to rush it in.

Thanks,

Jonathan

> 
> > ---
> >  drivers/staging/iio/meter/ade7854.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> > index 029c3bf42d4d..07774c000c5a 100644
> > --- a/drivers/staging/iio/meter/ade7854.c
> > +++ b/drivers/staging/iio/meter/ade7854.c
> > @@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(0644,
> >  static IIO_DEV_ATTR_IPEAK(0644,
> >                 ade7854_read_32bit,
> >                 ade7854_write_32bit,
> > -               ADE7854_VPEAK);
> > +               ADE7854_IPEAK);
> >  static IIO_DEV_ATTR_APHCAL(0644,
> >                 ade7854_read_16bit,
> >                 ade7854_write_16bit,
> > --
> > 2.17.1  
> 

