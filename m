Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E36D6A2.7030409@cam.ac.uk>
Date: Mon, 01 Aug 2011 17:38:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: impedance-analyzer: New driver for AD5933/4 Impedance
 Converter, Network Analyzer
References: <1312212513-2824-1-git-send-email-michael.hennerich@analog.com> <4E36D31A.6090807@cam.ac.uk>
In-Reply-To: <4E36D31A.6090807@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/01/11 17:23, Jonathan Cameron wrote:
> On 08/01/11 16:28, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The AD5933 is a high precision impedance converter system solution
>> that combines an on-board frequency generator with a 12-bit, 1 MSPS,
>> analog-to-digital converter (ADC). The frequency generator allows an
>> external complex impedance to be excited with a known frequency.
>>
>> The response signal from the impedance is sampled by the on-board ADC
>> and a discrete Fourier transform (DFT) is processed by an on-chip DSP engine.
>> The DFT algorithm returns a real (R) and imaginary (I) data-word at each
>> output frequency.
>>
>> Changes since V1:
>>
>> Apply list review feedback:
>> Consistently use poll_time_jiffies.
>> Use be|le cpu endian helpers where applicable.
>> Add various comments.
>>
> I think next kernel is intended to be 3.1 not 3.0.1?  
> 
> Please do some more build tests... Missing semicolons on 414, 422.
> ad5933_default_pdata should be static. Data undefined at 209.
> All trivial stuff though so not to worry from review point of view.
> 
> Will pull fixed version into iio-blue when you send it to Greg
> (below everything else).
I've pushed out an updated version of iio-blue.git with this driver
near the bottom (post the above mentioned trivial fixes).  I'll fixup
anything else when Greg has merged this driver into staging-next.

Also in the new version of iio-blue are some static checker found bug
fixes in various drivers.  Most of them are my errors and obvious.

I'll post them formally at some point.

Jonathan
