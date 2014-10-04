Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51739 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaJDOHU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 10:07:20 -0400
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: adc: mxs-lradc: Disable the clock on probe failure
Date: Sat, 4 Oct 2014 16:06:54 +0200
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1412423421-5951-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1412423421-5951-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201410041606.54956.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday, October 04, 2014 at 01:50:21 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We should disable lradc->clk in the case of errors in the probe function.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
