Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54462 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFQW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Sep 2018 12:22:56 -0400
Subject: Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
To: Emmanuel Vadot <manu@bidouilliste.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
Date: Thu, 6 Sep 2018 13:47:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04.09.2018 18:46, Emmanuel Vadot wrote:
>> +			/* Data cells */
>> +			thermal_calibration: calib@234 {
>> +				reg = <0x234 0x8>;
>> +			};
>   You are declaring 8 bytes of calibration data but to my knowledge it's
> only 2 bytes per sensor, so 2 bytes for H3.
>   Am I missing something ?
> 
>   Thanks,

Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes 
for H3, but the thermal calibration data field is on all chips 64 bit 
wide - so 8 bytes. So I'm reading here the complete calibration data field.

Philipp
