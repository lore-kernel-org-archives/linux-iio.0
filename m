Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52409 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbcDQIlq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 04:41:46 -0400
Subject: Re: [PATCH 5/5] max44000: Initial triggered buffer support
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <dc82c7c28df002717a2668708cc96732a0856fac.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072152010.26969@pmeerw.net> <570BCCA5.7020004@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57134C42.8070103@kernel.org>
Date: Sun, 17 Apr 2016 09:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <570BCCA5.7020004@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 17:11, Crestez Dan Leonard wrote:
> On 04/07/2016 10:59 PM, Peter Meerwald-Stadler wrote:
>>>   static int max44000_probe(struct i2c_client *client,
>>>                 const struct i2c_device_id *id)
>>>   {
>>> @@ -513,6 +569,12 @@ static int max44000_probe(struct i2c_client *client,
>>>           return ret;
>>>       }
>>>
>>> +    ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
>>> +    if (ret < 0) {
>>> +        dev_err(&client->dev, "iio triggered buffer setup failed\n");
>>> +        return ret;
>>> +    }
>>> +
>>>       return iio_device_register(indio_dev);
>>
>> no devm_ possible anymore :-)
> 
> It's not clear to me why explicit calls to
> iio_triggered_buffer_cleanup are done in every driver. Wouldn't it be
> possible for iio_dev_release to call iio_triggered_buffer_cleanup?
> That would require triggered_buffer_cleanup to explictly NULL the
> fields it deallocates so that duplicate cleanups don't crash.
Because not all devices are using the triggered buffer setup function
thus they can't use the cleanup one.  There are different buffers for
starters and the core has no way to identify them (very deliberately
as it should never care what they are).

There is also the general obvious correctness of code question.
If you do one thing in probe, it should be reverse in remove...

We could in theory do a devm version of the iio_triggered_buffer_cleanup
function though as then the tear down would occur in the write order and
as it is a devm_ call in the probe we'd know how the unwind was being
done...


> -- 
> Regards,
> Leonard

