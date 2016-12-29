Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbcL2RZw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Dec 2016 12:25:52 -0500
Message-ID: <1483032127.27585.13.camel@linux.intel.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rrs@researchut.com, linux-iio <linux-iio@vger.kernel.org>
Date: Thu, 29 Dec 2016 09:22:07 -0800
In-Reply-To: <1482947598.21657.1.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
         <1482947598.21657.1.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2016-12-28 at 23:23 +0530, Ritesh Raj Sarraf wrote:
> On Wed, 2016-12-28 at 23:07 +0530, Ritesh Raj Sarraf wrote:
> > 
> > On Wed, 2016-12-28 at 22:54 +0530, Ritesh Raj Sarraf wrote:
> > > 
> > > Device4, for which there are no x, y, z attributes, reports the
> > > name
> > > "dev_rotation".
> > > Even for the other devices, I see no change in the reported
> > > values.
> > On the 4.8 kernel, the values do change. The iio-sensor-proxy still
> > does not
> > do
> > the rotation.
> For the sake of completeness, I booted up iio-sensor-proxy (with
> latest patch
> from today), on both 4.8 and 4.9.
> 
> With 4.8, I am reliably able to see screen rotation. And for the
> record, on 4.8,
> the memset change is the old one.
> 
> With 4.9, nothing. Which may be expected given there were no data
> seen with
> those device attributes (when using cat).
> 
> 
> If you need more information, please tell me.
I tried on couple of systems with the patch. It seems to fix the issue.
It is possible some low level power related changes have impacted this.
Can you do bisect? I suggest just try 4.9-rc1. I think it will not work
there probably.

Thanks,
Srinivas

> 
> 
