Return-Path: <SRS0=aecl=3D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BBC33CA9
	for <linux-iio@archiver.kernel.org>; Tue, 14 Jan 2020 01:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5732F217BA
	for <linux-iio@archiver.kernel.org>; Tue, 14 Jan 2020 01:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578963907;
	bh=w6b7zxtaX1JNVVh331GpaaL1Tljp48nC2gXOjBChnjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtqmpP8Dtp0/oA6x8g/KYO9txxirvv3sUsf5eJLALUmMlAEgblOSUGuPiHAfSfbyb
	 G8LNqB4qQXOEHitnJlr+zMSKrCATqTRSgTvXAX45i0pT66LROAmeD0PGhQg9OZT+E5
	 LBOl9tJKNsLB1kRt++D2LxWu6H0bKS54UAKNHtYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgANBFH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:05:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35180 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANBFG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 20:05:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so10274216oik.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 17:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXJN2b85yGTyfLCLDYBimi22Hg8WM/nHD10wRzYfTm4=;
        b=SwgXCU5FRGRRGjIc+7+JfAphY0hK5gIO0ThTQZgwmBqKBIYlj5Y1vvtueNE+EW7kVH
         gUSClG9PXokebPszhGkSbDxI7EuAcGSvsJMCFzrdwdcpSGEnU8vTSDNquk0x3qvwcZGx
         f8+Y4qFiEOZwDR5Kxho7QJOH7ms7duZckQBILDYZj7SgsW7W9UId5hWQq1I8203y+NVi
         5MYaBdpBBjsxQiGLCqwmYmc2wqNuCMGy6M0AjvnQ/DEaXIYVKL0ikMES8wHZ/fTdfFoZ
         abcZ9Zjab1u56EFrqceTB8YIjRX9WVVw9KFHQnZdWICG42i++lxO1NV+d3K0SgRMj6Fg
         CUfg==
X-Gm-Message-State: APjAAAXUlAVWbJYjoVUfQar5VHRK8IZnVrvN1+5C+DUsVLpx6icDvtTs
        Rin7BnKsS+Yl7cBSYmVvnjfYYYb6Tw==
X-Google-Smtp-Source: APXvYqzIBqbwC/7eMSAOrLCnM0i6z+kqseaORYdBN6vuBp92h0fQW5w6/wRT0CqTLzGq+MSv0hHnbw==
X-Received: by 2002:aca:3255:: with SMTP id y82mr14332327oiy.41.1578963905521;
        Mon, 13 Jan 2020 17:05:05 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm4787371otq.46.2020.01.13.17.05.03
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:05:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:33:32 -0600
Date:   Mon, 13 Jan 2020 18:33:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 15/17] dt-bindings: arm: add sam9x60-ek board
Message-ID: <20200114003332.GA3401@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:18:07 +0200, Claudiu Beznea wrote:
> Add documentation for SAM9X60-EK board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
