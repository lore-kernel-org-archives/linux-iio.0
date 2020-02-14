Return-Path: <SRS0=TOo6=4C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E8C2BA83
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5836E222C4
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581688417;
	bh=yh0Z4k/ppAgCkCNDYZ5URG46uPBI68lQzLESuFNZNsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TeJb+dgDuTGDtHqkCKJv4oAuxwCB8+DwhS6NftQqrKVl5KhKoS4lPvhYFZIcWTuKA
	 N9KS7ujI6SmYPtmf7FBjgR/MghsvRm4Xpv3LBbsuDk41e2jB+Ug5KEZJEC7uQPpB9N
	 w+tEcS3FWQP/w9CL+oWBPTjc9vSCEDlBiSxNR4Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgBNNxh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBNNxg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 08:53:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2A0206ED;
        Fri, 14 Feb 2020 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581688416;
        bh=yh0Z4k/ppAgCkCNDYZ5URG46uPBI68lQzLESuFNZNsw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wf078pn0m+dJnf/HXhUmz5pFFETglUm/OWClpJ9rCGtSOG4WjYZ6v8Ga/c9nG+W9z
         KrVh7vFKYoosbNNTMweTVUP8bFgemoARRTYsXVkqixX9kzqHZE7dXyUTZ7KtuhKKY1
         Yod+c2K8iFiDAMxVQoVoV88iDQuUv3ZXNUZeLZUg=
Date:   Fri, 14 Feb 2020 13:53:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200214135332.759b5316@archlinux>
In-Reply-To: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
References: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Feb 2020 22:13:07 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Amended HDC2010/2080 diver and sysfs documentation for its heater element.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

Sparse through up a brackets warning which made me take a closer look at this
line highlighted below.

> +	indio_dev->channels = hdc2010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
> +
> +	/* Enable Automatic Measurement Mode at 5Hz */
> +	hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
> +
> +	/*
> +	 * We enable both temp and humidity measurement.
> +	 * However the measurement won't start even in AMM until triggered.
> +	 */
> +	tmp = (u8)(~HDC2010_MEAS_CONF |
> +		   HDC2010_MEAS_TRIG & data->measurement_config) |
> +		HDC2010_MEAS_TRIG;
Sparse suggested brackets in this so it made me take a closer look.

I'm fairly sure that's the same as the more natural
(data->measurement_config & ~HDC2010_MEAS_CONF) | HDC2010_MEAS_TRIG;

What am I missing?

> +
> +	ret = i2c_smbus_write_byte_data(client,
> +					HDC2010_REG_MEASUREMENT_CONF, tmp);
> +	if (ret)
> +		return ret;
> +	data->measurement_config = tmp;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
