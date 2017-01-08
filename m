Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162901AbdAHKPa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Jan 2017 05:15:30 -0500
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
To: Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
 <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
 <20161230101501.06958c0d@jacob-builder>
 <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
 <20170103102343.735dbdd1@jacob-builder>
 <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
 <20170104095517.6f7ee610@jacob-builder>
 <c86f5ad2-f504-e2a9-32eb-d16d500a09fe@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c0346ee-753f-97ef-5f43-f7b561baf2e9@redhat.com>
Date: Sun, 8 Jan 2017 11:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <c86f5ad2-f504-e2a9-32eb-d16d500a09fe@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 07-01-17 23:23, Jonathan Cameron wrote:
> On 04/01/17 17:55, Jacob Pan wrote:
>> On Tue, 3 Jan 2017 23:10:57 +0100
>> Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>>> It could have been a quirk we had to do on our platforms, I just
>>>> cannot recall the details. Are you testing this on x86 platforms?
>>>
>>> Yes, I've successfully tested this on 2 different models cherrytrail
>>> tablets.
>>
>> [Jacob Pan] I am ok with your change. I last tested on baytrail
>> tablets, I don't know if you have one available to verify. That would
>> be ideal.
>>
> Stable material?  As I read this it is a fairly major fix, but we aren't
> entirely sure there wasn't a reason on some platforms for this 'interesting'
> corner of code?
>
> So basically are we sure this won't cause regressions? If so I'll take
> it as a fix and mark for stable.

The main consumer of the axp288_adc code is the axp288_fuel_gauge driver,
which until now was not really functional. It depended on platform data
being attached to its mfd device, and the provider of that platform data
never got merged.

I've got patches queued up for 4.11 fixing this. So in practice the chance
of this patch causing regressions is close to 0 as so far it had no
consumers, likewise adding a Cc: stable is not really useful.

Regards,

Hans
