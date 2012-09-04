Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45975 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2IDVXd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2012 17:23:33 -0400
Received: by dady13 with SMTP id y13so4662219dad.19
        for <linux-iio@vger.kernel.org>; Tue, 04 Sep 2012 14:23:33 -0700 (PDT)
Date: Tue, 4 Sep 2012 14:21:01 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>,
	linux-iio@vger.kernel.org, jkosina@suse.cz
Subject: Re: [PATCH 0/9] HID-Sensor v8
Message-ID: <20120904212101.GA2463@kroah.com>
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com>
 <503D1D4F.2030805@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503D1D4F.2030805@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 28, 2012 at 08:34:39PM +0100, Jonathan Cameron wrote:
> I am pretty happy with the whole series now, so next question from
> my end is what route this takes into the kernel?
> 
> Patch 1 should go through the IIO tree (as it touches
> a fairly high churn area of the IIO core).
> 
> 2-4 are very much in HID...
> 5-9 very much IIO.
> 
> My personal preference is to take the lot though the IIO tree
> but then I know we have a few patches in the pipeline that will
> touch this driver after it merges (internal api changes) and have
> no idea what is going on from the HID side so naturally I full on
> the side of least work for me :)
> 
> Jiri what are you thoughts on this series?
> 
> CC'd Greg given he's the one who will get the fishy pull request
> from me if it goes though IIO...

If Jiri says it is ok, that's fine with me, whatever works easier for
you two.

greg k-h
