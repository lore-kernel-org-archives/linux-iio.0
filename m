Return-Path: <greg@kroah.com>
Date: Wed, 24 Aug 2011 14:24:07 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] Trigger locking rework and splitting up trigger.h
Message-ID: <20110824212407.GC9707@kroah.com>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 24, 2011 at 05:28:32PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> This series has been floating around for a while and fixes some nasty
> issues with reference counting on triggers + gets rid of some work
> arounds people were using in drivers for the above issue.  Series
> has had a few little reorganization patches added since first posting,
> but nothing controversial.
> 
> Whilst some of this is technically stable material it's probably better
> to wait an see if anyone cares then do a backport as and when.
> 
> Thanks as ever for your hard work.

All applied and pushed out.

thanks,

greg k-h
