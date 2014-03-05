Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51172 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752550AbaCES1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Mar 2014 13:27:25 -0500
Date: Wed, 5 Mar 2014 19:27:22 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/15] iio: adc: at91_adc: Add support for touchscreens
 without TSMR
Message-ID: <20140305192722.786d5549@skate>
In-Reply-To: <1394040940-18246-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1394040940-18246-5-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre Belloni,

On Wed,  5 Mar 2014 18:35:29 +0100, Alexandre Belloni wrote:

> -static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +void handle_adc_rl_ts_irq(int irq, struct at91_adc_state *st, u32 status)

I believe this function,

> +void handle_adc_9x5_ts_irq(int irq, struct at91_adc_state *st, u32 status)

and this one should be 'static'.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
