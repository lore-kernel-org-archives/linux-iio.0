Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56036C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19189218FE
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552757254;
	bh=1Px2nC6ZdMaAK6iZAOyh9Z5Ld1nmjA9tp8I9gtomFQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0G0d9uzBroyF3bGOPPYSByoTe8iwMdGrSaFhUyRrPDOhSodFTG4/6wIHrRyFSIrI/
	 AiEnisMH8+0g4ei4xpqB5hqT5zzciVRKCJto/AdJhgVpJvIqW4CgjQuuLxE/rxNzek
	 RDSTEhS0wBuhRti32xgj7b2RePyC6FFxBRFJX910=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCPR1d (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfCPR1d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 13:27:33 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A61A218FC;
        Sat, 16 Mar 2019 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552757253;
        bh=1Px2nC6ZdMaAK6iZAOyh9Z5Ld1nmjA9tp8I9gtomFQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NB1BX6R38LRvYBVW7ioaC+dhslNhE6VqN5aPz8AjuSADGEY3WWdsE7V+W21fXyVOO
         QgX4oOIN70EsKaRL88uEKty2IKgrj0MpPuBUhTglrQBZifNV2BQZllVqbcpqHBuGXC
         NCSg5I6uLlKteCtSf3kYjCOVydQHAeqW3WbsofdQ=
Date:   Sat, 16 Mar 2019 17:27:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
Message-ID: <20190316172727.1bd525e3@archlinux>
In-Reply-To: <20190315095231.17001-5-gregory.clement@bootlin.com>
References: <20190315095231.17001-1-gregory.clement@bootlin.com>
        <20190315095231.17001-5-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 10:52:31 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> As most of the other ADC the lpc32xx one use a vref-supply property:
> document it.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Applied.

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

