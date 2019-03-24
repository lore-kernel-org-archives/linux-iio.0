Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C2C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7101A20989
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553448341;
	bh=Pht7by6FxZJE6tlDG1kbUaxEdhH6bun8rbXByI4SOPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bnqp1JqGa9pEQGt3vJp3i5hYOKzUq0VIYV9it1V+2C7EE/96CvSbbgYVkydtjjrld
	 MXGBde2sIfv7uomLPhrPmsJvycqKVnJAhhfGNgWRNDHdyEA2Fz2K18F4fo7pjtUYdp
	 KT/GLFFzRg0Ui07X3rhF/w3tyDXNwFG2BOCAiRxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfCXRZg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfCXRZf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Mar 2019 13:25:35 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B650920870;
        Sun, 24 Mar 2019 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553448335;
        bh=Pht7by6FxZJE6tlDG1kbUaxEdhH6bun8rbXByI4SOPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTZROOZybJZTbZcpgJgdSSgYxHYJ4geeQlaax+5useFFCARA09d1rtSZoJXE6RvtB
         ZCiw9g1b7Afbmi1CTmEA3cEvtMVMJ4WvxnyVCyzuzArx5Eewf5bcQGTikZgKMEoilo
         6gCXZOiroOvrpNpz7GDfqp4m8qw8GdzOqScw6zMQ=
Date:   Sun, 24 Mar 2019 17:25:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: iio: light: add vcnl4040 devicetree
 bindings
Message-ID: <20190324172529.3f84a17c@archlinux>
In-Reply-To: <20190321154047.23236-6-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
        <20190321154047.23236-6-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Mar 2019 08:40:47 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> Document the vishay VCNL4040 devicetree bindings.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Applied.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/light/vcnl4000.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> index 4a9d558a412a..955af4555c90 100644
> --- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> @@ -1,6 +1,6 @@
>  VISHAY VCNL4000 -  Ambient Light and proximity sensor
>  
> -This driver supports the VCNL4000/10/20 and VCNL4200 chips
> +This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
>  
>  Required properties:
>  
> @@ -8,11 +8,13 @@ Required properties:
>          vishay,vcnl4000
>          vishay,vcnl4010
>          vishay,vcnl4020
> +        vishay,vcnl4040
>          vishay,vcnl4200
>  
>  	-reg: I2C address of the sensor, should be one from below based on the model:
>          0x13
>          0x51
> +        0x60
>  
>  Example:
>  

