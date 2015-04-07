Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <55242295.2090908@linux.intel.com>
Date: Tue, 07 Apr 2015 11:31:49 -0700
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 3/4] iio: ltr501: Add interrupt rate control support
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<01dd6c5e1f73bc2b1a170d750e7e81ca92171ce6.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZCbbiS=-0SJKBuT5BOtjRAsDuYSyUeOL=tj=xNg=ECxkA@mail.gmail.com>
In-Reply-To: <CAEnQRZCbbiS=-0SJKBuT5BOtjRAsDuYSyUeOL=tj=xNg=ECxkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 04/07/2015 03:36 AM, Daniel Baluta wrote:
> On Thu, Apr 2, 2015 at 6:51 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Added rate control support for ALS and proximity
>> threshold interrupts.
>>
>> Setting <n> to ALS intr_persist sysfs node would
>> generate interrupt whenever ALS data cross either
>> upper or lower threshold limits <n> number of times.
>> Similarly setting <m> to proximity intr_persist sysfs
>> node would genere interrupt whenever proximity data falls
>> outside threshold limit <m> number of times.
>
> Hi Sathya,
>
> We might have a problem here because _period attribute should
> be in seconds.
Thanks Daniel. I missed the units representation in the ABI doc. I work 
on creating a new ABI for representing the interrupt persistence and 
modify this patch to support it.
>
> See:
>
> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L785
>
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
