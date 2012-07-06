Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51158 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab2GFN0E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jul 2012 09:26:04 -0400
Message-ID: <4FF6E766.7000503@cam.ac.uk>
Date: Fri, 06 Jul 2012 14:25:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: anish singh <anish198519851985@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: adc-jack-driver opinion related to IIO
References: <CAK7N6voPsDGJLoh71Kgcz=bnWDE4QYmXjOrMv0x+bN7RTCHF3g@mail.gmail.com>
In-Reply-To: <CAK7N6voPsDGJLoh71Kgcz=bnWDE4QYmXjOrMv0x+bN7RTCHF3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 7/6/2012 1:00 PM, anish singh wrote:
> Hello Jonathan,
>
> I would be extremely happy if I can get your opinion on this.
>
> Recently Myungjoo Ham had posted Extcon: adc-jack driver patch.
>
> Description of this driver:
> This is basically a Headset(jack) driver.Once the headset is inserted
> a irq_handler is called and in this handler we have a callback(this
> callback calls into pmic driver to get the adc value) to get
> the adc value to determine the kind of headset: This headset could
> be headset with mic, headset without mic or headset with
> keys(volume-up/down) attached to it.One we have found out the kind
> of headset we use extcon framework to notify the other interested drivers or
> userspace that a headset with so and so capabilities has been inserted.
>
> Question:
> Does this driver fall into IIO as pointed by Mark Brown in his review comments?
The driver itself probably doesn't, but the adc part does in that IIO
provides a means of talking to the relevant adc.
>
> Why do we need to use IIO to get the adc value?As for different boards the
> method of getting adc is different.How does IIO help in this?
Ultimately, IIO in this case is acting as an infrastructure for ALL 
adcs. E.g. for different boards you'll need a mapping to tell it which
adc channel is connected but that is it.  Hence you don't need a 
specific callback for each pmic as you will be using generic interfaces 
to query it.

Jonathan
