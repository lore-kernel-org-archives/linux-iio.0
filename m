Return-Path: <SRS0=N7E/=YL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD0CA9EA9
	for <linux-iio@archiver.kernel.org>; Fri, 18 Oct 2019 18:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F3821897
	for <linux-iio@archiver.kernel.org>; Fri, 18 Oct 2019 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571424951;
	bh=2833mxmAM8pjahHLXCbOjn02YJ5+sxLz8UHE35rpoaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rTm8oSnF974CO9mRiAe8thIvvE4OYgLuAKcDlSHODurnBVHnYlmHDBqZt1WRfp5mo
	 anMLsJvWjVHJsSOBHxjDG467P9P8FqK4vKDcfDJk603ZaayK8xRf957SHI3wM1KJSK
	 Z3IWeG8lfg7shp1sBx2IflYtI7s5by74b2wXcYZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440003AbfJRSzu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRSzu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:55:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8912A20640;
        Fri, 18 Oct 2019 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571424950;
        bh=2833mxmAM8pjahHLXCbOjn02YJ5+sxLz8UHE35rpoaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEr67jGxcjky3mmw0LVyDyMrpA3U84fv3pix5UTmn4+YCWC7Ydtxo/6DuicRapjIF
         VzPLvItDYXwwFbFYNVmXwb3Yk8mspmm9/JFrmn9kkpg3tNMyvMc+vVZS/cqBJyTjGE
         cwMbYKKgEzPP/0mf7++HJoJ88+ybG8lds0q5moFk=
Date:   Fri, 18 Oct 2019 19:55:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Explicity make a 'poison' value big
 endian
Message-ID: <20191018195546.40035d36@archlinux>
In-Reply-To: <CACRpkdb71HM0QmmQZtb0=KYPNWLtknPq5Z_gsmAb-SdbQzAQ6w@mail.gmail.com>
References: <20191013100255.1445528-1-jic23@kernel.org>
        <CACRpkdb71HM0QmmQZtb0=KYPNWLtknPq5Z_gsmAb-SdbQzAQ6w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Oct 2019 14:19:46 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Oct 13, 2019 at 12:05 PM <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This clearly has no actual affect but it does show sparse and similar
> > static analysers that we are doing this intentionally.
> >
> > CHECK   drivers/iio/gyro/mpu3050-core.c
> > drivers/iio/gyro/mpu3050-core.c:546:48: warning: incorrect type in assignment (different base types)
> > drivers/iio/gyro/mpu3050-core.c:546:48:    expected restricted __be16 <noident>
> > drivers/iio/gyro/mpu3050-core.c:546:48:    got int
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
Applied. Thanks,

Jonathan


