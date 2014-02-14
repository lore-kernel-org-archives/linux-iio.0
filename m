Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39772 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbaBNJDy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 04:03:54 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: Propagate the real error code on platform_get_irq() failure
Date: Fri, 14 Feb 2014 09:22:50 +0100
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1392348515-11420-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1392348515-11420-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201402140922.50329.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday, February 14, 2014 at 04:28:35 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> No need to return a 'fake' return value on platform_get_irq() failure.
> 
> Just return the error code itself instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
