Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46574 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab3H2UAR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 16:00:17 -0400
Message-ID: <521FB660.8010607@kernel.org>
Date: Thu, 29 Aug 2013 22:00:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Josh Wu <josh.wu@atmel.com>, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v3 4/6] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com> <1377602932-1899-5-git-send-email-josh.wu@atmel.com> <20130828090354.GP2695@lukather>
In-Reply-To: <20130828090354.GP2695@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/28/13 10:03, Maxime Ripard wrote:
> Hi Josh,
> 
> On Tue, Aug 27, 2013 at 07:28:50PM +0800, Josh Wu wrote:
>> Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed. This patch can choose different
>> start up time calculation formula for different chips.
>> 
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
Unfortunately this one has a dependency on the fix patch which is going in through
my fixes branch so will have to wait until that hits my upstream.

I'd like 5 and 6 to sit a while longer anyway (and 6 needs Dmitry's sign off before
I take that.)

Thanks for these,

Jonathan
