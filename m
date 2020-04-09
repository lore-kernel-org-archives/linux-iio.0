Return-Path: <SRS0=RyTo=5Z=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E00BC2BA2B
	for <linux-iio@archiver.kernel.org>; Thu,  9 Apr 2020 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1868820678
	for <linux-iio@archiver.kernel.org>; Thu,  9 Apr 2020 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586449714;
	bh=SgwGKFbSHVDA8eQcCi+mtqVv/w0Ga4e+4iWfTlHywos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VaUrwbmiKpvIPs1RVZYIN4Q6kGqxapzukQG+0gbF7k0S1l4zOgQ+X3QwpuiLfP7hr
	 GXLFKFONmpGZzmXPj177HkEE1U+7i2Hfb8kMCxio3q966rZKBREmCAP8dePojTO6XH
	 BKurF6SZ5tAYtlNG6dBenYHDtldETmvDIW2aw9+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDIQ2d (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:28:33 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45766 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgDIQ2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 12:28:33 -0400
Received: by mail-il1-f196.google.com with SMTP id x16so212336ilp.12;
        Thu, 09 Apr 2020 09:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ee4vTSSGbLNR1xppvF9XOE8HHJL/QWxXyf8eSU/DfT0=;
        b=Lq27RI4zTajWVs9JfNBS6YITs88LytljXdMnp7THGLr1Fc2BP7sA2bD8M2WqmQEaUx
         O6Dq7bgQgJLrsrJTnynkuwpuSWfNjEAF/F7UUNptY2fp/00VOL99hb1WM1ozYFdjI2Br
         jA2AXufJHqTNFG57H4780ytrYXeYxhHS0kQHQ0euBl3gW3UmNxq/mfmB4FYNtApuYJuf
         rqi83wEUaBJ4E+iY7QfJu3rB1QdqF4I3Kwt09ZXBpX1zyMZ/kg3XO5z+7wX85P3142Xs
         Ngf/Klr8IXqObBDyQVe00De0QsbQCv2rXIegfJ8eG3b+Qt8cC9xI4F+vZc3TLzCz7+/+
         +eRg==
X-Gm-Message-State: AGi0Pubtt7LvKnExK9RgraEf6GIFSmM77H7irN/dnEJWj1+mKxp9LhR4
        xZ7q2vbVMGj27sHMszlHMg==
X-Google-Smtp-Source: APiQypKesjzxfkk+tDmiFPnOJARU55BVhWEWcrbHntl8lZTHHZgQJC4yEhCdTOY3U0KbnLhL02ZFTQ==
X-Received: by 2002:a92:d349:: with SMTP id a9mr590811ilh.10.1586449710960;
        Thu, 09 Apr 2020 09:28:30 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c16sm3129352ils.37.2020.04.09.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:28:30 -0700 (PDT)
Received: (nullmailer pid 26503 invoked by uid 1000);
        Thu, 09 Apr 2020 16:28:29 -0000
Date:   Thu, 9 Apr 2020 10:28:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, alexandru.tachici@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: dac: ad5770r: Fix the file path
Message-ID: <20200409162829.GA26256@bogus>
References: <20200327131825.23650-1-festevam@gmail.com>
 <20200327131825.23650-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327131825.23650-3-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 10:18:25 -0300, Fabio Estevam wrote:
> The following warning is seen with 'make dt_binding_check':
> 
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml: $id: relative path/filename doesn't match actual path or filename
> 
> Fix it by removing the "bindings" directory from the file path.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
