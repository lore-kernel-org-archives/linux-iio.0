Return-Path: <SRS0=5nFi=5L=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B632DC43331
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C85D20714
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585248983;
	bh=hdJPv9xhaBKDZLXddal+yjQOkmE6xXXuourHmFStd1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BMQAMFKrR4lS/unna5pEHfSPWvsPWpTcQcKJ3RE8rJy55/9zgm11cNMRi4gJdcY0t
	 stAY53u3ogGcNI62Lq+RTBTCxnDKf0SlmpjfVH/prjCeHisB3YcPhFngYj5jXEiFzr
	 tMqlHBXa3nSQfKE11/zffUxdjSfIMzvD03zyLvpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZS4T (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:56:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35373 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZS4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 14:56:19 -0400
Received: by mail-io1-f67.google.com with SMTP id o3so1651645ioh.2;
        Thu, 26 Mar 2020 11:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsRID+4ywURyAyuA/w9/hHAuGfXNLPrY2kgVLRJSNDI=;
        b=Q48UCJ+Esz+1rMNm5O0Zwpj93vORqxoZPpeadZE7QRtuYplxB+FDTkLUHm5UWQnqNm
         z3ZF8GfkFYAaemulzwigMLuTiH96SrPvaLh+gn5tmnIcvNWeS+XUPqI7Ysbw1fgiFQe2
         K3dpdACCI8Mff9cSzQ75DOqzcXUKEn2xDk7pY3E8DYNWQgTxwN+YIQIzOyjsi+lrEub1
         svkBTc2kTIMeGNBApLYCNiexhhcvhNJzOmXGTW++opS1ruX4tDc4AOSoadv2IJztakwu
         Kal7g45cI1J8A64o6WP/NdmSOvQEVNY91znvviQxiYnfBunx5C6V23Pc0eZHQoRlj8RH
         k/tQ==
X-Gm-Message-State: ANhLgQ28pA7CgrRYtHHA6+ewDV+NxOJuDMyK2VXE6Nq1gubrOT1zMGC2
        yCLLciHhs2kpX2cHGlcYYRM+qM8=
X-Google-Smtp-Source: ADFU+vtRPv4apIZSrqWZwLmrtHPu5H5hRNKX2YALCXj/uOlsIjEEAlNmaZzmEb4PLudSoqRBOKy4rw==
X-Received: by 2002:a5e:d919:: with SMTP id n25mr9062347iop.205.1585248978329;
        Thu, 26 Mar 2020 11:56:18 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y6sm1064630ilc.41.2020.03.26.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 11:56:17 -0700 (PDT)
Received: (nullmailer pid 3638 invoked by uid 1000);
        Thu, 26 Mar 2020 18:56:16 -0000
Date:   Thu, 26 Mar 2020 12:56:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        Laszlo.Nagy@analog.com, Andrei.Grozav@analog.com,
        Michael.Hennerich@analog.com, Istvan.Csomortani@analog.com,
        Adrian.Costina@analog.com, Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Message-ID: <20200326185616.GA2673@bogus>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
 <20200324134636.64643-9-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324134636.64643-9-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 15:46:36 +0200, Alexandru Ardelean wrote:
> This change adds the binding doc for the AD9467 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
