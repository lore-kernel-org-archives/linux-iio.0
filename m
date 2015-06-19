Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36570 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbFSGpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jun 2015 02:45:51 -0400
Received: by igbiq7 with SMTP id iq7so7919895igb.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2015 23:45:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5582E038.3090207@metafoo.de>
References: <CAM=Q2cucHAsMEYb-YtB2oU9d7wHk-KD+XVCMtuNMbaBqqn4+Cw@mail.gmail.com>
	<5582E038.3090207@metafoo.de>
Date: Fri, 19 Jun 2015 12:15:51 +0530
Message-ID: <CAM=Q2cv5r=F25uFpZXUQh1vj3Dd+a91hJoQ2A+oBdPhTMts+qg@mail.gmail.com>
Subject: Re: JESD204B support
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 18, 2015 at 8:44 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/18/2015 02:46 PM, Shubhrajyoti Datta wrote:
>>
>> Hi ,
>>
>> I was wondering if there is any plans or existing support for JESD204B.
>> I was thinking of IIO. However any other ideas may be welcome.
>
>
> Yes, IIO is the way to go. We have some out-of-tree drivers for JESD204B
> chips.

Great.

> They are not quite ready yet,  but we'll get there
May be sharing early could get some alignment.


The thing is the data rate change and the related clock tree
dependencies that it may bring.
That part looked tricky to me. So thought of talking to the community
before sketching something
not compatible. :-)

>
> - Lars
>
