Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58099 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcDNUDY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2016 16:03:24 -0400
Message-ID: <570FF5AF.7010801@denx.de>
Date: Thu, 14 Apr 2016 21:55:27 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT 0/5] iio: mxs-lradc: fix leak and implement PM ops
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/14/2016 05:48 PM, Stefan Wahren wrote:
> This patch series fix a memory leak and implements suspend/resume
> support for mxs-lradc.
> 
> Patch 1: fix the memory leak
> Patch 2-4: refactor mxs-lradc in order to prepare PM implementation
> Patch 5: implement suspend/resume support
> 
> These patches has been tested with i.MX23 and i.MX28 but without
> a touchscreen. I added only a bogus touchscreen in devicetree.
> 
> It would be nice if someone with a real touchscreen could test it.
> 
> Stefan Wahren (5):
>   iio: mxs-lradc: fix memory leak
>   iio: mxs-lradc: move TS config into suitable function
>   iio: mxs-lradc: move STMP reset out of ADC init
>   iio: mxs-lradc: disable only mapped channels in mxs_lradc_hw_stop
>   iio: mxs-lradc: implement suspend/resume support
> 
>  drivers/iio/adc/mxs-lradc.c |  116 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 82 insertions(+), 34 deletions(-)
> 

On M28EVK:

Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
