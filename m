Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46464 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab3H2Tub (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 15:50:31 -0400
Message-ID: <521FB417.4000005@kernel.org>
Date: Thu, 29 Aug 2013 21:50:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Josh Wu <josh.wu@atmel.com>, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	plagnioj@jcrosoft.com, nicolas.ferre@atmel.com,
	thomas.petazzoni@free-electrons.com, mark.rutland@arm.com,
	b.brezillon@overkiz.com
Subject: Re: [PATCH v3 3/6] iio: at91: Use different prescal, startup mask
 in MR for different IP
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com> <1377602932-1899-4-git-send-email-josh.wu@atmel.com> <20130828085631.GO2695@lukather>
In-Reply-To: <20130828085631.GO2695@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/28/13 09:56, Maxime Ripard wrote:
> Hi Josh,
> 
> 
> On Tue, Aug 27, 2013 at 07:28:49PM +0800, Josh Wu wrote:
>> For at91 boards, there are different IPs for adc. Different IPs has different
>> STARTUP & PRESCAL mask in ADC_MR.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> It looks fine.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Maxime
> 
Note there was some fuzz with this one (because of taking the fix
via the other branch I would guess).  Hence please sanity check
it is fine when you have a minute.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
