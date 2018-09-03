Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbeICVum (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Sep 2018 17:50:42 -0400
Date: Mon, 3 Sep 2018 18:29:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180903182927.344858c4@archlinux>
In-Reply-To: <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-19-embed3d@gmail.com>
        <20180902211125.0098c808@archlinux>
        <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 3 Sep 2018 15:58:30 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> On 02.09.2018 22:11, Jonathan Cameron wrote:
> > This feels like a good place to factor out the code into a utility
> > function that just does one of them.  That should hopefully
> > reduce the indenting etc enough to make the code easier to read.
> >   
> >> +		info->tzds[i].info = info;
> >> +		info->tzds[i].sensor_id = i;
> >> +
> >> +		info->tzds[i].tzd = thermal_zone_of_sensor_register(
> >> +				info->sensor_device,
> >> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
> >> +		/*
> >> +		 * Do not fail driver probing when failing to register in
> >> +		 * thermal because no thermal DT node is found.
> >> +		 */
> >> +		if (IS_ERR(info->tzds[i].tzd) && \
> >> +				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
> >> +			dev_err(&pdev->dev,
> >> +				"could not register thermal sensor: %ld\n",
> >> +				PTR_ERR(info->tzds[i].tzd));
> >> +			return PTR_ERR(info->tzds[i].tzd);
> >> +		}  
> 
> So this code above should be placed in a separate function and called by 
> the for loop?
> Did I understand that right?
Yes - exactly.

> 
> Philipp
