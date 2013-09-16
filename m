Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3IPRj1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 13:39:27 -0400
Message-ID: <5237506C.4010607@kernel.org>
Date: Mon, 16 Sep 2013 19:39:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
Subject: Re: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register
 access
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-4-git-send-email-jbe@pengutronix.de> <52358D71.2040905@kernel.org> <201309161017.31846.jbe@pengutronix.de>
In-Reply-To: <201309161017.31846.jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/13 09:17, Jürgen Beisert wrote:
> Hi Jonathan,
> 
> On Sunday 15 September 2013 12:35:29 Jonathan Cameron wrote:
>> [...]
>>> +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
>>> +{
>>> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
>>> +}
>>> +
>>> +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
>>> +{ 
>>> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
>>> +}
>>> +
>>
>> mxs_lradc_reg_write might be clearer?
> 
> I would prefer the shorter name. Due to long macro names and long function 
> names the lines in the code below needs more and more line breaks which is 
> IMHO less helpfull to read the code.
Hmm.  It's not entirely obvious what else this might be doing, but it is
also not obvious from the name that it is writing to the register...

I remain unconvinced by the short name!

