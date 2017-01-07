Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43042 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933636AbdAHJss (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:48 -0500
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
 <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
 <20161230101501.06958c0d@jacob-builder>
 <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
 <20170103102343.735dbdd1@jacob-builder>
 <221c8f4e-0757-19bb-90db-4e34677734c5@redhat.com>
 <20170104095517.6f7ee610@jacob-builder>
Cc: Chen-Yu Tsai <wens@csie.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c86f5ad2-f504-e2a9-32eb-d16d500a09fe@kernel.org>
Date: Sat, 7 Jan 2017 22:23:47 +0000
MIME-Version: 1.0
In-Reply-To: <20170104095517.6f7ee610@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 17:55, Jacob Pan wrote:
> On Tue, 3 Jan 2017 23:10:57 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>>> It could have been a quirk we had to do on our platforms, I just
>>> cannot recall the details. Are you testing this on x86 platforms?  
>>
>> Yes, I've successfully tested this on 2 different models cherrytrail
>> tablets.
> 
> [Jacob Pan] I am ok with your change. I last tested on baytrail
> tablets, I don't know if you have one available to verify. That would
> be ideal.
> 
Stable material?  As I read this it is a fairly major fix, but we aren't
entirely sure there wasn't a reason on some platforms for this 'interesting'
corner of code?  

So basically are we sure this won't cause regressions? If so I'll take
it as a fix and mark for stable.

Thanks,

Jonathan
> Thanks,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

