Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:37670 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAKhJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 06:37:09 -0400
Date: Sat, 1 Jul 2017 06:37:07 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 5/6] staging: iio: tsl2x7x: refactor
 {read,write}_event_value to allow handling multiple iio_event_infos
Message-ID: <20170701103707.47bjnjxiv6a5353w@basecamp>
References: <20170629170352.11264-1-masneyb@onstation.org>
 <20170629170352.11264-6-masneyb@onstation.org>
 <20170701104020.60257a88@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170701104020.60257a88@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jul 01, 2017 at 10:40:20AM +0100, Jonathan Cameron wrote:
> On Thu, 29 Jun 2017 13:03:51 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > tsl2x7x_read_thresh() and tsl2x7x_write_thresh() currently assumes
> > that IIO_EV_INFO_VALUE is the only iio_event_info that will be
> > passed in.  This patch refactors these two functions so that
> > additional iio_event_infos can be passed in. The functions are
> > renamed from tsl2x7x_{read,write}_thresh() to
> > tsl2x7x_{read,write}_event_value(). This patch also adds the
> > missing return value check to tsl2x7x_invoke_change() since this
> > was previously missing.
> > 
> Hmm.. Why make this change?  Are there additional uses of this
> function on the way?
> 
> If not I wouldn't necessarily worry about the naming or the
> assumptions as the assumptions are enforced by the driver
> anyway.  Nothing wrong with a bit of paranoid defence against
> future  bugs, but it's not strictly necessary.

I should have mentioned in the changelog that this change sets the
driver up for migrating the in_intensity0_thresh_period
and in_proximity0_thresh_period sysfs attributes to be created by
iio_event_spec. This is one of the patches that I held back until
I am able to properly test it.

Brian
