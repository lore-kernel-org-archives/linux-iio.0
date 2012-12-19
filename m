Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:57461 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342Ab2LSSxT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Dec 2012 13:53:19 -0500
Received: from mail644.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 621C7108414E
	for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2012 19:43:00 +0100 (CET)
Date: Wed, 19 Dec 2012 19:32:36 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 0/3] IIO: AT91: add lowres, sleep and sample&hold time
 missing support
Message-ID: <20121219183236.GP23971@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

	The current adc driver is missing some key feature support
	 - select high/low resolution support
	 - sleep mode
	 - Sample and Hold Time

	 This patch seris fix it
	 Without it the current driver is not usable in most of the case

Jean-Christophe PLAGNIOL-VILLARD (2):
      ARM: AT91: IIO: add sleep mode support
      ARM: AT91: IIO: fix missing Sample and Hold time

Ludovic Desroches (1):
      ARM: AT91: IIO: add low and high res support for adc

 Documentation/devicetree/bindings/arm/atmel-adc.txt |   13 ++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                  |    3 +++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |    3 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                   |    3 +++
 drivers/iio/adc/at91_adc.c                          |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 107 insertions(+), 5 deletions(-)

Best Regards,
J.
