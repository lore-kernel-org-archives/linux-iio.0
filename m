Return-Path: <SRS0=HY5B=OX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5DDC67872
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 01:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA87208E7
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 01:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544751565;
	bh=OY7VzTFnl/o7Zj5mlJ2aBunXOzfDB/fOVSpzIQUoHkY=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=oLY2zlNx4HDNEEFQaaRmWaGGCQwL27OtNrZqihF9OzE9LHgajec0rv9MEX/Rt+tAR
	 F04iS1sLwnXvyiYFqEQSkbUWjQiwEln1Jl3AWkTzaiAkjIvU37QmXqSCvT5aBleY0m
	 03+ui8k6rVTp3HqdxqNU8VybcMstW5pL+wZVkxWk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA87208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLNBjY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbeLNBjY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Dec 2018 20:39:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795A220811;
        Fri, 14 Dec 2018 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544751563;
        bh=OY7VzTFnl/o7Zj5mlJ2aBunXOzfDB/fOVSpzIQUoHkY=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=aCnnKHO8xtTgxe0yGbrerK54ciPcgG4eQUMM6YGQehYjuaNVcBoZV+b97sAl45u1r
         7CRGT/TrvrJfawF5fKmqPXvX0GFwXewDKX8P4NahT5XLrr/hNS1TJlKS8TokblDUM/
         ftoDKtw+5JGCKoK3oAvcIrotAz8VyTNl5Ji3Ip9s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181208152954.596529f8@archlinux>
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external clock reference
To:     Jonathan Cameron <jic23@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
References: <20181206091052.7644-1-mircea.caprioru@analog.com> <20181208152954.596529f8@archlinux>
Message-ID: <154475156267.19322.6284056396098102605@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org
Date:   Thu, 13 Dec 2018 17:39:22 -0800
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2018-12-08 07:29:54)
> On Thu, 6 Dec 2018 11:10:51 +0200
> Mircea Caprioru <mircea.caprioru@analog.com> wrote:
>=20
> > This patch adds a clock to the state structure of ad7192 for getting the
> > external clock frequency. This modifications is in accordance with clock
> > framework dt bindings documentation.
> >=20
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
>=20
> +cc Rob and the clk list for advise on how to do the binding for this one.
>=20
> It is basically 2 pins, you can put a clock in on one of them or connect
> a crystal across them.  The driver has to set a register to say which is
> the case. =20
>=20
> Current proposal is two optional clocks (fall back to internal oscillator)
> but that doesn't seem to be commonly done, so I'm wondering if there
> is a 'standard' way to handle this sort of thing.
>=20

I'm not sure I fully understand, but I think perhaps
assigned-clock-parents would work? Or does that not work because either
way some parent is assigned, either the crystal or the optional clk that
isn't a crystal?

