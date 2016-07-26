Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34650 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204AbcGZWt1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 18:49:27 -0400
Received: by mail-yw0-f195.google.com with SMTP id j12so2551622ywb.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2016 15:49:26 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:49:19 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: lkp@lists.01.org
Cc: linux-iio@vger.kernel.org
Subject: drivers/iio & kbuild test robot
Message-ID: <20160726224911.GA16097@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Fengguang,

I recently submitted a patch that adds Kconfig options required
to build a few drivers in IIO.  The kbuild robot did not find
these. 

You can see the patch here:
http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg-post-rc1&id=9b1425b1698cca01887ad154b631b59666882fb5

I'd like to get a general understanding of the build testing the robot
provides the iio subsystem, and then specifically see if these types of test
cases can be added.

I'm up for digging into this if you'll point me in the right direction.

First off, I hope this is the correct email list - lkp@list.01.org
I didn't want to get lost in all the robo messages in kbuild-all.

Thanks,
alisons

