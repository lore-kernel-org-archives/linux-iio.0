Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57108 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbcLaOdw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2016 09:33:52 -0500
Subject: Re: [PATCH v2] iio: common: st_sensors: fix channel data parsing
To: Linus Walleij <linus.walleij@linaro.org>
References: <1479330928-7208-1-git-send-email-lorenzo.bianconi@st.com>
 <c773de82-3e67-871e-93fd-18b3cfe3a492@kernel.org>
 <CACRpkdabHPxr1J3MHY-kVZCnb42cxndmJNTXd0f2SBbE+M-UgQ@mail.gmail.com>
 <CACRpkdb--6YpW_+WnXXLU7nGw26=5vTBzkqcVJ2sq-t3Vbk+fg@mail.gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        lorenzo.bianconi@st.com, Gregor Boirie <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <66478d35-d0ba-b881-7e43-6768518c686e@kernel.org>
Date: Sat, 31 Dec 2016 14:33:48 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdb--6YpW_+WnXXLU7nGw26=5vTBzkqcVJ2sq-t3Vbk+fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/16 20:49, Linus Walleij wrote:
> On Sat, Nov 19, 2016 at 4:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Nov 19, 2016 at 2:07 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 16/11/16 21:15, Lorenzo Bianconi wrote:
>>>> Using realbits as i2c/spi read len, when that value is not byte aligned
>>>> (e.g 12 bits), lead to skip msb part of out data registers.
>>>> Fix this taking into account scan_type.shift in addition to
>>>> scan_type.realbits as read length:
>>>>
>>>> read_len = DIV_ROUND_UP(realbits + shift, 8)
>>>>
>>>> This fix has been tested on 8, 12, 16, 24 bit sensors
>>>>
>>>> Fixes: e7385de5291e ("iio:st_sensors: align on storagebits boundaries")
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>
>>> Do highlight (typically below the --) what changes have occurred.  I'm guessing this
>>> was mostly about testing on the 24 bit sensor and the additions in the core file.
>>>
>>> Applied to the fixes-togreg and marked for stable.  I will probably sit on this one
>>> for a few days before sending upstream if anyone has any final comments on it.
>>
>> Makes all kind of sense.
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> After making my 12bit LIS3LV02 work again it is also:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> And I think it should be tagged for stable.
Already was. In a bit of patch shuffling to avoid having multiple pull requests
I've cherry picked this one into the fixes-togreg-post-rc1 branch and added
Linus' tested-by.  Will send a pull request in a few minutes.

Jonathan
> 
> Yours,
> Linus Walleij
> 

