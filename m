Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52529 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbHPJF4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2015 05:05:56 -0400
Subject: Re: [PATCH v3 5/7] iio: Support triggered events
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1438174648-19296-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <55C4B66C.1020609@metafoo.de> <55C4D878.1010605@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D05272.7010107@kernel.org>
Date: Sun, 16 Aug 2015 10:05:54 +0100
MIME-Version: 1.0
In-Reply-To: <55C4D878.1010605@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Vladimir - before I forget, could you try to wrap emails to around 
80 characters per line.  Otherwise we end up with really tricky
to read thread when some are doing so and others aren't!

On 07/08/15 17:10, Vladimir Barinov wrote:
> Hi Lars,
> 
> On 07.08.2015 16:45, Lars-Peter Clausen wrote:
>> Hi,
>>
>> On 07/29/2015 02:57 PM, Vladimir Barinov wrote:
>>> Support triggered events.
>>>
>>> This is useful for chips that don't have their own interrupt sources.
>>> It allows to use generic/standalone iio triggers for those drivers.
>>>
>> Thanks for the patch. Can you describe in more detail how
>> INDIO_EVENT_TRIGGERED differs from the INDIO_BUFFER_TRIGGERED. By just
>> looking at the source code I don't understand quite why it is necessary.
> This is needed for the case when iio buffer is not used and used only
> iio event.
> 
> The difference to INDIO_BUFFER_TRIGGERED is that for triggered buffer
> the trigger poll function is attached (using
> iio_trigger_attach_poll_func) only in industrialio-buffer.c using
> number of steps/conditions starting by issuing 1 to buffer/enable
> sysfs path.
> 
> For chips that do not use iio buffer but use only iio events the
> iio_trigger_attach_poll_func never called.
> 
> In case of using INDIO_BUFFER_TRIGGERED the poll func is
> attached/detached via industrialio-buffer.c In case of using
> INDIO_EVENT_TRIGGERED the poll func is attached/detached via
> industrialio-trigger.c during set/change the current trigger.
> 
> Regards, Vladimir
You've convinced Lars and I agree with his argument that this
is a sensible addition to IIO.
> 

>> Thanks,
>> - Lars
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

