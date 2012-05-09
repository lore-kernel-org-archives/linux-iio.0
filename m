Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47131 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2EINCb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 09:02:31 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, grant.likely@secretlab.ca
Subject: [PATCHv4] Add ADC driver for Atmel G20, G45 and X5 boards
Date: Wed,  9 May 2012 15:01:59 +0200
Message-Id: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Here is another round of ADC patches based on reviews from Nicolas Ferre.
Nothing really fancy here, mostly changed the compatible string to at91sam9260
since the g20 and the 9260 both share the same ADC, and various small fixes,
typos, etc.

Thanks,
Maxime

