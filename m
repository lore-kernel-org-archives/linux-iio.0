Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4FC61DA4
	for <linux-iio@archiver.kernel.org>; Wed, 22 Feb 2023 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBVPdF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjBVPdE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 10:33:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410152A17E;
        Wed, 22 Feb 2023 07:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB35D614AA;
        Wed, 22 Feb 2023 15:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC8AC433EF;
        Wed, 22 Feb 2023 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677079982;
        bh=txryyDE2882BFByD8yhgCuBO2UJpM5MCFYWdzJfIfD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+wtjBbZgEuC6t8L9rjCGlgp0JEKiSfbAi6PQx2k4O6aZhjJP5KVaHDju87nwePzp
         /ogARUEAAg50VOb0iCz/JZUt/DUvJo6lOecQS50bok4S6sC7kKpxWerumU9XG1qopj
         UmYdSjm0yVn7iAxAfXys2VbHFPYii5+kENcvnkBI0wzvyYmc5LT+70oH6LsAggaQze
         VlT7i689GGPsxp3pLAnkzvzOsGA4zU5xW9HOyGbnMPFAOJ+K/P5PXvE76IpxiLYLiy
         iVqrObHU7N+qHoAnLzpa5ys8XPHR1yDlJFzXzjdj33ly1EZKLgDAV7C+tNp2Dj/CSn
         ikC/0Kms3aTPw==
Date:   Wed, 22 Feb 2023 15:32:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y/Y1p/4Mc1Oy4dWl@google.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-6-okan.sahin@analog.com>
 <Y/S1ftKmV92TL8VO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/S1ftKmV92TL8VO@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Feb 2023, Andy Shevchenko wrote:

> On Tue, Feb 21, 2023 at 01:39:13PM +0300, Okan Sahin wrote:
> > MFD driver for MAX77541/MAX77540 to enable its sub
> > devices.
> > 
> > The MAX77541 is a multi-function devices. It includes
> > buck converter and ADC.
> > 
> > The MAX77540 is a high-efficiency buck converter
> > with two 3A switching phases.
> > 
> > They have same regmap except for ADC part of MAX77541.
> 
> Extra space in the Subject.
> 
> ...
> 
> > +#include <linux/of_device.h>
> 
> Why?
> 
> ...
> 
> > +static const struct regmap_config max77541_regmap_config = {
> > +	.reg_bits   = 8,
> > +	.val_bits   = 8,
> 
> Do you need lock of regmap?
> 
> > +};
> 
> ...
> 
> > +static const struct mfd_cell max77540_devs[] = {
> 
> > +	MFD_CELL_OF("max77540-regulator", NULL, NULL, 0, 0,
> > +		    NULL),
> 
> Perfectly one line.
> 
> > +};
> 
> > +static const struct mfd_cell max77541_devs[] = {
> > +	MFD_CELL_OF("max77541-regulator", NULL, NULL, 0, 0,
> > +		    NULL),
> > +	MFD_CELL_OF("max77541-adc", NULL, NULL, 0, 0,
> > +		    NULL),
> 
> Ditto.
> 
> > +};
> 
> ...
> 
> > +	if (max77541->chip->id == MAX77541) {
> > +		ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> > +					       IRQF_ONESHOT | IRQF_SHARED, 0,
> > +					       &max77541_adc_irq_chip,
> > +					       &max77541->irq_adc);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> > +	return ret;
> 
> return 0;
> 
> ...
> 
> > +static const struct i2c_device_id max77541_i2c_id[];
> 
> What for?
> 
> ...
> 
> > +	if (dev->of_node)
> > +		max77541->chip  = of_device_get_match_data(dev);
> > +	else
> > +		max77541->chip  = (struct chip_info *)
> > +					i2c_match_id(max77541_i2c_id,
> > +						     client)->driver_data;
> 
> Oh. Please use
> 
> 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> 	...
> 	max77541->chip  = device_get_match_data(dev); // needs property.h
> 	if (!max77541->chip)
> 		max77541->chip  = (struct chip_info *)id->driver_data;
> 
> > +	if (!max77541->chip)
> > +		return -EINVAL;
> 
> ...
> 
> > +#ifndef __MAX77541_MFD_H__
> > +#define __MAX77541_MFD_H__
> 
> Can we go towards consistency in this?
> Seems to me the most used patter so far is
> 
> #ifndef __LINUX_MFD_MAX77541_H

Drop the LINUX_ part please.

-- 
Lee Jones [李琼斯]
