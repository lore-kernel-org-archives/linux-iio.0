Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60826 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756146AbcINLoj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2016 07:44:39 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id CEF8A486538
        for <linux-iio@vger.kernel.org>; Wed, 14 Sep 2016 13:34:14 +0200 (CEST)
Message-ID: <1473852847.6389.12.camel@hadess.net>
Subject: Re: possible odd acceleration scaling
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@kernel.org>, rrs@researchut.com,
        linux-iio@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Wed, 14 Sep 2016 13:34:07 +0200
In-Reply-To: <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
References: <1473787814.8047.8.camel@researchut.com>
         <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2016-09-13 at 18:50 +0100, Jonathan Cameron wrote:
> 
<snip>
> Looking at your bug report, raw readings are around magnitude 1000.
> 1000*0.009806 = 9.81
> 
> Given accelerations in IIO are in m/s^2 I'm slightly confused...

Sigh. I think this is the second time I get this wrong. The code to
calculate the orientation expects 1G ~= 0x100. So the driver is
correct, and I need to fix this again in iio-sensor-proxy.

Sorry about that.
