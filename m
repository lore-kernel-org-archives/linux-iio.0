Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43877 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1K1M3I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 07:29:08 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: [PATCH v10] AT91: Add a driver for the ADC
Date: Mon, 28 Nov 2011 13:28:44 +0100
Message-Id: <1322483326-25570-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This is a new version of the ADC driver for AT91. I dropped the first patch
adding platform data from the patchset since Nicolas Ferre already included it
in his tree, and it didn't change from the v9 to the v10 anyway.

So, basically, in this version, the only thing that changed is that the driver
name is no longer at91adc but at91_adc. So there should be no functionnal
difference between the v9 and the v10, only s/at91adc/at91_adc/.

Regards,
Maxime

