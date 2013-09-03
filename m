Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53914 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373Ab3ICBAD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2013 21:00:03 -0400
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] iio: mxs-lradc: Fix the order of resources removal
Date: Tue, 3 Sep 2013 03:00:00 +0200
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1378169292-29899-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1378169292-29899-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309030300.00678.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the order of resources removal in the error path of mxs_lradc_probe()
> and also in mxs_lradc_remove().
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
