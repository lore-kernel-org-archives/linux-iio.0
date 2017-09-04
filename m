Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:33188
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751329AbdIDVEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2017 17:04:04 -0400
Date: Mon, 4 Sep 2017 23:04:01 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/7] iio: accel: kxcjk1003: support Kionix KXTF9
Message-ID: <20170904210400.qbeatyxhif4rewjv@qmqm.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
 <20170903124335.19dcb386@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20170903124335.19dcb386@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 03, 2017 at 12:43:35PM +0100, Jonathan Cameron wrote:
> On Tue, 22 Aug 2017 00:03:29 +0200
> Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > This series adds support for KXTF9 accelerometer. It is mostly compatible
> > to KXCJK, but replaces motion direction interrupt with tap detection
> > (not supported in this implementation, yet).
> > 
> > First 5 patches are refactorings with no outside-visible effects.
> > Patch 6 fixes sysfs attribute name of sampling_frequency_avail
> > to match sampling_frequency attribute it describes.
> > Patch 7 finally adds support for KXTF9 accelerometers.
> Cc'd Srinivas (original author of this driver - should really have been cc'd
> from the start).
> 
> Micha³: I'm assuming you don't have the parts already supported by the driver?

No. The only one I have is inside my Asus TF300T I'm trying to
get working fully under Debian.

> We are past the point where these are going to make the coming merge window
> anyway so have plenty of time.

I'll rebase the series after v4.14-rc1 comes out, then. I can add
the global renaming cleanup on top (removing '1013' from driver and
register names) if you're willing to accept it.

Thanks for reviewing!

Best Regards,
Micha³ Miros³aw
