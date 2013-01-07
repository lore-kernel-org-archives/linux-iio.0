Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:39515 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab3AGJUR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jan 2013 04:20:17 -0500
Message-ID: <50EA9344.8060002@free-electrons.com>
Date: Mon, 07 Jan 2013 10:20:04 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: "ludovic.desroches" <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for
 adc
References: <20121219183236.GP23971@game.jcrosoft.org> <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com> <50D2EBA1.4050305@free-electrons.com> <50D2EDE6.3090706@atmel.com> <50D3340F.3090209@free-electrons.com> <50D33940.4000607@atmel.com> <50D426C1.5050807@free-electrons.com> <20121222172133.GT23971@game.jcrosoft.org>
In-Reply-To: <20121222172133.GT23971@game.jcrosoft.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 22/12/2012 18:21, Jean-Christophe PLAGNIOL-VILLARD a écrit :
> On 10:07 Fri 21 Dec     , Maxime Ripard wrote:
>> Le 20/12/2012 17:13, ludovic.desroches a écrit :
>>> I have not found other ways to deal with it properly. I would like to
>>> have them hidden into the driver (depending on the compatible string)
>>> but it will be a mess if we split parameters into dt and driver.
>>
>> I'm glad we feel the same way :)
> I'm not I fee; exactly this opposte way
> 
> I do want to toucht the kernel code to add new soc

This is an argument we already had, and yes, I still don't like these
bindings.

And both this patchset and what Ludovic and you said in this thread have
proven that this is something that can't be achieved, you'll always have
to modify the driver anyway.

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
