Return-Path: <SRS0=19IN=WV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4CDC3A5A1
	for <linux-iio@archiver.kernel.org>; Sun, 25 Aug 2019 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9272173E
	for <linux-iio@archiver.kernel.org>; Sun, 25 Aug 2019 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566746146;
	bh=tRpJQfihq8gr/PN//GQjyQ84R73rV9qUx8tON+YhPzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VAWTxchRqw9lFT9tcwMHXMNuI7q+MnGJiGHj19TIxJ17y2f8IXR9Vip7+utfrFdU6
	 HESbZ3lNN+xaKSIZNCYANQxaNW2JY3+yHUQx0YJl7T8ZlEa/FDVPancRnsII0ngWS3
	 cagW9nPN6/CfsBPmAy6ts7eQUyPtqk7YVe+7octw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfHYPPq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 25 Aug 2019 11:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfHYPPq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 11:15:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC358206B7;
        Sun, 25 Aug 2019 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566746145;
        bh=tRpJQfihq8gr/PN//GQjyQ84R73rV9qUx8tON+YhPzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmZfQueqN9y9cu0ZEMNg4/KR+ElJhPWUhO/0n8g2op+J16vz01uxcwUISFLssOGSU
         yKQ3YZobntPvs2zOn8tRkVHo0ORTpo+fOCHGyQF9tp3aH8Szo9G7n5DNSwv/2CfHsN
         qCd3mjYAGTy6dgTW5L+J6aIAZo0c4bmDfMsmlTl4=
Date:   Sun, 25 Aug 2019 16:15:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v3 2/4] MAINTAINERS: Add Beniamin Bia for AD7606 driver
Message-ID: <20190825161538.58420cf6@archlinux>
In-Reply-To: <20190821141656.4815-2-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
        <20190821141656.4815-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 17:16:54 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Add Beniamin Bia as maintainer for AD7606 driver.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to probably ignore it.

Thanks,

Jonathan

> ---
> Changes in v3:
> -nothing changed
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad498428b38c..052d7a8591fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -895,6 +895,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
>  
>  ANALOG DEVICES INC AD7606 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Beniamin Bia <beniamin.bia@analog.com>
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported

