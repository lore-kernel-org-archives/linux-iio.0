Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47213 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaI3MAO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Sep 2014 08:00:14 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so7475308pad.25
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2014 05:00:13 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v3 0/4] Correct vendor-prefix and document device isl29028
Date: Tue, 30 Sep 2014 17:29:04 +0530
Message-Id: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Patchset documents correct and the deprecated vendor-prefix found by checkpatch 
warning and also documents information of device isl29028 for compatibility. 
Patchset also includes corrected vendor-prefix and device name in compatible 
property for files with checkpatch warning of undocumented string "isil,isl29028".

Darshana Padmadas (4):
  Documentation: devicetree: bindings: Document correct and deprecated
    vendor-prefix with device isl29028
  Documentation: devicetree: bindings: Document deprecated device vendor
    name to fix related warning
  Staging: iio: light: Added correct vendor-prefix for device isl29028
  arch: arm: boot: dts: Added correct vendor-prefix with device name to
    compatible property
  
Changes in v3:
    - In PATCH 1/4 corrected alphabetical order of vendor-prefix and device name.
    - In PATCH 2/4 inserted deprecated vendor-prefix in list in alphabetical order
      and edited vendor/chip string.
    - In PATCH 4/4 dropped deprecated string "isil,isl29028" and included correct 
      vendor-prefix isl with isl29028 to give "isl,isl29028" for device's compatible
      property.

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
 drivers/staging/iio/light/isl29028.c                      | 3 ++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.9.1

