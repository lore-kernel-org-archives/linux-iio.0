Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38560 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab3EFMtR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 08:49:17 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: rachna@ti.com, linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with partial activation
Date: Mon,  6 May 2013 14:48:57 +0200
Message-Id: <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
In-Reply-To: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Pantelis,

while trying out your patch on a custom AM335x board, I noticed that the
sysfs entries ware missing. This is fixed in the first patch, you might want
to squash that into your original patch.

The second one makes sure that the iio framework does not read invalid data.

Regards,
Jan

