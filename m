Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:42679
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750830AbaBPHtY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Feb 2014 02:49:24 -0500
Date: Sun, 16 Feb 2014 15:50:23 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <sachin.kamat@linaro.org>, <pmeerw@pmeerw.net>,
	<lars@metafoo.de>, <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] ARM: dts: vf610-twr: Add ADC support
Message-ID: <20140216075021.GB2946@S2101-09.ap.freescale.net>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-2-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1390714773-23066-2-git-send-email-B38611@freescale.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 26, 2014 at 01:39:31PM +0800, Fugang Duan wrote:
> @@ -178,6 +187,14 @@
>  
>  				/* functions and groups pins */
>  
> +				adc0 {
> +					pinctrl_adc0_ad5: adc0_ad5 {
> +						fsl,pins = <
> +						VF610_PAD_PTC30__ADC0_SE5	0xa1
> +						>;
> +					};

We have been moving pinctrl setting nodes into board dts.  Please rebase
the patch against my for-next branch.

Shawn

> +				};
> +


