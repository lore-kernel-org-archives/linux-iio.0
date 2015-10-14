Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1058 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbbJNPMh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2015 11:12:37 -0400
Message-ID: <561E70E0.1010508@metafoo.de>
Date: Wed, 14 Oct 2015 17:12:32 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	mfuzzey@parkeon.com
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH v3] iio: mma8452: support either of the available interrupt
 pins
References: <1444828542-28861-1-git-send-email-martink@posteo.de>
In-Reply-To: <1444828542-28861-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/2015 03:15 PM, Martin Kepplinger wrote:
[...]
> +			if (irq1 > 0)
> +				client->irq = irq1;

You must not overwrite client->irq, that field is manged by the I2C core and
is supposed to be read only for device drivers.

> +			dev_info(&client->dev, "using interrupt line INT1\n");

This should probably be a dev_dbg()

> +		} else {
> +			client->irq = irq2;
> +			dev_info(&client->dev, "using interrupt line INT2\n");

Same here

> +		}
