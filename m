Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:10457 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754022AbdKJXvV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Nov 2017 18:51:21 -0500
Date: Fri, 10 Nov 2017 23:50:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: getting started w/ iio driver
Message-ID: <20171110235057.00005cd3@huawei.com>
In-Reply-To: <788bbd7f-28da-00b0-4008-a087373147b6@metux.net>
References: <4d347c06-b53a-de3d-f8f1-8e05684a4ebd@metux.net>
        <20171103071702.00005355@huawei.com>
        <d470edd4-a67f-7e1f-91b6-41ae22aea762@metux.net>
        <53418B0A3A5CEF439F1108674285B0A9014D15CC@lhreml523-mbs.china.huawei.com>
        <be9b39c0-01c1-7c57-3103-b04727dff857@metux.net>
        <38963561-8108-40CE-9B45-76672A860F0B@jic23.retrosnub.co.uk>
        <788bbd7f-28da-00b0-4008-a087373147b6@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 4 Nov 2017 21:51:34 +0100
"Enrico Weigelt, metux IT consult" <info@metux.net> wrote:

> On 04.11.2017 21:38, Jonathan Cameron wrote:
> 
> >> How should I implement the sampling rate setting w/ separate devices ?
> >> Maybe some master-slave concept where settings on the master
> >> automatically affect the slaves ?  
> > 
> > Yes it will be a bit ugly. Probably do it as a set of peers where writing any will change them all.  

Sorry, been a busy week - now have beer and am on right side of airport security ;)
> 
> Ok. By the way: how to set the sampling-rate via iio ?
> Is there a callback or device field for that ?
Yes - the raw_write callback will do it but you will also need to
add the IIO_CHAN_SPEC_SAMP_FREQ bit to the appropriate 
infomask_shared_by*
> 

> where should i tell the adc to start capture w/ ?
> in pre- or post-enable buffer ops ?

Conceptually in the post-enable.  The pre / post divide is
rather vague now as it the original plan to do it nice and cleanly
was flawed by some race conditions.  Now they both occur in a very
similar state...
> 
> 
> --mtx
> 
> 

