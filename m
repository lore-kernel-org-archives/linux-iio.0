Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39256 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbFXSB6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2015 14:01:58 -0400
Message-ID: <558AF096.6060702@kernel.org>
Date: Wed, 24 Jun 2015 19:01:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: STK3310: un-invert proximity values
References: <1434539393-1451-1-git-send-email-tiberiu.a.breana@intel.com> <55868C77.2060407@kernel.org> <4586F61A4A291F4DA44D32824E7C0F402216B6EA@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F402216B6EA@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/06/15 10:41, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Sunday, June 21, 2015 1:06 PM
>> To: Breana, Tiberiu A; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH] iio: light: STK3310: un-invert proximity values
>>
>> On 17/06/15 12:09, Tiberiu Breana wrote:
>>> In accordance with the recent ABI changes, STK3310's proximity
>>> readings should be un-inversed in order to return low values for
>>> far-away objects and high values for close ones.
>>>
> 
> <snip>
> 
>>> -/*
>>> - * Maximum PS values with regard to scale. Used to export the 'inverse'
>>> - * PS value (high values for far objects, low values for near objects).
>>> - */
>>> +
>>> +/* Estimate maximum proximity values with regard to measurement
>>> +scale. */
>>>  static const int stk3310_ps_max[4] = {
>>> -	STK3310_PS_MAX_VAL / 64,
>>> -	STK3310_PS_MAX_VAL / 16,
>>> -	STK3310_PS_MAX_VAL /  4,
>>> -	STK3310_PS_MAX_VAL,
>>> +	STK3310_PS_MAX_VAL / 640,
>>> +	STK3310_PS_MAX_VAL / 160,
>>> +	STK3310_PS_MAX_VAL /  40,
>>> +	STK3310_PS_MAX_VAL /  10
>>>  };
>> What's this change about?  All uses of this array as present in this patch have
>> been removed.  It is used elsewhere for parameter sanity checking, but I
>> can't follow why it now needs to be divided by 10.
> 
> Indeed, these values are still used in _write_event for setting proximity interrupt
> threshold values. Truth is, they should have been divided by 10 from the start,
> but since all values were relative to the pre-defined maximum values, it didn't
> really matter. I used the higher max values because the readings would
> sometimes go over the expected range (when I press down on the sensor with
> my thumb), so the proximity readings became negative. But that shouldn't happen
> in the case of a real device, as the sensor is covered by at least a screen layer.
> 
> For the default scale of 0.1 real proximity readings max out at around 6500,
> roughly a tenth of the maximum theoretical value, as expected. Now that we're
> using un-inverted measurements, we can't use the same reference values as
> before - e.g. if the real maximum value is 6500, we can't allow setting a threshold
> of 30000 - it will never be reached.
> If you think this change warrants a separate patch, I'll split it.
> 
Perhaps just warrants a mention in the patch description!

