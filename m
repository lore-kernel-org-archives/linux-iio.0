Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35880 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbdCFQs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2017 11:48:29 -0500
Received: by mail-qk0-f193.google.com with SMTP id n141so21875113qke.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Mar 2017 08:48:29 -0800 (PST)
Date: Mon, 6 Mar 2017 11:48:16 -0500
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc: jeff.dagenais@gmail.com
Subject: Re: [PATCH] iio: dac: Add support for ltc2632 DACs
Message-ID: <20170306164815.GA4185@localhost.localdomain>
References: <20170302190127.23157-1-maxime.roussinbelanger@gmail.com>
 <4cc58721-aca3-f8ef-4ad3-97983f71f264@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4cc58721-aca3-f8ef-4ad3-97983f71f264@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 06, 2017 at 11:24:58AM +0100, Lars-Peter Clausen wrote:
> On 03/02/2017 08:01 PM, Maxime Roussin-Belanger wrote:
> > +
> > +#define LTC2632_CMD_WRITE_INPUT_N               0x0
> > +#define LTC2632_CMD_UPDATE_DAC_N                0x1
> > +#define LTC2632_CMD_WRITE_INPUT_N_UPDATE_ALL    0x2
> > +#define LTC2632_CMD_WRITE_INPUT_N_UPDATE_N      0x3
> > +#define LTC2632_CMD_POWERDOWN_DAC_N             0x4
> > +#define LTC2632_CMD_POWERDOWN_CHIP              0x5
> > +#define LTC2632_CMD_INTERNAL_REFER              0x6
> > +#define LTC2632_CMD_EXTERNAL_REFER              0x7
> 
> Looks like the SPI versions of the  LTC I2C DACs already supported in
> ad5064.c. Since that driver has SPI support, we could support them there
> instead of a separate driver. Should be a lot less code.
> 

We considered it, but the ad5064 is complicated for the simple ltc2632. It
would complicated ad5064, I don't think it is worth it.

For example, we would need another spi_write, because the CMD shift and the
ADDR shift are not the same. The current support for LTC2632 doesn't support
midscale. It only has 2 channels.

We think this new ltc2632 driver could become the base for the rest of the
ltc2632 series as well as other similarly simple DACs.
