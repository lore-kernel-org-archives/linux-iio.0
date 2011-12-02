Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:35868 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab1LBPf2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2011 10:35:28 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [RFC] IIO: Add hardware triggers support to the AT91 ADC driver
Date: Fri,  2 Dec 2011 16:34:59 +0100
Message-Id: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi list,

here is a patchset that adds the hardware triggers support to the at91_adc
driver that only supported software triggers so far.

Please note that this is NOT for inclusion, only for review for now, as there is
no support for buffers and triggers out of staging out of staging, and the first
patches only duplicate the at91_adc driver I submitted out of staging.

So basically, the important patches at the 4th and 5th.

The fourth rework the way I declared the platform_data, in a more DT-compliant
way. I needed it for the available triggers declaration. I will surely backport
this part soon to the out-of-staging driver, because it will certainly be useful
to it.

The fifth one adds the triggers and buffers support to the driver in itself.
While the whole dynamic triggers declaration might seem overkill for now as I
only support the sam9g20-ek board, support for other atmel boards will come soon
and I surely need that in place.
On the downside, it probably needs some more work. Jonathan suggested earlier
that kfifo is a more convenient backend for the buffer, so I might switch to it
in the future. Also, I have not been able to test the timer counters triggers,
only the external for now.

This patchset is based on the commit 3413ec44 from Jonathan's master tree.

So please, take a look.
Thanks,
Maxime

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

