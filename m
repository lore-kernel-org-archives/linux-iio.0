Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610EEC61CE4
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CF520883
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547918693;
	bh=58TuBYCCxkTt+rzruZ2k6Y52kT73MDHEYoOc/FTPrPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=INSr3d2auy6yAUd7Jc08YLTnXwTJVdl0aisZUJTWgbmgkJlml2Idq+eSG8FhSvCit
	 31dA51W2dYdU0aCSpvFGTW2iWxHI4IPGrSOxUCoFj0raTOoO37DaNA3kKYF//KRWY3
	 qfeyxSxMzsCzBzFTcFzKTFdpgWe5cURwXwcoXywM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfASRYw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfASRYw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Jan 2019 12:24:52 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFAB2084C;
        Sat, 19 Jan 2019 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547918691;
        bh=58TuBYCCxkTt+rzruZ2k6Y52kT73MDHEYoOc/FTPrPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q5xN6npHyNEA+/v7WH5DV7g31I/Hf8oS2wIZlkYVwBw4fYpdFCISoS5rLyOerrMk1
         NYUVvjJArVoMlNANl4WpntxOjEphdQJP1jSRyRRklVr1+n+GBtO855uzzdvbhWF+5H
         JPdN/Wd/ZGDVKVezIjMQ2v4bXDYjkQaMJs59FzSk=
Date:   Sat, 19 Jan 2019 17:24:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings:bmi160: add "BOTH" int pin type
Message-ID: <20190119172447.4536fc00@archlinux>
In-Reply-To: <20190114035621.5252-5-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
        <20190114035621.5252-5-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jan 2019 19:56:20 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> The bindings currently allow for interrupts routing to INT1 or INT2, but
> the hardware allows for routing to both, so add "BOTH" as an int pin entry.
> 

DT binding changes should be sent to the dt list as well as Rob.

> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> index 1aec19997fb5..a56d377dabf3 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -11,7 +11,8 @@ Required properties:
>  Optional properties:
>   - interrupts : interrupt mapping for IRQ
>   - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> -   input, set to "INT2" if INT2 pin should be used instead
> +   input, set to "INT2" if INT2 pin should be used instead, set to "BOTH" if
> +   both should be used.
>  
>  Examples:
>  
> @@ -33,3 +34,13 @@ bmi160@0 {
>  	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>  	interrupt-names = "INT2";
>  };
> +
> +bmi160@0 {
> +	compatible = "bosch,bmi160";
> +	reg = <0>;
> +	spi-max-frequency = <10000000>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "BOTH";

Just have two entries, not BOTH.  Routing both internal interrupts to the
same pin on the host doesn't make any sense, so we should only see both
along with a pair of entries for the interrupts.

Jonathan
> +};

