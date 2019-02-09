Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED1C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC12192C
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549732156;
	bh=hh9kUpTU/t+T3LtaJNOcpFiksItwOq8rvl1bQx4tdr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FYQBf1v/86sX2S5AjSdMK9KB3BKbk9bX4wX8dOvuMz1RtXaidpCuDPbMvReXc/14U
	 9dHOXEgtOQ+bnsr6GaqJ7owG7Y7ymoqAIuMkXrDklE5P2ufqBSYiYe6+vRbYceKZf6
	 idPNM1VPpyD48/WJgnWjVFGJmnfesE+Jj1Rsp0N0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfBIRJQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfBIRJQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 12:09:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6902192D;
        Sat,  9 Feb 2019 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549732155;
        bh=hh9kUpTU/t+T3LtaJNOcpFiksItwOq8rvl1bQx4tdr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aJkleny/3xUqmV69ThEf88pEUZCKHsr8IOCiag9vsrnbTgK9desSe3m1urZ9j6JHq
         88T9ppO6vjXusmdBL8eTtpu8ZT+AJE7DqruL9u/mpBcE053cDIXED0OKBuHM36msBm
         QIekjxi4SibXZEJ6xpVAIt+LO6DvLCTibzDKUJ80=
Date:   Sat, 9 Feb 2019 17:09:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
Message-ID: <20190209170909.6f947a69@archlinux>
In-Reply-To: <20190208160944.13281-3-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
        <20190208160944.13281-3-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Feb 2019 17:09:41 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> As most of the other ADC the lpc32xx one use a vref-supply property:
> document it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Hmm. This is indeed an oddity as you document. Normally we would
insist on it, but we can't because of legacy and as it is actually
queries, we can't even use the fact a stub regulator will be provided
to get around it.

I'll have some comments on the patch implementing it anyway, but
good to let this sit for a while given it's slightly unusual nature.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> index b3629d3a9adf..3a1bc669bd51 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> @@ -6,6 +6,10 @@ Required properties:
>    region.
>  - interrupts: The ADC interrupt
>  
> +Optional:
> + - vref-supply: The regulator supply ADC reference voltage, optional
> +   for legacy reason, but highly encouraging to us in new device tree
> +
>  Example:
>  
>  	adc@40048000 {
> @@ -13,4 +17,5 @@ Example:
>  		reg = <0x40048000 0x1000>;
>  		interrupt-parent = <&mic>;
>  		interrupts = <39 0>;
> +		vref-supply = <&vcc>;
>  	};

