Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44750 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbcICPCd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 11:02:33 -0400
Subject: Re: screen rotation flipped in 4.8-rc
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux@sciencehorizons.net" <linux@sciencehorizons.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        Grant Likely <glikely@secretlab.ca>, jikos@kernel.org
References: <1472596930.23886.13.camel@intel.com>
 <1472856487.5025.84.camel@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <99e3b9fa-1dc5-44a5-b550-3754b8339d7d@kernel.org>
Date: Sat, 3 Sep 2016 16:02:17 +0100
MIME-Version: 1.0
In-Reply-To: <1472856487.5025.84.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 23:48, Srinivas Pandruvada wrote:
> On Tue, 2016-08-30 at 22:42 +0000, Pandruvada, Srinivas wrote:
>> Hi All,
>>
>> I observed that using iio-sensor-proxy.service, the auto screen
>> rotation flipped on my laptop (Normal -> vertical, vertical->normal)
>> using kernel v4.8.
>>
>> Anyone else has seen this?
>>
>> I did a bisect and found a commit, which I am not sure how can it
>> impact.
>>
>>
>> commit 703b5faf22fbddf984a361e6555f3a03fdba63d9
>> Author: George Spelvin <linux@sciencehorizons.net>
>> Date:   Fri Jun 10 00:22:12 2016 -0400
>>
> [...]
> 
> It turns out to be some assumption user space program is making about
> the traversing directory using glib call g_dir_read_name(). 
> 
> With the commit 703b5faf22fbddf984a361e6555f3a03fdba63d9 (fs/dcache.c:
> Save one 32-bit multiply in dcache lookup)
>  in kernel 4.8-rc, somehow the order is changed (so the in_accel_y was
> appearing before in_accel_x )
> 
> I modified user space program to use correct iio scan element index to
> determine byte offset instead depending on the glib_dir_read_name,
> which doesn't guarantee any order.
> 
> I sent a pull request to author of iio-sensor-proxy to review.
> 
> Hadess,
> 	Please look.
> 
> https://github.com/hadess/iio-sensor-proxy/pull/99/commits/de80c50b2678
> 2ba6e899ee5a95b31b28790c940d

Good find Srinivas and thanks for keeping us updated with your progress
tracking this down!

Jonathan
> 
> 
> Thanks,
> Srinivas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

