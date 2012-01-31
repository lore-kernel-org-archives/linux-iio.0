Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-004.synserver.de ([212.40.185.4]:1155 "EHLO
	smtp-out-249.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752378Ab2AaR1w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2012 12:27:52 -0500
Message-ID: <4F282445.8000906@metafoo.de>
Date: Tue, 31 Jan 2012 18:26:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 4/6] staging:iio:events: Use waitqueue lock to protect
 event queue
References: <1324290580-17511-1-git-send-email-lars@metafoo.de> <1324290580-17511-4-git-send-email-lars@metafoo.de> <4F258D7D.9090000@kernel.org>
In-Reply-To: <4F258D7D.9090000@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2012 07:18 PM, Jonathan Cameron wrote:
> On 12/19/2011 10:29 AM, Lars-Peter Clausen wrote:
>> Use the waitqueue lock to protect the event queue instead of a custom mutex.
>> This has the advantage that we can call the waitqueue operations with the lock
>> held, which simplifies the code flow a bit.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Hmm.. I really should have noticed this before.. If this hasn't gone to
> Greg already, can you also clear out the documentation for
> event_list_lock within struct iio_event_interface.  Cleaner to do it
> here than in a follow up patch.

Yes, the whole series has already been send to Greg, but since he hasn't
applied it yet, I suppose I could resend it with your fixes.

Thanks,
- Lars
