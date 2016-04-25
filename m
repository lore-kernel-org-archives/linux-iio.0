Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 3/5] iio: inv_mpu6050: Check WHO_AM_I register on probe
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1461156671.git.leonard.crestez@intel.com>
 <de4fc83c1c049176bbea7eeb4617166df593dcee.1461156671.git.leonard.crestez@intel.com>
 <db4459f9-7cb4-ff85-658d-a21f363aee3a@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <571DFCE7.1030300@intel.com>
Date: Mon, 25 Apr 2016 14:17:59 +0300
MIME-Version: 1.0
In-Reply-To: <db4459f9-7cb4-ff85-658d-a21f363aee3a@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2016 02:14 PM, Jonathan Cameron wrote:
> On 20/04/16 14:15, Crestez Dan Leonard wrote:
>> This can be used to distinguish mpu6500. This is a warning rather than
>> an error because the differences are mostly irrelevant and it's nice to
>> avoid breaking users with slightly incorrect ACPI/DT.
>>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Would we be better off fixing their configuration though by using the right part
> if we can identify it?  So if wrong, maybe we should search the info table to 
> figure out what it is?  I'm not certain on this though as then we are trying to
> deal with unknown future cases - maybe what you have here is the best balance.

I'm not sure about that. One issue is that 6000/6050/9150 have the same
WHOAMI value and can't be distinguished this way. They also seem to
identical interfaces. Models MPU6500 and MPU9250 report different WHOAMI
values.

Changing chip_type based on the WHOAMI would require some additional
refactoring. Placing that in a separate patch might be worthwhile anyway.

>> +#define INV_MPU6050_REG_WHOAMI			117
>> +
>> +#define INV_MPU6000_WHOAMI_VALUE		0x68
>> +#define INV_MPU6050_WHOAMI_VALUE		0x68
>> +#define INV_MPU6500_WHOAMI_VALUE		0x70
