Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:49716 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab0KAMMw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2010 08:12:52 -0400
Message-ID: <4CCEB02D.7090002@cam.ac.uk>
Date: Mon, 01 Nov 2010 12:18:53 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [Device-drivers-devel] [PATCH 00/36 v2] staging: iio: ADI drivers
 for staging-next
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org> <AANLkTi=-YOdnuQczTD85e7YKuf+OsEbvi4OF6rQnRo7F@mail.gmail.com>
In-Reply-To: <AANLkTi=-YOdnuQczTD85e7YKuf+OsEbvi4OF6rQnRo7F@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/28/10 02:44, Mike Frysinger wrote:
> On Tue, Oct 26, 2010 at 14:17, Mike Frysinger wrote:
>> Hopefully there shouldn't be any roadblocks now before pushing to GregKH.
>> I'll do so in a day or two if there aren't any issues.
> 
> ive bounced it over to him now
> -mike
> 
I'm guessing this lot *just* missed the merge window.  Despite all Mike's
hard work they were proposed for merging very late so we can't really complain!

Anyhow, this is not necessarily a bad thing as it will mean they sit in
staging-next for a couple of months and we can do a lot of needed cleaning up
before the next merge window.  The trick is probably going to be to synchronize
this chunk of the blackfin tree against staging-next so that we can apply any
accepted/reviewed patches to both trees as we move forward.

I can set up an additional 'in between' tree if that is helpful? (kernel.org hosted)
It would contain whatever we have sent on to Greg KH but based against mainline
rather than linux-next (with no rebasing but with merges to move with the release
candidates as they appear). Hence it would effectively be iio-next though formally
that role will still be handled by Greg's staging-next tree.

Jonathan

