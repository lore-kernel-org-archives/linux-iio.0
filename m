Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4991 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbDIW06 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 9 Apr 2015 18:26:58 -0400
Message-ID: <5526FCB8.3000903@linux.intel.com>
Date: Thu, 09 Apr 2015 15:27:04 -0700
From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 1/1] iio: ltr301: Add support for ltr301
References: <cover.1428372691.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<f944512157939827cd6f06b29bb3d1181692e9c1.1428372691.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<552650FB.6000107@kernel.org> <CAEnQRZDje3kaJE+LHPi0NnGDFY3oRuY2Ewrvj4NCzwzypdyS+w@mail.gmail.com> <5526817C.8080608@kernel.org>
In-Reply-To: <5526817C.8080608@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 04/09/2015 06:41 AM, Jonathan Cameron wrote:
> On 09/04/15 13:20, Daniel Baluta wrote:
>> On Thu, Apr 9, 2015 at 1:14 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 07/04/15 03:16, Kuppuswamy Sathyanarayanan wrote:
>>>> Added support for Liteon 301 Ambient light sensor. Since
>>>> LTR-301 and LTR-501 are register compatible(and even have same
>>>> part id), LTR-501 driver has been extended to support both
>>>> devices. LTR-501 is similar to LTR-301 in ALS sensing, But the
>>>> only difference is, LTR-501 also supports proximity sensing.
>>>>
>>>> LTR-501 - ALS + Proximity combo
>>>> LTR-301 - ALS sensor.
>>>>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Patch naming convention
>>> iio:<name of driver>: Add support for ltr301
>>> so here would be
>>> iio:ltr501:Add support for ltr301.
>>>
>>> Otherwise, looks good to me.  A comment inline that it might
>>> make sense to introduced a ltr501_chip info structure and use
>>> static const struct ltr501_chip_info[2] = {
>>> [LTR301] = {
>>>         .info = ...
>>>         ....
>>>         },
>>> [LTR501] = {
>>> }};
>>>
>>> That way you make all the truely constant data apparently constant
>>> and loose the switch statement. It makes for an easier to review / simpler
>>> driver in the long run.
>>>
>>> I haven't checked but this is probably what Daniel was suggesting in
>>> his review for v1 of this patch.
>> Hi Sathya,
>>
>> I think the best approach to get this merged in would be for you
>> to rebase your ltr301 patches on my patches for ltr559.
>>
>> http://marc.info/?l=linux-kernel&m=142779827617036&w=2
>>
> yes, that would make a lot of sense.

Ok. I will rebase my patch on top of your patch.
>> Let me know if you have any questions.
>>
>> Daniel.
>>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

