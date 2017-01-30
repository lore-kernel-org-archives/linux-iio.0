Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33595 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbdA3TQr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 14:16:47 -0500
Received: by mail-pg0-f41.google.com with SMTP id 204so103482756pge.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2017 11:15:15 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, carlo@caione.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] ARM64: dts: meson: meson-gx: add the SAR ADC
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
        <20170122181714.6259-4-martin.blumenstingl@googlemail.com>
Date: Mon, 30 Jan 2017 10:50:01 -0800
In-Reply-To: <20170122181714.6259-4-martin.blumenstingl@googlemail.com>
        (Martin Blumenstingl's message of "Sun, 22 Jan 2017 19:17:14 +0100")
Message-ID: <m2efzktmau.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
> 10-bit ADC while GXL and GXM provide a 12-bit ADC.
> Some boards use resistor ladder buttons connected through one of the ADC
> channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
> to change the resistance (and thus the ADC value) on one of the ADC
> channels to indicate the board revision.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>

Now that IIO driver looks like it will be merged shortly, I applied this
to v4.11/dt64.

Didn't make the first pull request for arm-soc, but may still make it if
I have time to send another batch.

Kevin
