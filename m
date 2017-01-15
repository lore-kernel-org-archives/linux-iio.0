Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56819 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdAONJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 08:09:42 -0500
Subject: Re: [PATCH 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
To: Lars-Peter Clausen <lars@metafoo.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
 <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3adef00d-aceb-029f-1f6a-0f6c71721559@kernel.org>
Date: Sun, 15 Jan 2017 13:09:40 +0000
MIME-Version: 1.0
In-Reply-To: <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/01/17 12:26, Lars-Peter Clausen wrote:
> On 01/11/2017 06:43 PM, Martin Blumenstingl wrote:
>> +	indio_dev->name = dev_name(&pdev->dev);
> 
> The name is supposed to be the type of the device, e.g. part name, not the
> name of parent device instance. E.g. meson-gxbb-saradc or meson-gxl-saradc
> in this case.
Drat. I've been missing these again.  Somehow, never manage to get them
onto those things my eyes pick up whilst reviewing.

Thanks Lars,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

