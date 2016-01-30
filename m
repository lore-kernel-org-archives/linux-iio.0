Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53504 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbcA3QGJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:06:09 -0500
Subject: Re: [PATCH] iio: ltr501: Use a signed return type for
 ltr501_match_samp_freq
To: Lucas Tanure <tanure@linux.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1453809982-3548-1-git-send-email-tanure@linux.com>
 <alpine.DEB.2.02.1601261309440.22166@pmeerw.net>
 <CAJX_Q+08m4d-gwkn=ZZN2ceq+GbtTGuWrTSX=3FJEJ9f=TGjKQ@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACDF6F.1060002@kernel.org>
Date: Sat, 30 Jan 2016 16:06:07 +0000
MIME-Version: 1.0
In-Reply-To: <CAJX_Q+08m4d-gwkn=ZZN2ceq+GbtTGuWrTSX=3FJEJ9f=TGjKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/16 12:12, Lucas Tanure wrote:
> Hi,
> 
> On Tue, Jan 26, 2016 at 10:10 AM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
>>
>>> The return type "unsigned int" was used by the ltr501_match_samp_freq function
>>> despite of the aspect that it will eventually return a negative error code.
>>> So, change to signed int and get the value by reference in the parameters.
>>
>> ok, or just change the return type to int w/o adding a new pointer
>> argument?
> Yeah, you explained better. =p
> Do you need me to resend ?
> 
Nope, I just dropped the controversial line as it was clear in the patch title.

Applied to the fixes-togreg-post4.5rc1 branch.

Thanks,

Jonathan
> Thanks!
> 
>>
>>> Done with the help of Coccinelle.
>>>
>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>> ---
>>>  drivers/iio/light/ltr501.c | 27 +++++++++++++++------------
>>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>>> index 809a961..99e8b12 100644
>>> --- a/drivers/iio/light/ltr501.c
>>> +++ b/drivers/iio/light/ltr501.c
>>> @@ -180,16 +180,19 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
>>>                       {500000, 2000000}
>>>  };
>>>
>>> -static unsigned int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
>>> -                                        int len, int val, int val2)
>>> +static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
>>> +                                        int len, int val, int val2,
>>> +                                        int *ret)
>>>  {
>>>       int i, freq;
>>>
>>>       freq = val * 1000000 + val2;
>>>
>>>       for (i = 0; i < len; i++) {
>>> -             if (tab[i].freq_val == freq)
>>> -                     return i;
>>> +             if (tab[i].freq_val == freq) {
>>> +                     *ret = i;
>>> +                     return 0;
>>> +             }
>>>       }
>>>
>>>       return -EINVAL;
>>> @@ -236,12 +239,12 @@ static int ltr501_als_write_samp_freq(struct ltr501_data *data,
>>>  {
>>>       int i, ret;
>>>
>>> -     i = ltr501_match_samp_freq(ltr501_als_samp_table,
>>> +     ret = ltr501_match_samp_freq(ltr501_als_samp_table,
>>>                                  ARRAY_SIZE(ltr501_als_samp_table),
>>> -                                val, val2);
>>> +                                val, val2, &i);
>>>
>>> -     if (i < 0)
>>> -             return i;
>>> +     if (ret < 0)
>>> +             return ret;
>>>
>>>       mutex_lock(&data->lock_als);
>>>       ret = regmap_field_write(data->reg_als_rate, i);
>>> @@ -255,12 +258,12 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
>>>  {
>>>       int i, ret;
>>>
>>> -     i = ltr501_match_samp_freq(ltr501_ps_samp_table,
>>> +     ret = ltr501_match_samp_freq(ltr501_ps_samp_table,
>>>                                  ARRAY_SIZE(ltr501_ps_samp_table),
>>> -                                val, val2);
>>> +                                val, val2, &i);
>>>
>>> -     if (i < 0)
>>> -             return i;
>>> +     if (ret < 0)
>>> +             return ret;
>>>
>>>       mutex_lock(&data->lock_ps);
>>>       ret = regmap_field_write(data->reg_ps_rate, i);
>>>
>>
>> --
>>
>> Peter Meerwald-Stadler
>> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

