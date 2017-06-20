Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33577 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFTL27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2017 07:28:59 -0400
Received: by mail-io0-f179.google.com with SMTP id t87so82508401ioe.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2017 04:28:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619200431.9615-2-lorenzo.bianconi@st.com>
References: <20170619200431.9615-1-lorenzo.bianconi@st.com> <20170619200431.9615-2-lorenzo.bianconi@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Jun 2017 13:28:58 +0200
Message-ID: <CACRpkdaH0E9XbP5_TgENXxffPEg9fAf_UNpu8tkObZ9enm0DXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: st_gyro: fix L3GD20H support
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Robert Dolca <robert.dolca@intel.com>,
        Denis CIOCCA <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 19, 2017 at 10:04 PM, Lorenzo Bianconi
<lorenzo.bianconi83@gmail.com> wrote:

> Add proper support for L3GD20H gyroscope sensor. In particular:
> - use L3GD20H as device name instead of L3GD20
> - fix available full scales
> - fix available sample frequencies
>
> Fixes: 9444a300c2be (IIO: Add support for L3GD20H gyroscope)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Is this then fixing the issue papered over by
commit a0657716416f834ef7710a9044614d50a36c3bdc
"iio:gyro: bug on L3GD20H gyroscope support"
?

Then we should probably state that as a Fixes: too.

Yours,
Linus Walleij
