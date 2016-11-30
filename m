Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <1480393503.3233.5.camel@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com> <20161124053345.11254-4-shrirang.bagul@canonical.com> <CACRpkdYJAwDgpuTYuXuTAxu3RBHeATEpbxq_xE3LxrJ7D9CKBQ@mail.gmail.com> <c72ee668-196d-d29b-b58a-f290efe8c2a4@kernel.org> <1480393503.3233.5.camel@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/3] iio: st_pressure: Support i2c probe using acpi
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 30 Nov 2016 17:20:45 +0000
To: Shrirang Bagul <shrirang.bagul@canonical.com>,Jonathan Cameron <jic23@kernel.org>,Linus Walleij <linus.walleij@linaro.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald <pmeerw@pmeerw.net>,Denis CIOCCA <denis.ciocca@st.com>,Tiberiu Breana <tiberiu.a.breana@intel.com>,Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,Gregor Boirie <gregor.boirie@parrot.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <D9A97E68-AB9C-4DB5-B03A-D77801C09F12@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 29 November 2016 04:25:03 GMT+00:00, Shrirang Bagul <shrirang.bagul@canonical.com> wrote:
>On Sun, 2016-11-27 at 11:12 +0000, Jonathan Cameron wrote:
>> On 24/11/16 14:28, Linus Walleij wrote:
>> > On Thu, Nov 24, 2016 at 6:33 AM, Shrirang Bagul
>> > <shrirang.bagul@canonical.com> wrote:
>> > 
>> > > Compatible strings are not available on ACPI based systems. This
>patch
>> > > adds
>> > > support to use DSDT information read from platform BIOS instead
>for
>> > > probing
>> > > st pressure sensors.
>> > > 
>> > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>> > 
>> > (...)
>> > > +#ifdef CONFIG_ACPI
>> > > +static const struct acpi_device_id st_press_acpi_match[] = {
>> > > +       {"SNO9210", LPS22HB},
>> > > +       { },
>> > > +};
>> > 
>> > Same comment. One sensor only supported by ACPI really?
>> 
>> As demonstrated by this one, they are often registered under
>effectively
>> random names!
>> Digging out those random names and associating them with a particular
>chip is
>> always
>> going to be a non trivial job.
>> 
>> Hence I'm happy to take these as they stand.  We can add more entries
>when we
>> come
>> across them.
>> > 
>> > Take a wider look.
>Yes, I will.
>> 
>> Shirang has done a good job identifying this one and sending it
>upstream.
>> Be nice Linus and don't try to get him to do all the hard work ;)
>> 
>> As such applied to the togreg branch of iio.git. Will be pushed out
>as testing
>> for
>> the autobuilders to play with it.
>> 
>> Note there will be some weeks before I push this out as togreg (given
>merge
>> window
>> is about to open) so plenty of time for others to take a look!
>> 
>> Thanks,
>> 
>> Jonathan
>Thank you Jonathan. I'll follow-up on Linus's suggestion and try and
>identify
>more of these sensors on some of the hardware we have in the lab. and
>try to add
>support for some more devices.
Great! Thanks for looking into this.

J
>
>Thanks,
>Shrirang
>> > 
>> > Yours,
>> > Linus Walleij
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>linux-iio" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > 
>> 
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
