Return-Path: <SRS0=9Qm3=QA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437BC282C3
	for <linux-iio@archiver.kernel.org>; Thu, 24 Jan 2019 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD6D21872
	for <linux-iio@archiver.kernel.org>; Thu, 24 Jan 2019 11:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfAXLRb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:17:31 -0500
Received: from mailgw04.loh-group.com ([195.226.74.53]:58796 "EHLO
        mailgw04.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAXLRb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jan 2019 06:17:31 -0500
X-Greylist: delayed 1724 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 06:17:29 EST
Received: from mailgw04.loh-group.com (mailgw04.loh-group.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A23CDFA3A
        for <linux-iio@vger.kernel.org>; Thu, 24 Jan 2019 11:48:43 +0100 (CET)
Received: from mailgw04.loh-group.com (mailgw04.loh-group.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66214DFA12
        for <linux-iio@vger.kernel.org>; Thu, 24 Jan 2019 11:48:43 +0100 (CET)
Received: from notesroot2.de.flg.int (rootserver2.de.flg.int [10.201.6.141])
        by mailgw04.loh-group.com (Postfix) with ESMTP
        for <linux-iio@vger.kernel.org>; Thu, 24 Jan 2019 11:48:43 +0100 (CET)
MIME-Version: 1.0
X-Disclaimed: 1
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: imx25 ADC values wrong after sporadic time
From:   Benjamin Beckmeyer <beckmeyer.b@rittal.de>
To:     linux-iio@vger.kernel.org
Message-ID: <OF76C145E1.65F3BD5B-ONC125838C.00390E6F-C125838C.003B6395@rittal.de>
X-Mailer: Lotus Domino Web Server Release 9.0.1FP6 April  20, 2016
X-MIMETrack: Serialize by http on herborn07/DE/FLG(Release 9.0.1FP6|April  20, 2016) at
 24.01.2019 11:48:41,
        Serialize complete at 24.01.2019 11:48:41,
        Itemize by http on herborn07/DE/FLG(Release 9.0.1FP6|April  20, 2016) at
 24.01.2019 11:48:41,
        Serialize by Router on rootserver2/FLG(Release 9.0.1FP6|April  20, 2016) at
 24.01.2019 11:48:43,
        Serialize complete at 24.01.2019 11:48:43
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
        charset=ISO-8859-1
Date:   Thu, 24 Jan 2019 11:48:43 +0100 (CET)
X-TM-AS-GCONF: 00
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey all,

I have a problem with a i.MX25 device and the ADC in special. The ADC is already a kernel module (to reload it when the error occurs) and it all works fine. Then suddenly the ADC delivers wrong values and even a reload of the kernel module doesn't fix it.

The interesting part of it: It's so sporadic that the devices in our company never show the problem it's only at our customer devices. And even there some devices run for 2 month and other for only some hours.

I got a dmesg output from a customer(where the error is now present) the last line is the only interesting part I think, at least for the ADC.

[467450.903249] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
[613458.872789] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5bec3543 reg = 0x00000000
[2974587.954034] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5c103c70 reg = 0x00000000
[3149932.971010] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5c12e961 reg = 0x00000000
[4212751.737165] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
[4648608.098370] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
[5089481.865850] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
[5609097.665957] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
[6126834.383266] iio iio:device0: ADC wait for measurement failed

So there is a timeout, where the driver was waiting for an interrupt to be finished, when I'm right.

The message never pops up again and the ADC values will be read all 200ms or so.

So my thinking is that this has something to do with my error. But the other messages before the ADC message had the same issue with a timeout with a similar function. So maybe there is a problem somewhere deeper? 

I'm running linux kernel 4.14.95 at the moment. And at that point I'm not able to reproduce the error, just that friendly customer help us. 

What I can say is that there was the earlier kernel version 3.7.2 with a custom kernel driver module for this ADC which was working fine over years and still is. But with me there came the current kernel to the device and I wanted to use the existing linux driver. 

What I have changed at this point is that the driver is running in POWER MODE instead of POWER SAVE MODE. 

I'm sure the driver is working properly, but then after a unknown time it suddenly starts to give wrong values back. First when it runs properly it gives back some values close to the max values of 4095 and the suddenly almost 0 but not only 0.

So do any of you guys have an idea what we can do about it? Or maybe how we can get closer to the problem. Any help would be appreciated. In the next days I wanted to see if the rtc of the device is running properly because of the dmesg output. Maybe that could bring me to a more deeper problem about the interrupt controller. But this is only guesswork.

Best Regards,

Benjamin Beckmeyer
