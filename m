Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:32795 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2JSIyw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 04:54:52 -0400
Message-ID: <50811553.9060800@free-electrons.com>
Date: Fri, 19 Oct 2012 10:54:43 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: at91_adc: Use devm_kcalloc to allocate arrays
References: <1350571399-17723-1-git-send-email-lars@metafoo.de> <1350571399-17723-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 18/10/2012 16:43, Lars-Peter Clausen a écrit :
> Use dev_kcalloc instead of devm_kzalloc to allocate arrays since it is
> semantically more appropriate.
> 
> While we are at it the patch also fixes the following coccinelle warning:
> 	drivers/iio/adc/at91_adc.c:277:25-31: ERROR: application of sizeof to pointer
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-By: Maxime Ripard <maxime.ripard@free-electrons.com>


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
