Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41236 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcHOOoB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:44:01 -0400
Subject: Re: Messed up the fixes-togreg-post-rc1 branch so cherry picking into
 fixes-togreg
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Alison Schofield <amsfield22@gmail.com>
References: <faaec59c-07d8-6618-cd0d-0614e690c3e2@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8bc6a47d-52e2-f1f0-5218-aff27c667bde@kernel.org>
Date: Mon, 15 Aug 2016 15:43:59 +0100
MIME-Version: 1.0
In-Reply-To: <faaec59c-07d8-6618-cd0d-0614e690c3e2@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/16 15:37, Jonathan Cameron wrote:
> Hi All,
> 
> Seems I messed up the base of the fixes-togreg-post-rc1 branch
> (based on a random point in togreg rather than the last 
> pull request as intended).  I'll drop that branch as
> junk having cherry picked into an updated fixes-togreg branch.
> 
> Make a bit of a mess of dates, but otherwise should have no
> real affect.
> 
> This is just in case anyone was basing on that branch which
> will shortly disappear.
> 
> Jonathan
Note this also involved dropping the thermocouple kconfig fix
from Alison as that driver hasn't hit mainline yet.

Alison, would you mind resending that one part of the patch based
on the togreg branch?  That way I won't forget it.

Thanks

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

