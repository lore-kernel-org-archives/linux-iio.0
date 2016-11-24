Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33324 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965569AbcKXO0w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 09:26:52 -0500
Received: by mail-qk0-f174.google.com with SMTP id x190so50983327qkb.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2016 06:26:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161124053345.11254-3-shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com> <20161124053345.11254-3-shrirang.bagul@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Nov 2016 15:26:51 +0100
Message-ID: <CACRpkdazkanxGsQ6G=NrHc0duR46FLhA81BkZF4HpdxJECWHaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: st_accel: Support sensor i2c probe using acpi
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 24, 2016 at 6:33 AM, Shrirang Bagul
<shrirang.bagul@canonical.com> wrote:

> Add support to probe st_accel sensors on i2c bus using ACPI. Compatible
> strings are not avaialable on ACPI based systems.
>
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
(...)

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id st_accel_acpi_match[] = {
> +       {"SMO8A90", LNG2DM},
> +       { },
> +};

Why is ACPI only supporting one out of 14 devices?

Surely there are some out-of-tree ACPI platforms using one
or more of the others?

Apart from that it looks nice.

Yours,
Linus Walleij
