Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6520C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 12:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B842222D6
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553430171;
	bh=q8VkKL0JtpjIHw9ScRXMrvx/xNpM7nrXa5OUNNXsC5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SMIHR/s4fhPqCnuITk6EVITNn0PQa0t9od4byKM9TkwS5ER6vKjbyNmQsCSo04IVh
	 i2d/znAVjm53ZO3VDUHLm+AlrZEXjanwcU7t7yvTgKUj4sl98YkXbmO+cWE+qVp8Bn
	 aUjj17vBDW6KKdWpDTXWC/Ts8GRWsA6CIAFtOAik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfCXMWu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfCXMWu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Mar 2019 08:22:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D48C222BA;
        Sun, 24 Mar 2019 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553430169;
        bh=q8VkKL0JtpjIHw9ScRXMrvx/xNpM7nrXa5OUNNXsC5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=emKw5D1BmcJe8N143V6DuRmRDlZUsyTpN5BS20QyJwizJq9HzygK0GhZ48a5yhT2Y
         PgbtLeDgsZMwwQRXbpxid4eLf9rs+x7C2KDNDLEIbS3Wc2n7RFgqwCgWOPK6l0VV43
         3ZLXSTvoWFgl+5Iupd2dJJOVQS6fikd91eJxMIFE=
Date:   Sun, 24 Mar 2019 12:22:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190324122244.484b6dfb@archlinux>
In-Reply-To: <20190319212507.GM9224@smile.fi.intel.com>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
        <20190318205242.GA11257@arch>
        <20190318223728.GA9224@smile.fi.intel.com>
        <20190319190213.GB11257@arch>
        <20190319212507.GM9224@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Mar 2019 23:25:07 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Mar 19, 2019 at 08:02:15PM +0100, Tomasz Duszynski wrote:
> > On Tue, Mar 19, 2019 at 12:37:28AM +0200, Andy Shevchenko wrote:  
> > > On Mon, Mar 18, 2019 at 09:52:42PM +0100, Tomasz Duszynski wrote:  
> > > > On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:  
> 
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/driver.h>
> > > > > +#include <linux/iio/machine.h>  
> 
> > > > Alphabetical order is preferred.  
> > >
> > > Ah, you meant iio.h vs. driver.h?
> > >  
> > 
> > Yes.  
> 
> It won't compile in alphabetical order.

That's a little worrying as this should definitely not be order dependant.
What was the error? 

Ah, I'm guessing struct iio_dev not defined.
If you would like to put a patch in to add that forward definition in driver.h
that would be great.  Its an omission rather than intentional.

Any chance of getting the whole MFD including this buildable with COMPILE_TEST?
Otherwise coverage likely to be somewhat reduced (I probably won't build it
normally for starters!)

Jonathan

> 
> > > > > +	u8 buf[2];
> > > > > +	int ret;  
> > >  
> > > > > +	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> > > > > +	if (ret)
> > > > > +		goto done;
> > > > > +
> > > > > +	*result = (buf[0] << 8) | buf[1];  
> > > >
> > > > be/le16_to_cpu() will do it for you.  
> > >
> > > I think get_unaligned_le16() will be better here. Otherwise we need to define
> > > __le16 variable and cast around it.
> > >  
> > 
> > I was thinking about be16_to_cpu(*(__be16 *)buf).
> > Given this is local array and you do not do any pointer arithmetic
> > before casting I would be surprised if that caused unaligned access.  
> 
> Explicit casting to bitwise types seems weird to me, that's why get_unaligned looks better.
> And no, there is no unaligned access per se.
> 

