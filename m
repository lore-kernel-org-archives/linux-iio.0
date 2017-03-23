Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:45286 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdCWJxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 05:53:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170323093527.ojcdpvruzqnhvysq@earth>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com> <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
 <20170323093527.ojcdpvruzqnhvysq@earth>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 23 Mar 2017 17:52:47 +0800
Message-ID: <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X
 and AXP22X PMICs ADCs
To: Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Liam Breck <liam@networkimprov.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 23, 2017 at 5:35 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
>> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
>> Not sure if that was the intended usage of the new imply syntax though.
>
> I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
> as you will not end up with a long list.

I'd still need to add imply statements for the various subsystems though,
like regulators, power supplies, extcon, etc..
But I suppose that's cleaner, and fits the original intent of the syntax.

ChenYu
