Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EEC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 19:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C88D2177E
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550518752;
	bh=f2rWkJR+eJzuGqJqv1Up4F5qctNljHuU5YaRTwS1naQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jO36wV1g06PbHb3E/5DOvGjsPVk5gG8KnEMw7DPqYZxmW5OZ1OGmnWb19mEb0bjHy
	 Ara2ZNRmSLoV2od8gMYXy4MQztkFQMDCKo88/MFoMHsLgEOOGoSXBwm/SrDxyYhS+H
	 5QbdVN0Ech+qQ4RdwFPYA2Iwyg/3eNCZ6rAlrZ0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfBRTjL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:39:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37600 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfBRTjL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Feb 2019 14:39:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so30224090otp.4;
        Mon, 18 Feb 2019 11:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9FUx/CZlt0xCIU204slR3UemaF12G534vBVyxna6+jc=;
        b=UEMjx4VLm0DOUke7A1rGp2WBBsYXNkXc5pBfdLEmL/Ozukq5Dh/TkfqSNb5m//5dS/
         Z9ji3nxCwWiR310CuCtDVRoCoGDWX6Cv6e+kMMz/IUvN8sVEtuyZrL73CDZVAj0ML2q2
         y8hVLexp/Wwds9tZdpXzjyUEQ3P+j2KLTh0DUXq89EPV6G87jsVxCVTtEsz1W3JR5AZ/
         4pflpxHkmPxd0XHg1+m8Uxj2ZnQ9dYlCiS+/+qxudotK9p4xhm+UaCpUlZ/Sohkg8fjV
         3RYHu4MA1TOAwTu0h0KPBPyOnlhMj8eFrlFohHlYQU0mKPNFcw3NgWwmpELTj0ga4Pzz
         /k4g==
X-Gm-Message-State: AHQUAuZUk+dTgKTkNzK9SugkXM6RwdA6Pd5Pygg+CagKmKTMyEh6KUS7
        auogg7rE2/6OhCrYiKNW+g==
X-Google-Smtp-Source: AHgI3IZvYTVTmsZRudp5UupScuzFzD1LZyFSN5lnVVUSQpvKkIA0CWp+nf8S77tehTud55oM2UUFLw==
X-Received: by 2002:a9d:1a7:: with SMTP id e36mr14748889ote.270.1550518750744;
        Mon, 18 Feb 2019 11:39:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n187sm2966177oia.34.2019.02.18.11.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:39:09 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:39:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH v2 1/5] iio: gyro: add DT bindings to fxas21002
Message-ID: <20190218193908.GA25214@bogus>
References: <20190205174333.17672-1-rui.silva@linaro.org>
 <20190205174333.17672-2-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205174333.17672-2-rui.silva@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Feb 2019 17:43:29 +0000, Rui Miguel Silva wrote:
> Add device tree bindings for the FXAS21002 gyroscope.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../bindings/iio/gyroscope/fxas2100x.txt       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
