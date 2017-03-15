Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58181 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdCOWAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:00:06 -0400
Subject: Re: [PATCH 0/3] pc104: Mask PC/104 Kconfig options
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
 <CACRpkdaqeLktgqmd6qcdGmruxABS0fWQacPOTYf0V24cKyiSRA@mail.gmail.com>
 <20170301204652.GA31812@sophia>
 <61fd7559-9001-ede7-f16d-2f74f8f9ef61@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <73b3264d-9167-d871-d218-cbfb96cb5b45@kernel.org>
Date: Wed, 15 Mar 2017 22:00:04 +0000
MIME-Version: 1.0
In-Reply-To: <61fd7559-9001-ede7-f16d-2f74f8f9ef61@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 12:48, Jonathan Cameron wrote:
> On 01/03/17 20:46, William Breathitt Gray wrote:
>> On Wed, Jan 11, 2017 at 04:26:19PM +0100, Linus Walleij wrote:
>>> On Tue, Jan 10, 2017 at 7:50 PM, William Breathitt Gray
>>> <vilhelm.gray@gmail.com> wrote:
>>>
>>>> PC/104 form factor devices serve a specific niche of embedded system
>>>> users. Since PC/104 devices and hardware are typically used by just a
>>>> subset of Linux users, it would be appropriate to filter PC/104 related
>>>> Kconfig options for those uninterested.
>>>>
>>>> This patchset introduces the PC104 Kconfig option, and uses it to mask
>>>> PC/104 specific device drivers and options, so that only those users
>>>> interested in PC/104 related Kconfig options are exposed to them.
>>>
>>> Tell me when/if the PC104 option is merged and I can merge the GPIO
>>> patch.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> Jonathan and Linus,
>>
>> Now that the PC104 option is merged for 4.11, it should be all right to
>> merge in the GPIO and IIO patches without worry of warnings. Please
>> merge the relevant patch to your respective tree after you pull in the
>> PC104 option.
> If it looks like I've forgotten this, feel free to poke me again!
> 
> At least replying to you should get it back into my recent threads
> in my email client ;)
> 
Done,. Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> Jonathan
>>
>> Thank you,
>>
>> William Breathitt Gray
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

