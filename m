Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61761 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaCRIA3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Mar 2014 04:00:29 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi5so3267591wib.5
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2014 01:00:27 -0700 (PDT)
Date: Tue, 18 Mar 2014 08:00:23 +0000
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
Subject: Re: [PATCHv4 2/7] mfd: twl4030-madc: Add DT support and convert to
 IIO framework
Message-ID: <20140318080023.GB25324@lee--X1>
References: <1394934211-21605-1-git-send-email-sre@debian.org>
 <1394934211-21605-3-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1394934211-21605-3-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> This converts twl4030-madc module to use the Industrial IO ADC
> framework and adds device tree support.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Tested-by: Marek Belisko <marek@goldelico.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/mfd/twl4030-madc.c | 127 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 116 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
