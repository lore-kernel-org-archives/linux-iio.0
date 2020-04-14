Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF676C2BA19
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F972072D
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586865200;
	bh=D43Bu/ZLpshHkAJBUbBrh5xBrdOB1DSsVsdvcQSwfNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTm5DL9e3LVT+3+xKy40EFuvG8rV80obTuyTQJ061Wp8jSWjRBEtBM3ZvxXjG19/V
	 ol1D/QrnKKOiZ4nX5XfWYH6V7plIrC/yp7AyGg2CGVJ8e5/Z37np5vvXDcbN4ZiOOz
	 SCqwQnfaje1kGPbxK5vm9PYeYUOE2FxC/Ypp/XWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439663AbgDNLxT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439662AbgDNLxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 07:53:16 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.102.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A81206D5;
        Tue, 14 Apr 2020 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865196;
        bh=D43Bu/ZLpshHkAJBUbBrh5xBrdOB1DSsVsdvcQSwfNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Clj8lQN7P3dEhHGhulq35t2RhO+AitzH5UFcJfbxLwpvj5tOrA7liaLMG5iPlzNOo
         w1KOI6Z7f9B0dKQoiXz+FUYHBBE2CCLrhsqn+0YQDaR72qpxhr3QoTU269zf1iz6RJ
         zlSfCPGL/h7PtgJ08tEvoNSYoYk9pg+sRLjFV6QQ=
Date:   Tue, 14 Apr 2020 17:23:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC
 sensor
Message-ID: <20200414115306.GA28064@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-4-mani@kernel.org>
 <CAHp75VeHctOu7+o6nMsqNU7q7gcJnK=n=dPX3xVMSgR9PsWjAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeHctOu7+o6nMsqNU7q7gcJnK=n=dPX3xVMSgR9PsWjAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 11:23:03PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 13, 2020 at 10:23 AM <mani@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <mani@kernel.org>
> >
> > Add devicetree OF match table support for CCS811 VOC sensor.
> 
> ...
> 
> > +#include <linux/of.h>
> 
> Why?
> 

As replied to Jonathan, will drop this and of_match_ptr.

Thanks,
Mani

> ...
> 
> > +static const struct of_device_id ccs811_dt_ids[] = {
> > +       { .compatible = "ams,ccs811" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
> 
> Since it has no ugly ifdeffery...
> 
> >  static struct i2c_driver ccs811_driver = {
> >         .driver = {
> >                 .name = "ccs811",
> > +               .of_match_table = of_match_ptr(ccs811_dt_ids),
> 
> ...use of of_match_ptr() brings a compiler warning.
> 
> Drop of_match_ptr() for good. And thus drop redundant of.h.
> 
> >         },
> 
> -- 
> With Best Regards,
> Andy Shevchenko
