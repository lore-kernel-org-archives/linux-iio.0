Return-Path: <info@metux.net>
Subject: Re: getting started w/ iio driver
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <4d347c06-b53a-de3d-f8f1-8e05684a4ebd@metux.net>
 <20171103071702.00005355@huawei.com>
 <d470edd4-a67f-7e1f-91b6-41ae22aea762@metux.net>
 <53418B0A3A5CEF439F1108674285B0A9014D15CC@lhreml523-mbs.china.huawei.com>
 <be9b39c0-01c1-7c57-3103-b04727dff857@metux.net>
 <38963561-8108-40CE-9B45-76672A860F0B@jic23.retrosnub.co.uk>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <788bbd7f-28da-00b0-4008-a087373147b6@metux.net>
Date: Sat, 4 Nov 2017 21:51:34 +0100
MIME-Version: 1.0
In-Reply-To: <38963561-8108-40CE-9B45-76672A860F0B@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04.11.2017 21:38, Jonathan Cameron wrote:

>> How should I implement the sampling rate setting w/ separate devices ?
>> Maybe some master-slave concept where settings on the master
>> automatically affect the slaves ?
> 
> Yes it will be a bit ugly. Probably do it as a set of peers where writing any will change them all.

Ok. By the way: how to set the sampling-rate via iio ?
Is there a callback or device field for that ?

where should i tell the adc to start capture w/ ?
in pre- or post-enable buffer ops ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
