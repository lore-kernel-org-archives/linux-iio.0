Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:40624 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753588AbdETSgh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 May 2017 14:36:37 -0400
Date: Sat, 20 May 2017 14:36:35 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: surenderpolsani@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        gregor.boirie@parrot.com, singhalsimran0@gmail.com,
        maitysanchayan@gmail.com, eraretuya@gmail.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jon Brenner <Jon.Brenner@ams.com>
Subject: Re: [PATCH v3] staging: iio: light: Replace symbolic permissions as
 per coding style
Message-ID: <20170520183635.GA4124@200591939db7>
References: <20170519082041.GA18353@kroah.com>
 <1495186632-31114-1-git-send-email-surenderpolsani@gmail.com>
 <e374d59a-c216-a19b-a3a1-a26a862f0ae5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e374d59a-c216-a19b-a3a1-a26a862f0ae5@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 20, 2017 at 06:55:02PM +0100, Jonathan Cameron wrote:
> On 19/05/17 10:37, surenderpolsani@gmail.com wrote:
> >From: Surender Polsani <surenderpolsani@gmail.com>
> >
> >Fixed the following checkpatch.pl warnings:
> >octal permissions are more preferable than symbolic permissions
> >
> >Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
> >as suggested by Greg K-H. Changed attributes and function
> >names where ever required to satisfy internal macro definitions
> >like __ATTR__RW().
> >
> >Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
> Nicely presented patch, but it runs into the fact that some of these
> shouldn't exist as hand rolled attrs in the first place.
> 
> Some of theses should be handled through the various info_mask and
> event_info_mask bitmaps + read_raw etc.
> 
> This would be a much less mechanical change however...
> 
> See inline and I'll try and pick out which ones.
> 
> Brian is working on this driver as well at the moment so there may
> well be some clashes.
> 
> Perhaps you two could confer on who will target what?  Saves
> everyone time to work together!

You can apply this if you'd like. I just got 7 different hardware
samples from Jon this week that are supported by this driver. I haven't
gotten far yet with coding since I'm currently working on getting
them all setup so that it will be easy for me to test my upcoming
driver changes.

For my first patch series, I'm planning to migrate the driver to use
IIO channels, cleaning up the I2C calls, and runtime power management
support. Hopefully I'll have this to you for next weekend.

Brian
