Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:42038 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab1LGS3E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2011 13:29:04 -0500
Message-ID: <4EDFB067.1080306@free-electrons.com>
Date: Wed, 07 Dec 2011 19:28:55 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC v2] IIO: Add hardware triggers support to the AT91 ADC driver
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

HI,

I also have a question related to that.

The SAM9G20 has timer counters as trigger sources for the ADC. Is there
some kind of integration for them in IIO, or should we do the setup of
these counters outside of IIO ?

Thanks,
Maxime

On 07/12/2011 19:25, Maxime Ripard wrote:
> Hi all,
> 
> This is a follow-up of the previous patchset about hardware triggers for the
> ADC on AT91.
> 
> This is still not for inclusion, as it relies on a duplication of !staging code.
> But basically, I'm submitting it for review and be sure I do everything right.
> Moreover, it will save some iterations when the time for it to be included will
> come.
> 
> I should have addressed all the points made by Jonathan in the v1, but here is
> what changed:
>   - Fix the timestamp declaration. scan_timestamp was set to true, but no
> channel was declared for it. It is obviously wrong.
>   - Rebased on brand new patches, instead of outdated branch. This patch now
> requires the buffer clean ups and scan demux unit patchsets from Jonathan and
> the brand new wrapper functions introduced by Lars Peter.
>   - Renamed the triggers to be more explicit
>   - Lot of small fixes and improvements: use ALIGN, change the location of
> IRQ acknowledgements, etc.
>   - Added comments, switched to kernel doc for the structure declarations
>   - split the cosmetic changes into a new commit
> 
> Thanks,
> Maxime
> 
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
