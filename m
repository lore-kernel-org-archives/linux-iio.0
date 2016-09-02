Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10755 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752956AbcIBWsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Sep 2016 18:48:09 -0400
Message-ID: <1472856487.5025.84.camel@linux.intel.com>
Subject: Re: screen rotation flipped in 4.8-rc
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "linux@sciencehorizons.net" <linux@sciencehorizons.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>,
        Grant Likely <glikely@secretlab.ca>, jikos@kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 02 Sep 2016 15:48:07 -0700
In-Reply-To: <1472596930.23886.13.camel@intel.com>
References: <1472596930.23886.13.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2016-08-30 at 22:42 +0000, Pandruvada, Srinivas wrote:
> Hi All,
> 
> I observed that using iio-sensor-proxy.service, the auto screen
> rotation flipped on my laptop (Normal -> vertical, vertical->normal)
> using kernel v4.8.
> 
> Anyone else has seen this?
> 
> I did a bisect and found a commit, which I am not sure how can it
> impact.
> 
> 
> commit 703b5faf22fbddf984a361e6555f3a03fdba63d9
> Author: George Spelvin <linux@sciencehorizons.net>
> Date:   Fri Jun 10 00:22:12 2016 -0400
> 
[...]

It turns out to be some assumption user space program is making about
the traversing directory using glib call g_dir_read_name(). 

With the commit 703b5faf22fbddf984a361e6555f3a03fdba63d9 (fs/dcache.c:
Save one 32-bit multiply in dcache lookup)
 in kernel 4.8-rc, somehow the order is changed (so the in_accel_y was
appearing before in_accel_x )

I modified user space program to use correct iio scan element index to
determine byte offset instead depending on the glib_dir_read_name,
which doesn't guarantee any order.

I sent a pull request to author of iio-sensor-proxy to review.

Hadess,
	Please look.

https://github.com/hadess/iio-sensor-proxy/pull/99/commits/de80c50b2678
2ba6e899ee5a95b31b28790c940d


Thanks,
Srinivas
