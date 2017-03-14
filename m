Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32939 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdCNPW5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Mar 2017 11:22:57 -0400
Received: by mail-io0-f169.google.com with SMTP id f84so1605701ioj.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Mar 2017 08:22:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488300679-3259-3-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com> <1488300679-3259-3-git-send-email-fabrice.gasnier@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Mar 2017 16:22:54 +0100
Message-ID: <CACRpkdY9Xh8+Fe61ZQf6pa_ptNVaXj7DeTgtat4ZRNs3qzyGVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: trigger: add OF support
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 28, 2017 at 5:51 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Provide OF support. Device drivers can get IIO triggers from dt.
> Introduce IIO trigger specifiers, so there are:
> - IIO trigger providers, e.g. dt nodes designated with
>   #io-trigger-cells=<num of cells>
> - IIO trigger consumers, e.g. phandles listed in io-triggers = <...>.
>   Those can be identified by names by using 'io-trigger-names'.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is very elegant.

Yours,
Linus Walleij
