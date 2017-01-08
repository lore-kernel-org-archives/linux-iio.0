Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43186 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966107AbdAHKmH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:42:07 -0500
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
 <d6661ff6-442c-5535-aec2-35066577f119@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <4b893807-99c2-f0ba-9eec-d93c52c2f151@free-electrons.com>
Date: Sun, 8 Jan 2017 11:41:58 +0100
MIME-Version: 1.0
In-Reply-To: <d6661ff6-442c-5535-aec2-35066577f119@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 07/01/2017 20:31, Jonathan Cameron wrote:
> On 02/01/17 11:37, Quentin Schulz wrote:
[...]
>> +		/*
>> +		 * IIO framework gives mV but Power Supply framework gives µV.
>> +		 */
> single line comment syntax throughout or we'll have to face a patch 'fixing' it.

I actually had to make it a multiple lines comment to make checkpatch
happy. Maybe there is something with the encoding of the µ symbol? I'll
retry with a u instead and let you know.

[...]

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
