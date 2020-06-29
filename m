Return-Path: <SRS0=WQji=AK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B19C433E0
	for <linux-iio@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855F1206C0
	for <linux-iio@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463567;
	bh=UCUfaDjUVmlDpTU3LRBvAL1Yi4B0vDt8IAFLorzpyrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ImJCTDKNi0qsurhe9tA/MRPJfktNX+6UQZUlNfw4Ul10F4amdNKaGxIjysC1UrDBp
	 0/uE10VMeRV3pnjBZuwNhIYxxWVwdG8XxIlQ7pFrJZLho0LBgOR078om3GV49rZLqF
	 FRc8I6OAFkNf2orp3T1pL5ksyNP+CpDTj70iSyNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgF2UqG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgF2TNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2020 15:13:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D95C08ECB9;
        Sun, 28 Jun 2020 23:52:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so2833421edr.5;
        Sun, 28 Jun 2020 23:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJNvhIQCteTm5VtFSyzzsWJRKykcFhaBMFS+SgAaulE=;
        b=uNI53+DW4ONYlbuHphXC9uYMySsEMjyWfy5sBfX+nJbg4OS9i4+HWrsrE1tWTK/Hef
         02OIFYUVziudbAsKub4UzWh1xRVhXjYE5FnNrbLcGcXQ7qr+7Ilpk6XFAzB9kDwAr/QX
         oVGpNc84c8tKZEO/yPLs7jAyvT8qSv0+gbiIG00uGK+Gwk026vO4birTebkPxwjQCQhf
         /tHgX4kwxIn/+TzpFtRp457rHdY1XnQlQxPZnPfuwaj4Aa1o+VvZR5OWzyPUY0G5Aev4
         cvLIOMRCe4/yYTnMIyWSIVYfHH2FtVDSQs1Xw2AFfqOuYKr//f3g2FyzEjOUPiRn0ykP
         zNZA==
X-Gm-Message-State: AOAM532Z9dACPIuq4ShX8Zn+MRhc06Y3FtBXyvPT6EdT5VC2gN9OcQ9L
        8+/oJ1CkwU6vJkS4NbTiDc0=
X-Google-Smtp-Source: ABdhPJw9FZnwCiOCE7JrbDHqCcdYHvx1EqL2R+gxeefz5/+dK9PWLHMqdziIkts4ezYexqkOwTWX0w==
X-Received: by 2002:a50:f047:: with SMTP id u7mr16877181edl.274.1593413532938;
        Sun, 28 Jun 2020 23:52:12 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id m14sm9438582ejx.80.2020.06.28.23.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jun 2020 23:52:12 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:52:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: bmc150_magn: Document and fix
 missing compatibles
Message-ID: <20200629065210.GB5879@kozik-lap>
References: <20200622060110.23192-1-krzk@kernel.org>
 <20200627144359.1ae30bb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200627144359.1ae30bb0@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 27, 2020 at 02:43:59PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jun 2020 08:01:09 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > The driver supports also BMC156B and BMM150B but these compatibles had
> > redundant suffix "_magn".  Add existing compatibles marking them
> > deprecated along with adding a new, proper one for this family of
> > devices.
> Thanks for tidying this up.
> 
> The BMC156B is a dual magnetometer and accelerometer chip
> so for that one the _magn postfix probably is needed.
> 
> Or am I missing something?
> 
> The way this does SPI is rather odd but seems to be the same as the bmc150
> (two chips with non overlapping register maps).

You're right, only one compatible should be trimmed from suffix. I'll
send v3.

Best regards,
Krzysztof

