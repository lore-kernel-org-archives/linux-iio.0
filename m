Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab3KEVpS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2013 16:45:18 -0500
Message-ID: <52797533.7080803@kernel.org>
Date: Tue, 05 Nov 2013 22:46:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: Fix sign extension table in mcp3422 driver
References: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net> <CA+TH9VkZROpEd5=OgxNXHs=4DMnb3LMtmtedX+vrYtVzb1jEhw@mail.gmail.com> <5277FE37.5090606@kernel.org> <CA+TH9VnuA8tAG3dmQUzmyw2Hmm2r4s3eE5HzKro5rmg-LBEDqw@mail.gmail.com> <c8dcfdae-fb88-4885-9e04-29786ec3f46d@email.android.com>
In-Reply-To: <c8dcfdae-fb88-4885-9e04-29786ec3f46d@email.android.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/13 13:28, Jonathan Cameron wrote:
> Thanks. Given interesting merge window might be a few weeks before it hits mainline.
> 
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>> Hi jonathan,
>>
>> Yes, this patch should be applied.
>>
>> Acked-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,
>>
>> 2013/11/4 Jonathan Cameron <jic23@kernel.org>:
>>> On 11/02/13 22:09, Angelo Compagnucci wrote:
>>>> Hi Peter,
>>>>
>>>> You are totally right, index is 0 based and this is a bug!
>>>>
>>>> Thank your for fixing!
>>> If you are happy with a patch that effects your code, the convention
>> is
>>> to reply with
>>>
>>> Acked-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>>>
>>> to indicate this in the commit log.
>>>
>>> Do you mind me adding that to this patch?
>>>>
>>>> 2013/11/2 Peter Meerwald <pmeerw@pmeerw.net>:
>>>>> the index argument to sign_extend32() gives the bit position (from
>> 0)
>>>>> to the sign bit
>>>>>
>>>>> so e.g. if the measurement has 16-bit resolution, we need to pass
>> 15;
>>>>> a measurement of 0x8000 should be reported as -32768, not 32768
>>>>>
>>>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>>>>> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>>>>> ---
>>>>>  drivers/iio/adc/mcp3422.c | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>>>>> index 1294832..c8c1baa 100644
>>>>> --- a/drivers/iio/adc/mcp3422.c
>>>>> +++ b/drivers/iio/adc/mcp3422.c
>>>>> @@ -88,10 +88,10 @@ static const int mcp3422_sample_rates[4] = {
>>>>>
>>>>>  /* sample rates to sign extension table */
>>>>>  static const int mcp3422_sign_extend[4] = {
>>>>> -       [MCP3422_SRATE_240] = 12,
>>>>> -       [MCP3422_SRATE_60] = 14,
>>>>> -       [MCP3422_SRATE_15] = 16,
>>>>> -       [MCP3422_SRATE_3] = 18 };
>>>>> +       [MCP3422_SRATE_240] = 11,
>>>>> +       [MCP3422_SRATE_60] = 13,
>>>>> +       [MCP3422_SRATE_15] = 15,
>>>>> +       [MCP3422_SRATE_3] = 17 };
>>>>>
>>>>>  /* Client data (each client gets its own) */
>>>>>  struct mcp3422 {
>>>>> --
>>>>> 1.8.4.2
>>>>>
>>>>
>>>>
>>>>
> 
