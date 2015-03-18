Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-145.synserver.de ([212.40.185.145]:1037 "EHLO
	smtp-out-133.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754949AbbCRJhv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2015 05:37:51 -0400
Message-ID: <55094775.7010102@metafoo.de>
Date: Wed, 18 Mar 2015 10:37:57 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v5 1/3] iio: add watermark logic to iio read and poll
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>	<1425491773-28499-2-git-send-email-octavian.purdila@intel.com>	<55094327.9040903@metafoo.de> <CAE1zot+ZJao0zDWNqpjH57oegiVq5E1kGM7dyAepUCd-REUSLQ@mail.gmail.com>
In-Reply-To: <CAE1zot+ZJao0zDWNqpjH57oegiVq5E1kGM7dyAepUCd-REUSLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/18/2015 10:29 AM, Octavian Purdila wrote:
> On Wed, Mar 18, 2015 at 11:19 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

>>> +static ssize_t iio_buffer_store_watermark(struct device *dev,
>>> +                                         struct device_attribute *attr,
>>> +                                         const char *buf,
>>> +                                         size_t len)
>>> +{
>>> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +       struct iio_buffer *buffer = indio_dev->buffer;
>>> +       unsigned int val;
>>> +       int ret;
>>> +
>>> +       ret = kstrtouint(buf, 10, &val);
>>> +       if (ret)
>>> +               return ret;
>>> +       if (!val)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&indio_dev->mlock);
>>> +
>>> +       if (val > buffer->length) {
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>
>>
>> This is missing the check for val == 0.
>>
>
> Unless I misunderstand you, the check is done right after kstrtouint()
> before taking the lock.

Yep, sorry overlooked that.

