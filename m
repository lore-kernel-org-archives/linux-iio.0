Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59443 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaBZIPn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2014 03:15:43 -0500
Received: by mail-wg0-f41.google.com with SMTP id l18so1348411wgh.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2014 00:15:42 -0800 (PST)
Date: Wed, 26 Feb 2014 08:15:35 +0000
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
Subject: Re: [RFCv3 4/7] mfd: twl-core: Add twl_i2c_read/write_u16
Message-ID: <20140226081535.GG9195@lee--X1>
References: <1393193271-16717-1-git-send-email-sre@debian.org>
 <1393374270-20079-1-git-send-email-sre@debian.org>
 <1393374270-20079-5-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1393374270-20079-5-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Add a simple twl_i2c_read/write_u16 wrapper over
> the twl_i2c_read/write, which is similar to the
> twl_i2c_read/write_u8 wrapper.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  include/linux/i2c/twl.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
