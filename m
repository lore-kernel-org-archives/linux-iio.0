Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [213.199.154.189] ([213.199.154.189]:57718 "EHLO
	db8outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752716Ab3IWPSF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 11:18:05 -0400
Message-ID: <52405A7F.1050801@freescale.com>
Date: Mon, 23 Sep 2013 12:13:03 -0300
From: Fabio Estevam <fabio.estevam@freescale.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>, <linux-iio@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<devel@driverdev.osuosl.org>, <marex@denx.de>, <jic23@cam.ac.uk>,
	<linux-input@vger.kernel.org>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/2013 11:36 AM, Juergen Beisert wrote:

> +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> +	clk_prepare_enable(lradc->clk);

clk_prepare_enable() may fail, so better check its return value.

