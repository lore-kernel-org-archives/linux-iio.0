Return-Path: <SRS0=emZ9=BU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C75C433DF
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F4920729
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHJN0M (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:26:12 -0400
Received: from mailout07.rmx.de ([94.199.90.95]:55248 "EHLO mailout07.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgHJN0M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 09:26:12 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout07.rmx.de (Postfix) with ESMTPS id 4BQGv528ynzBtyq;
        Mon, 10 Aug 2020 15:26:09 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BQGtr4Wklz2xGF;
        Mon, 10 Aug 2020 15:25:56 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.13) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Aug
 2020 15:24:40 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: documentation: light: Add as73211 sysfs documentation
Date:   Mon, 10 Aug 2020 15:24:39 +0200
Message-ID: <2320252.sbR73lAtI7@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200810123540.sdzbtpgwkyqjg6ag@duo.ucw.cz>
References: <20200808171443.114c8e05@archlinux> <4688751.agSyimv0uN@n95hx1g2> <20200810123540.sdzbtpgwkyqjg6ag@duo.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.13]
X-RMX-ID: 20200810-152558-4BQGtr4Wklz2xGF-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Pavel,

On Monday, 10 August 2020, 14:35:40 CEST, Pavel Machek wrote:
> On Mon 2020-08-10 11:57:46, Christian Eggers wrote:
> > On Monday, 10 August 2020, 11:00:54 CEST, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > The driver for the as73211 light sensor provides the following not yet
> > > > documented sysfs entries:
> > > > - in_intensity_(x|y|z)_raw
> > > > - in_intensity_(x|y|z)_scale
> > > > - in_intensity_sampling_frequency(_available)
> > > > - in_intensity_hardwaregain(_available)
> > > 
> > > Should that be hardware_gain ?
> > 
> > drivers/iio/industrialio-core.c:
> > [IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
> 
> Yep. Fix that before people start to really use it.
it's too late! IIO_CHAN_INFO_HARDWAREGAIN was introduced back in 2012. My 
patch only adds "hardwaregain" in a new context (of "intensity").

> 								
	Pavel

regards
Christian




