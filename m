Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34521 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992958AbdD3XRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 19:17:15 -0400
Received: by mail-qk0-f173.google.com with SMTP id y63so86187689qkd.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Apr 2017 16:17:15 -0700 (PDT)
From: Quentin Swain <dudebrobro179@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com
Subject: Fix permissions warning from check-patch for tsl2x7x
Date: Sun, 30 Apr 2017 19:16:57 -0400
Message-Id: <20170430231702.377-1-dudebrobro179@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the use of symbolic permissions macros, S_IRUGO and S_IWUSR,
with octal permissons to resolve errors reported by checkpatch.pl.
checkpatch.pl still reports errors for use of decimal permissions in a
handful of cases where the macros were replaced with the octal in
ad9834 and ade7753. It seemed like those reports may be false positives
since this happens for a fraction of the changes that were made in those
files.

Thanks,
Quentin

