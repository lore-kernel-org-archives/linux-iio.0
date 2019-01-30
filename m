Return-Path: <SRS0=THUK=QG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F219C282D7
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB82086C
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867381;
	bh=bT7qQ2LCQPkMzr8OnAgsD8+FxuP0ar7Wcs0ge/U2fCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pH99FHqlHdGMhjH831qMZk9Wi57hOiXoKysU2lNHRL7mrgG1G0PXnnwH8L4vEUHWV
	 c9NABXotKYaGPjmdFnZIKsib14IHi3nkwEpiijFctONnOJmuskrvBumIOSNEYn72Pn
	 C116LJF9kMpXnYknjTqvBFnhV3SdQLIb398sKlH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfA3Q4V (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:56:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44850 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbfA3Q4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2019 11:56:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so159069oig.11;
        Wed, 30 Jan 2019 08:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDH6Zyby9XrW/2PVxImFi1cWrEer4NEAb6ZT2XZn9zI=;
        b=ODcsycxIBxMLe0lfIza7ynpDcV71p1XZGJVTqP7zvI/ZNb+B6A1RlVFlXUTk9r4J4Z
         VvdSk5ur9W4IAdr0oCe/uVwG4VEZycIiLdpuwCgwsxvgtlFBh+MHOsS06HEhg+fPanTS
         ALHtkFsvuiEW7uYSMQBKCHvdk5o5iljBOiqBNA0xG//VOb5frV3TJZRMrU4e1PskGVAS
         lnHF4CFUM0sAJNnXzwmy8tMKxQcSZzbGUAGP1z/gkH1nozTpg3Q9ezBkPE68j5/Go9Yz
         0ezmJkz9op3glb35NVM3KOX9figb93n4mHyUYZXYZD+CnhSZCkYcYXsMgJDQNo58yL1H
         BwCw==
X-Gm-Message-State: AHQUAubcX6GupcyQBmDI9L9KrdBDrsbpyy/L7MRiRnYmOOoHZMpteasV
        3eTyoqjwfmuD2+EkRArL4g==
X-Google-Smtp-Source: AHgI3IYOP30Kqk6E7j1k0Yx3DtL840FacN5MAFhXHWJ4tRr9OBvbjRj1jJTvEEA8rQ+2qQE/jPLv0Q==
X-Received: by 2002:aca:7581:: with SMTP id q123mr13255472oic.176.1548867380418;
        Wed, 30 Jan 2019 08:56:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm708808otb.79.2019.01.30.08.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:56:19 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:56:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: fix incorrect bmi160 IRQ note
Message-ID: <20190130165619.GA22806@bogus>
References: <20190127203911.8696-1-martin@martingkelly.com>
 <20190127203911.8696-4-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127203911.8696-4-martin@martingkelly.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jan 2019 12:39:08 -0800, Martin Kelly wrote:
> From: Martin Kelly <martin@martingkelly.com>
> 
> The bmi160 bindings say that the BMI160 requires level-triggered,
> active-low interrupts, but it actually supports all interrupt types, so fix
> the note to reflect that.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/bmi160.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
