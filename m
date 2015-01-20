Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47351 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbbATVBs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jan 2015 16:01:48 -0500
Date: Wed, 21 Jan 2015 04:30:44 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] First round of new IIO drivers, features and cleanups for
 the 3.20 cycle
Message-ID: <20150120203044.GA11994@kroah.com>
References: <54AAF235.5000209@kernel.org>
 <20150109022228.GA12876@kroah.com>
 <CAEnQRZC_nQXqOqpS7P5SyyFTfU5TiBp6VEnDK9Q2ZCuWqdh9NQ@mail.gmail.com>
 <CAEnQRZARBq9fztLFuOVHQUpXmW1p9NuYBNq4gzYuJV1fYGvo7g@mail.gmail.com>
 <54BEBA73.5090709@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54BEBA73.5090709@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 20, 2015 at 08:28:35PM +0000, Jonathan Cameron wrote:
> On 09/01/15 09:46, Daniel Baluta wrote:
> > On Fri, Jan 9, 2015 at 9:43 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >> On Fri, Jan 9, 2015 at 4:22 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> On Mon, Jan 05, 2015 at 08:21:09PM +0000, Jonathan Cameron wrote:
> >>>> The following changes since commit 5e62863aea463c9bf24538315327d0922be35d64:
> >>>>
> >>>>   staging: comedi: das800: use comedi_async 'scans_done' to detect EOA (2014-11-05 14:59:48 -0800)
> >>>>
> >>>> are available in the git repository at:
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.20a
> >>>
> >>> This breaks the build for me:
> >>>
> >>> drivers/iio/imu/kmx61.c:1563:21: error: ‘kmx61_runtime_suspend’ undeclared here (not in a function)
> >>>   SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
> >>>                      ^
> >>> include/linux/pm.h:347:21: note: in definition of macro ‘SET_RUNTIME_PM_OPS’
> >>>   .runtime_suspend = suspend_fn, \
> >>>                      ^
> >>> drivers/iio/imu/kmx61.c:1563:44: error: ‘kmx61_runtime_resume’ undeclared here (not in a function)
> >>>   SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
> >>>                                             ^
> >>> include/linux/pm.h:348:20: note: in definition of macro ‘SET_RUNTIME_PM_OPS’
> >>>   .runtime_resume = resume_fn, \
> >>>                     ^
> >>>
> >>> So I don't want to pull it :(
> >>
> >> I will look into this.
> > 
> > OK. It's my fault :(. I've sent a patch to fix this.
> > 
> > Daniel.
> > 
> Hi Greg,
> 
> Just thought I'd check where we are with this. Are you still
> OK to take the series and handle the fixup patch in the merge?

Ah, I forgot about it, for some reason I was thinking you would just add
it to your tree.

Can you do so, I don't have that patch in my queue anywhere :(

thanks,

greg k-h
