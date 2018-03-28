Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:14800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752258AbeC1AeJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Mar 2018 20:34:09 -0400
Subject: Re: How to handle missing timestamps? (was Re: [PATCH] iio: imu:
 inv_mpu6050: improve missing timestamp handling)
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20180324000240.19519-1-mkelly@xevo.com>
 <20180324123519.0acba88e@archlinux>
 <7c1718f2fc324eb6b959257a80e136cdCY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <cc66bed2-ef59-ea75-d26d-f5ed55b55a65@xevo.com>
 <CY4PR1201MB0184826F66D8C1439D2FA6D1C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <d18234ce-f311-17df-1281-26ea3f035e13@xevo.com>
Date: Tue, 27 Mar 2018 17:34:02 -0700
MIME-Version: 1.0
In-Reply-To: <CY4PR1201MB0184826F66D8C1439D2FA6D1C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/27/2018 01:47 AM, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> this raises a good question of which interrupts we are missing (the oldest ones or the newest ones).
> 
> My bet would be that we are loosing interrupts from the newest data (the irq thread can take too much time and we loose interrupt). In this case manual timestamping would rather be:
> 
> sample 0 (oldest timestamp): interrupt timestamp
> sample 1: interrupt timestamp + 0.1 seconds
> sample 2: interrupt timestamp + 0.2 seconds
> sample 3 (newest timestamp): interrupt timestamp + 0.3 seconds
> 
> Can you check with your setup that this is really what is happening?
> 

Yes, good point. I did a lot of testing and determined that the sequence 
of events is something like this:

IRQ --> timestamp
new datum
new datum
new datum
IRQ --> timestamp

Specifically:
- At 50 Hz, interrupts are being generated at about 30 Hz.
- The timestamps in the FIFO correspond to the *newest* data, not the 
oldest.

I tried interpolating using both assumptions: timestamps corresponding 
to oldest and then to newest data. Using timestamps corresponding to 
oldest data, we get timestamps that are not monotonically increasing and 
thus time moving backwards as the data flows. Using timestamps 
corresponding to oldest data, we get monotonically increasing time as it 
should be, and the data looks pretty consistent.

What I settled on is to use the newer timestamps we see to backdate the 
older data, the ones we remove first from the FIFO. It appears to be 
working nicely.

I sent a v2 of the patch that does this interpolation.
