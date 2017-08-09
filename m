Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbdHIOhj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:37:39 -0400
Date: Wed, 9 Aug 2017 15:34:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] hid-sensor-hub: Force logical minimum to 1 for power
 and report state
Message-ID: <20170809153349.57ab4d9f@archlinux>
In-Reply-To: <alpine.LSU.2.20.1708081026200.30597@cbobk.fhfr.pm>
References: <20170807045201.3286-1-srinivas.pandruvada@linux.intel.com>
        <alpine.LSU.2.20.1708081026200.30597@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 8 Aug 2017 10:26:58 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Sun, 6 Aug 2017, Srinivas Pandruvada wrote:
> 
> > In the reference HID sensor hub firmware all Named array enums were
> > 0-based. There is no description of the default base of enums in HID
> > sensor hub specification as logical minimum should have set this base
> > value.
> > 
> > Every sensor hub implemented enum as 1-based, without explicitly setting
> > logical minimum to 1, because of the implementation by one of the major
> > OS vendor. In Linux we used logical minimum to decide the enum base.
> > 
> > Some sensor hub FWs already changed logical minimum from 0 to 1. We hoped
> > that every other vendor will follow. But that didn't happen and we had to
> > fix the report header for every sensor hub to change logical minimum to 1
> > by using .report_fixup() callback. So for every new sensor hub we had to
> > modify source code by adding this quirk based on the vendor and device id.
> > This is becoming a maintenance burden.
> > 
> > This patch hardcodes the logical minimum of power and report state
> > attributes to 1. In this way we can remove the existing quirks and also
> > we don't have to add more quirks.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>  
> 
> Jonathan, are you ok with me taking this through hid.git? Thanks,
> 
Sure,
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

