Return-Path: <SRS0=jlvN=CY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A7C433E2
	for <linux-iio@archiver.kernel.org>; Tue, 15 Sep 2020 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2D2078E
	for <linux-iio@archiver.kernel.org>; Tue, 15 Sep 2020 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600196779;
	bh=q4g9KOjlO+1WCe4oNnLO0C69sX5+bUVE80UjQv0091Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JiZy8ZU9kA/mlc9m0jI5qlm3qtNvFobNpwgoVFI8jUzZqQCGJiUiXkfi3xMe6zymy
	 j6YKyPa+CoZJNwVC/iuZ7eCT6mgeEQHLu3LCFFmwm/n9OC68p9APTWEy+Vv4T6Hx4f
	 4qDAZ92FzH5wcqHpc37/tkxCRzoRGDLgged7dxWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgIOTGK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:06:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34144 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgIOTE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:04:29 -0400
Received: by mail-io1-f65.google.com with SMTP id m17so5373135ioo.1;
        Tue, 15 Sep 2020 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/uyvM+rNWZRJXZ9fqZJC2yRGVj5yDKdLeFC/xLpeHg=;
        b=dPva973YHdCljfcbfjVxwAx5jle7Mkq9ucXV+JOwhilIY+jEVcaStRGzRHXzEsaZh0
         N55DWd2TcVxcgZWxjD7Ehbp8v4Kd8/Bdz9RXKRsY6T9YJvXYx2UbK4tmeo9sZrt7osWR
         jaiVxp+ueQJMOGiyGbHdCaUjS+C1P8kBwkJYlzSj65qeNrxoG2L72wIt4Fp4UsMo+9q+
         3mNteCc0mFEa9wVTwCCz3aNCP6UBhIrWOv3zyN85LVBcPR8WPpC5Isfcoy1c2kqmsfvG
         aJncwJfF4sVYJNgJBnNSmcLeCOgo3GMyWLvGiXStrAN8yKaey76JbEQ2BY31W2K7AAjx
         pNvg==
X-Gm-Message-State: AOAM531g7AYdnVCSxufJT7yPcEoa98Rlwys6Ep7HW3gVXP4AIHJWAcad
        acqbx0tfBN/SGNUYo1BOsA==
X-Google-Smtp-Source: ABdhPJxUmPqrzYCpTIGB6eM80mA4TC2JhHA+2Cr1Bc1c55ajoS3AggRboE+EtlrOfgd/1tkRKSNuTg==
X-Received: by 2002:a5e:890c:: with SMTP id k12mr16234784ioj.75.1600196668495;
        Tue, 15 Sep 2020 12:04:28 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l2sm9124812ilk.19.2020.09.15.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:04:27 -0700 (PDT)
Received: (nullmailer pid 2318851 invoked by uid 1000);
        Tue, 15 Sep 2020 19:04:27 -0000
Date:   Tue, 15 Sep 2020 13:04:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/20] dt-bindings:iio:adc:marvell,berlin2-adc yaml
 conversion
Message-ID: <20200915190427.GA2318799@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-6-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:31 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Part of a general move of IIO bindings over to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  .../bindings/iio/adc/berlin2_adc.txt          | 19 -------
>  .../bindings/iio/adc/marvell,berlin2-adc.yaml | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
