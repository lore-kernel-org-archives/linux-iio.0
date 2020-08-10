Return-Path: <SRS0=emZ9=BU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC9BC433E3
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1894A206B5
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 09:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHJJBB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:01:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46146 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHJJBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 05:01:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 84DC01C0BDA; Mon, 10 Aug 2020 11:00:59 +0200 (CEST)
Date:   Mon, 10 Aug 2020 11:00:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: documentation: light: Add as73211 sysfs
 documentation
Message-ID: <20200810090054.GA8495@localhost>
References: <20200808171443.114c8e05@archlinux>
 <20200809074335.23734-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809074335.23734-1-ceggers@arri.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

> The driver for the as73211 light sensor provides the following not yet
> documented sysfs entries:
> - in_intensity_(x|y|z)_raw
> - in_intensity_(x|y|z)_scale
> - in_intensity_sampling_frequency(_available)
> - in_intensity_hardwaregain(_available)

Should that be hardware_gain ?
							Pavel



-- 
