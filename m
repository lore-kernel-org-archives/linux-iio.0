Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:58157 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2LTKs4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Dec 2012 05:48:56 -0500
Message-ID: <50D2EB04.9080804@free-electrons.com>
Date: Thu, 20 Dec 2012 11:40:04 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 0/3] IIO: AT91: add lowres, sleep and sample&hold time
 missing support
References: <20121219183236.GP23971@game.jcrosoft.org>
In-Reply-To: <20121219183236.GP23971@game.jcrosoft.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Le 19/12/2012 19:32, Jean-Christophe PLAGNIOL-VILLARD a écrit :
> Hi,
> 
> 	The current adc driver is missing some key feature support
> 	 - select high/low resolution support
> 	 - sleep mode
> 	 - Sample and Hold Time
> 
> 	 This patch seris fix it
> 	 Without it the current driver is not usable in most of the case

Could you put me in Cc for the next iterations please?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
