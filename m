Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47656 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759632Ab2EKNgH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 09:36:07 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, jic23@kernel.org, nicolas.ferre@atmel.com
Subject: [PATCHv5] Add ADC driver for Atmel G20, G45 and X5 boards
Date: Fri, 11 May 2012 15:35:31 +0200
Message-Id: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Here is a patchset adding an IIO driver for various Atmel SoCs.
As it relies on out-of-staging-IIO, which is still in staging-next, it
seems that you should be the one merging it.

As you can see, it got an acked-by all the maintainers involved in this
patch, so it should be pretty good for inclusion.

Thanks,
Maxime

