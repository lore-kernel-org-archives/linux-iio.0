Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:39816 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758764AbdCVDca (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 23:32:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170321153611.16228-3-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com> <20170321153611.16228-3-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 22 Mar 2017 11:31:54 +0800
Message-ID: <CAGb2v64MHK7A-FhZR5KBbDji4VvnhJukqDz0Ude-LjS2YgVVfA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] ARM: sun8i: a33: add all operating points
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds almost all operating points allowed for the A33 as defined by
> fex files available at:
> https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33
>
> There are more possible frequencies in this patch than there are in the
> fex files because the fex files only give an interval of possible
> frequencies for a given voltage. All supported frequencies are defined
> in the original driver code in Allwinner vendor tree.
>
> There are two missing frequencies though: 1104MHz and 1200MHz which
> require the CPU to have 1.32V supplied, which is higher than the default
> voltage.
>
> Without all A33 boards defining the CPU regulator, we cannot have these
> two frequencies as it would cause the CPU to try to run a higher
> frequency without "overvolting" which is very likely to crash the CPU.
>
> Therefore, these two frequencies must be enabled on a per-board basis.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
