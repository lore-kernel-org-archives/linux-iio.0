Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56401 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab1LNUt0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 15:49:26 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] staging:iio: trigger owner field confusion cleanup.
Date: Wed, 14 Dec 2011 20:49:29 +0000
Message-Id: <1323895771-9940-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Lifting from original posting...

This issue came to my attention whilst reviewing Maximes at91 patches.
Anyhow, we have iio_trigger->owner and iio_trigger->ops->owner.

The first was meant to have gone away.
A couple of drivers don't provide iio_trigger->ops causing nastiness
to happen when the trigger get or put occurs. Not seen in the wild
as I don't have either of the two devices in question.

Simple fix.  Add the struture where missing and get rid of the owner field
from the iio_trigger structure.

Thanks,

Jonathan

Jonathan Cameron (2):
  staging:iio: Make sure all triggers have a trigger_ops for the owner
    field.
  staging:iio: iio_trigger contains defunct owner field. Remove it.

 drivers/staging/iio/adc/ad7192.c                   |    7 +++++--
 drivers/staging/iio/adc/ad7793.c                   |    6 +++++-
 drivers/staging/iio/trigger.h                      |    2 --
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    1 -
 4 files changed, 10 insertions(+), 6 deletions(-)

-- 
1.7.7.4

