Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41142 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaBHLtF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 06:49:05 -0500
Message-ID: <52F619C9.8060701@kernel.org>
Date: Sat, 08 Feb 2014 11:49:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/01/14 13:13, Jiri Kosina wrote:
> On Thu, 23 Jan 2014, Srinivas Pandruvada wrote:
>
>> Remove the hard coded indexes, instead search for usage id and
>> use the index to set the power and report state.
>> This will fix issue, where the report descriptor doesn't contain
>> the full list of possible selector for power and report state.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> Jonathan, I'd probably take this together with the patch for HID API
> change. Could you please provide your Ack/Signoff, and I'll take it
> through my tree, if you agree?
Agreed. Help yourself ;)

Thanks and sorry for the slow response.  Amazing the backlog that builds
up if you take about 3 weeks out (more or less)
>
> Thanks.
>

