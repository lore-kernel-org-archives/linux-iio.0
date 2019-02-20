Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BDCC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575BE20880
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550676908;
	bh=+Aoj9Da2eXF3fDgmxkSjt8Q8Xf9yjX4rzfYUxCafbTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nwmISzQYfELXYavke3BgBb5zdXnu8fJm8WQNGkYsK6u18IpyvD3ctE2JAPkoQ91M7
	 +7Y52NqpxK1XjmP8G/BYmRJjnjndVxvgDYT8xZiQfVUqOjNLIgnzVy7JVxLwv87u1E
	 uy1TeMTdgjck9oxsGEIs7ego3JHeIM1iBEmTrEAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBTPfH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTPfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 10:35:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863BB2084F;
        Wed, 20 Feb 2019 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550676907;
        bh=+Aoj9Da2eXF3fDgmxkSjt8Q8Xf9yjX4rzfYUxCafbTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pO+1bructOEz3NmzI9cA4Vc49LqL0tXC8Xt+7IF5Be+1VmPgRuLI8altmELzi/ppX
         iQGl3REOrVq+azCyJSF/X4kBMn5E5NvRhqi/R/mt8Nzgnougib4LsvkjBWnYZ5Z8LZ
         inWWgvSA3Eg3JyUJ1pN+iqkEKd3tZ10awXXbS/uE=
Date:   Wed, 20 Feb 2019 15:35:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad7192: Fix ad7193 channel address
Message-ID: <20190220153501.4fed22c0@archlinux>
In-Reply-To: <20190220110820.25580-1-mircea.caprioru@analog.com>
References: <20190220110820.25580-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Feb 2019 13:08:20 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch fixes the differential channels addresses for the ad7193.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Hi

This is an impressively confusing datasheet, but I agree with the fix.
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


> ---
>  drivers/staging/iio/adc/ad7192.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..2fc8bc22b57b 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -109,10 +109,10 @@
>  #define AD7192_CH_AIN3		BIT(6) /* AIN3 - AINCOM */
>  #define AD7192_CH_AIN4		BIT(7) /* AIN4 - AINCOM */
>  
> -#define AD7193_CH_AIN1P_AIN2M	0x000  /* AIN1(+) - AIN2(-) */
> -#define AD7193_CH_AIN3P_AIN4M	0x001  /* AIN3(+) - AIN4(-) */
> -#define AD7193_CH_AIN5P_AIN6M	0x002  /* AIN5(+) - AIN6(-) */
> -#define AD7193_CH_AIN7P_AIN8M	0x004  /* AIN7(+) - AIN8(-) */
> +#define AD7193_CH_AIN1P_AIN2M	0x001  /* AIN1(+) - AIN2(-) */
> +#define AD7193_CH_AIN3P_AIN4M	0x002  /* AIN3(+) - AIN4(-) */
> +#define AD7193_CH_AIN5P_AIN6M	0x004  /* AIN5(+) - AIN6(-) */
> +#define AD7193_CH_AIN7P_AIN8M	0x008  /* AIN7(+) - AIN8(-) */
>  #define AD7193_CH_TEMP		0x100 /* Temp senseor */
>  #define AD7193_CH_AIN2P_AIN2M	0x200 /* AIN2(+) - AIN2(-) */
>  #define AD7193_CH_AIN1		0x401 /* AIN1 - AINCOM */

