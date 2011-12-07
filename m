Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41929 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab1LGS0D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2011 13:26:03 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [RFC v2] IIO: Add hardware triggers support to the AT91 ADC driver
Date: Wed,  7 Dec 2011 19:25:34 +0100
Message-Id: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This is a follow-up of the previous patchset about hardware triggers for the
ADC on AT91.

This is still not for inclusion, as it relies on a duplication of !staging code.
But basically, I'm submitting it for review and be sure I do everything right.
Moreover, it will save some iterations when the time for it to be included will
come.

I should have addressed all the points made by Jonathan in the v1, but here is
what changed:
  - Fix the timestamp declaration. scan_timestamp was set to true, but no
channel was declared for it. It is obviously wrong.
  - Rebased on brand new patches, instead of outdated branch. This patch now
requires the buffer clean ups and scan demux unit patchsets from Jonathan and
the brand new wrapper functions introduced by Lars Peter.
  - Renamed the triggers to be more explicit
  - Lot of small fixes and improvements: use ALIGN, change the location of
IRQ acknowledgements, etc.
  - Added comments, switched to kernel doc for the structure declarations
  - split the cosmetic changes into a new commit

Thanks,
Maxime

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


