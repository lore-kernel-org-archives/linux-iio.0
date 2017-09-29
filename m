Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:50150
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752448AbdI2WF6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2017 18:05:58 -0400
Date: Sat, 30 Sep 2017 00:05:54 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 8/8] iio: accel: kxcjk1013: drop variation number from
 driver's name
Message-ID: <20170929220554.pa5wzel6uhlukkqt@qmqm.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
 <d6bf7a25a40366e3d816621765a9a05072ca4103.1505660069.git.mirq-linux@rere.qmqm.pl>
 <20170924160326.7e5d3497@archlinux>
 <1506707107.3098.3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1506707107.3098.3.camel@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 29, 2017 at 10:45:07AM -0700, Srinivas Pandruvada wrote:
> On Sun, 2017-09-24 at 16:03 +0100, Jonathan Cameron wrote:
> > On Sun, 17 Sep 2017 17:01:05 +0200
> > Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > 
> > > Rename kxcjk-1013 driver by removing -1013 suffix. '1013' is a
> > > variation
> > > specifier only (eg. different voltage) as can be seen in datasheet
> > > for eg. KXTF9 parts.
> > > 
> > > Old name is left as an modules's alias. Should not matter, though,
> > > for distros using proper module loading based on device name not
> > > module name.
> > > 
> > > Mostly a mechanical change + whitespace fixes.
> > > 
> > > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Whilst this seems logical I worry we'll break some random platforms
> > init scripts.   I think I'd rather not risk breakage and leave it as
> > it is.  Once we make a mistake like this, sometimes we are stuck
> > with it long term unfortunately.
> Agree. The config files are not touched when user upgrade kernel. So
> this may be simply overlooked. That is why we have compatible ids in
> both ACPI and DTs.

Ok, I see the point. I'll remove the renaming of kconfig symbol in
the next version.

Best Regards,
Micha³ Miros³aw
