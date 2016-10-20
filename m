Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11597 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935180AbcJTMzj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 08:55:39 -0400
Message-ID: <5808BB3D.2020201@nvidia.com>
Date: Thu, 20 Oct 2016 18:10:29 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: =?UTF-8?B?UGF3ZcWCIEphcm9zeg==?= <paweljarosz3691@gmail.com>
CC: <linux-iio@vger.kernel.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature approximation
References: <20161018193147.GA14745@vaio-ubuntu>
In-Reply-To: <20161018193147.GA14745@vaio-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Wednesday 19 October 2016 01:01 AM, Paweł Jarosz wrote:
> In current version of the driver there is error in temperature
> calculation.
>
> So lets fix it using proper linear function.
>
> Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>

Per my calculation, existing and your equation is same as both are doing 
linear interpolation.

Only think I have seen is that I have used 1000 for two consecutive temp 
difference and you used (t2 - t1), so your is better in this case but 
still the equation is same.

The equation from you is

     t1 + (hi -val) * factor.

and existing one is
      t2 - (val -lo) * factor


factor is abs((t2-t1)/(hi-lo))

If my analysis is not correct then can you please provide the example 
with calculation for better understansing?


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
