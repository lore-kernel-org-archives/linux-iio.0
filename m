Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47655 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754813AbdERHl5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 May 2017 03:41:57 -0400
Date: Thu, 18 May 2017 09:41:46 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: spear_adc driver help needed ?
Message-ID: <20170518094146.6504821a@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

I've been working on a SPEAr600 platform recently, which uses the
spear_adc driver, and was about to start working on moving the driver
out of staging... only to discover in 4.12-rc1 that you already moved
it out of staging.

In the commit log that moves it out of staging, you're saying:

    There are some unanswered questions due to disagreements between the code
    and various datasheets (including between different datasheets for the same
    part).
    
    I don't think that is necessarily a reason to keep it in staging however.
    I'm partly posting this patch inorder to reignite debate and with a bit
    of luck find someone who has one of these to test!

What are the unanswered questions you are talking about?

Also, I am currently using the driver on a SPEAr600 device, so I can do
some testing.

The driver has support for the SPEAr3xx, but it isn't used anywhere:
there is no compatible string for it, and nowhere is old-style probing
used for "spear-adc".

So I'm thinking of:

 - Dropping SPEAr3xx support, because it's unused. This will also
   remove the ugly checks done on the compatible string all over the
   place.

 - Moving to a "base + offset" style of register accesses, rather than
   the struct-based accesses.

What do you think ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
