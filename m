Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbcA3OMh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 09:12:37 -0500
Subject: Re: [PATCH 1/2] staging:iio:adc:added space around '-'
To: Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
 <115dd2e3f67706fd323c18b23871068ad36dfa94.1452878721.git.bhumirks@gmail.com>
 <56995378.1010204@metafoo.de> <20160120142137.GC6370@mwanda>
 <56A4FD7F.6010800@kernel.org> <56A5068D.4080207@metafoo.de>
Cc: Bhumika Goyal <bhumirks@gmail.com>, devel@driverdev.osuosl.org,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACC4D2.8040802@kernel.org>
Date: Sat, 30 Jan 2016 14:12:34 +0000
MIME-Version: 1.0
In-Reply-To: <56A5068D.4080207@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/01/16 17:14, Lars-Peter Clausen wrote:
> On 01/24/2016 05:36 PM, Jonathan Cameron wrote:
>> On 20/01/16 14:21, Dan Carpenter wrote:
>>> On Fri, Jan 15, 2016 at 09:15:52PM +0100, Lars-Peter Clausen wrote:
>>>> On 01/15/2016 08:42 PM, Bhumika Goyal wrote:
>>>>> This patch adds apace around '-' operator.Found using checkpatch.pl
>>>>>
>>>>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>>>>> ---
>>>>>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
>>>>> index f45ebed..0c73bce 100644
>>>>> --- a/drivers/staging/iio/adc/ad7280a.c
>>>>> +++ b/drivers/staging/iio/adc/ad7280a.c
>>>>> @@ -744,14 +744,14 @@ out:
>>>>>  }
>>>>>  
>>>>>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
>>>>> -		in_voltage-voltage_thresh_low_value,
>>>>> +		in_voltage - voltage_thresh_low_value,
>>>>
>>>> Hi,
>>>>
>>>> Thanks for patch. But when sending cleanup patches like this please make
>>>> sure that you a) understand what the code does and how your change affects
>>>> it and b) as a bare minimum of testing perform a compile test, if possible
>>>> also do functional testing.
>>>>
>>>> The patch as it is, is neither semantically nor syntactically correct. As an
>>>> exercise please make sure you understand why.
>>>
>>> Ugh!
>>>
>>> It took me a long time to figure out the bug in this patch...  Why does
>>> that filename have a mix of dashes and underscores?  Too late to fix it
>>> now...  :/
>>>
>> Very deliberately.  The - is indicating it is a differential channel!
>> Literally A minus B.
>>
>> It's an awfully compact representation for maths ;)
>> This is obscured partly in this case as it's specifying an attribute
>> shared by a set of differential channels so it's the generalization
>> of
>> in_voltage0-voltage1_thresh_low_value
>> which does begin to slightly stretch the argument that it is nice and
>> clear ;(
> 
> One thing we should maybe take a look at is making it explicit that this is
> a string so it does not get picked up by checkpatch.
Make sense. Patches welcome :)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

