Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36899 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbcGYTmP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jul 2016 15:42:15 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Caesar Wang <wxt@rock-chips.com>, dianders@chromium.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Explicitly disable ADC on probe
Date: Mon, 25 Jul 2016 21:41:41 +0200
Message-ID: <2966977.qtjPvpdIFp@diego>
In-Reply-To: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
References: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Montag, 25. Juli 2016, 12:39:00 schrieb Guenter Roeck:
> If the ADC is read for the first time, the caller gets a timeout error,
> and the kernel log shows
> 
> read channel() error: -110
> 
> The ADC may be enabled on boot, and needs to be explicitly disabled
> for a read sequence to work (otherwise there is no completion interrupt).
> Disaple it explicitly in the probe function.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

in my tests I hadn't notices that issue before, but that is likely because the 
bootloaders I had didn't enable the saradc. Anyway, that looks definitly sane, 
so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
