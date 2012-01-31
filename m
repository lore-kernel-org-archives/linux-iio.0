Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:45561 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab2AaU6B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2012 15:58:01 -0500
Message-ID: <4F285602.8010002@cam.ac.uk>
Date: Tue, 31 Jan 2012 20:58:42 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 4/6] staging:iio:events: Use waitqueue lock to protect
 event queue
References: <1324290580-17511-1-git-send-email-lars@metafoo.de> <1324290580-17511-4-git-send-email-lars@metafoo.de> <4F258D7D.9090000@kernel.org> <4F282445.8000906@metafoo.de>
In-Reply-To: <4F282445.8000906@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2012 05:26 PM, Lars-Peter Clausen wrote:
> On 01/29/2012 07:18 PM, Jonathan Cameron wrote:
>> On 12/19/2011 10:29 AM, Lars-Peter Clausen wrote:
>>> Use the waitqueue lock to protect the event queue instead of a custom mutex.
>>> This has the advantage that we can call the waitqueue operations with the lock
>>> held, which simplifies the code flow a bit.
>>>
>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Hmm.. I really should have noticed this before.. If this hasn't gone to
>> Greg already, can you also clear out the documentation for
>> event_list_lock within struct iio_event_interface.  Cleaner to do it
>> here than in a follow up patch.
> 
> Yes, the whole series has already been send to Greg, but since he hasn't
> applied it yet, I suppose I could resend it with your fixes.
Either that or just send Greg a small follow up (or I'll get to it at
somepoint) None of it is remotely critical!

