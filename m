Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42164 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab2LJWEG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Dec 2012 17:04:06 -0500
Message-ID: <50C65C54.6010100@kernel.org>
Date: Mon, 10 Dec 2012 22:04:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: James Robinson <james_robinson@vuzix.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Latest Git Repo
References: <loom.20121210T224225-931@post.gmane.org>
In-Reply-To: <loom.20121210T224225-931@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/2012 09:46 PM, James Robinson wrote:
> I have looked around and I am unable to find the git rep. that everyone seems to
> 
> be posting patches against. I looked at 
> 
> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git/info/refs
> 
> but I don't seem to see the [PATCH] [V5] Invensense MPU6050 Device Driver. 
>
Indeed not. It's not been merged yet as it is still under review.

Personally I've not had time to spend on it since it was posted (a whole 3 days ago ;)
and would need a go ahead from Lars-Peter on this one seeing as he has been doing
much of the review work.

I believe it is very close to merging, but has unfortunately missed the 3.8 merge
cycle, so will not hit mainline now until 3.9.  It will probably be a couple of weeks
before it hits the staging-next tree as Greg tends to only start pulling stuff
again once rc1 for a given cycle is out.

> changes.
> 
> Am I pointing to the right place?
As long as you look at the staging-next branch of that tree then pretty much.

Stuff tends to get queued up in the togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

though often doesn't sit there for longer than it takes me to catch up with
my emails / Greg to decide to pull when he gets the request.


> 
> Thanks for your time,
You are welcome.

Looking forward to your patches!
> 
> James
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
