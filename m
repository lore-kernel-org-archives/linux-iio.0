Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB88C2BA19
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3965620732
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586865135;
	bh=Fdj1YVdp//ceZ9oMqGAN8F8tYVPLTWDDFpuFS8d9ZK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LReIVRwo0eTbilFpv1v5KjqXNY+EDC+WnrmdcWYvvyFt2Bv7xHIuW4fG6o+L5SCov
	 D3xygIddh+BQ8gnNnny1Ee1AqBh5Jz8h8zEgw7lnVG1J5cC14YYnYu/XpE3beyrV1M
	 ZgvT1J4TG7XIBHVNM9j6CC4c18ein45sIAKFXDWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgDNLwI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgDNLwG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 07:52:06 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.102.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC477206D5;
        Tue, 14 Apr 2020 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865126;
        bh=Fdj1YVdp//ceZ9oMqGAN8F8tYVPLTWDDFpuFS8d9ZK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvLl7gxIK83JbrlKz158gl7mOTjXgiogxIFkzAfjjz+oIY5zBWsHqzrNFmgAqOLbA
         P/zzA3lQB9Qd8GhjnQIg/w6omdvO2ltpJYdcrpsC36+XJuHHDFS9eJQhe7h7x2Ost3
         nxZiqNMd+376EhOyEglUhGg3Hizw1Q0W+Df/EDvc=
Date:   Tue, 14 Apr 2020 17:21:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC
 sensor
Message-ID: <20200414115153.GC21559@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-4-mani@kernel.org>
 <20200413175054.626283dc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413175054.626283dc@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 05:50:54PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Apr 2020 00:06:58 +0530
> mani@kernel.org wrote:
> 
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Add devicetree OF match table support for CCS811 VOC sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hi,
> 
> A few small things to clean up inline
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/chemical/ccs811.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> > index 6cd92c49c348..313931208f61 100644
> > --- a/drivers/iio/chemical/ccs811.c
> > +++ b/drivers/iio/chemical/ccs811.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> 
> You are including this just to get things in mod_devicetable.h
> so include that directly instead.
> 

I added this include for of_match_ptr. Since it is not needed anymore, I'll drop
this.

> >  
> >  #define CCS811_STATUS		0x00
> >  #define CCS811_MEAS_MODE	0x01
> > @@ -538,9 +539,16 @@ static const struct i2c_device_id ccs811_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ccs811_id);
> >  
> > +static const struct of_device_id ccs811_dt_ids[] = {
> > +	{ .compatible = "ams,ccs811" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
> > +
> >  static struct i2c_driver ccs811_driver = {
> >  	.driver = {
> >  		.name = "ccs811",
> > +		.of_match_table = of_match_ptr(ccs811_dt_ids),
> No need for the of_match_ptr macro.  It has several issues.
> 
> 1) Blocks PRP001 ACPI magic device types being used to instantiate
> this using the device tree binding but under ACPI.
> 2) Will give warnings about ccs811_dt_ids being unused on no
>    device tree builds.
> 

Okay, will use ccs811_dt_ids directly.

Thanks,
Mani

> >  	},
> >  	.probe = ccs811_probe,
> >  	.remove = ccs811_remove,
> 
