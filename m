Return-Path: <SRS0=Vd33=RF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4EC43381
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8652086D
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="tikhzNPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfCBSsq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:48:46 -0500
Received: from smtpng3.m.smailru.net ([94.100.177.149]:52006 "EHLO
        smtpng3.m.smailru.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCBSsq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2019 13:48:46 -0500
X-Greylist: delayed 6817 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 13:48:44 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1id5Ub3a4AM/c3g7b+V/97rKwwBRIwcc1rpiJ62YYmo=;
        b=tikhzNPBFVADJZ64p7BwOCRGC8kWYWGgXYjgjUFm9SOhGZujwwJ7YudZap63wucnER4/xUkElFgTSaUBC9JtOS+OtfqMIwdIwZq1UuxnTqwN/7ANe9FJjz120cgavFMspMIGqxmfkPeM+90t5Hcx0T4c34HFdGZCt9XO4dGXt2Q=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1h09gg-0002IU-GW; Sat, 02 Mar 2019 21:48:43 +0300
Date:   Sat, 2 Mar 2019 21:48:30 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: fix chip ID reading
Message-ID: <20190302184829.GA7375@hp>
References: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
 <20190302180824.646398a2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302180824.646398a2@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=cerg2010cerg2010@mail.ru smtp.mailfrom=cerg2010cerg2010@mail.ru
X-77F55803: E14BCC6235C710295A78504BD2AC294173B5FE5E8078F29643051AECEE952BD826571D752CD617CC271E572A60368839
X-7FA49CB5: 0D63561A33F958A5D4465939ED5BE96CE59CBFC17EE01A0A343677170ABA59278941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E735D40979ECBF88E8C6B771977FE7C074C9731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB2526A3BF303149AF3C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 689FA8AB762F739359CD701D0F70D3B180F2DF78441075F862EADBECDC371F2E59BDA819A5E6616DA8F624234B89B86CE8B5287D445C8DCEAF94EBD2C457D57F4B70C0F398F9AAE4ECC6A6E4A36FFAA567EA787935ED9F1B
X-Mras: OK
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 02, 2019 at 06:08:24PM +0000, Jonathan Cameron wrote:
> On Sat,  2 Mar 2019 19:54:55 +0300
> Sergey Larin <cerg2010cerg2010@mail.ru> wrote:
> 
> > According to the datasheet, the last bit of CHIP_ID register controls
> > I2C bus, and the first one is unused. Handle this correctly.
> > 
> > Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
> Fix certainly seems to be correct, but seeing as we only support i2c for
> this chip and that I assume the bottom bit is actually set (though
> reserved), currently this is a tidy up rather than a fix.
> 
> Hence I'll take this the slow way rather than quickly as I would
> a fix with actual effect.
> 
> Let me know if I've missed something!
> 
> Jonathan

That's actually a fix for me. On my device, the bottom bit is set so driver
reports an error. With this patch, driver probes OK, prints chip info to
dmesg (die ID, revision, etc) and reports the data to sysfs, which looks
correct.

> 
> > ---
> >  drivers/iio/gyro/mpu3050-core.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > index 77fac81a3adc..5ddebede31a6 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -29,7 +29,8 @@
> >  
> >  #include "mpu3050.h"
> >  
> > -#define MPU3050_CHIP_ID		0x69
> > +#define MPU3050_CHIP_ID		0x68
> > +#define MPU3050_CHIP_ID_MASK	0x7E
> >  
> >  /*
> >   * Register map: anything suffixed *_H is a big-endian high byte and always
> > @@ -1176,8 +1177,9 @@ int mpu3050_common_probe(struct device *dev,
> >  		goto err_power_down;
> >  	}
> >  
> > -	if (val != MPU3050_CHIP_ID) {
> > -		dev_err(dev, "unsupported chip id %02x\n", (u8)val);
> > +	if ((val & MPU3050_CHIP_ID_MASK) != MPU3050_CHIP_ID) {
> > +		dev_err(dev, "unsupported chip id %02x\n",
> > +				(u8)(val & MPU3050_CHIP_ID_MASK));
> >  		ret = -ENODEV;
> >  		goto err_power_down;
> >  	}
> 
