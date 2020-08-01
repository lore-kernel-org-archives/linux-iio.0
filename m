Return-Path: <SRS0=1Shn=BL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81186C433E0
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559B4207FB
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596295804;
	bh=P8T+Tnd7uA29eNwgrQ7qBdEtBlOeKFxgx2mQ8vnK9WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YTdBDH+a93UuBiIE/q2FkPzxIOsRao/IGzk8GupymwCukReiF5PVEdVsijINKDo8A
	 WTTrLYdNaaTeM0zqf5/a+AdiN5cyNSvGf3SbQvHT1Xrzg9tkMEGwiPEe4eR967Slbg
	 af7UbVLU9f4mUUfgErPpTXSV797+xGLxyLxbkdwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHAPaD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAPaD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:30:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7EC2076B;
        Sat,  1 Aug 2020 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596295803;
        bh=P8T+Tnd7uA29eNwgrQ7qBdEtBlOeKFxgx2mQ8vnK9WQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B8/luOJzMSlo+rP8VED7ogHEJDNgOoss+z5BJpvM17Gvgff3Q7/KejW4MwThdFVrS
         w3Jym+NFTwWyiVyCyLnucjBlCvsWnq0NMAuSmbTJQTCC8Hj+4CNgG47eD+ohI0S2nH
         O89F6geEJHbHGQU1jSEZEH8Tz0uy2Zeu6AFoIiqI=
Date:   Sat, 1 Aug 2020 16:29:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: light: as73211: New driver
Message-ID: <20200801162958.56000bd0@archlinux>
In-Reply-To: <20200731070114.40471-3-ceggers@arri.de>
References: <20200731070114.40471-1-ceggers@arri.de>
        <20200731070114.40471-3-ceggers@arri.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 09:01:14 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
> 
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
> 
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.
> 
> Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
> Signed-off-by: Christian Eggers <ceggers@arri.de>

A question inline about flipping to config mode mid capture.

> ---
>  MAINTAINERS                 |   7 +
>  drivers/iio/light/Kconfig   |  15 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/as73211.c | 780 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 803 insertions(+)
>  create mode 100644 drivers/iio/light/as73211.c
> 
...
> +
> +static int as73211_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct as73211_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	/* Need to switch to config mode ... */

Is this safe whilst we are doing a capture?
You may want to claim_direct_mode for write_raw to ensure we don't get such a
race.

> +	if ((data->osr & AS73211_OSR_DOS_MASK) != AS73211_OSR_DOS_CONFIG) {
> +		data->osr &= ~AS73211_OSR_DOS_MASK;
> +		data->osr |= AS73211_OSR_DOS_CONFIG;
> +
> +		ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
> +		if (ret < 0)
> +			goto error_release;
> +	}
> +
> +	ret = _as73211_write_raw(indio_dev, chan, val, val2, mask);
> +
> +error_release:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}

