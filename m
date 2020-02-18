Return-Path: <SRS0=ao10=4G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1133C3404B
	for <linux-iio@archiver.kernel.org>; Tue, 18 Feb 2020 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEB924655
	for <linux-iio@archiver.kernel.org>; Tue, 18 Feb 2020 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582059672;
	bh=CrvL6Fu71IIMWSbKPHV6n8JUND8AaU31nyzwsp5iw2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBlN3I+TrfpYudLaLbvE26nnwRA/td8xhXZtYPpDEW2n07N1061VPqssFav4Gh/wa
	 lxPR+GG7s1pHCdG+e5vPpaP/mtHNJ3nfERNN2EhrfkrgNWUNYybij67kkKBBzqhyAY
	 GYRveBOG1Z192diRmH79ruCQc6P7qfrACpan/o1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBRVBM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:01:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40091 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 16:01:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so20953378otr.7;
        Tue, 18 Feb 2020 13:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UOeZaH3v4Y+ZlEV3oAmdS6HQDRLOduqQRyNOB2xC5c=;
        b=Djo1NuFIa5gRukliWiPwdQa0RbGzhnYj50qtbYfpcNq31aOHklL1oHWRgtlHowuY+f
         LnYXV6X9x/UgeM10spKvS94E6WbjSAQOfuuNr6JJNzNHh/dyyTFwJZV8LU+EsZbyWE61
         4Nf2PE5+nEqNLp8Lq2IyKzYpTnJhxlEIUot/nM1Lv7n5lluiNPj589BnXPaspfuci/An
         xjf6+t6VBRGlIbPLusk4PaSaXX+tnCI5aRLpG2rqIfRuxOolTPiW9k3w5+FUlAbtEELM
         C/YFdmVpYKT0QDklUjW6/HBWg3+EWhrOace/DGDUOFylgSdqGkYX/OULmg92YK7KkVfg
         SwJw==
X-Gm-Message-State: APjAAAVRfvTzMWzOljoWb70TiAH6JmS78jAj+HTcyPzBvY+2oVga/k8e
        Gxh+ckyu09pE6b9366mYWA==
X-Google-Smtp-Source: APXvYqySr5SN9c8HUFsUtyV6Yaw0BE8v8KterAwiEnJ6/QG00uH6c9heW/cM3fHdlWSMk9PpCIZ2/g==
X-Received: by 2002:a05:6830:1011:: with SMTP id a17mr16192900otp.45.1582059671162;
        Tue, 18 Feb 2020 13:01:11 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm1740628otx.75.2020.02.18.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:01:10 -0800 (PST)
Received: (nullmailer pid 29034 invoked by uid 1000);
        Tue, 18 Feb 2020 21:01:09 -0000
Date:   Tue, 18 Feb 2020 15:01:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
Message-ID: <20200218210109.GA28353@bogus>
References: <20200211191201.1049902-1-david@ixit.cz>
 <20200211191201.1049902-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211191201.1049902-2-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:55 +0100, David Heidelberg wrote:
> This commit add dt-bindings support to al3320a driver and vendor-prefix
> dynaimage.
> Partly based on unmerged commit:
> "iio: Add Dyna-Image AP3223 ambient light and proximity driver"
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v5
>  - drop requirement on interrups and vdd-supply
>  - s/al3320a@1c/light-sensor@1c/
>  - dual license also under BSD
> 
>  .../bindings/iio/light/al3320a.yaml           | 43 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
