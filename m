Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45139 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab2JWKck (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2012 06:32:40 -0400
From: Marek Vasut <marex@denx.de>
To: Peter Turczak <peter@turczak.de>
Subject: Re: i.MX28 die temperature
Date: Tue, 23 Oct 2012 12:32:37 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201210231052.39983.marex@denx.de> <81D7F19D-A9F8-4022-81F0-B8A836F7F087@turczak.de>
In-Reply-To: <81D7F19D-A9F8-4022-81F0-B8A836F7F087@turczak.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201210231232.37469.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Peter Turczak,

> Hi Marek,
> 
> On Oct 23, 2012, at 10:52 AM, Marek Vasut wrote:
> > We have some basic LRADC driver in upstream already, you should use that.
> > 
> > See drivers/staging/iio/adc/mxs-lradc.c
> 
> Thanks for the heads-up.
> I was referring to this driver (pulled from linus' 3.7rc), it does not
> currently seem to have a consumer api for use within other kernel modules.
> Maybe I'm just heading the wrong way now...

Ah yes, it doesn't ... feel free to implement it. It can -- though -- read the 
CPU die temperature, just sample those two channels, substract one from another 
and multiply by the coeficient ... you'll find that in the datasheet.

Best regards,
Marek Vasut
