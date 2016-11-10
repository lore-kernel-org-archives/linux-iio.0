Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:28531 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbcKJGiN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 01:38:13 -0500
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
To: John Syne <john3909@gmail.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
 <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
 <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
 <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
        "N, Mugunthan V" <mugunthanvnm@ti.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <b7232421-10f7-2bac-0ad8-847804126bf2@ti.com>
Date: Thu, 10 Nov 2016 10:37:12 +0530
MIME-Version: 1.0
In-Reply-To: <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Thursday 10 November 2016 05:23 AM, John Syne wrote:
> OK, then back to my original question. Given that these DT properties are supported in the driver
> 

Below properties are supported by only by ti_am3335x_adc driver and not
ti_am335x_tsc driver. As author of this patch pointed out in another
reply, there is no need to change step-opendelay for tsc. AFAIK, I don't
see a use case where these values needs to be tweaked for tsc channels,
therefore it does not make sense to be DT properties.

> shouldn’t the following be added to am33xx.dtsi and am4372.dtsi?

Its totally upto board dts files to allocate channels for tsc and adc.
So, how could these be added to dtsi files?

> ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
> ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
> ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
> 
> Regards,
> John
>>
>> -- 
>> Regards
>> Vignesh
> 

-- 
Regards
Vignesh
