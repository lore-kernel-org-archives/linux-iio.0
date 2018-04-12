Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:54795
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbeDLSRG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Apr 2018 14:17:06 -0400
Subject: Re: [PATCH v5 1/2] iio:imu: inv_mpu6050: support more interrupt types
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20180409202128.5031-1-mkelly@xevo.com>
 <64b0a5c7-ee8d-d1ca-b3aa-a1801f19787c@invensense.com>
 <6e3f08f8-ec16-e67b-c68c-7020eb660b14@xevo.com>
 <2ab59fc6-49c9-7426-fe95-824a165cfefa@invensense.com>
 <ef871439-f42f-cb7d-6dc3-4e0c47ff8986@xevo.com>
 <3b0b5ed8-f224-e589-ce60-e1871e76b25a@invensense.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <67000b98-7db9-f16e-d468-bc688cc56342@xevo.com>
Date: Thu, 12 Apr 2018 11:16:54 -0700
MIME-Version: 1.0
In-Reply-To: <3b0b5ed8-f224-e589-ce60-e1871e76b25a@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/2018 08:01 AM, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> I've done further investigations on this issue, since I wasn't 
> understanding why we were loosing interrupts where we shouldn't. And I 
> think I found the root cause.
> 
> The irq handlers top and bottom are written in a way considering that 
> every interrupt will be handled by the top part in the hard irq handler, 
> even if the irq thread is still running in the bottom part. That's why 
> we are using a FIFO for storing multiple timestamps.
> 
> But by using triggered-buffer setup, we are using the ONESHOT irq mode 
> that is disabling irq until the thread processing is done. In this way, 
> we are never reliably catching data interrupts when the thread is 
> running, and there is no need to have a FIFO for storing timestamps.
> 
> The correct way would be to have the top part in the hard irq handler 
> without using ONESHOT mode, and use only the thread for reading FIFO 
> data in the triggered-buffer interrupt.
> 
> I have done a patch which is working correctly on my side. But since I 
> am not able to trigger the issue in the first time, I cannot guarantee 
> this is fixing the problem.
> 
> Martin,
> is it possible for you to test the following patch and tell me if it is 
> working better like that?
> 
> For sure, there is a conception issue here, because in the current setup 
> having a FIFO for storing timestamps is completely useless.
> 
> JB
> 

That's a good point, and sounds like a good change to me. Unfortunately 
it does not fix the issue I'm seeing, although I'm guessing it would 
improve it at high frequencies (though that's trickier to measure).

My issue is happening even at 10 Hz, in which the thread has ample time 
to complete before the next interrupt, so I think it's something related 
to the interrupt controller rather than this driver in particular.
