Return-Path: <SRS0=pulz=5C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6229C1975A
	for <linux-iio@archiver.kernel.org>; Tue, 17 Mar 2020 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1520724
	for <linux-iio@archiver.kernel.org>; Tue, 17 Mar 2020 21:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="kJRKu8WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQVYa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:24:30 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:47964 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgCQVYa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 17:24:30 -0400
Date:   Tue, 17 Mar 2020 23:28:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584480268;
        bh=+ZZSo8OcyZ54YeLYuO1ZbYTBVlMNDmX2tlsxo7c5gpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJRKu8WGx3+HBP4XGD+97WrIbBEt+wEtTdOVyhCSzviM2xToZsOTGZDwxRRGcfYF0
         El/MDGY5NG8M+polTKK8loGtJ1llQ0W+fwKhxHtk3jSADAPzm3bEpKDHQbeC2nA8xr
         y2nxBQj0LmNx5z7M2ORg8XtKPoytHQ0/TO+3V5See46QtFxPVxQ2rbaYxnWDi3D+Mb
         E3flW0reluXijWKX+ypEXM2y/TnyFP2KqaSyNRk9V9twzp2uGsV4bwkBehtjYF75BF
         2K2/r7aKmagJQU/+eHVcNpY3zRA/zZ3rgY2MsZqh2jb0MjpYKdW1PZWk4Ue4e1NA96
         L8J3cuUlkiTQw==
From:   Alexandru Lazar <alazar@startmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
Message-ID: <20200317212857.GA28983@leena.republic>
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars,

Thank you very much for your comments! I'll send a version with the
fixes in a day or two (ar as soon as there's no more feedback, anyways)
-- in the meantime I have a question about this one:

> > +	if (!adc->shdn)
> > +		dev_info(&spi->dev, "no shdn pin passed, low-power mode disabled");
> > +	else
> > +		dev_info(&spi->dev, "shdn pin passed, low-power mode enabled");
> 
> I can see how these message above are useful during development, but I'd
> remove them or turn them into dev_dbg() for the "production" version of the
> driver. Imagine every driver printed something like this, there would be a
> lot of spam in the bootlog.

I thought this should go under info, rather than debug, because it's
(possibly) relevant runtime information. It doesn't require any action,
but it's something that a user of this driver may want to be aware
of. The timing (and power consumption, of course) in low-power mode are
different. It's akin to e.g.:

./at91_adc.c:782: dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
./at91_adc.c:842: dev_info(dev, "ADC Touch screen is disabled.\n");
./at91_adc.c:955: dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");

or:

./ti-ads124s08.c:320: dev_info(&spi->dev, "Reset GPIO not defined\n");

which is why I figured I'd do the same in my code (what can I say, I
wear my code monkey badge with pride!).

Needless to say, since you've seen more IIO subsystem drivers than I've
seen, I totally trust your assessment of whether this is debug or info
more than I trust mine. If this was a false positive on your "looks like
a leftover debug message", let me know (and while I'm at it I might make
the message more useful/friendly...). Otherwise it'll get bumped down to
dev_dbg in my next revision.

Thanks,
Alex
