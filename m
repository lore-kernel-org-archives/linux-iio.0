Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55539 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbcKASfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2016 14:35:18 -0400
Subject: Re: [PATCH v3] staging: iio: cdc: ad7746: add additional config
 defines
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
References: <1477643212-7200-1-git-send-email-eraretuya@gmail.com>
 <f59b10dc-e273-d147-611c-0fca52ee8bc0@kernel.org>
 <48d88156-88a9-dcc9-48d8-809d992c56e1@metafoo.de>
 <5ef0f1e1-236c-0698-cdfc-533125b2d2c7@kernel.org>
 <20161031074901.GA2207@Socrates-DK> <20161031080534.GB2207@Socrates-DK>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6d501ea0-aadb-a9d6-1cc9-d6146f1b0076@kernel.org>
Date: Tue, 1 Nov 2016 18:35:15 +0000
MIME-Version: 1.0
In-Reply-To: <20161031080534.GB2207@Socrates-DK>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 08:05, Eva Rachel Retuya wrote:
> On Mon, Oct 31, 2016 at 03:49:01PM +0800, Eva Rachel Retuya wrote:
>> On Sun, Oct 30, 2016 at 06:49:00PM +0000, Jonathan Cameron wrote:
>>> On 30/10/16 17:46, Lars-Peter Clausen wrote:
>>>> On 10/30/2016 06:41 PM, Jonathan Cameron wrote:
>>>>> On 28/10/16 09:26, Eva Rachel Retuya wrote:
>>>>>> Introduce defines for shifting and mask under the config register for
>>>>>> better readability. Also, introduce helper variables for index
>>>>>> calculation.
>>>>>>
>>>>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>>>>> Looks good to me.
>>>>>
>>>>> Lars could you sanity check this one as well?
>>>>
>>>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>> There was a bit of fun applying this.  Eva, can you check I didn't mess it
>>> up?
>>
>> It looks fine to me. Thanks!
>>
> 
> Have to retract that statement, I rebased and went through the merge
> conflict. Extra whitespace can be seen after the statement in line 644:
> 	*val = ad7746_cap_filter_rate_table[idx][0];
> 
Err I messed up.  Will fix... Will push out in a mo.

Jonathan
> What to do?
> Eva
> 
>>>
>>> Applied to the togreg branch of iio.git.  Initially pushed out as testing
>>> for the autobuilders to play with it. (and this time I remembered to actually
>>> do the push!)
>>>
>>> thanks,
>>>
>>> Jonathan
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

