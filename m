Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:38647 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab2LUJJO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Dec 2012 04:09:14 -0500
Message-ID: <50D4272A.1080702@free-electrons.com>
Date: Fri, 21 Dec 2012 10:08:58 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 3/3] ARM: AT91: IIO: fix missing Sample and Hold time
References: <20121219183236.GP23971@game.jcrosoft.org> <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com> <1355942232-26251-3-git-send-email-plagnioj@jcrosoft.com> <50D2EEA0.8040807@free-electrons.com> <20121220124909.GR23971@game.jcrosoft.org>
In-Reply-To: <20121220124909.GR23971@game.jcrosoft.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 20/12/2012 13:49, Jean-Christophe PLAGNIOL-VILLARD a écrit :
> On 11:55 Thu 20 Dec     , Maxime Ripard wrote:
>> Since, from all the datasheet I have (G20, G45 and X5), the minimum time
>> is always 500ns, do we really need to add a dt property for that?
> you must this is hardware specific it depend on the line capacity

Ok, I see. The comment about adding the unit in the documentation is
still valid though.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
