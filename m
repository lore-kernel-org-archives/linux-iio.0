Return-Path: <jkosina@suse.cz>
Date: Thu, 14 Jun 2012 15:08:04 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/8] HID-Sensor: v2
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
Message-ID: <alpine.LNX.2.00.1206141507000.8644@pobox.suse.cz>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 9 Jun 2012, srinivas pandruvada wrote:

> Submitting v2.
> Changes compared to version 1:
> 
> - Replaced Ring-SW with KFiFO
> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
> - SysFS (
> --- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
> --- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
> --- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
> )
> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
> sensor have only channels, sampling_frequency and hyst_raw as the ABI.
> - Additional patch to enable ST Micro sensor hub 
> 
> TBD for v3
> - Use Lars-Peter's patch: "v2 1/9 patch: Add helper function for initialize trigger buffers). Want to make sure
> that API is final. 
> 
> DATA Format examples:
> Had few questions on data format for floating point. This spec uses.
> - First of size of each field is specified in report descriptor. So it is variable
> - It uses VT_F16Ex format. For example VTF16E0 means 16 bit float with unit exponent 0. 
> Refer to Page 43 of the "HID Sensor Usage Table"
> For example, if the size is 16 bits
> 0xFFF4 with VTF16E14 format -> -0.12
> 0xFFF8 with VTF16E14 format -> -0.08
> 0x0067 with VTF16E14 format -> +1.03
> 
> I tried sensor hubs from two different makers. One use 16 bit and other uses 32 bit for accelerometer.
> Also the unit expo is different for them. Also units are different.
> 
> Possible IIO addition:
> I wish we can add two more items for unit and unit_expo in IIO_CHAN_INFO_XXXX. So that we can add
> them during channel definition. Currently I am using offset and scale, which doesn't actually mean
> this. I think conversion should be done is user space based on the info provided.

Thanks for your work on this.

As this is however a staging driver (and depends on IIO, which is a 
staging infrastructure), I suggest you resend the patch to staging 
maintainers so that it gets applied and we can work on polishing the 
driver there.

Also, what are the plans regarding moving IIO out of staging, please?

-- 
Jiri Kosina
SUSE Labs
