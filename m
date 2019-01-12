Return-Path: <SRS0=wu9M=PU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3887C43387
	for <linux-iio@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16820870
	for <linux-iio@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547317724;
	bh=bAFjfZIOogonwcErRtkSmCGZZ5Prb+b6MQCBJZosHZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tGEvCRtQ5c8eYywacrlYQR7/aUond07j0oek+QN3tYC364nUTA3q0n2y4cf9fZIta
	 HMmoie5rt2SFy9floLW8pKGowibysclCplORIXOk3jYRSgbTZCy0aYhsIS4IiWIP1J
	 QAfFv0fUr8CKeLcwh/Y2h/zm6CNqw6hFAQ63fYvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfALS2o (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfALS2n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Jan 2019 13:28:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CCE2084C;
        Sat, 12 Jan 2019 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547317722;
        bh=bAFjfZIOogonwcErRtkSmCGZZ5Prb+b6MQCBJZosHZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s7n2PRLPWjW4duZ804SBRv663LIWR2D0426PEd538LvzvAuvTo3L7bsvd9gWWMmYr
         x+OUnFjjNOHtq/iCyNE789GacgXrIi+wbN/ashk/FQ8xHrQ4/VrjRkbuiKpCC/uQCv
         7hOIY6cOOSWEX8wzIkJc0jyz2Uz9wF9JJJIcDESo=
Date:   Sat, 12 Jan 2019 18:28:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
Message-ID: <20190112182837.4cc42743@archlinux>
In-Reply-To: <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
        <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jan 2019 15:53:59 -0500
Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:

> BME680 is a pressure/temperature/humidity/voc sensor.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>

Hmm. We could add the VDD and VDIO regulators perhaps.
Driver assumes they are on currently but we'll get a board where control
is needed sooner or later.  I'm not that fussed about this though.

Jonathan

> ---
>  .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> new file mode 100644
> index 000000000000..885a1b918340
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> @@ -0,0 +1,11 @@
> +Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
> +
> +Required properties:
> +- compatible: must be "bosch,bme680"
> +
> +Example:
> +
> +bme680@77 {
> +          compatible = "bosch,bme680";
> +          reg = <0x77>;
> +};

