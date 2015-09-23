Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-198.synserver.de ([212.40.185.198]:1206 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754940AbbIWN3A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 09:29:00 -0400
Message-ID: <5602A8F6.5060403@metafoo.de>
Date: Wed, 23 Sep 2015 15:28:22 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Rosin <peda@lysator.liu.se>, linux-iio@vger.kernel.org
CC: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: mcp4531: Driver for Microchip digital potentiometers
References: <1443009454-14310-1-git-send-email-peda@lysator.liu.se> <1443009454-14310-3-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1443009454-14310-3-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/2015 01:57 PM, Peter Rosin wrote:
[...]

Looks pretty good.

One thing I'm concerned about is that this array

> +static const struct mcp4531_cfg mcp4531_cfg[] = {
> +	{ /* MCP4531-502 */ .wipers = 1, .max_pos = 128, .kohms =   5, },
> +	{ /* MCP4531-103 */ .wipers = 1, .max_pos = 128, .kohms =  10, },
> +	{ /* MCP4531-503 */ .wipers = 1, .max_pos = 128, .kohms =  50, },
> +	{ /* MCP4531-104 */ .wipers = 1, .max_pos = 128, .kohms = 100, },
[...]
> +};
> +

And the indices into the array defined here need to stay in sync. It is
really easy to mess this up by accident when a new entry is added. And it
will probably take a while to notice when this happens.

> +static const struct i2c_device_id mcp4531_id[] = {
> +	{ "mcp4531-502",  0 },
> +	{ "mcp4531-103",  1 },
> +	{ "mcp4531-503",  2 },
> +	{ "mcp4531-104",  3 },
[...]
> +	{}
> +};

I see two options to solve this. Either define a enum with all the different
devices and use a symbolic name for the indices.

E.g.

enum mcp4531_type {
	MCP4531_502,
	MCP4531_103,
	...
};

static const struct mcp5431_cfg mcp5431_cfg[] = {
	[MCP4531_502] = {.wipers = 1, .max_pos = 128, .kohms =   5, },
	[MCP4531_103] = {.wipers = 1, .max_pos = 128, .kohms =  10, },
	...
};

static const struct i2c_device_id mcp4531_id[] = {
	{ "mcp4531-502",  MCP4531_502 },
	{ "mcp4531-103",  MCP4531_103 },
	...
};

Or the second option is to directly assign the cfg struct as the driver data
in the device ID table.

E.g.

#define MCP4531_CFG(_wipers, _max_pos, _kohms) \
	(kernel_ulong_t)&(struct mcp4531_cfg) { \
		.wipers = _wipers, .max_pos = _max_pos, .kohms = _kohms }

static const struct i2c_device_id mcp4531_id[] = {
	{ "mcp4531-502",  MCP4531_CFG(1, 128, 5) },
	{ "mcp4531-103",  MCP4531_CFG(1, 128, 10) },
	...
};
