Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:44744 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab0FDPje (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2010 11:39:34 -0400
Message-ID: <4C091E4F.3090000@cam.ac.uk>
Date: Fri, 04 Jun 2010 16:39:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] adis16400: fix some minor issues and clean-up
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com> <1275643194-25328-2-git-send-email-21cnbao@gmail.com> <1275643194-25328-3-git-send-email-21cnbao@gmail.com> <4C08DC46.8010907@cam.ac.uk> <20100604152832.GC25400@suse.de>
In-Reply-To: <20100604152832.GC25400@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/10 16:28, Greg KH wrote:
> On Fri, Jun 04, 2010 at 11:58:14AM +0100, Jonathan Cameron wrote:
>> On 06/04/10 10:19, Barry Song wrote:
>>> 1. move adis16400_spi_read_burst() to adis16400_ring.c since it is only
>>>    called there
>>> 2. add the lost calling to adis16400_self_test()
>>> 3. codes cleanup
>>>
>> Same issue with commit comment location
> 
> Same confusion on my part, what's wrong with this?  This is what should
> be in the changelog, right?
Fair enough. I just thought the clean up etc was pretty much covered by the title
and the rest was merely clarification. I'll go with your opinion though as you have
been doing this a lot longer than I have!

Barry, sorry for the confusion!

Jonathan
