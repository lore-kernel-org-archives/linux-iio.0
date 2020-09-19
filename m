Return-Path: <SRS0=/qDq=C4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73AC43463
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0557921741
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600523845;
	bh=R1FEqwRjQOSYw1ZtN6G5hz/aj3I8ZJQDU+FS6xPminQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=to+V5YbsSfyicDyVj/VNBjrz+jwatRUYzd9oMapAsokjT1DfUs5maWvfdio/cQ0uD
	 5JfHXRPi4x9yq7eAEvLcXokfWrcqoszdzgS1R74KALKNtWTFiLZw98lskBWl1VNjSt
	 NOgPSHUNFtYJDCR8uX8luUSUpbYFJEzGd2Kkckgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgISN5Y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Sep 2020 09:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISN5Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:57:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CAE02100A;
        Sat, 19 Sep 2020 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600523843;
        bh=R1FEqwRjQOSYw1ZtN6G5hz/aj3I8ZJQDU+FS6xPminQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsJyHZIozuzFvrBdwUefEAAfaWTEuRfN1pmWqkHWWbZlIwDHneAiOUDQcH+QjrdLD
         0U/jgrXB0px1lubQ0rK+bWXmcu5XVjHhwYyMiA75Gq94Uh39Ri4mcn66fYx/8EgLwU
         VPcVQ8Kg5Y22vfQpL/8Lj/MPiUHrfbauu8PKib7c=
Date:   Sat, 19 Sep 2020 14:57:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml
 conversion.
Message-ID: <20200919145719.2ce9d1d0@archlinux>
In-Reply-To: <20200915190522.GA2320364@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-7-jic23@kernel.org>
        <20200915190522.GA2320364@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:05:22 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:32 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > I changed the name to reflect a specific part in line with normal
> > naming conventions. If there is a particularly strong reason to
> > keep the wild cards let me know.
> > 
> > Otherwise this was a fairly simple conversion as part of converting
> > all the IIO bindings to yaml.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
> >  .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
> >  2 files changed, 72 insertions(+), 40 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.  Thanks,

Jonathan


