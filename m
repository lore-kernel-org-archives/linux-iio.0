Return-Path: <SRS0=m5bt=BG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2EC433E3
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jul 2020 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E2F2083B
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jul 2020 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595873725;
	bh=aA66v6dN7zvi7hT8+jDWpepyEwVN5MR32Ef27QQoFW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wbqdzs06hQZl4wOD7jqQp63kJ0FDvwDmXTyKkJjUL/X9uahSE6/5sPMU/skKz18bc
	 H3S/ZvUjjAXFhj/uwkL2a0HDfQR2DSbC4f3eCLksdZvaZJJmz3BflYOgS44tb/xsrh
	 OuloRBVJDPk8YIFhssTNt7IW7nN19ePf5T1lLU9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgG0SPY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:15:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45184 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgG0SPY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 14:15:24 -0400
Received: by mail-io1-f65.google.com with SMTP id e64so17945332iof.12;
        Mon, 27 Jul 2020 11:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPySXAZCXNAPcxTnIrbRyNITLVf9/SCdJpSv4va/tXo=;
        b=QcYkV8bFgXOn/DIaAZH1GM0SlHu9gxHFQ+10LaNwp/etHQxFja0r/zx4UZi4r3HCgC
         a8AYbe9EHn16GQHMfVPwXojxnzy+XwmbUGLPCPCSc4d5ddtj+AF0Axj/Yx4gc9x9I65d
         SrTtf3x7StpAu66jO5rfGZaBfVilPaNh7aX0s5Nphe699dFWfVAfQWHlp/vr80B9jayp
         BA8R5JgYmMcr7sdjEUKzT3BKfCjwdewCeMoxtpPBKYBv4HjZrU8EAsM3+n3qPQmxT0v2
         /im2tJGfcpVX88fmLNNiZLjKJEyZB/uNlXBopHmvxswi6X+0FhstE78pAUe9VJ+4lfv4
         rkUg==
X-Gm-Message-State: AOAM5307R7BEc0HERffMshd3yt1Q/NUBg4Emqm8mSdEXgQWTesFwEDeM
        l0w+BhKCM27zsmawEgaAuLTXKkdRTw==
X-Google-Smtp-Source: ABdhPJwhusEJrY0gD6pxlBikusEFjEJ7+Axs4d+t20HxTMW2fq6sMJs0tIgnLEW2CSDknTVU0cycdA==
X-Received: by 2002:a6b:6211:: with SMTP id f17mr19106841iog.34.1595873722942;
        Mon, 27 Jul 2020 11:15:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c25sm1533544ilf.63.2020.07.27.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:15:22 -0700 (PDT)
Received: (nullmailer pid 640852 invoked by uid 1000);
        Mon, 27 Jul 2020 18:15:21 -0000
Date:   Mon, 27 Jul 2020 12:15:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: add AMS AS73211 support
Message-ID: <20200727181521.GA640662@bogus>
References: <20200727144741.3927-1-ceggers@arri.de>
 <20200727144741.3927-2-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727144741.3927-2-ceggers@arri.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 16:47:40 +0200, Christian Eggers wrote:
> Add DT bindings for AMS AS73211 XYZ True Color Sensor.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  .../bindings/iio/light/ams,as73211.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/light/ams,as73211.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/light/ams,as73211.yaml#


See https://patchwork.ozlabs.org/patch/1337022

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

