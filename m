Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33943 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdLKIJ5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Dec 2017 03:09:57 -0500
Message-ID: <1512979794.25007.570.camel@linux.intel.com>
Subject: Re: [PATCH] iio: Handle enumerated properties with gaps
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Date: Mon, 11 Dec 2017 10:09:54 +0200
In-Reply-To: <20171207094209.14748-1-lars@metafoo.de>
References: <20171207094209.14748-1-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2017-12-07 at 10:42 +0100, Lars-Peter Clausen wrote:

> Open for suggestions on how to massage __sysfs_match_string() into
> handling
> this use-case.

I use to have an idea to use bitmap variant of such functions.
Though I didn't find enough users to make it beneficial.

match_string_[with_gaps](...unsigned long *map, ...)
{
...
 for_each_set_bit() {
 ...
 }
...
}

So, in addition to (or instead of) passing size pass bitmap.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
