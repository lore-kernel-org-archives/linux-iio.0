Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1152 "EHLO
	smtp-out-084.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbcCGUK7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2016 15:10:59 -0500
Subject: Re: [PATCH v2 2/2] iio:adc:at91-sama5d2: add support for signed
 conversion
To: Ludovic Desroches <ludovic.desroches@atmel.com>, jic23@kernel.org
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
 <1457360997-29179-3-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56DDDEBF.30905@metafoo.de>
Date: Mon, 7 Mar 2016 21:04:15 +0100
MIME-Version: 1.0
In-Reply-To: <1457360997-29179-3-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/2016 03:29 PM, Ludovic Desroches wrote:
> The at91-sama5d2 ADC controller can achieve unsigned and signed
> conversions. For each channel, a signed and an unsigned variant are
> created.
> Sign mode is a global configuration, it is not tied to a specific
> channel. For this reason, the controller has to be configured upon
> conversion request.

So, what's the difference between signed and unsigned mode?
