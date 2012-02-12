Return-Path: <stigge@antcom.de>
Message-ID: <4F38209B.5080602@antcom.de>
Date: Sun, 12 Feb 2012 21:27:07 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: devel@driverdev.osuosl.org, kevin.wells@nxp.com,
 w.sang@pengutronix.de, jic23@cam.ac.uk
Subject: Re: [PATCH v2] ARM: LPC32xx: ADC support
References: <1329077345-15305-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1329077345-15305-1-git-send-email-stigge@antcom.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 12/02/12 21:09, Roland Stigge wrote:
> This patch adds a 3-channel ADC driver for the LPC32xx ARM SoC
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

This patch applies cleanly to arm-soc.git/for-next, since it builds upon
fixes for LPC32xx in Linux 3.3.

Anyway, I already integrated the very useful suggestions for IIO by
Kevin Wells and Jonathan Cameron.

Thanks,

Roland
