Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <551C2E23.2080400@linux.intel.com>
Date: Wed, 01 Apr 2015 10:42:59 -0700
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: ltr301: Add support for ltr301
References: <cover.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<f807f1dedd46ef414e5b5160b4d5c8574ac5a2a7.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZBUS6LDLJUMWafVV4hs9kwovkSqD1Tg9XJA-ZkG3zuCyw@mail.gmail.com>
In-Reply-To: <CAEnQRZBUS6LDLJUMWafVV4hs9kwovkSqD1Tg9XJA-ZkG3zuCyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Daniel,

On 04/01/2015 08:34 AM, Daniel Baluta wrote:
> On Wed, Apr 1, 2015 at 7:06 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Added support for Liteon 301 Ambient light sensor. Since
>> LTR301 and LTR501 are register compatible(and even have same
>> part id), LTR501 driver has been extended to support both
>> devices. LTR501 is similar to LTR301 in ALS sensing, But the
>> only difference is, LTR501 also supports proximity sensing.
>>
>> LTR501 - ALS + Proximity combo
>> LTR301 - ALS sensor.
>>
>> Following are the data sheets for both devices:
>>
>> http://optoelectronics.liteon.com/upload/download/DS86-2013-0004/S_110_LTR-303ALS-01_DS_V1.pdf
>>
>> http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1[1].pdf
> One more thing. The datasheet you posted is for LTR303 not LTR301.
> Which chip are you adding support for?
No. I posted link for the wrong data sheet. I will fix it once I find a 
proper link.

But LTR301 is register compatible with LTR501. I have verified it once 
again.
>
> If indeed the datasheet link is correct, then although LTR303 and
> LTR501 are register compatbile at
> a first glance I spotted at least one difference.
>
> The ALS Control register is not the same.
>
> (e.g ALS Gain uses 1 bit for LTR501 and 3 bits for LTR303).
>
> thanks,
> Daniel.
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
