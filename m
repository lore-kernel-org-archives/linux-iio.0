Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FAC282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 20:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AC321872
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548534005;
	bh=7FUQ1Au7QuFBhseLYU3HVQuZ1znBzQH3+LK3d9CIXpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=b4OMdet/7GSUbbf22SS6jMfPDh/zyktFWsIQSClxMCkVmbI9R+TqLcuPuUZSy4h1f
	 wcsp5J1O5erDtiecttMBqNNz/ponKZ6PUUAsg2HLurXxqQHec6mZu4VFQ38rRYMeF7
	 QLW1sQojXa8U6Q5xE2p1fXVCTe0bNYbtgxlA8/5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfAZUUF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfAZUUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Jan 2019 15:20:05 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C08120C01;
        Sat, 26 Jan 2019 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548534004;
        bh=7FUQ1Au7QuFBhseLYU3HVQuZ1znBzQH3+LK3d9CIXpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gNOul6GA9Gtu7ZyFysREx1ARpoANlJ4smmyEBpc8Zp82HwlLY7rpzmklsr7sGlCSu
         UOaCKWW7WTfhOb20EWxxHv2uVlEHJ0EvJuVgs1US0xpkQR3oyygs3juKNz0HrBK407
         8Ul449vdx0+WnKDSkeWCA1pxTyBxFuhxxQMJKjGc=
Date:   Sat, 26 Jan 2019 20:19:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: document open-drain property
Message-ID: <20190126201958.0448e660@archlinux>
In-Reply-To: <20190122020431.5338-4-martin@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
        <20190122020431.5338-4-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Jan 2019 18:04:29 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> We have added an optional boolean property for configuring a BMI160
> interrupt pin as open-drain, as opposed to the default push-pull, so
> document this.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> index 1aec19997fb5..7eb4b6016404 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - interrupts : interrupt mapping for IRQ
>   - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
>     input, set to "INT2" if INT2 pin should be used instead
> +- bmi160,open-drain : set if the specified interrupt pin should be configured as
> +  open drain. If not set, defaults to push-pull.
I missed this before, but normally we prefix with a manufacturer rather than
a particular part number.  Maybe that changed when I wasn't looking though!

Anyhow, these DT binding changes all need devicetree maintainer reviews as they
aren't totally trivial.

Thanks,

Jonathan

>  
>  Examples:
>  

