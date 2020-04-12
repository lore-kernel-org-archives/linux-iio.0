Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA5C2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EF820709
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586689517;
	bh=/G9a5N4EsNqKH+T/lms89vJhplOJCs+R8Eje0o+5H/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bjKU/dWuGYvrBs5cpk3VRtEFTp4wplbSUNx/SOcXRbujt8tcmr54si8gpmChuevQd
	 SRRpRhKvTGbtEGh4l5MePKmqoiKjx9r/ZNFzBvgE5DVF3GMt43jj8RpH64Ri+Fnnjk
	 rvQrxPPUOSb+YnP7BOYgDZxE6XaC2atqZs8L9tis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDLLFN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 07:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLLFN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:05:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AD420708;
        Sun, 12 Apr 2020 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586689513;
        bh=/G9a5N4EsNqKH+T/lms89vJhplOJCs+R8Eje0o+5H/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=peW511SVOWZkWEg26/N8B0miVNp8xXwo71gfsyfoLC33ReCMoc+KhXfWizXcHg4wT
         I67gGAQBRYtjgLroZc56GIQInlGm7K3h837F7zY1P124px/vk9LEV1wbrjRyGhAYy4
         zAmbjA0v7maQ5VeeXSlt9V8DkBwtbSlM/7sK0i1k=
Date:   Sun, 12 Apr 2020 12:05:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio/dac: ltc2632.txt
Message-ID: <20200412120431.03631ea8@archlinux>
In-Reply-To: <20200408081029.11167-1-chris.ruehl@gtsys.com.hk>
References: <20200408081029.11167-1-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  8 Apr 2020 16:10:24 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> This patch add support for Analog Devices (Linear Technology)
> LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> Update ltc2632.txt with the expansions for it.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Looks fine.

We need to convert this over to yaml at somepoint.  If you are feeling
particularly generous and want to do it would be much appreciated but
it certainly isn't a requirement just to add IDs :)

thanks,

jonathan

> ---
>  Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> index 338c3220f01a..1ab9570cf219 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> @@ -1,4 +1,4 @@
> -Linear Technology LTC2632/2636 DAC
> +Linear Technology LTC2632/2634/2636 DAC
>  
>  Required properties:
>   - compatible: Has to contain one of the following:
> @@ -8,6 +8,12 @@ Required properties:
>  	lltc,ltc2632-h12
>  	lltc,ltc2632-h10
>  	lltc,ltc2632-h8
> +	lltc,ltc2634-l12
> +	lltc,ltc2634-l10
> +	lltc,ltc2634-l8
> +	lltc,ltc2634-h12
> +	lltc,ltc2634-h10
> +	lltc,ltc2634-h8
>  	lltc,ltc2636-l12
>  	lltc,ltc2636-l10
>  	lltc,ltc2636-l8

