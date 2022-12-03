Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87BFC47088
	for <linux-iio@archiver.kernel.org>; Sat,  3 Dec 2022 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiLCRIG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 3 Dec 2022 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCRIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2022 12:08:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E111140;
        Sat,  3 Dec 2022 09:08:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72CBA60CA4;
        Sat,  3 Dec 2022 17:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B89C43147;
        Sat,  3 Dec 2022 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670087282;
        bh=ppRGsAuveB/mzFObi0kSfA/m3eGVTINv0aX2P7vrwlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ge70MXN73OfY8Bqlh4c4Zaiyhrur6sB9auQEbY7511NDKxTl6EQR7PS3+CVIdBTqX
         UmMplOqzQm5BN+uuCoFVOZn6s6Z0Uw2myZS+qYOJSOjDkI0hz1nICxSuIb8ryB/zno
         rc6cT9aPSMeefhFEJ66M7rcyzoexjdSNbTvKxEPT4cKB5A5i76CVoBqm0bjZfRbrk3
         iInksGyW5gW5l0iI8RRH1eIOEi6XszPVV4cPQU4SpFtduyoq+zEwKxHHNKCcXHPJ1k
         +HiFJwBbmoge82ITfsRUfuKXQxEDaE4vT/z6JhxlEVcvB0BySrf/2Mp/M0dxf6WdrP
         CsjMYE2P2Jxzw==
Date:   Sat, 3 Dec 2022 17:20:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v6 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <20221203172047.2792343e@jic23-huawei>
In-Reply-To: <20221201072220.402585-4-gerald.loacker@wolfvision.net>
References: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
        <20221201072220.402585-4-gerald.loacker@wolfvision.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Dec 2022 08:22:20 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmag5273
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +		case IIO_ANGL:
> +			/*
> +			 * Angle is in degrees and has four fractional bits,
> +			 * therefore use 1/16 * pi/180 to convert to radiants.
typo. radians

I'll fix whilst applying.
> +			 */

> +}
