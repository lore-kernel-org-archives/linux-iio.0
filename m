Return-Path: <lars@metafoo.de>
Message-ID: <5630977D.2020102@metafoo.de>
Date: Wed, 28 Oct 2015 10:38:05 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicola Corna <nicola@corna.info>, Wolfram Sang <wsa@the-dreams.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
References: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info> <1446015506-21371-1-git-send-email-nicola@corna.info>
In-Reply-To: <1446015506-21371-1-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/28/2015 07:58 AM, Nicola Corna wrote:
[...]
> +			holdmode = !((*client)->adapter->quirks &&
> +					(*client)->adapter->quirks->flags &
[...]
> +		   client->adapter->quirks &&
> +		   client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)

This is rather ugly, can we get a helper in the I2C core something along the
lines of

i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)

- Lars
