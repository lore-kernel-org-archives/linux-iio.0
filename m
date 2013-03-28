Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59660 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab3C1W6O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2013 18:58:14 -0400
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] iio: mxs-lradc: Do hardware initialization earlier
Date: Thu, 28 Mar 2013 23:58:08 +0100
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jimwall@q.com, brian@crystalfontz.com,
	Maxime Rpard <maxime.ripard@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>
References: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201303282358.08630.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre Belloni,

> We need to initialize hardware before registering the touchscreen. Else,
> we end up setting registers in mxs_lradc_ts_open(), getting called just
> after registering the touchscreen with input_register_device() and by
> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
> correct configuration.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Marek Vasut <marex@denx.de>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
