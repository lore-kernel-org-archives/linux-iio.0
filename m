Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:61742 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbbJRMxH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 18 Oct 2015 08:53:07 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx002) with ESMTPSA (Nemesis) id 0Ln897-1aUGoX0TsL-00hK97 for
 <linux-iio@vger.kernel.org>; Sun, 18 Oct 2015 14:53:04 +0200
To: linux-iio@vger.kernel.org
From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: iio_interrupt_trigger
Message-ID: <5623962F.6040105@gmx.net>
Date: Sun, 18 Oct 2015 14:53:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

I'm trying to set on a IMX6 SoC (wandboard) a PWM to use as a 
'iio_interrupt_trigger' source.
I can't figure out how to assign the pwm to the 'iio_interrupt_trigger' 
module in the device tree source.
(The pwm an the iio adc device when sysfs triggered is working fine)

Any suggestions?

Thanks
     Matthias


