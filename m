Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:47936
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754654AbeDYRuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Apr 2018 13:50:10 -0400
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
From: Martin Kelly <mkelly@xevo.com>
Subject: Patch process question
Message-ID: <80821ad8-08fe-2a2a-ea2d-08db094dcf4b@xevo.com>
Date: Wed, 25 Apr 2018 10:49:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have a quick question regarding the patch submission process for IIO. 
Let's say I have a patch that I know will hit conflicts against other 
accepted patches that are in linux-iio testing and/or togreg but have 
not yet landed in torvalds master.

Which of these things should I do?

- Make patch against torvalds master (then it will have merge conflicts 
when accepted).

- Make patch against testing or togreg (whichever branch contains the 
conflicts).

- Wait to test/send the patch until the patches with conflicts make it 
into torvalds master (this could be a while, and depending on which 
patches get accepted, more conflicts may arise again in testing/togreg).

Thanks,
Martin
