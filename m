Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:42933 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760072Ab0EDVdh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 17:33:37 -0400
Message-ID: <4BE0935E.8030504@cam.ac.uk>
Date: Tue, 04 May 2010 22:36:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/20] staging:iio updates Abi changes and new drivers
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk> <20100504204834.GA31435@kroah.com>
In-Reply-To: <20100504204834.GA31435@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/10 21:48, Greg KH wrote:
> On Tue, May 04, 2010 at 02:42:55PM +0100, Jonathan Cameron wrote:
>> Dear Greg,
>>
>> The following set is based upon your staging-next tree as of Sunday.
>> When the caching updates they should be available on:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-new-abi.git master
>>
>> so if it is easier for you, pull from there.
> 
> All looks good, I've queued all of them up, thanks for the patches.
Thanks!
> 
> Note, some of them added some whitespace errors, that you might want to
> go back and fix up now before someone else does :)
checkpatch is giving what looks like a spurious warning on iio_bus_type export.
I'll take another look at that tomorrow.

I'm not entirely sure which patch introduced the other issues I've just sent
fixes to. (I suspect some were there all along!)  Thanks for pointing out they
were there.

Jonathan
