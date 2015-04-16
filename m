Return-Path: <lars@metafoo.de>
Message-ID: <552F54A0.7010902@metafoo.de>
Date: Thu, 16 Apr 2015 08:20:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Thomas Betker <thomas.betker@freenet.de>,
 linux-iio@vger.kernel.org
CC: Michal Simek <michal.simek@xilinx.com>, =?windows-1252?Q?S=F6ren_Br?=
 =?windows-1252?Q?inkmann?= <soren.brinkmann@xilinx.com>,
 Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: Re: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <552ECFF8.2070501@kernel.org>
In-Reply-To: <552ECFF8.2070501@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/15/2015 10:54 PM, Jonathan Cameron wrote:
[...]
>>      Note that .extend_name = "vccint", "vccaux", ... also has the side
>> effect of creating the sysfs nodes vccint_sampling_frequency,
>> vccaux_sampling_frequency, ... [due to .info_mask_shared_by_all =
>> BIT(IIO_CHAN_INFO_SAMP_FREQ)], which is probably not desired.
> This last one sounds like a bug and definitely isn't the intended result!
> The extended name should be ignored for shared_by values.

It was fixed a while ago, see 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=77bfa8baa0c230eb3d8acccd7d341f406a32cdf4
