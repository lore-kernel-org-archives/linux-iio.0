Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37657 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdAOM1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 07:27:03 -0500
Subject: Re: [PATCH 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
Date: Sun, 15 Jan 2017 13:26:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/2017 06:43 PM, Martin Blumenstingl wrote:
> +	indio_dev->name = dev_name(&pdev->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. E.g. meson-gxbb-saradc or meson-gxl-saradc
in this case.

