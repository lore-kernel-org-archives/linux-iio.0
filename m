Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3902C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9874220815
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551614335;
	bh=ZP5FvJZ8Dx9/IuUiB+GqTNylY8ZwBkMbAFbhgr5ZcdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mjFgtqdkP/rK790t/L7WAiLyeACzTD4lXePLrZcboY2cVYPjFlLLTMGsoDGtm1vzz
	 xqwSnzSdTWRBr5zHKgbqQn/WvN++TmdjCtGPfDn6SPUV66FPmEEXLs838T7YZrcsHP
	 WrH6s6JhUU3t1hQMmk94T7m3B9jcYMYE8jVS4QYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfCCL6y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 06:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCCL6y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Mar 2019 06:58:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B788E20857;
        Sun,  3 Mar 2019 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551614334;
        bh=ZP5FvJZ8Dx9/IuUiB+GqTNylY8ZwBkMbAFbhgr5ZcdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ol4lFjUDsn/PKN7E6DUMObAomYy1Tiz33dXjA1V/YUvFgOjifS45HBD+ks716AzVW
         p/nsTtzhqJM5Opo/V7+/3LNuR9MTnQNmT+dBA79AMc6FH3hXiVftJpAOBh/Ius+/DO
         UZ+4v++us89Vq2kJwS+Q8zSImuCMnjRqyMdLg+gM=
Date:   Sun, 3 Mar 2019 11:58:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: fix chip ID reading
Message-ID: <20190303115849.0475aa05@archlinux>
In-Reply-To: <20190302184829.GA7375@hp>
References: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
        <20190302180824.646398a2@archlinux>
        <20190302184829.GA7375@hp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2 Mar 2019 21:48:30 +0300
Sergey Larin <cerg2010cerg2010@mail.ru> wrote:

> On Sat, Mar 02, 2019 at 06:08:24PM +0000, Jonathan Cameron wrote:
> > On Sat,  2 Mar 2019 19:54:55 +0300
> > Sergey Larin <cerg2010cerg2010@mail.ru> wrote:
> >   
> > > According to the datasheet, the last bit of CHIP_ID register controls
> > > I2C bus, and the first one is unused. Handle this correctly.
> > > 
> > > Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>  
> > Fix certainly seems to be correct, but seeing as we only support i2c for
> > this chip and that I assume the bottom bit is actually set (though
> > reserved), currently this is a tidy up rather than a fix.
> > 
> > Hence I'll take this the slow way rather than quickly as I would
> > a fix with actual effect.
> > 
> > Let me know if I've missed something!
> > 
> > Jonathan  
> 
> That's actually a fix for me. On my device, the bottom bit is set so driver
> reports an error. With this patch, driver probes OK, prints chip info to
> dmesg (die ID, revision, etc) and reports the data to sysfs, which looks
> correct.
Ah fair enough. Moved to the fixes-togreg branch with a note added
to the description that there are real parts out there where this matters.

Also added Linus' tag.

This will upstream sometime after rc1 in a few weeks time.

Thanks,

Jonathan
> 
> >   
> > > ---
> > >  drivers/iio/gyro/mpu3050-core.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > > index 77fac81a3adc..5ddebede31a6 100644
> > > --- a/drivers/iio/gyro/mpu3050-core.c
> > > +++ b/drivers/iio/gyro/mpu3050-core.c
> > > @@ -29,7 +29,8 @@
> > >  
> > >  #include "mpu3050.h"
> > >  
> > > -#define MPU3050_CHIP_ID		0x69
> > > +#define MPU3050_CHIP_ID		0x68
> > > +#define MPU3050_CHIP_ID_MASK	0x7E
> > >  
> > >  /*
> > >   * Register map: anything suffixed *_H is a big-endian high byte and always
> > > @@ -1176,8 +1177,9 @@ int mpu3050_common_probe(struct device *dev,
> > >  		goto err_power_down;
> > >  	}
> > >  
> > > -	if (val != MPU3050_CHIP_ID) {
> > > -		dev_err(dev, "unsupported chip id %02x\n", (u8)val);
> > > +	if ((val & MPU3050_CHIP_ID_MASK) != MPU3050_CHIP_ID) {
> > > +		dev_err(dev, "unsupported chip id %02x\n",
> > > +				(u8)(val & MPU3050_CHIP_ID_MASK));
> > >  		ret = -ENODEV;
> > >  		goto err_power_down;
> > >  	}  
> >   

