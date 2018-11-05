Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f171.google.com ([209.85.222.171]:46399 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFEUU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2018 23:20:20 -0500
Received: by mail-qk1-f171.google.com with SMTP id q1so16645799qkf.13
        for <linux-iio@vger.kernel.org>; Mon, 05 Nov 2018 10:59:17 -0800 (PST)
Date: Mon, 5 Nov 2018 16:59:11 -0200
From: Lucas Santos <ilucas.ms@gmail.com>
To: linux-iio@vger.kernel.org
Cc: kernel-usp@googlegroups.com
Subject: Work plan on ad5933
Message-ID: <20181105185911.g5324s46ixlgbvxj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I'm looking at the code of impedaance-analyzer/ad5933, trying to understand
what is needed to move it to the main tree. I am part of a study group and we
are willing to work on it.

We do not understand all the necessary steps yet, but we have some guests. I'd
like to ask if we are on the right track. All feedback will be much
appreciated.

We understand that we should refactor the way the driver is designed. We think
we should removed the delayed work pattern (events queue) and use IRQ pattern
instead. Is that correct? Do we need to do any additional work?

Best regards,
Lucas
