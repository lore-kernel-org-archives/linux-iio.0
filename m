Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3266 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbJEK4k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2015 06:56:40 -0400
Message-ID: <56125571.8070906@nvidia.com>
Date: Mon, 5 Oct 2015 16:18:17 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	<gg@slimlogic.co.uk>, <jic23@jic23.retrosnub.co.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2 1/3] iio:adc: add iio driver for Palmas (twl6035/7)
 gpadc
References: <cover.1444025625.git.hns@goldelico.com> <fba10a9902d88110569630da2a86ed4faf261e79.1444025628.git.hns@goldelico.com>
In-Reply-To: <fba10a9902d88110569630da2a86ed4faf261e79.1444025628.git.hns@goldelico.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Monday 05 October 2015 11:44 AM, H. Nikolaus Schaller wrote:
> This driver code was found as:
>
> https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc
>
> Fixed various compilation issues and test this driver on omap5 evm.
>
> Signed-off-by: Pradeep Goudagunta <pgoudagunta@nvidia.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
