Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41185 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753582AbcK0LOy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:14:54 -0500
Subject: Re: [PATCH 2/3] iio: st_accel: Support sensor i2c probe using acpi
To: Linus Walleij <linus.walleij@linaro.org>,
        Shrirang Bagul <shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
 <20161124053345.11254-3-shrirang.bagul@canonical.com>
 <CACRpkdazkanxGsQ6G=NrHc0duR46FLhA81BkZF4HpdxJECWHaw@mail.gmail.com>
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
Message-ID: <fbc223ef-46e8-9fb2-92e7-a0d8b4cd04e3@kernel.org>
Date: Sun, 27 Nov 2016 11:14:47 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdazkanxGsQ6G=NrHc0duR46FLhA81BkZF4HpdxJECWHaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 14:26, Linus Walleij wrote:
> On Thu, Nov 24, 2016 at 6:33 AM, Shrirang Bagul
> <shrirang.bagul@canonical.com> wrote:
> 
>> Add support to probe st_accel sensors on i2c bus using ACPI. Compatible
>> strings are not avaialable on ACPI based systems.
>>
>> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> (...)
> 
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id st_accel_acpi_match[] = {
>> +       {"SMO8A90", LNG2DM},
>> +       { },
>> +};
> 
> Why is ACPI only supporting one out of 14 devices?
> 
> Surely there are some out-of-tree ACPI platforms using one
> or more of the others?
> 
> Apart from that it looks nice.
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Anyone know where the ACPI names come from? Is there some big
list somewhere to prevent clashes?

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

