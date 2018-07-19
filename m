Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:49632
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730382AbeGSJE3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Jul 2018 05:04:29 -0400
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
To: Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Joe Perches <joe@perches.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
 <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
Date: Thu, 19 Jul 2018 10:22:07 +0200
MIME-Version: 1.0
In-Reply-To: <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> On 07/18/2018 01:12 PM, Manish Narani wrote:
>> This patch fix the following checkpatch warning in xadc driver.
>> - Reusing the krealloc arg is almost always a bug.
>>
>> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
>> warning.
>>
> 
> This is a bug in checkpatch and should be fixed in checkpatch. The code is
> not actually re-using the parameter. channels and xadc_channels are
> independent variables, just checkpatch somehow does not realize this.

I think it should be fine to have this patch in tree. Change in commit
message to reflect this should be enough. But that's just view.

Thanks,
Michal
