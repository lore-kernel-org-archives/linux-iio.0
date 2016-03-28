Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44056 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbcC1IdI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:33:08 -0400
Subject: Re: git tree for linux-iio
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160327011133.GA13730@d830.WORKGROUP>
 <CAEnQRZAYuFQQ-HyyckTNo17rJAhTCbUKa_XnqKLsyUEPE+a4EQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8EC43.10609@kernel.org>
Date: Mon, 28 Mar 2016 09:33:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAYuFQQ-HyyckTNo17rJAhTCbUKa_XnqKLsyUEPE+a4EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/16 13:46, Daniel Baluta wrote:
> Hi Alison,
> 
> On Sun, Mar 27, 2016 at 4:11 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Jonathan,
>>
>> What is the correct git tree to use for iio development - both
>> staging and upstream?
> 
> linux-iio tree is at https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/
> 
> Here how I think things work with IIO:
> 
> * new features are based on togreg branch, but first tested on testing branch.
Yes - basic difference is that I'll rebase testing, but not togreg.  So whilst
it's occasionally worth glancing at testing, most patches should in theory
be against togreg.  However, testing works fine too - just beware if you try
to fastforward a series that I may have undercut the history!  In theory
nothing should sit in testing and not togreg for more than about a week.

About every 2 weeks in the middle of a cycle (weeks 4-8 ish), I send a pull request
to GregKH and then fast forward this branch to the result of him pulling that.

> * bugfixes are based on togreg and integrated in fixes-togreg, but
> first tested on testing branch.
Not quite.  Fixes-togreg is based on staging/staging-linus which closely tracks
Linus' tree + whatever else Greg has lined up in the way of fixes.

There are sometimes additional branches at the end of a cycle to handle fixes
that need applying soon after the merge window closes as I don't send stuff
to Greg for one week before to about one week after the merge window.
> 
> I always use the testing branch when sending patches.
That works.

Jonathan
> 
> Jonathan please correct me if I'm wrong.
> 
> thanks,
> Daniel.
> 

