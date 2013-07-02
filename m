Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.105]:22694 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665Ab3GBK5Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 06:57:24 -0400
Message-ID: <51D2B057.9090005@digi.com>
Date: Tue, 2 Jul 2013 12:49:59 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
CC: Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Accessing specific hardware features of mxs-lradc
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Greetings,

The mxs-lradc has some hardware specific features like the DIVIDE_BY_TWO (an analog 
divide by two circuit that can be activated per channel).
This is not currently implemented in the driver and I was wondering what would be the 
way to expose and control such setting. A specific sysfs entry? Somehow through the 
device tree?

Is there any example of how to control a hw-specific feature in other similar iio drivers?

Best regards,
--
Hector Palacios
