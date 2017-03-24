Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48980 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756100AbdCXICh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 04:02:37 -0400
MIME-Version: 1.0
In-Reply-To: <13f2f8ba-af9e-576e-24ee-60c3a1609f80@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com> <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
 <20170323093527.ojcdpvruzqnhvysq@earth> <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
 <13f2f8ba-af9e-576e-24ee-60c3a1609f80@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 24 Mar 2017 16:01:37 +0800
Message-ID: <CAGb2v65whWFfHFi9BULqvh8to8BbQCub_phOS3wpFVNWuPER0A@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [RESEND PATCH v4 2/9] iio: adc: add support for
 X-Powers AXP20X and AXP22X PMICs ADCs
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 24, 2017 at 3:55 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi,
>
> On 23/03/2017 10:52, Chen-Yu Tsai wrote:
>> On Thu, Mar 23, 2017 at 5:35 PM, Sebastian Reichel <sre@kernel.org> wrote:
>>> Hi,
>>>
>>> On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
>>>> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
>>>> Not sure if that was the intended usage of the new imply syntax though.
>>>
>>> I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
>>> as you will not end up with a long list.
>>
>> I'd still need to add imply statements for the various subsystems though,
>> like regulators, power supplies, extcon, etc..
>> But I suppose that's cleaner, and fits the original intent of the syntax.
>>
>
> Hum. I don't really understand what you are saying.. Am I supposed to
> modify something or, is it okay and we're waiting for Lee to apply on
> his tree?
>
> Thanks in advance for clearing it up,
>
> Quentin

I'm just mentioning some follow up tasks I want to do.
The patch is fine and we're waiting for Lee to take it.

ChenYu
