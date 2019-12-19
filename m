Return-Path: <SRS0=YDjO=2J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1337C43603
	for <linux-iio@archiver.kernel.org>; Thu, 19 Dec 2019 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1FC24672
	for <linux-iio@archiver.kernel.org>; Thu, 19 Dec 2019 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576792153;
	bh=L8mrM3lA1V9ZQh2cHIKtpAyFPrZudmpsb9+qcZ57g/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aMWsV9FNpG61dBsgFVle13kEJku01X9fzhWeNJ6jvKW0Z10+wrotdiRDBhEoyd7UH
	 u12AqQA7ObSVtB8XQ+mjvEN8a8GU5yP/0iCVaL6eSZo00f/rRwPKw/VQ5HtObaFrGy
	 ob785Lx4egAJP6LZ1QWy6FNRVsNOPHeZWjIRORlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLSVtN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:49:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34467 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSVtN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 16:49:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so9037188otf.1;
        Thu, 19 Dec 2019 13:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKIao3Hx9jJKwqQP/RXgQCvGLhPT1+X7pm/hu0NpBV8=;
        b=TL7jZlXyHGuZNYSFt9vAc+hiWVGQEPCAz0EwmKN2ce6riU9QEFKNJkVkuYc/HSaAso
         mRcA0IBr4QqXk4iKqoj1tsNIpstyyKo9GtcAqHv0K+RTw0wfTdc59VUdWONDwDreZyYc
         O8Eeo1YbduqXyqvEgwSmC5+3Ti1Umsukjs40emwq0k1oddWn9ScGEu5eqPVr/BgKF9Yj
         IojCXAWVMePLTcLrVU1UjEUF/18FtOEilBXZsEWwMF7OB/Q4ysJc8BaMc1dLPZOWgwZa
         X6EBv6d/wamZDP0ahFlEWM2QKTEFg+QGp8/gPT6dv/kUQ1tb0dK6dV+gbapUV1+GLKnG
         shpQ==
X-Gm-Message-State: APjAAAWCf5ZS3OLj4vw6WQnIh7blPtiWFZmH2qFUYfYzhgtYg5pML5fg
        ujbq28hqLb4wOf4uudQ5+Q==
X-Google-Smtp-Source: APXvYqz2gW/XlSmYj6ZEO5sdTV3J4iZniHY0zC80aaRxAOIj5Wdn4HTj/NCzv0ZF1vY74TPSXk6Zfw==
X-Received: by 2002:a9d:24c1:: with SMTP id z59mr10708739ota.207.1576792152312;
        Thu, 19 Dec 2019 13:49:12 -0800 (PST)
Received: from localhost ([2607:fb90:1cd2:8a0d:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id e9sm2461049oia.10.2019.12.19.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:49:11 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:49:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: accel: bma180: BMA254 support
Message-ID: <20191219214904.GA1592@bogus>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
 <20191211213819.14024-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211213819.14024-4-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 22:38:19 +0100, Linus Walleij wrote:
> This adds support for the BMA254 variant of this
> accelerometer. The only difference for the simple IIO
> driver is that values are 12 bit and the temperature
> offset differs by 1 degree.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/bma180.txt  |   7 +-
>  drivers/iio/accel/Kconfig                     |   4 +-
>  drivers/iio/accel/bma180.c                    | 108 +++++++++++++++---
>  3 files changed, 100 insertions(+), 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
