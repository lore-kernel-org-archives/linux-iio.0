Return-Path: <SRS0=x61j=S2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B5C10F11
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95B218DA
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 12:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfDXMvl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:51:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbfDXMvl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Apr 2019 08:51:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F0FD3DB66085936E4F9;
        Wed, 24 Apr 2019 20:51:39 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 20:51:37 +0800
Date:   Wed, 24 Apr 2019 13:51:26 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Daniel G <dagmcr@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
        <stefan.popa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>,
        "Javier Martinez Canillas" <javier@dowhile0.org>
Subject: Re: [PATCH] spi: AD accelerometer: declare missing of table
Message-ID: <20190424135126.00001e7c@huawei.com>
In-Reply-To: <CA+U=DspXd1VMOQ+qf_UYzru2E5VOZHa8Cksgeh+UAH-v4nQ8Uw@mail.gmail.com>
References: <1555959916-8207-1-git-send-email-dagmcr@gmail.com>
        <CA+U=DspEySc2e6+O6bR41My0Sme0oCRH=c9Q16eHTVsJ0cRpvQ@mail.gmail.com>
        <CAPsT6h=CQV07V2S8j07ZzLKNuAbM0q9xOCqSqb4BrdXaKcjX6A@mail.gmail.com>
        <CA+U=DspXd1VMOQ+qf_UYzru2E5VOZHa8Cksgeh+UAH-v4nQ8Uw@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Apr 2019 09:39:20 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, Apr 23, 2019 at 10:55 PM Daniel G <dagmcr@gmail.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 9:58 AM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:  
> > >
> > > On Mon, Apr 22, 2019 at 10:20 PM Daniel Gomez <dagmcr@gmail.com> wrote:  
> > > >
> > > > Add missing <of_device_id> table for SPI driver relying on SPI
> > > > device match since compatible is in a DT binding or in a DTS.
> > > >  
> > >
> > > Hey,
> > >
> > > The driver is under iio, so commit title should be something like:
> > >
> > > iio: accelerometer: adxl372: declare missing of table
> > > or
> > > iio: adxl372: declare missing of table  
> > Okay! It makes sense so, I'll make the changes and send it back as v2.
> > I have sent other patches fixing the same issue under iio but with other
> > maintainers so, I will follow the same approach.  
> > >  
> > > > Before this patch:
> > > > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> > > >
> > > > After this patch:
> > > > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> > > > alias:          spi:adxl372
> > > > alias:          of:N*T*Cadi,adxl372C*
> > > > alias:          of:N*T*Cadi,adxl372
> > > >
> > > > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > > > Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/adxl372_spi.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> > > > index e14e655..af0624b 100644
> > > > --- a/drivers/iio/accel/adxl372_spi.c
> > > > +++ b/drivers/iio/accel/adxl372_spi.c
> > > > @@ -7,6 +7,8 @@
> > > >
> > > >  #include <linux/module.h>
> > > >  #include <linux/regmap.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > >  #include <linux/spi/spi.h>
> > > >
> > > >  #include "adxl372.h"
> > > > @@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
> > > >  };
> > > >  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
> > > >
> > > > +static const struct of_device_id adxl372_spi_of_match[] = {  
> > >
> > > The `spi` part of the name is un-needed.
> > > So,
> > > adxl372_spi_of_match  ->  adxl372_of_match
> > > or
> > > adxl372_spi_of_match  ->  adxl372_of_table
> > >
> > >  
> > > > +        { .compatible = "adi,adxl372" },
> > > > +        { },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, adxl372_spi_of_match);
> > > > +
> > > >  static struct spi_driver adxl372_spi_driver = {
> > > >         .driver = {
> > > >                 .name = "adxl372_spi",
> > > > +               .of_match_table = of_match_ptr(adxl372_spi_of_match),  
> > >
> > > I think the the `of_match_ptr()` is un-needed. It messes with some ACPI stuff.
> > >
> > > So, something like:
> > >     .of_match_table = adxl372_of_table,
> > > should be fine.  
> > Okay, I'll remove it as well but I thought this macro was needed to check if DT
> > support is enabled but only if the driver can be compiled as a module.
> > So, what's the reason for being unneeded in this case?  
> 
> There are 2 main mechanisms for configuring a device/board/computer [in Linux].
> One is ACPI (mostly driven by Intel & Microsoft) and the other one is
> DT (mostly driven by ARM).
A bit more here for reference.

DT actually came from Power originally I believe.

ACPI is very heavily driven by ARM and ARM licensees as well as the others
these days. I spend far too much time in work groups around that to not
comment ;)

It is just normally used on more 'standard' oriented platforms
such as laptops, desktops and servers.

> Ideally, a driver should work with both.
> 
> I'm a bit vague on how ACPI uses this table/information.
> I did look through the ACPI code (drivers/acpi) but a lot of the fine
> details are unclear to me.
> There seems to be some code in there that can parse of_match_table.

There is indeed.  PRP0001 which is wonderfully a vendor namespace allocated
to the UEFI forum (who 'own' ACPI these days). 
It basically lets you put DT elements in an ACPI DSDT table.
 
> 
> In any case, I do remember however that this is some older comment
> from other reviews.
> i.e. (if possible) do not use of_match_ptr(), because ACPI won't work
> 
> btw, a fun read about ACPI on ARM is:
> http://www.secretlab.ca/archives/151
> 
> Thanks
> Alex
> 
> > Thanks in advance!  
> > >
> > > Rest looks good
> > >
> > > Thanks
> > > Alex
> > >  
> > > >         },
> > > >         .probe = adxl372_spi_probe,
> > > >         .id_table = adxl372_spi_id,
> > > > --
> > > > 2.7.4
> > > >  


