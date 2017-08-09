Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37027 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751890AbdHIURY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 16:17:24 -0400
Date: Wed, 9 Aug 2017 22:17:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] hid-sensor-hub: Force logical minimum to 1 for power
 and report state
In-Reply-To: <20170809153349.57ab4d9f@archlinux>
Message-ID: <alpine.LSU.2.20.1708092217060.30597@cbobk.fhfr.pm>
References: <20170807045201.3286-1-srinivas.pandruvada@linux.intel.com> <alpine.LSU.2.20.1708081026200.30597@cbobk.fhfr.pm> <20170809153349.57ab4d9f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 9 Aug 2017, Jonathan Cameron wrote:

> > Jonathan, are you ok with me taking this through hid.git? Thanks,
> > 
> Sure,
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks. Applied to for-4.14/ish.

-- 
Jiri Kosina
SUSE Labs

