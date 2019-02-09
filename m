Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A686C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3185F21919
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549725650;
	bh=mUfP5oh/o24VwZipoI1l75thMJ6c1iE5nqPRpXA5z9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jQJ4hd0GxEPVpGvnTzxhxdSfv//dYQwSylZW9gTTINm/OY61qvye7rqeYN/0IXB9M
	 S/pmqgwdKgLx3IMFtuxkFzyOFhcOwWQvT1USwEVabTXUxWT3fRDBtaRFHCetn3V39I
	 MmSt6BY5rR2XAMlFCS9BOhJPeEDVA6kaoPm/BtGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBIPUt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBIPUt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 10:20:49 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882C7218D2;
        Sat,  9 Feb 2019 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549725648;
        bh=mUfP5oh/o24VwZipoI1l75thMJ6c1iE5nqPRpXA5z9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mLv+GUMFdQGkPbVea+hHFKgQ0CqXPXa+ZQgif1hdztcxNv2OGRIaA5EYlbAoOk7gX
         JzktElnr5Asu7z1auHVI+unowUip/8nhtfczWibLrsK7+VQZFnKajhOmx3UzmCzlYK
         Kl2yoNU4WSwdhqRFTNzP0a2dD0iqTlLxNf66IuNg=
Date:   Sat, 9 Feb 2019 15:20:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: document open-drain property
Message-ID: <20190209152043.4075d4ad@archlinux>
In-Reply-To: <20190202215601.20275-5-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
        <20190202215601.20275-5-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Feb 2019 13:55:59 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> We have added an optional boolean property for configuring a BMI160
> interrupt pin as open-drain, as opposed to the default push-pull, so
> document this.
> 
Applied with the addition of bmi160 in the patch title so people know
'which' binding is having this documented.

Thanks,

Jonathan
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> index 1aec19997fb5..900c169de00f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - interrupts : interrupt mapping for IRQ
>   - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
>     input, set to "INT2" if INT2 pin should be used instead
> + - drive-open-drain : set if the specified interrupt pin should be configured as
> +   open drain. If not set, defaults to push-pull.
>  
>  Examples:
>  

