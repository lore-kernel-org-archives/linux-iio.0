Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:47880 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbLUKZ6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2015 05:25:58 -0500
Date: Mon, 21 Dec 2015 11:25:27 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
Message-ID: <20151221102527.GB14161@odux.rfo.atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
 <alpine.DEB.2.02.1512211029260.14320@pmeerw.net>
 <20151221101611.GA14161@odux.rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151221101611.GA14161@odux.rfo.atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 21, 2015 at 11:16:11AM +0100, Ludovic Desroches wrote:
> On Mon, Dec 21, 2015 at 10:38:11AM +0100, Peter Meerwald-Stadler wrote:
> > 
> > > This driver supports the new version of the Atmel ADC device introduced
> > > with the SAMA5D2 SoC family.
> > 
> > some minor, quick comments below...
> 
> Thanks for your review
> 

[...]

> > > +static unsigned at91_adc_startup_time(unsigned startup_time_min,
> > > +				      unsigned adc_clk_khz)
> > > +{
> > > +	const unsigned startup_lookup[] = {
> > > +		0,     8,  16,  24,
> > > +		64,   80,  96, 112,
> > > +		512, 576, 640, 704,
> > > +		768, 832, 896, 960
> > > +		};
> > 
> > do we need the ADC_MR_STARTUP_SUT #defines then?
> > 
> 
> Why not.
>

Sorry my answer is not clear! I mean, yes these defines are probably
useless.

[...]
