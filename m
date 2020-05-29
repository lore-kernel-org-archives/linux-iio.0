Return-Path: <SRS0=6BNV=7L=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDFC433DF
	for <linux-iio@archiver.kernel.org>; Fri, 29 May 2020 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42F420814
	for <linux-iio@archiver.kernel.org>; Fri, 29 May 2020 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590772118;
	bh=0+5Z5Fq1nyJGEpQbNCrpKFiotn+/7z1jFC8FwekB55o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=itQkpZ4rpmrxyNCPWBzhrRHOITv5qbrd934uDjR6DSVG/lfXVFVX+yS2SrHetPKHQ
	 no7+XH+TbAv3wORniCs56Zr8+YAE4hUlOCiYlj6rKs4aK9/a+tMs2tv3E20fpljBWB
	 BEZD59UdR1wcRCb6/thRWfV0rnrOhtj8vdl4qByM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE2RIi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 29 May 2020 13:08:38 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40294 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2RIh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 13:08:37 -0400
Received: by mail-il1-f193.google.com with SMTP id t8so2680563ilm.7;
        Fri, 29 May 2020 10:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D95feVP8fNINTONsHNy6XAbLPbENXR1ygY9pNbTIOsQ=;
        b=dHFhaiXfvZyEiLr/JxtZIcruQW18ck+uwV5mIiMsew+6TfopHvbag0LVeroqwWNpRE
         FrF672GFgL1U1c+5k/ivGM8Qe31IE6droqxaHQ5Yma5vQFzME4omNfcnXk66OeXHzKgi
         eaB7xHjW2LMVy6EMJ+U2Ur88mcWD31cCBUaAs2EPZrcTwmGn75RK/cPhEjIb8nrQBPf5
         z2W6ToLnhunU0T4DyeychKqyvyzOil0FKD/QtTdxddKvrPAKXGhBjqscoXf/7Jm+LoDp
         DM9/0QVF6F+CX3xxjO7dTpkWJGFhSp9yk9BSLBRWycNdn1b/fJSF45z4jQ9oU56aG0xb
         Wc5g==
X-Gm-Message-State: AOAM532YDvwVnQNli4bpCxV4Cxmx2LB3rHye3t/1BBwzKD1pGaEY/Q//
        o8zJKVbegm+K9yqzYUOY0tfQfBQ=
X-Google-Smtp-Source: ABdhPJxwuJH7rNRjhUyQbx2kWRh/qnBNf8caLMRmTscH8RZ4TPVTctW/gbqusaImUmICQSFBdKylNQ==
X-Received: by 2002:a05:6e02:dd3:: with SMTP id l19mr7635449ilj.154.1590772116748;
        Fri, 29 May 2020 10:08:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i78sm5188003ile.87.2020.05.29.10.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:08:35 -0700 (PDT)
Received: (nullmailer pid 2578616 invoked by uid 1000);
        Fri, 29 May 2020 17:08:34 -0000
Date:   Fri, 29 May 2020 11:08:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        daniel.baluta@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: iio: imu: bmi160: convert format to
 yaml, add maintainer
Message-ID: <20200529170834.GA2578530@bogus>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
 <20200525164615.14962-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525164615.14962-2-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 18:46:00 +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
>  .../bindings/iio/imu/bosch,bmi160.yaml        | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
