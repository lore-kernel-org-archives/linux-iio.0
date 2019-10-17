Return-Path: <SRS0=D5XV=YK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7242DFA372A
	for <linux-iio@archiver.kernel.org>; Thu, 17 Oct 2019 21:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1D21D7A
	for <linux-iio@archiver.kernel.org>; Thu, 17 Oct 2019 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571346495;
	bh=ddM+TqhEtWRfr29CbPhNibEcfNOB8CVV1mBkVDeMVH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qE+9MS1JiVlujbaQXSQKMs+RLSiekmY2hExtkbdKsYgIoVfnygiqWK9TRQI4OpGce
	 qFFrinn4GNQJ8I6AZlWaX+EGMteXB7dBTUQ3QUSIYuHq1qL+w9H5rgg0I21rIeYywM
	 vojcY7IN0ycy6w+4tzhc9h2Iwe+QlhrQQjxguHoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440994AbfJQVIO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394814AbfJQVIO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:08:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395EC21A4C;
        Thu, 17 Oct 2019 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571346493;
        bh=ddM+TqhEtWRfr29CbPhNibEcfNOB8CVV1mBkVDeMVH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vYUFL78uKZXFHbUtBPFajxMMtiw3buWIsT3eGHY3DG08q0wZagEpvN1xjhSSbnm7O
         JiNVzp8KILf9DJE60cD5t9fDpLniidtN0g6BCbO1RcieBQ6GeulVBLvkHDAhQyfO7f
         Vi6NHYyB1oeGMpqHgzKmZlk0rZoTCKGbBdCL0Hgc=
Date:   Thu, 17 Oct 2019 22:08:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 4/7 v4] hwmon: ab8500: convert to IIO ADC
Message-ID: <20191017220809.464deea1@archlinux>
In-Reply-To: <CACRpkdbZA6kDWWP0_HCwMH1nFSwAFWjiFhaQXBi3cDgZ0ahapA@mail.gmail.com>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
        <20191011071805.5554-5-linus.walleij@linaro.org>
        <b192d50a-3bcf-6d4b-f2f5-2d6276601cf4@roeck-us.net>
        <CACRpkdbZA6kDWWP0_HCwMH1nFSwAFWjiFhaQXBi3cDgZ0ahapA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 22:48:24 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Oct 11, 2019 at 3:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 10/11/19 12:18 AM, Linus Walleij wrote:  
> 
> > > This should not be applied to the hwmon tree right now, it
> > > will be applied along with the other changes in ARM SoC.  
> >
> > I assume this is still true ?  
> 
> Yeah the plan is to merge all patches through the IIO tree.

Immutable branch created based on 5.4-rc1 at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-ab8500-5.4-rc1

This is an overly fiddly set to actually build so Linus if you could
do a quick sanity check that would be great.  Even better if you could
take a look at relaxing some of the build constraints so this
gets some decent build coverage from the various autobuilders.

I plan on pulling this into my togreg branch in a few minutes, which will
then be pushed out as testing for the autobuilders to maybe figure out
how to build this.

Thanks,

Jonathan

> 
> Thanks,
> Linus Walleij

