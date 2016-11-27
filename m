Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41160 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbcK0LM6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:12:58 -0500
Subject: Re: [PATCH 3/3] iio: st_pressure: Support i2c probe using acpi
To: Linus Walleij <linus.walleij@linaro.org>,
        Shrirang Bagul <shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
 <20161124053345.11254-4-shrirang.bagul@canonical.com>
 <CACRpkdYJAwDgpuTYuXuTAxu3RBHeATEpbxq_xE3LxrJ7D9CKBQ@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c72ee668-196d-d29b-b58a-f290efe8c2a4@kernel.org>
Date: Sun, 27 Nov 2016 11:12:54 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdYJAwDgpuTYuXuTAxu3RBHeATEpbxq_xE3LxrJ7D9CKBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 14:28, Linus Walleij wrote:
> On Thu, Nov 24, 2016 at 6:33 AM, Shrirang Bagul
> <shrirang.bagul@canonical.com> wrote:
> 
>> Compatible strings are not available on ACPI based systems. This patch adds
>> support to use DSDT information read from platform BIOS instead for probing
>> st pressure sensors.
>>
>> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> (...)
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id st_press_acpi_match[] = {
>> +       {"SNO9210", LPS22HB},
>> +       { },
>> +};
> 
> Same comment. One sensor only supported by ACPI really?
As demonstrated by this one, they are often registered under effectively random names!
Digging out those random names and associating them with a particular chip is always
going to be a non trivial job.

Hence I'm happy to take these as they stand.  We can add more entries when we come
across them.
> 
> Take a wider look.
Shirang has done a good job identifying this one and sending it upstream.
Be nice Linus and don't try to get him to do all the hard work ;)

As such applied to the togreg branch of iio.git. Will be pushed out as testing for
the autobuilders to play with it.

Note there will be some weeks before I push this out as togreg (given merge window
is about to open) so plenty of time for others to take a look!

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

