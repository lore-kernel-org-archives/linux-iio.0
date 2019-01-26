Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B4C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A6A2184C
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfAZR6O (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:58:14 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59922 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAZR6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 12:58:14 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4DA8D9E76FE;
        Sat, 26 Jan 2019 17:58:11 +0000 (GMT)
Date:   Sat, 26 Jan 2019 17:58:10 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: imx25 ADC values wrong after sporadic time
Message-ID: <20190126175810.2b6f8058@archlinux>
In-Reply-To: <OF76C145E1.65F3BD5B-ONC125838C.00390E6F-C125838C.003B6395@rittal.de>
References: <OF76C145E1.65F3BD5B-ONC125838C.00390E6F-C125838C.003B6395@rittal.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jan 2019 11:48:43 +0100 (CET)
Benjamin Beckmeyer <beckmeyer.b@rittal.de> wrote:

> Hey all,
> 
> I have a problem with a i.MX25 device and the ADC in special. The ADC
> is already a kernel module (to reload it when the error occurs) and
> it all works fine. Then suddenly the ADC delivers wrong values and
> even a reload of the kernel module doesn't fix it.
> 
> The interesting part of it: It's so sporadic that the devices in our
> company never show the problem it's only at our customer devices. And
> even there some devices run for 2 month and other for only some hours.
> 
> I got a dmesg output from a customer(where the error is now present)
> the last line is the only interesting part I think, at least for the
> ADC.
> 

> [467450.903249] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
> [613458.872789] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5bec3543 reg = 0x00000000
> [2974587.954034] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5c103c70 reg = 0x00000000
> [3149932.971010] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x5c12e961 reg = 0x00000000
> [4212751.737165] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
> [4648608.098370] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
> [5089481.865850] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
> [5609097.665957] imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x00000000 reg = 0x00000004
> [6126834.383266] iio iio:device0: ADC wait for measurement failed
> 

> So there is a timeout, where the driver was waiting for an interrupt to
> be finished, when I'm right.
> 
> The message never pops up again and the ADC values will be read all 200ms or so.
> 
> So my thinking is that this has something to do with my error. But the other 
> messages before the ADC message had the same issue with a timeout with a 
> similar function. So maybe there is a problem somewhere deeper? 
> 
> I'm running linux kernel 4.14.95 at the moment. And at that point I'm not able
> to reproduce the error, just that friendly customer help us. 
> 
> What I can say is that there was the earlier kernel version 3.7.2 with a custom
> kernel driver module for this ADC which was working fine over years and still is. 
> But with me there came the current kernel to the device and I wanted to use the
> existing linux driver. 
> 
> What I have changed at this point is that the driver is running in POWER MODE 
> instead of POWER SAVE MODE. 
> 
> I'm sure the driver is working properly, but then after a unknown time it 
> suddenly starts to give wrong values back. First when it runs properly it 
> gives back some values close to the max values of 4095 and the suddenly
> almost 0 but not only 0.
> 
> So do any of you guys have an idea what we can do about it? Or maybe how we
> can get closer to the problem. Any help would be appreciated. In the next
> days I wanted to see if the rtc of the device is running properly because
> of the dmesg output. Maybe that could bring me to a more deeper problem
> about the interrupt controller. But this is only guesswork.

Obviously I'm guessing just as much as you are.

I would first check to see if the interrupt fired at all in the case
where the timeout occurred.  The completion only fires if we have
a flag set in the status register.  Add an else to that block see
if we get interrupts where it isn't set.  For example if we are
getting spurious interrupts from somewhere occasionally we might
get a race in there as it clears all the irq sources, not just the
ones we have actually handled (which is dubious as there is defintely
a race in there if any of the others are firing).
You could cynically add a spinning loop of some type to waste time
in that race period and see if you can open the window up to replicate
on your system.

I don't have one of these, but perhaps try on your 'good' system
with just clearing the SR_E0Q interrupt and it may give us some insight
into why the others are being cleared.

Note that if we don't find an expected interrupt (and there isn't
a weird hardware bug that needs working around) then we should
return IRQ_NONE to let the kernel spurious interrupt handling kick
in correctly.

Otherwise, I would indeed look at the interrupt controller driver.
Might be something dubious in there.  Of course the RTC error
could be something entirely different.

Of course the usual issues of power brownout and similar might
also be going on.  The delights of systems at customers working
differently than the ones you have!

Jonathan
> 
> Best Regards,
> 
> Benjamin Beckmeyer

