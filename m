Return-Path: <ludovic.desroches@atmel.com>
Date: Wed, 28 Aug 2013 15:27:24 +0200
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Josh Wu <josh.wu@atmel.com>
CC: <jic23@cam.ac.uk>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <nicolas.ferre@atmel.com>,
	<b.brezillon@overkiz.com>, <maxime.ripard@free-electrons.com>,
	<plagnioj@jcrosoft.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/6] iio: at91: move the num_channels from DT to
 driver itself
Message-ID: <20130828132724.GQ7468@ludovic.desroches@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-6-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1377602932-1899-6-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 27, 2013 at 07:28:51PM +0800, Josh Wu wrote:
> CC: devicetree@vger.kernel.org
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 -
>  drivers/iio/adc/at91_adc.c                          |   12 +++++-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
