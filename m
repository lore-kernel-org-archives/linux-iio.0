Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33424 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdCXHze (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 03:55:34 -0400
Subject: Re: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X
 and AXP22X PMICs ADCs
To: Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com>
 <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
 <20170323093527.ojcdpvruzqnhvysq@earth>
 <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Liam Breck <liam@networkimprov.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <13f2f8ba-af9e-576e-24ee-60c3a1609f80@free-electrons.com>
Date: Fri, 24 Mar 2017 08:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 23/03/2017 10:52, Chen-Yu Tsai wrote:
> On Thu, Mar 23, 2017 at 5:35 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> Hi,
>>
>> On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
>>> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
>>> Not sure if that was the intended usage of the new imply syntax though.
>>
>> I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
>> as you will not end up with a long list.
> 
> I'd still need to add imply statements for the various subsystems though,
> like regulators, power supplies, extcon, etc..
> But I suppose that's cleaner, and fits the original intent of the syntax.
> 

Hum. I don't really understand what you are saying.. Am I supposed to
modify something or, is it okay and we're waiting for Lee to apply on
his tree?

Thanks in advance for clearing it up,

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
