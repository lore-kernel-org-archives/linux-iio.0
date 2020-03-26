Return-Path: <SRS0=5nFi=5L=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D8AC2D0EC
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFBA2074D
	for <linux-iio@archiver.kernel.org>; Thu, 26 Mar 2020 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585241655;
	bh=2Sg0tSwXVBMFqh06X4jP5osQnnHtEH+Q9guXtHaimsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZqYAtSVV7Q+JqVqAYYJ5FN9oPrbE6aHeZF3vwtZDa7zCdHwHWaPN8h1433uCWQS5
	 hTRJXqGrPXAJdghOuTv9VPULDQvNeBsLzmVOUihWMtVUcq6vHkCv5WA4slpKp6pZSe
	 RQNTCzvaE0Yb0pyvC1Md4kzxo/6IQRWuN/eDXsGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCZQyO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:54:14 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35053 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQyO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 12:54:14 -0400
Received: by mail-il1-f196.google.com with SMTP id 7so6042682ill.2;
        Thu, 26 Mar 2020 09:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZwfR/fBPdMpotJWfH8l3kCi597eNk1DfLb7u1dTx3Wo=;
        b=rmSebLGqA4T0J1zIFyyHLLlSkpdY9FVpDAEYioo0koWdvLpiVeNVZz8zdFapb726n2
         sJQP0eKqOSDPwqsTiiX0Y4Ma+4SPdHdywpVNIaBe5tT7mvX+baiLf9TsMcCCEJXAhqsp
         2nR6GghDaCgXdPwxPumEfVKjl/o3hxa/43nrx4BpO7of85gf9pQhzzAYfNVtvwDVfp2T
         uuMbpA7y8BIicOmZusXY1TSGNozViZuIl2OfQ8dOmMLNx33dEq4hXI2v0HyVEn/T354M
         xUN4Cr3HcomdorqKO7sRywulIT0/9QQsGalvaXoNo8uCQ+2j52YXc7iyxNIyidPveh7Q
         CVHQ==
X-Gm-Message-State: ANhLgQ0CCDorW5SFy88QVebsupCJ0F5DLTguQbJizy123x97WEVBOavA
        4h+IH8+D7vcdMvN0OIWjCKgP6/s=
X-Google-Smtp-Source: ADFU+vuXmK4F1Qp+e2kTN3c5xoaJcMADkXSaoy0ZVFhuFIcjEmWwOSP/F/DFYq1+Y8iOgkk9dgNCyg==
X-Received: by 2002:a92:48cb:: with SMTP id j72mr9631300ilg.162.1585241653028;
        Thu, 26 Mar 2020 09:54:13 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n5sm774947iop.23.2020.03.26.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:54:12 -0700 (PDT)
Received: (nullmailer pid 10167 invoked by uid 1000);
        Thu, 26 Mar 2020 16:54:10 -0000
Date:   Thu, 26 Mar 2020 10:54:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200326165410.GA2305@bogus>
References: <20200325151211.19949-1-i.mikhaylov@yadro.com>
 <20200325151211.19949-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325151211.19949-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 18:12:10 +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/proximity/vcnl3020.example.dts:19.12-25: Warning (reg_format): /example-0/iio-proximity@13:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/vcnl3020.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/vcnl3020.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/vcnl3020.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

See https://patchwork.ozlabs.org/patch/1261460

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
