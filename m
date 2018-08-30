Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHaAEa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 20:04:30 -0400
Subject: Re: [linux-sunxi] [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180830162734.uq65l6ox6uwrmulo@core>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
Date: Thu, 30 Aug 2018 22:00:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180830162734.uq65l6ox6uwrmulo@core>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30.08.2018 18:27, Ondřej Jirman wrote:
>> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
>> +{
>> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>> +//			info->calibration_data[0]);
>> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>> +//			info->calibration_data[1]);
> This should probably be implemented, or left out completely.
> 
> regards,
>    o.
> 
Thanks you are right!
This should be implemented! I will fix this in the next version!

Thanks,
Philipp
