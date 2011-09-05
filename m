Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55856 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753222Ab1IER6D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2011 13:58:03 -0400
Date: Mon, 5 Sep 2011 10:57:59 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:accel:lis3l02dq use regmap.
Message-ID: <20110905175758.GJ3889@opensource.wolfsonmicro.com>
References: <1315240395-6623-1-git-send-email-jic23@cam.ac.uk>
 <1315240395-6623-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315240395-6623-2-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 05, 2011 at 05:33:15PM +0100, Jonathan Cameron wrote:

> +static bool lis3l02dq_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	return (reg == LIS3L02DQ_REG_OFFSET_X_ADDR ||
> +		reg == LIS3L02DQ_REG_OFFSET_Y_ADDR ||
> +		reg == LIS3L02DQ_REG_OFFSET_Z_ADDR ||

These would all look nicer as switch statements I think - this doesn't
look terribly idiomatic.

> +static bool lis3l02dq_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	return (reg == LIS3L02DQ_REG_WAKE_UP_ACK_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_X_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_X_H_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Y_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Y_H_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Z_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Z_H_ADDR);	
> +}
> +/* Read the data registers might result in unexpected datardy signal
> + * so they have to be marked precious */
> +static bool lis3l02dq_reg_precious(struct device *dev, unsigned int reg)
> +{
> +	return (reg == LIS3L02DQ_REG_WAKE_UP_ACK_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_X_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_X_H_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Y_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Y_H_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Z_L_ADDR ||
> +		reg == LIS3L02DQ_REG_OUT_Z_H_ADDR);

These could perhaps be the same function?
