Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45274 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792Ab2EIJGk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:06:40 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
Date: Wed,  9 May 2012 11:05:57 +0200
Message-Id: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Here is another version of the patches to bring ADC driver to Atmel boards.
Since last version, here is what changed:
  * Rebased on top of staging-next to move out of staging. Had to change to IIO
    kfifo buffer along the way.
  * Reworked the DT bindings according to Jean-Christophe reviews
  * Made various fixes according to reviews
  * Support for X5 boards

Thanks,
Maxime

