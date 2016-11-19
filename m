Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46732 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbcKSMf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 07:35:27 -0500
Subject: Re: [PATCH 1/2] iio: st_sensors: centralize I2C probe() code
To: Linus Walleij <linus.walleij@linaro.org>
References: <1478773133-23034-1-git-send-email-linus.walleij@linaro.org>
 <3761c454-10e5-ba26-bee3-2cc4df5025e0@kernel.org>
 <CACRpkdb7T3jm93AeTyg+c6to+8DStKw_DEC56_L9JAYcST8KpQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <86e5d69d-0a92-bd2f-3c26-ccafe40d69e3@kernel.org>
Date: Sat, 19 Nov 2016 12:35:24 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdb7T3jm93AeTyg+c6to+8DStKw_DEC56_L9JAYcST8KpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/11/16 12:25, Linus Walleij wrote:
> On Sat, Nov 12, 2016 at 5:11 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Also wondering why we ended up with the divide between generic
>> and specific where it was rather than as you have it here.
>> oh well.  Made sense at the time I guess ;)
> 
> This is not even all of it. There is still a bunch of code
> duplicated in all the subdrivers, but I'll try to collect it up
> and centralize it better.
Cool.

Feel free to bump this one if we don't here from Giuseppe or Denis over the next
week or so and I'll take a view on it as they are probably snowed under!

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

