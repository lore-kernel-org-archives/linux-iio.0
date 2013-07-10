Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45274 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab3GJLnV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2013 07:43:21 -0400
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: Check the return value from stmp_reset_block()
Date: Wed, 10 Jul 2013 13:43:19 +0200
Cc: jic23@cam.ac.uk, shawn.guo@linaro.org, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1373423775-11053-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1373423775-11053-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307101343.19408.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> stmp_reset_block() may fail, so let's check its return value and propagate
> it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
