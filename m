Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbcKYKOc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Nov 2016 05:14:32 -0500
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] more quirks for hid-sensor-hub
Date: Fri, 25 Nov 2016 11:03:42 +0100
Message-Id: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jiri,

here are 2 more quirks for the sensor-hub.

Srinivas, I am wondering if we can not detect those automatically.
Looking at the report_fixup, it looks like the buggy report descriptors have
a logical max of 5 (which would correspond to an enum of 0 to 5). But there
are 6 fields in the enum, so that means the report descriptor is just wrong.

Given that Microsoft's driver requires a min of 1, wouldn't it be too much
assumption to say that we need to fix the report descriptor anyway when we
see a range of 0..5 instead of 1..6?

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: sensor-hub add quirk for Microsoft Surface 3
  HID: sensor-hub: add quirk for Microchip MM7150

 drivers/hid/hid-sensor-hub.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.7.4

