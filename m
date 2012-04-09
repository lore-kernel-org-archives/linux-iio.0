Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:36916 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516Ab2DISEz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Apr 2012 14:04:55 -0400
Message-ID: <4F8324C3.9080407@cam.ac.uk>
Date: Mon, 09 Apr 2012 19:04:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com> <CACRpkdYi990U+9LEZo18C0ueqPVqDf6_JHA5Efy5aH3YoQjQAw@mail.gmail.com>
In-Reply-To: <CACRpkdYi990U+9LEZo18C0ueqPVqDf6_JHA5Efy5aH3YoQjQAw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/2012 06:50 PM, Linus Walleij wrote:
> On Mon, Apr 9, 2012 at 1:34 PM, Srinidhi KASAGAR
> <srinidhi.kasagar@stericsson.com> wrote:
> 
>> Add support for lsm303dlh magnetometer device.
>>
>> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Jonathan are you funneling patches to IIO or shall we send them directly
> to Greg?
> 
> Thanks,
> Linus Walleij
Technically I only ever took patches through my tree when there were big
changes afoot (to avoid mass breakages as the sets hit Greg).  There's
no formal requirement but what usually happens is that changes go to
linux-iio and someone (not necessarily me (thanks as always to the
others who help with this!)  reviews them.  If I want to take a look (or
anyone else does) and I don't have time in the first few days, I tend to
drop the author email asking them to hold it till I've commented.  I'll
also often suggest sending on to Greg anything I have acked (as long as
there are no other outstanding comments from others to be addressed), or
suggest who else I want some feedback from before
it goes to Greg so he has the most information possible when chosing
whether to merge or not.

So I operate a sort of informal maintainership.  Note that any fixes
for blindingly obvious stuff such as build fixes tend to go to Greg
at the same point they go to linux-iio.

Jonathan


