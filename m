Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5EC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB07218AC
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549100808;
	bh=PYRgHpsCb5hzCRmD3+NM5EWmSP6cSExZRKoBKlQTmM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jDyxc9ywEBoxm6ZJjIqV3E/A9+805GAksLV1eHYiD5y/+T3iZYPE10UuGUtvOm2eG
	 Qqqq2WnPuQZXRkZoHgrjWPe4Ve4rral6jD61d/QXvv6csPhEbtf7E37g2xSelKOVpF
	 NQIYzUFlxlmRxQz79CdHvKBNA6VGv/3vdee4pRPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBBJqr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfBBJqr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Feb 2019 04:46:47 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01375218A6;
        Sat,  2 Feb 2019 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549100806;
        bh=PYRgHpsCb5hzCRmD3+NM5EWmSP6cSExZRKoBKlQTmM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDXcbeXQoa2J67i9eFN5cFrDfg92376rQmbeYvUe4Q73wVxtTITKrrulXHt8jDUXe
         JLO35JXmGN8zgOvDn7yMVN/0aSXvVv14tVzoidEzAZtP3bBEyymUKGYBJxQxuiWz0L
         JcuJonPFwjblx4eZgKyuGEI/e3QLkK8yt/luVG84=
Date:   Sat, 2 Feb 2019 09:46:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio:bmi160: add drdy interrupt support
Message-ID: <20190202094641.6dad8095@archlinux>
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jan 2019 12:39:05 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> This patch series adds drdy interrupt support to the BMI160 IMU. It also updates
> the relevant DT bindings and does a little bit of related cleanup.
> 
> v2:
> - Drop "BOTH" interrupt setting.
> - Change to "if (ret)" instead of "if (ret < 0)".
> - Stylistic changes suggested by Jonathan Cameron.
> - Fix bogus return check after iio_trigger_get.
> 
> v3:
> - More cleanup changes.
> - Directly get INT1/INT2 by name instead of using I2C/SPI IRQs. Move this code
>   to the probe function.
> - Fix EDGE/LEVEL #define naming. The code was correct but the names were wrong.
> 
> Martin Kelly (6):
>   iio:bmi160: add SPDX identifiers
>   iio:bmi160: add drdy interrupt support
>   dt-bindings: fix incorrect bmi160 IRQ note
>   dt-bindings: document open-drain property
>   iio:bmi160: use iio_pollfunc_store_time
>   iio:bmi160: use if (ret) instead of if (ret < 0)
> 
>  .../devicetree/bindings/iio/imu/bmi160.txt         |   6 +-
>  drivers/iio/imu/bmi160/bmi160.h                    |  11 +
>  drivers/iio/imu/bmi160/bmi160_core.c               | 317 +++++++++++++++++++--
>  drivers/iio/imu/bmi160/bmi160_i2c.c                |   5 +-
>  drivers/iio/imu/bmi160/bmi160_spi.c                |   4 +-
>  5 files changed, 304 insertions(+), 39 deletions(-)
Other than addressing Rob's comments I think this is looking good.
Will take one last look at v4 of course!

Thanks,

Jonathan

> 
> --
> 2.11.0
> 

