Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11806C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D005921907
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552756625;
	bh=smam8LcaKFTpmB2kV++xPykZGbIT+xjXrqgYB8gZyMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sPwYVROjuSWyCn3a/FxrN1dfNdhORQdHX0xooe10xXUHCFI08BSPzHDYAn9/NETbi
	 1HG3xxSbOM1z4LKwo/NhhIV+PwMEG4fEbpv3YMRbwU6So1nEGsHUv5WvLC57gyIO2s
	 aNgrJwNcr7nRg59GjB5X95sgjMnP+YJhq2C3fhb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCPRRF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCPRRF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 13:17:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF28921904;
        Sat, 16 Mar 2019 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552756624;
        bh=smam8LcaKFTpmB2kV++xPykZGbIT+xjXrqgYB8gZyMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EwOlCy5g9D+UEH9OG1ar8p2T1kYzkJC+XPCMHaBMrxW4+VPOu+zC7RV9atljRNtz+
         o8ZYwbMTzJN1XXgFcRWAWQu5wV3bLJSrdx/F7joTbrjujIpJo4O9+6XZJ8OF40q+uu
         yFeqahtfL/Wp9NjAxepOKwGIGppPh0z6KGkmjrp8=
Date:   Sat, 16 Mar 2019 17:16:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Adding scale support to the lpc32xx ADC driver
Message-ID: <20190316171658.327ab411@archlinux>
In-Reply-To: <20190315095231.17001-1-gregory.clement@bootlin.com>
References: <20190315095231.17001-1-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 10:52:27 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello,
> 
> This is the second version of a series adding the support of the scale
> feature to the lpc32xx ADC driver. In order to use it we need to have
> the voltage reference as a device tree property, however in order to
> be backward compatible, this property is optional and do not prevent
> to use the driver if missing.
> 
> I updated the binding documentation accordingly.
> 
> Gregory
> 
> Changelog:
> v1 -> v2:
> 
>  - "dt-bindings: iio: adc: move lpc32xx-adc out of staging" and
>    "iio:adc:lpc32xx use SPDX-License-Identifier" has been merged
> 
>  - split "iio:adc:lpc32xx use SPDX-License-Identifier" in 2 patches
>    one foe sorting and the second one for removal
Hohum. I'm reviewing cover letters now. Must have too much time on 
my hands ;)

This is talking about the wrong patch.

> 
>  - add reviewed-by from Rob Herring on the binding documentation patch
> 
>  - add default in the switch/case in lpc32xx_read_raw()
> 
>  - no more use scan_type.realbits and directly put the value in the
>    IIO_CHAN_INFO_SCALE case
> 
>  - keep the const for the struct iio_chan_spec and declare 2 of them.
> 
>  - remove the unrelated and bad whitespace change.
> 
> Gregory CLEMENT (4):
>   iio: adc: lpc32xx: Sort headers
>   iio: adc: lpc32xx: Cleanup headers
>   iio: adc: lpc32xx: Add scale feature
>   dt-bindings: iio: adc: lpc32xx-adc: Document vref-supply
> 
>  .../bindings/iio/adc/lpc32xx-adc.txt          |  5 ++
>  drivers/iio/adc/lpc32xx_adc.c                 | 59 +++++++++++++------
>  2 files changed, 47 insertions(+), 17 deletions(-)
> 

