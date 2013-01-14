Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:14027
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754797Ab3ANAuW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2013 19:50:22 -0500
Date: Mon, 14 Jan 2013 08:50:27 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Marek Vasut <marex@denx.de>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] iio: mxs: Enable touchscreen on m28evk
Message-ID: <20130114005026.GB24575@S2101-09.ap.freescale.net>
References: <1357947308-11226-1-git-send-email-marex@denx.de>
 <1357947308-11226-2-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1357947308-11226-2-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 12, 2013 at 12:35:08AM +0100, Marek Vasut wrote:
> This patch adds necessary DT properties to m28evk to enable touchscreen
> in the LRADC block. The M28EVK is shipped with 4-wire resistive touchscreen.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Changed the subject prefix to "ARM: mxs: ...", and applied the patch.

Shawn

