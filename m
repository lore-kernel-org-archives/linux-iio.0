Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:59812 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755428AbcJ0NwH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Oct 2016 09:52:07 -0400
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
To: Lee Jones <lee.jones@linaro.org>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
CC: <linux-iio@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Vignesh R <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        John Syne <john3909@gmail.com>
From: Mugunthan V N <mugunthanvnm@ti.com>
Message-ID: <ae3d5312-a328-f643-7e0a-cacc5bb95d28@ti.com>
Date: Thu, 27 Oct 2016 16:50:24 +0530
MIME-Version: 1.0
In-Reply-To: <20161024060226.4170-1-mugunthanvnm@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 24 October 2016 11:32 AM, Mugunthan V N wrote:
> Increase ADC reference clock from 3MHz to 24MHz so that the
> sampling rates goes up from 100K samples per second to 800K
> samples per second on AM335x and AM437x SoC.
> 
> Also increase opendelay for touchscreen configuration to
> equalize the increase in ADC reference clock frequency,
> which results in the same amount touch events reported via
> evtest on AM335x GP EVM.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Found issues with touchscreen usage with GUI on my AM335x GP EVM. Fixed
with change the "ti,charge-delay" DT property based on change in ADC
clocks. Will be sending v2 patch soon.

Regards
Mugunthan V N
