Return-Path: <SRS0=9uIE=ZE=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2] iio: trigger: free trigger resource correctly
To: Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <amsfield22@gmail.com>
References: <20170120034730.GA8864@d830.WORKGROUP>
 <8cf25699-4e6b-21cc-af4d-01212279ecd4@kernel.org>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <36545c61-0398-83b2-f89f-6c17c8e7d8cb@metafoo.de>
Date: Sun, 22 Jan 2017 16:56:39 +0100
MIME-Version: 1.0
In-Reply-To: <8cf25699-4e6b-21cc-af4d-01212279ecd4@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 01/22/2017 03:25 PM, Jonathan Cameron wrote:
> On 20/01/17 03:47, Alison Schofield wrote:
>> These stand-alone trigger drivers were using iio_trigger_put()
>> where they should have been using iio_trigger_free().  The
>> iio_trigger_put() adds a module_put which is bad since they
>> never did a module_get.
>>
>> In the sysfs driver, module_get/put's are used as triggers are
>> added & removed. This extra module_put() occurs on an error path
>> in the probe routine (probably rare).
>>
>> In the bfin-timer & interrupt trigger drivers, the module resources
>> are not explicitly managed, so it's doing a put on something that
>> was never get'd.  It occurs on the probe error path and on the
>> remove path (not so rare).
>>
>> Tested with the sysfs trigger driver.
>> The bfin & interrupt drivers were build tested & inspected only.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> This is certainly more consistent. 
> Lars, could you sanity check as well given the bfin timer is
> in here.

looks good.
