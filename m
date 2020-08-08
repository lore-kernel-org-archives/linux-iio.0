Return-Path: <SRS0=Ar39=BS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7228C433E0
	for <linux-iio@archiver.kernel.org>; Sat,  8 Aug 2020 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C3E20748
	for <linux-iio@archiver.kernel.org>; Sat,  8 Aug 2020 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596903291;
	bh=UhfRsD3gCNBaDuX7v23KYcWuUlaYedsYaBZ1AvOdqr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sae9+MwMqRYaQyAA5mLe1flH5azpL85FgYUSKToub+6lS5/wCFnnv6ytaufQXQdPC
	 e7ZnoFg9pt8cOrzhoCqCyMxcOtwjl6AzUIzdmY00jUaNsYw/2ZMWIDWa1+WY2fIDI1
	 yvg9faAO5Dtm9Pax1/fB1s2HDdRRn0y6muYroAXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHHQOt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHQOs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Aug 2020 12:14:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F68D20716;
        Sat,  8 Aug 2020 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596903288;
        bh=UhfRsD3gCNBaDuX7v23KYcWuUlaYedsYaBZ1AvOdqr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K8/IxSO6ttFIPtbFPN71HU11kXTWDdIpysuVBcv6RtDrO+6GdVFNqeG7N3nFnBU3r
         n2N80CPA28Kh1H2o2RIurfSuBBgjTIP7y46B0lcmnpekPJ9qn3+CHZhsQdZUOqDGbQ
         VxphEr9eqW+iaeqYKISSkXdYb2y0x5rBPkXmfGHM=
Date:   Sat, 8 Aug 2020 17:14:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: light: as73211: New driver
Message-ID: <20200808171443.114c8e05@archlinux>
In-Reply-To: <4466981.tjO45I7u8z@n95hx1g2>
References: <20200805055744.31909-1-ceggers@arri.de>
        <20200805055744.31909-3-ceggers@arri.de>
        <20200806184451.04293626@archlinux>
        <4466981.tjO45I7u8z@n95hx1g2>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Aug 2020 17:46:36 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Hi Jonathan,
> 
> On Thursday, 6 August 2020, 19:44:51 CEST, Jonathan Cameron wrote:
> > Hi Christian,
> > 
> > I'll take this, but please send a follow up patch to add documentation
> > for in_intensity_x_raw and all the other new ABI this adds in
> > Documentation/ABI/testing/sysfs-bus-iio
> > I should have mentioned that earlier, but kind of assumed we already
> > had these documented for some reason!  
> where to add these entries in Documentation/ABI/testing/sysfs-bus-iio?
> Shall all missing entries be added together at the bottom (as AS73211
> is the first device using it) , or inserted in different existing paragraphs
> (when the enums where introduced)?

Insert them into the relevant groups that already exist.  In some cases
it will just be adding an entry with no specific explanation.
For the _raw attribute add a bit more info about what x, y and z are
(basically just say they are from cie1931 (I think?)

> 
> Which kernel version shall I use (5.10)?
This file doesn't change that quickly so that should be fine. I'll deal
with any merge conflicts that do occur.

Thanks,

Jonathan

> 
> regards
> Christian
> 
> 
> 
> 

