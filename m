Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D1C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0CF21903
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548524086;
	bh=IVYJ51YLUTNvPXXWNnJJ/vzlOn8ROHenq5hF93KSB8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PGlKeAnDPd+Y5yJTq9yiAlJL10yYTaThjxXglOwcBBqU4Iop7BgEb6SQB8vuWex5R
	 bymo0X/DFl4M4+/DeMnrpL6YduD/W2+6LsspWgA6YL7dKnEjqwCwDG8COdzYWaZ+ex
	 08LWUidbTUbeyaGqzPkGghCy2hgdSlLFDKa7z2WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfAZRep (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfAZRep (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Jan 2019 12:34:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D664218A2;
        Sat, 26 Jan 2019 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548524084;
        bh=IVYJ51YLUTNvPXXWNnJJ/vzlOn8ROHenq5hF93KSB8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g7Kukl7P+k7XVJ8gC6KDrFtK5uqqhQ/gbcMrsFvy2bN2K7e8YwQQYFi/rZpAMrpcK
         twNkiFCcI/Ghd7rRsxj8GkvJdcffZC1oE+Nxx6mAREyt1sPx9fmGFRs97mp2rsa4/4
         2bKwaC4s65/oecq8QNrvByuQJbBHQA+bNw0cCCUw=
Date:   Sat, 26 Jan 2019 17:34:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH] dt-bindings: iio: pressure: add LPS22HH bindings
Message-ID: <20190126173438.5433d03f@archlinux>
In-Reply-To: <75c2b56fcacf732d87cdfc11f947a1a275b95c6b.1547930719.git.lorenzo.bianconi@redhat.com>
References: <cover.1547930719.git.lorenzo.bianconi@redhat.com>
        <75c2b56fcacf732d87cdfc11f947a1a275b95c6b.1547930719.git.lorenzo.bianconi@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 19 Jan 2019 21:47:53 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Fix following checkpatch warnings:
> WARNING: DT compatible string "st,lps22hh" appears un-documented -- check ./Documentation/devicetree/bindings/
> 		.compatible = "st,lps22hh",
> 
> WARNING: DT compatible string "st,lps22hh" appears un-documented -- check ./Documentation/devicetree/bindings/
> 		.compatible = "st,lps22hh",
> 
> Fixes: e5aab7b0d88d ("iio:st_pressure:initial lps22hh sensor support")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index ddcb95509599..52ee4baec6f0 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -77,3 +77,4 @@ Pressure sensors:
>  - st,lps22hb-press
>  - st,lps33hw
>  - st,lps35hw
> +- st,lps22hh

