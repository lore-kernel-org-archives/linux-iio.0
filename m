Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41754 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbAIF73 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jan 2015 00:59:29 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so16412917pac.11
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2015 21:59:28 -0800 (PST)
Received: from [10.18.0.121] ([115.115.225.206])
        by mx.google.com with ESMTPSA id gi6sm5882181pbd.93.2015.01.08.21.59.25
        for <linux-iio@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2015 21:59:27 -0800 (PST)
Message-ID: <54AF6DFA.7040204@gmail.com>
Date: Fri, 09 Jan 2015 11:28:18 +0530
From: Sanchayan Maity <maitysanchayan@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Query regarding a IIO consumer touchscreen driver
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I have been working on a IIO consumer touchscreen driver. On one of our Vybrid modules we use the ADC channels for
the touchscreen. I ported an earlier driver in the 3.0 kernel done by my colleague to the recent 3.18/19 kernel to
use the IIO based consumer interface.

The touchscreen driver is here
http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/input/touchscreen/colibri-vf50-ts.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5

The ADC driver with which it interacts is here
http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/iio/adc/vf610_adc.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5

Currently, this works in a limited capaicty I would say. One of the problems I have with this driver is that when
this driver is used I can't get valid readings for any of the other ADC channels by using something like "cat". I
believe this is because of the fact that the workqueue runs a while loop every 10ms and reads the channels. This
clearly does not play well with reading of other channels and results in random reads on trying to read other channels,
for example the temperature channel. The exact reason I have not figured out here. I was thinking may be a device
lock would be required, but, that doesn't help.

The workqueue function
http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/input/touchscreen/colibri-vf50-ts.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5#n102

The primary read raw function
http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/iio/adc/vf610_adc.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5#n449

I was thinking this would need a better design than what has been done? Can someone give some suggestions as what
would be the right design/architecture here. I was thinking if setting up a IIO ring buffer, pushing the readings
to it and then reading from the touchscreen driver would work. One of the aims is also to make it clean enough for
eventual submission to the mainline. 

Thanks & Regards,
Sanchayan Maity.
