Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbdASTNf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 14:13:35 -0500
Date: Thu, 19 Jan 2017 11:13:32 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, carlo@caione.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] clk: gxbb: add the SAR ADC clocks and expose them
Message-ID: <20170119191332.GA7829@codeaurora.org>
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170119145822.26239-3-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/19, Martin Blumenstingl wrote:
> The HHI_SAR_CLK_CNTL contains three SAR ADC specific clocks:
> - a mux clock to choose between different ADC reference clocks (this is
>   2-bit wide, but the datasheet only lists the parents for the first
>   bit)
> - a divider for the input/reference clock
> - a gate which enables the ADC clock
> 
> Additionally this exposes the ADC core clock (CLKID_SAR_ADC) and
> CLKID_SANA (which seems to enable the analog inputs, but unfortunately
> there is no documentation for this - we just mimic what the vendor
> driver does).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

This should go through arm-soc along with the other patch to dts.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
