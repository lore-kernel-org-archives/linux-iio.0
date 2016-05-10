Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56884 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcEJQkP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 10 May 2016 12:40:15 -0400
Subject: Re: [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
 <1462870813-24700-2-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <90802d98-c7bc-bc14-214c-0d1c3bf19b14@intel.com>
Date: Tue, 10 May 2016 19:40:17 +0300
MIME-Version: 1.0
In-Reply-To: <1462870813-24700-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/2016 12:00 PM, Linus Walleij wrote:
> Leonard Crestez observed the following phenomenon: when using
> hard interrupt triggers (the DRDY line coming out of an ST
> sensor) sometimes a new value would arrive while reading the
> previous value, due to latencies in the system.
> 
> As the interrupts from the ST sensors are a pulse, intended
> to be read by an edge-triggered interrupt line (such as a
> GPIO) one edge (transition from low-to-high or high-to-low)
> will be missed while processing the current values.
> 
> If this happens, the state machine that triggers interrupts on
> the DRDY line will lock waiting for the current value to be
> read out and not fire any more interrupts. That means that
> when we exit the interrupt handler, even though new values are
> available from the sensor, no new interrupt will be triggered.
> 
> ChangeLog v5->v6:
> - Add a loop counter to the threaded value poll function: let's
>   just loop here for at maximum 10 loops before we exit and
>   let the thread re-trigger if more interrupts arrived.

This only serves to hide the problem. Version 5 seems preferable. Or
even just adding msleep(10) in that infinite loop.

-- 
Regards,
Leonard
