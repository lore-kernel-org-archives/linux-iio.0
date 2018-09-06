Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:42831 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQkB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Sep 2018 12:40:01 -0400
Date: Thu, 06 Sep 2018 20:04:11 +0800
In-Reply-To: <20180906115114.inc6dhqhy47obo25@flea>
References: <20180830154518.29507-1-embed3d@gmail.com> <20180830154518.29507-28-embed3d@gmail.com> <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com> <55579dd6-625d-e71b-1482-4592dccac665@gmail.com> <20180906115114.inc6dhqhy47obo25@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [linux-sunxi] Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
To: maxime.ripard@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philipp Rossak <embed3d@gmail.com>
CC: Emmanuel Vadot <manu@bidouilliste.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



于 2018年9月6日 GMT+08:00 下午7:51:15, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>> > > +			/* Data cells */
>> > > +			thermal_calibration: calib@234 {
>> > > +				reg = <0x234 0x8>;
>> > > +			};
>> >   You are declaring 8 bytes of calibration data but to my knowledge
>it's
>> > only 2 bytes per sensor, so 2 bytes for H3.
>> >   Am I missing something ?
>> > 
>> >   Thanks,
>> 
>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2
>bytes for
>> H3, but the thermal calibration data field is on all chips 64 bit
>wide - so
>> 8 bytes. So I'm reading here the complete calibration data field.
>
>Having one cell per channel would make more sense I guess.

I have mentioned that this is impossible because of wrong
addressing caused by LE2BE in SID driver.

>
>Maxime
