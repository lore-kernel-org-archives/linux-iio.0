Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:18866
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752525AbeEOVSY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 May 2018 17:18:24 -0400
Subject: Re: [PATCH 0/5] iio: imu: inv_mpu6050: add new timestamping mechanism
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <25d72583-0397-bbf0-2862-e003aa0ffd85@invensense.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <ae193cbf-30a2-880c-0180-88906e37cda2@xevo.com>
Date: Tue, 15 May 2018 14:18:18 -0700
MIME-Version: 1.0
In-Reply-To: <25d72583-0397-bbf0-2862-e003aa0ffd85@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/14/2018 02:05 PM, Jean-Baptiste Maneyrol wrote:
> The purpose of this series is to implement a new timestamping mechanism 
> able to cope with missing and delayed interrupts.
> 
> Since our system is not real-time, there will be cases where interrupts 
> with higher priorities will prevent the execution of our interrupt 
> handler. We need to be able to deal with it and keep an accurate 
> timestamp for data. We will not loose data since chips have a FIFO, but 
> we will loose interrupt timestamps.
> 
> The main idea in this mechanism is first to validate interrupt 
> timestamps, and then use them to estimate the chip internal clock from 
> system side. For validating an interrupt timestamp, we compute the delta 
> time between 2 interrupts and divide it by the chip divider to come back 
> to the chip internal 1KHz frequency. If the value matches 1KHz by +/- 
> 4%, we consider it to be valid. In this case, we use the interrupt 
> timestamps for the data and the computed interval for estimating the 
> chip internal frequency (doing a mean with the precedent value for a 
> low-pass filtering). If the value doesn't match the 4% criteria, we drop 
> the timestamp and we compute a new one using the precedent value and the 
> estimated chip frequency.
> 
> The first patches of the series are some cleanup needed for this 
> implementation :
> * patch 1: get rid of the timestamps FIFO (was in fact useless)
> * patch 2: replace fifo rate in Hz by the sample rate divider needed by 
> the timestamp mechanism. Sample rate divider is equivalent to fifo rate.
> * patch 3: fix fifo count reading by ignoring incomplete datum (can happen)
> * patch 4: fix fifo overflowing by using more accurate int status bit
> * patch 5: the new timestamp mechanism
> 
> Martin,
> any feedback from your platform where the issue appears a lot are welcome.
> 
> Thanks.
> JB

I like this approach. I tested the patch series on my troubled board and 
am happy to report it working nicely.

Tested-by: Martin Kelly <mkelly@xevo.com>
(for all the patches)
