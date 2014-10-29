Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f201.google.com ([209.85.192.201]:44830 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbaJ2WBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 18:01:51 -0400
Received: by mail-pd0-f201.google.com with SMTP id r10so710553pdi.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2014 15:01:50 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: srinivas.pandruvada@linux.intel.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/1] iio: ak8975: Add AKM0991x support.
Date: Wed, 29 Oct 2014 15:01:36 -0700
Message-Id: <1414620097-6787-1-git-send-email-gwendal@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

AK09912 is an accelerometer with the same register set as AK09911, but
same behavior as AK8973, so I was not sure where to add the support.
I decided to merge all AKM magnetometer support in the same file while
being as clean as I could.

