Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:30853 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614Ab2CZPjB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Mar 2012 11:39:01 -0400
From: Stefan Roese <sr@denx.de>
To: lm-sensors@lm-sensors.org
Subject: Location for ADC driver
Date: Mon, 26 Mar 2012 17:33:38 +0200
Cc: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201203261733.38794.sr@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'll start porting a driver for the ST SPEAr600 SoC internal ADC in a short 
while. First I thought it would be located in drivers/hwmon with its 
infrastructure. Then I noticed the drivers/staging/iio/adc directory.

So my question is, where should such an SoC internal ADC driver best be 
placed? hwmon or iio/adc? Or can I choose freely?

Thanks,
Stefan
