Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENSoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 May 2018 14:44:06 -0400
Date: Mon, 14 May 2018 19:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: RFC: Drop the adis16060 gyro driver from staging.
Message-ID: <20180514194401.2ce52589@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

This part uses a strange double chip select which is really tricky to support
properly.  It could be done, but it's a lot of work to support one odd device.

Given the device is now 'not for new designs' I instead propose to simply
drop it from staging.

Does anyone mind / have the hardware to test if we try to add the support
nicely?

Thanks,

Jonathan
