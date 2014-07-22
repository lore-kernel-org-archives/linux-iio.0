Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58767 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaGVNAF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jul 2014 09:00:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, jic23@kernel.org,
	devicetree@vger.kernel.org, kgene.kim@samsung.com,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	t.figa@samsung.com, linux-kernel@vger.kernel.org,
	kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org,
	ch.naveen@samsung.com
Subject: Re: [PATCH 2/2] iio: adc: exynos_adc: Add support for S3C24xx ADC
Date: Tue, 22 Jul 2014 14:59:25 +0200
Message-ID: <5954793.q4YDWmuNDB@wuerfel>
In-Reply-To: <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com> <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday 22 July 2014 11:11:14 Chanwoo Choi wrote:
> This patch add support for s3c2410/s3c2416/s3c2440/s3c2443 ADC. The s3c24xx
> is alomost same as ADCv1. But, There are a little difference as following:
> - ADCMUX register address to select channel
> - ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

While looking at the driver again to see if the touchscreen patch needs
an update for this, I noticed that the s3c24xx variants don't have the
ADC_V1_INTCLR and ADC_V1_CLRINTPNDNUP registers, so I assume your patch
will have to be updated not to acknowledge the interrupts.

It's possible that writing to the missing registers is harmless though and
that you don't need that change.

	Arnd
