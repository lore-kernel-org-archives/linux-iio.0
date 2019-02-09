Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45444C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DE2192D
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549731958;
	bh=WNXxYNEpp45e0JzheuLTWXnISOYxdjszVdvBG49Rfk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M+3LSCqduWdC8u1DnXQK8N9fAEBRzgpThPyO7ySQM+AerRZM2/sV+SVEz1Ej4IBtp
	 L3wJ8XHCuJpb3pcmhnwBDA/mzaIytAoYhDU+MlTxXMpIwGgiBM2rtFNfEa4IhVHVaV
	 5iK1xst/kJeU7uFopSaAaWz4sMubn9ULoJxpuDOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBIRF5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIRF5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 12:05:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAF72192C;
        Sat,  9 Feb 2019 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549731956;
        bh=WNXxYNEpp45e0JzheuLTWXnISOYxdjszVdvBG49Rfk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nGO/7dhjdoaTSV4mElFoglDF5tMSfuMtaWi3+J0wJ5I37hAOA6J+/XSmsaPYBeiVp
         GnUOncuAMr7RUh3nRq8n9WeyDhmjUoc+t5qd5pTiwS02/Zfm9soAtVQWD21nhJmWv1
         gcrMZoL26SAzHZesAorNVjeRWITattl1NGqjwRyE=
Date:   Sat, 9 Feb 2019 17:05:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: move lpc32xx-adc out of
 staging
Message-ID: <20190209170551.38a8e3de@archlinux>
In-Reply-To: <20190208160944.13281-2-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
        <20190208160944.13281-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Feb 2019 17:09:40 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> The drivers has been moved out since
> 0097e20e7771 ("staging:iio:adc:lpc32xx Move out of staging.") in v4.10,
> so let's align the binding documentation.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Oops. My fault.

You forgot the iio list on these so +cc

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt     | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt (100%)
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
> rename to Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt

