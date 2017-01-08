Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43300 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdAHKe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:34:29 -0500
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
To: Hans de Goede <hdegoede@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
 <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
 <20161230101501.06958c0d@jacob-builder>
 <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
 <20170103102343.735dbdd1@jacob-builder>
 <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
 <20170104095517.6f7ee610@jacob-builder>
 <c86f5ad2-f504-e2a9-32eb-d16d500a09fe@kernel.org>
 <9c0346ee-753f-97ef-5f43-f7b561baf2e9@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c9a8b592-9790-a0d7-7ec0-5d789cc34d6e@kernel.org>
Date: Sun, 8 Jan 2017 10:34:26 +0000
MIME-Version: 1.0
In-Reply-To: <9c0346ee-753f-97ef-5f43-f7b561baf2e9@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/17 10:15, Hans de Goede wrote:
> Hi,
> 
> On 07-01-17 23:23, Jonathan Cameron wrote:
>> On 04/01/17 17:55, Jacob Pan wrote:
>>> On Tue, 3 Jan 2017 23:10:57 +0100
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>>>> It could have been a quirk we had to do on our platforms, I just
>>>>> cannot recall the details. Are you testing this on x86 platforms?
>>>>
>>>> Yes, I've successfully tested this on 2 different models cherrytrail
>>>> tablets.
>>>
>>> [Jacob Pan] I am ok with your change. I last tested on baytrail
>>> tablets, I don't know if you have one available to verify. That would
>>> be ideal.
>>>
>> Stable material?  As I read this it is a fairly major fix, but we aren't
>> entirely sure there wasn't a reason on some platforms for this 'interesting'
>> corner of code?
>>
>> So basically are we sure this won't cause regressions? If so I'll take
>> it as a fix and mark for stable.
> 
> The main consumer of the axp288_adc code is the axp288_fuel_gauge driver,
> which until now was not really functional. It depended on platform data
> being attached to its mfd device, and the provider of that platform data
> never got merged.
> 
> I've got patches queued up for 4.11 fixing this. So in practice the chance
> of this patch causing regressions is close to 0 as so far it had no
> consumers, likewise adding a Cc: stable is not really useful.
Cool. I'll queue it for 4.11 as well then.

Applied to the togreg branch of iio.git which will be pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
> Regards,
> 
> Hans
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

