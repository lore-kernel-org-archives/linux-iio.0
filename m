Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:44636 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933925AbcHDOBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 10:01:23 -0400
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH 0/2]  Use complete() instead of complete_all()
Date: Thu,  4 Aug 2016 15:07:08 +0200
Message-Id: <1470316030-4153-1-git-send-email-wagi@monom.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Using complete_all() is not wrong per se but it suggest that there
might be more than one reader. For -rt I am reviewing all
complete_all() users and would like to leave only the real ones in the
tree. The main problem for -rt about complete_all() is that it can be
uses inside IRQ context and that can lead to unbounded amount work
inside the interrupt handler. That is a no no for -rt.

The patches grouped per subsystem and in small batches to allow
reviewing. Unfortanatly I am not so good in coming up with unique
commit message, so please bear with me in that regard. I could also
squash them together, although each patch containts a very short
reasoning why there is only one waiter. Let me know what you rather
prefer. One patch which updates all complete_all() users or those 2
patches with some reasoning.

It is only test compiled because I don't have the all the hardware.

cheers,
daniel

Daniel Wagner (2):
  iio: adc: Use complete() instead of complete_all()
  iio: sx9500: Use complete() instead of complete_all()

 drivers/iio/adc/nau7802.c      | 2 +-
 drivers/iio/proximity/sx9500.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
