Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47834 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaLZV5X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 16:57:23 -0500
Message-ID: <549DD9C0.3020100@kernel.org>
Date: Fri, 26 Dec 2014 21:57:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: kristina.martsenko@gmail.com, kernel@pengutronix.de,
	pawel.moll@arm.com, knaack.h@gmx.de, ijc+devicetree@hellion.org.uk,
	robh+dt@kernel.org, galak@codeaurora.org, festevam@gmail.com,
	mark.rutland@arm.com, linux-iio@vger.kernel.org, marex@denx.de,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mxs-lradc: check ranges of ts properties
References: <1419250476-2393-1-git-send-email-stefan.wahren@i2se.com> <1419250476-2393-3-git-send-email-stefan.wahren@i2se.com> <549D2905.4050801@kernel.org> <1377154085.658607.1419627037868.JavaMail.open-xchange@oxbaltgw05.schlund.de>
In-Reply-To: <1377154085.658607.1419627037868.JavaMail.open-xchange@oxbaltgw05.schlund.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/12/14 20:50, Stefan Wahren wrote:
> Hi Jonathan,
> 
>> Jonathan Cameron <jic23@kernel.org> hat am 26. Dezember 2014 um 10:23
>> geschrieben:
>>
>> [...]
>>>
>>> - lradc->over_sample_delay = 2;
>>> - ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
>>> - if (ret == 0)
>>> + if (of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt)) {
>>> + lradc->over_sample_delay = 2;
>>> + } else {
>>> + if (adapt < 2 || adapt > LRADC_DELAY_DELAY_MASK+1) {
>> please run checkpatch.pl over these. Should be spaces around the +
> 
> i'm afraid my checkpatch.pl doesn't find this issue. I'll fix it in the next
> version.
> 
So it doesn't!  Sorry about the false comment.

Hmm. I wonder why...

