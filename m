Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34807 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933205Ab2HPUBG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 16:01:06 -0400
Message-ID: <502D517F.7070008@kernel.org>
Date: Thu, 16 Aug 2012 21:01:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO Fixes for v3.6-rc1
References: <502D4E2B.5010109@kernel.org>
In-Reply-To: <502D4E2B.5010109@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry, messed that request up completely and failed to notice till I
made the same mistake again.  In future I'll remember to specify the
'from' of the pull request then it will actually contain something.

Sorry for the noise!

> The following changes since commit 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:
> 
>   iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/v3.6-rc1-iio-fixes
> 
> for you to fetch changes up to 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:
> 
>   iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)
> 
> ----------------------------------------------------------------
> IIO fixes for v3.6-rc1
> 
> These mostly consist of fixes from Lars-Peter Clausen that were
> the first part of a large series reworking the drivers concerned.
> Turns out these drivers had quite a wealth of minor bugs.
> 
> Also here are some build warning fixes for lm3533-als and
> adjd_s111 (both new drives in this cycle).
> Final elements are a a div factor overflow and a warning
> related fix in a couple of Analog Devices drivers.
> 
> All in all nothing major, but a worthwhile bunch of short
> fixes.
> 
> ----------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
