Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46690 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbcKSM10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 07:27:26 -0500
Subject: Re: [PATCH v2] iio: accel: st_accel: inline per-sensor data
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1479119721-17935-1-git-send-email-linus.walleij@linaro.org>
 <CAA2SeNJffygfHO5T4NRP=gP3JvuO_Hfxu+ZH4k2NyeWPEogh4A@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b623635-f12f-a044-ade5-dac14e9b618f@kernel.org>
Date: Sat, 19 Nov 2016 12:27:22 +0000
MIME-Version: 1.0
In-Reply-To: <CAA2SeNJffygfHO5T4NRP=gP3JvuO_Hfxu+ZH4k2NyeWPEogh4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/11/16 09:20, Lorenzo Bianconi wrote:
>> We have #defines for all the individual sensor registers and
>> value/mask pairs #defined at the top of the file and used at
>> exactly one spot.
>>
>> This is usually good if the #defines give a meaning to the
>> opaque magic numbers.
>>
>> However in this case, the semantic meaning is inherent in the
>> name of the C99-addressable fields, and that means duplication
>> of information, and only makes the code hard to maintain since
>> you every time have to add a new #define AND update the site
>> where it is to be used.
>>
>> Get rid of the #defines and just open code the values into the
>> appropriate struct elements. Make sure to explicitly address
>> the .hz and .value fields in the st_sensor_odr_avl struct
>> so that the meaning of all values is clear.
>>
>> This patch is purely syntactic should have no semantic effect.
>>
>> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> 
Applied.

Thanks.

Jonathan

