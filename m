Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41243 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbaCRIDB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Mar 2014 04:03:01 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so5493192wgg.6
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2014 01:02:59 -0700 (PDT)
Date: Tue, 18 Mar 2014 08:02:55 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>,
	Marek Belisko <marek@goldelico.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCHv4 7/7] mfd: twl4030-madc: Move driver to drivers/iio/adc
Message-ID: <20140318080255.GG25324@lee--X1>
References: <1394934211-21605-1-git-send-email-sre@debian.org>
 <1394934211-21605-8-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1394934211-21605-8-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> This is a driver for an A/D converter, which belongs into
> drivers/iio/adc.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/Kconfig                 | 10 ++++++++++
>  drivers/iio/adc/Makefile                |  1 +
>  drivers/{mfd => iio/adc}/twl4030-madc.c |  0
>  drivers/mfd/Kconfig                     | 10 ----------
>  drivers/mfd/Makefile                    |  1 -
>  5 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/{mfd => iio/adc}/twl4030-madc.c (100%)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
