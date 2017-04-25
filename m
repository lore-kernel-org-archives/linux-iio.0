Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1429764AbdDYMU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 08:20:27 -0400
Date: Tue, 25 Apr 2017 15:20:14 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
Message-ID: <20170425122014.GR7152@lahna.fi.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
 <bb8ca4d3-c70b-0bc5-640a-8c7fdb49f720@siemens.com>
 <1493119428.24567.190.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493119428.24567.190.camel@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 25, 2017 at 02:23:48PM +0300, Andy Shevchenko wrote:
> > Needed to make it work. If there is a better file to keep that, I'll
> > move it.
> 
> Ideally you need BIOS fixed for that.
> 
> Otherwise you may do a separate code which would provide CS GPIO look up
> table.
> 
> Mika, what do you think about fixing this in the C code for existing
> devices?

If nothing else helps but I would first try to explore the SSDT overlay
stuff if it can be used here instead.
