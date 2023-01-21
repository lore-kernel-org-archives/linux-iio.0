Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A802C38142
	for <linux-iio@archiver.kernel.org>; Sat, 21 Jan 2023 17:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAURl4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Jan 2023 12:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAURlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 12:41:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F7BBB5;
        Sat, 21 Jan 2023 09:41:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9342460B4B;
        Sat, 21 Jan 2023 17:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B7AC433A0;
        Sat, 21 Jan 2023 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674322914;
        bh=HAAyK8l575aV3MbhOxDAuQGKNupowsm4/5Bmqw32w20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdiLEIeRADYJPSVn/EaVKWnezIPPMM158hbBb8aUDF5ziZdY+Ehi05Qih1urFzyrV
         R4jdPFutfQx/WSlej0hrPD+30H16OzvG8YzjNdfEICuHZK48Jm9Iv/w+9D/woJ6Crp
         szp5ubYA79xaONzYL/TpqAZcrRcJQboNYbSctZoX/yKmikzmcn8C3cj6YGlKZtIYgi
         3agh5m3asw9n469tJd+Ux4uLbfreyCa5+XljN/NsMWxySWszbja3KX9hT0N6XpDZX4
         y0iMM+ah/PjzRTkLQKtauI3JzhuKOOMNP93AV/7342okBVORq43VbQ6dgGIGf+NNK1
         /LjUjjyc6T7Ag==
Date:   Sat, 21 Jan 2023 17:55:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] drivers: iio: adc: Add ADI MAX77541 ADC Support
Message-ID: <20230121175537.0ffe7652@jic23-huawei>
In-Reply-To: <20230118063822.14521-6-okan.sahin@analog.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
        <20230118063822.14521-6-okan.sahin@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Jan 2023 09:38:12 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
With Andy's comments resolved, I'm fine with this.
Note it will need to go via mfd because of the included header.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

