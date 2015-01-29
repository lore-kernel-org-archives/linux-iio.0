Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43804 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbbA2Ovi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jan 2015 09:51:38 -0500
MIME-Version: 1.0
In-Reply-To: <1422108103-15052-4-git-send-email-mpa@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
	<1422108103-15052-4-git-send-email-mpa@pengutronix.de>
Date: Thu, 29 Jan 2015 12:51:36 -0200
Message-ID: <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] iio: adc: fsl,imx25-gcq driver
From: Fabio Estevam <festevam@gmail.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Markus,

On Sat, Jan 24, 2015 at 12:01 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (priv->irq <= 0) {

This should be: if (priv->irq < 0) {
