Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16750 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932660AbcECMZr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 May 2016 08:25:47 -0400
Subject: Re: [RFC] iio: Release irq if set_trigger_state fails
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <28d5b780aa8bd065492e0be1aa2f5c59a0cc0e16.1461861330.git.leonard.crestez@intel.com>
 <202d0c23-c592-c891-a1aa-61b4a264c829@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <5728988D.1080502@intel.com>
Date: Tue, 3 May 2016 15:24:45 +0300
MIME-Version: 1.0
In-Reply-To: <202d0c23-c592-c891-a1aa-61b4a264c829@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2016 10:11 PM, Jonathan Cameron wrote:
> On 28/04/16 17:40, Crestez Dan Leonard wrote:
>> When attaching a pollfunc iio_trigger_attach_poll_func will allocate a
>> virtual irq and call the driver's set_trigger_state function. Fix error
>> handling to release the irq if set_trigger_state fails.
>>
>> Otherwise when using triggered buffers and the driver's
>> set_trigger_state fails once then the buffer becomes unusable.
>>
>> It is not possible to handle this sort of error by calling
>> iio_trigger_detach_poll_func externally somehow. That function should
>> only be called if attach is successful.
>>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> I'm embarrassed :(  good find! Not sure why you made such an obvious
> bug fix an RFC though! 
> 
> Slight issue in the new error handling though I think..
> 
>> +
>> +out_put_irq:
>> +	iio_trigger_put_irq(trig, pf->irq);
>> +	free_irq(pf->irq, pf);
>> +out_put_module:
> I think the iio_trigger_put_irq should be here as it will have been gotten before the 
> request_threaded_irq call and hence should always be unwound on error not just in the
> case above.
>
Yes. I sent V2 which should properly handle errors from
iio_trigger_get_irq and request_threaded_irq separately.

-- 
Regards,
Leonard
