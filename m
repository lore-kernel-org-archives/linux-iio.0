Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57722 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0JXXgH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 19:36:07 -0400
Message-ID: <4CC4C442.5000304@cam.ac.uk>
Date: Mon, 25 Oct 2010 00:41:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: device-drivers-devel@blackfin.uclinux.org,
	linux-iio@vger.kernel.org
Subject: Re: [Device-drivers-devel] [PATCH 00/36] staging: iio: ADI drivers
 for staging-next
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org> <AANLkTi=iuV0QuCKWROfbEiX9E9qEsTH=Bh1bjC0FBcv_@mail.gmail.com>
In-Reply-To: <AANLkTi=iuV0QuCKWROfbEiX9E9qEsTH=Bh1bjC0FBcv_@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/10 22:35, Mike Frysinger wrote:
> On Sun, Oct 24, 2010 at 17:22, Mike Frysinger wrote:
>> I've rebased all the drivers onto staging-next.  I've only fixed the API
>> breakage due to the changes made after 2.6.36 (and fixed a few warnings).
>> I've also run checkpatch across these.
>>
>> I have not however addressed any real feedback Jonathan has provided with
>> regards to driver correctness or direction.  That stuff I'm leaving up to
>> Michael Hennerich since it's his job and he actually understands this.
>>
>> Where possible, I'd like to have drivers merged so as to avoid another
>> round of "new API just broke all your drivers".  We will still look into
>> feedback given, but we'd like to focus on that rather than random `sed`
>> changes as API names change.
> 
> btw, how does the merging with IIO occur ?  do you take care of
> bouncing them to gregkh ?  or does he watch this list ?  or do i have
> to cc him too ?
CC Greg, or if the set has been on list then send them to him directly
and just post on the list that they have gone to Greg.
> 
> my assumption is that i send IIO patches to you and then you get them
> into the staging tree ...
Normally I just suggest people send them to Greg. That is definitely
the case with this set as I'm off on holiday tomorrow evening and
hence won't be able to respond to any queries that come up and might
block the merge.

Hence over to you. Perhaps hold off until everyone has gotten to their
email tomorrow just in case....

Jonathan

