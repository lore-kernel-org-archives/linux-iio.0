Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54250 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdGXGHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2017 02:07:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170723141354.42646-5-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io> <20170723141354.42646-5-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 14:07:08 +0800
Message-ID: <CAGb2v677mjrwN5-0A0cxFQthkCOHqrSwQmAgXreBLo8oPWj14g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 4/5] ARM: sun8i: h3: add support for the
 thermal sensor in H3
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As we have gained the support for the thermal sensor in H3, we can now
> add its device nodes to the device tree.
>
> Add them to the H3 device tree.
>
> The H5 thermal sensor has some differences, and will be added furtherly.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Other than the possibility of referencing e-fuses for calibration data,
this patch looks good.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
