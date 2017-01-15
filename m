Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37447 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdAOMYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 07:24:54 -0500
Subject: Re: [PATCH v2 2/2] iio: distance: srf08: add IIO driver for us ranger
To: Andreas Klinger <ak@it-klinger.de>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
References: <20170110184815.GA15532@andreas>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <54ad8bc2-905b-2481-1b42-539746f884cd@metafoo.de>
Date: Sun, 15 Jan 2017 13:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170110184815.GA15532@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/2017 07:48 PM, Andreas Klinger wrote:
[...]
> +	indio_dev->name = dev_name(&client->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. E.g. "srf08" in this case.

