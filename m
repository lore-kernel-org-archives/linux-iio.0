Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40960 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdAaEMV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 23:12:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170129163513.m7y4vbjgthh2esg4@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-12-quentin.schulz@free-electrons.com> <20170129163513.m7y4vbjgthh2esg4@earth>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 31 Jan 2017 12:11:06 +0800
Message-ID: <CAGb2v67P8fnDtAa15BprbDqBH62zb6LEpvwLj1O=UoGMnO2p5Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
To: Sebastian Reichel <sre@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 30, 2017 at 12:35 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Fri, Jan 27, 2017 at 09:54:44AM +0100, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
>> supply.
>>
>> This adds the AC power supply driver to the MFD cells of the AXP22X
>> PMICs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> Acked-By: Sebastian Reichel <sre@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
