Return-Path: <levinsasha928@gmail.com>
Subject: Re: [PATCH] iio: Fix build error in industrialio-core.c
From: Sasha Levin <levinsasha928@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
In-Reply-To: <4e3c37a6-3777-4138-800b-f055f7caa8f3@email.android.com>
References: <1322043239-26082-1-git-send-email-levinsasha928@gmail.com>
	 <4e3c37a6-3777-4138-800b-f055f7caa8f3@email.android.com>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 24 Nov 2011 10:54:41 +0200
Message-ID: <1322124881.4248.8.camel@lappy>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2011-11-24 at 08:49 +0000, Jonathan Cameron wrote:
> 
> Sasha Levin <levinsasha928@gmail.com> wrote:
> 
> >The error was introduced in commit b4641336 ("iio: fix a leak due to
> >improper use of anon_inode_getfd()").
> >
> >Looks like the code wasn't even compile tested. Instead of just fixing
> >the
> >error I changed the function a bit to make it nicer.
> Minimal change would have been slightly nicer but clean up is obvious so fine. Thanks for doing this.  Andrew m has a dirty build fix in NM but he will drop that when this hits.

If you'd like I can split it into two patches, the fix and the cleanup.

-- 

Sasha.
