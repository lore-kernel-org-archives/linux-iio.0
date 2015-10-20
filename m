Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:56778 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbbJTQAn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Oct 2015 12:00:43 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0M96Jd-1Zh74v3bB7-00CPVQ for
 <linux-iio@vger.kernel.org>; Tue, 20 Oct 2015 18:00:41 +0200
From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Re: iio_interrupt_trigger
To: linux-iio@vger.kernel.org
References: <5623962F.6040105@gmx.net> <5624BB59.20003@metafoo.de>
Message-ID: <56266527.1030705@gmx.net>
Date: Tue, 20 Oct 2015 18:00:39 +0200
MIME-Version: 1.0
In-Reply-To: <5624BB59.20003@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> The problem is that you can't really instantiate the
iio-interrupt-trigger
> from the devicetree. IIO is a software concept, there is no hardware
> associated with it that you could describe in the devicetree.

I managed to execute the 'iio_interrupt_trigger' ISR by executing 
'generic_handle_irq(intnr)' out of my PWM ISR - it works but its ugly.

For 'intnr' I used a gpio interrupt number on which I registerd the 
platform data for 'iio_interrupt_trigger' inside the 'pwm-imx' driver.

I also tried to share the same intnr for 'iio_interrupt_trigger' and the 
pwm but this did not work.

Is it possible to get a software INT Nr somehow istead of a gpio interrupt?

Btw:
generic_buffer from 4.1.y
	works well on 4.1.y and 4.2.y kernel,

whereas generic_buffer from 4.2.y and v4.3-rc6
	gives following error on a 4.2.y

"Problem reading scan element information
      diag /sys/bus/iio/devices/iio:device0
"

thx Matthias

