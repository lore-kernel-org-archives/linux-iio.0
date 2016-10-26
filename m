Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47896 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbcJZRi1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Oct 2016 13:38:27 -0400
Received: from localhost (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 8F4A038D
        for <linux-iio@vger.kernel.org>; Wed, 26 Oct 2016 17:38:25 +0000 (UTC)
Date: Wed, 26 Oct 2016 13:38:25 -0400
From: Brian Masney <masneyb@onstation.org>
To: linux-iio@vger.kernel.org
Subject: Question about submitting patch set against staging/iio/light/tsl2583
Message-ID: <20161026173825.GA21767@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Part of the tsl2583 driver cleanup that I am working on involves adding
device tree support to that driver. Based on the isl29018 driver cleanups
that I did, I now know that the device tree maintainers should be CCed for
any device tree changes. What is the appropriate way to submit my patch
set that spans two different subsystems? Should I submit my lone device
tree patch to linux-iio and CC the device tree maintainers? Then submit
the rest of my patch set to just the linux-iio maintainers? Or should I
CC the device tree maintainers with my entire patch set? I'm leaning
towards the separate approach to reduce the amount of noise to the
device tree list.

Brian

