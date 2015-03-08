Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36964 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbbCHO41 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 10:56:27 -0400
Received: by wesx3 with SMTP id x3so22453508wes.4
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2015 07:56:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54FC2FB9.6090107@kernel.org>
References: <1425399478-5464-1-git-send-email-octavian.purdila@intel.com>
	<1425399478-5464-2-git-send-email-octavian.purdila@intel.com>
	<54FC2FB9.6090107@kernel.org>
Date: Sun, 8 Mar 2015 16:56:26 +0200
Message-ID: <CAE1zot+Bit_UxtWtSp9tAhhwsnkUm=rHzmgALRu1DrmhvpMgkw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: bmc150: change sampling frequency
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 8, 2015 at 1:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/03/15 16:17, Octavian Purdila wrote:
>> From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
>>
>> Currently driver reports device bandwidth list as available
>> sampling frequency. But sampling frequency is actually twice
>> the device bandwidth. This patch fixes this issue.
>>
>> Signed-off-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
> I was going to reject this on the basis that it should be using the
> low_pass_filter_3db_bandwidth rather than sampling frequency but in
> this device the two are tied together in a fashion not often seen.
>
> Anyhow, fair enough.
>
> It's probably going to make life messy with the rest of the series, but this
> is clearly a fix that wants to stable as well.
>
> Note Octavian that as you handled the patch it ought to have your sign off
> as well as Sathyanarayanan's.
>

Yes, I missed that, sorry about that. Here is the sign off, I assume
there is no need to send the series again just for this:

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>

> Jonathan
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 8004ce3..74ee54e 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -168,14 +168,14 @@ static const struct {
>>       int val;
>>       int val2;
>>       u8 bw_bits;
>> -} bmc150_accel_samp_freq_table[] = { {7, 810000, 0x08},
>> -                                  {15, 630000, 0x09},
>> -                                  {31, 250000, 0x0A},
>> -                                  {62, 500000, 0x0B},
>> -                                  {125, 0, 0x0C},
>> -                                  {250, 0, 0x0D},
>> -                                  {500, 0, 0x0E},
>> -                                  {1000, 0, 0x0F} };
>> +} bmc150_accel_samp_freq_table[] = { {15, 620000, 0x08},
>> +                                  {31, 260000, 0x09},
>> +                                  {62, 500000, 0x0A},
>> +                                  {125, 0, 0x0B},
>> +                                  {250, 0, 0x0C},
>> +                                  {500, 0, 0x0D},
>> +                                  {1000, 0, 0x0E},
>> +                                  {2000, 0, 0x0F} };
>>
>>  static const struct {
>>       int bw_bits;
>> @@ -783,7 +783,7 @@ static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
>>  }
>>
>>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>> -             "7.810000 15.630000 31.250000 62.500000 125 250 500 1000");
>> +             "15.620000 31.260000 62.50000 125 250 500 1000 2000");
>>
>>  static struct attribute *bmc150_accel_attributes[] = {
>>       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>
>
