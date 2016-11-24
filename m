Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32952 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965678AbcKXO2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 09:28:19 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so51013981qkb.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2016 06:28:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161124053345.11254-4-shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com> <20161124053345.11254-4-shrirang.bagul@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Nov 2016 15:28:00 +0100
Message-ID: <CACRpkdYJAwDgpuTYuXuTAxu3RBHeATEpbxq_xE3LxrJ7D9CKBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: st_pressure: Support i2c probe using acpi
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

> Compatible strings are not available on ACPI based systems. This patch adds
> support to use DSDT information read from platform BIOS instead for probing
> st pressure sensors.
>
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
(...)
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id st_press_acpi_match[] = {
> +       {"SNO9210", LPS22HB},
> +       { },
> +};

Same comment. One sensor only supported by ACPI really?

Take a wider look.

Yours,
Linus Walleij
