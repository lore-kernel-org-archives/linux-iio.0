Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43169 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbaCRIBA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Mar 2014 04:01:00 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so5680276wgg.9
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2014 01:00:59 -0700 (PDT)
Date: Tue, 18 Mar 2014 08:00:55 +0000
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
Subject: Re: [PATCHv4 3/7] mfd: twl4030-madc: Cleanup driver
Message-ID: <20140318080055.GC25324@lee--X1>
References: <1394934211-21605-1-git-send-email-sre@debian.org>
 <1394934211-21605-4-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1394934211-21605-4-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Some style fixes in twl4030-madc driver.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Tested-by: Marek Belisko <marek@goldelico.com>
> ---
>  drivers/mfd/twl4030-madc.c       | 145 +++++++++++++++++++--------------------
>  include/linux/i2c/twl4030-madc.h |   2 +-
>  2 files changed, 73 insertions(+), 74 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
