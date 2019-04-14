Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20730C10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3700218FC
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555236289;
	bh=p7H9FRO+72SJifWiGq5/mDDMGKLIGM35cy0nSkQYgh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g+MRSbqPlA7vwHMvCAVhMKw/zYc4jTrHy3KaiiTQFIFCGqMnOn3+B3FlbgptRQGFh
	 /66HtRrzVN+yeH0cEVlWnRkU+mLcQVpjXSAITWSRGotLAR6FZZggB9g/8fBmoggi8G
	 VpV2uMpqAel8Euj4AoEbZv9XTGM1iVjXkMTUQkfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfDNKEs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKEs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 06:04:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C04218D3;
        Sun, 14 Apr 2019 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555236287;
        bh=p7H9FRO+72SJifWiGq5/mDDMGKLIGM35cy0nSkQYgh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a+TeU/ARPN7u4LwoHL26IKQjzV4NQ82lb4Bb38dCqkM5PAbO/P8v2FBoCrWsygZWJ
         CZVS7WnuUJnPHEnLi7esWP1m7CZEk6rNgnqeCbitlVsasDU8V5JmGsGKQyTcZcazYe
         Qs2bhJSMFRffDP9PaiqQORnqcC29Mrbagrp2EgVA=
Date:   Sun, 14 Apr 2019 11:04:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor
 device binding
Message-ID: <20190414110441.1e58f58c@archlinux>
In-Reply-To: <20190411001209.29488-2-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
        <20190411001209.29488-1-rjones@gateworks.com>
        <20190411001209.29488-2-rjones@gateworks.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Apr 2019 17:12:08 -0700
Robert Jones <rjones@gateworks.com> wrote:

> Signed-off-by: Robert Jones <rjones@gateworks.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index 52ee4ba..0ef64a4 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -49,6 +49,7 @@ Accelerometers:
>  - st,lis2dw12
>  - st,lis3dhh
>  - st,lis3de
> +- st,lis2de12
>  
>  Gyroscopes:
>  - st,l3g4200d-gyro

