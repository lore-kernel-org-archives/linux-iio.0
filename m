Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA090C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75666217D7
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548601646;
	bh=wijys3Fvl7GTbymGO3hqJMq834shSsXCs8R8URg3mDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tTpQUC0SvwWG7P/UXOb1Nq0pTIH9GBVE10D8TxM8e5ueUrTSrS5sPn2Z/IRIaLry3
	 mfk7XLY8h6dyS+tCWa4XSoQuIvV+gSfq1o++9bPeVfYjc6dFqAdqbYl+Ha81/mlXLC
	 mXqgbh0Lifgkl4fIXpsmo9y3fxCRARRSUwXiw4G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfA0PH0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfA0PHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jan 2019 10:07:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48D4214C6;
        Sun, 27 Jan 2019 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548601644;
        bh=wijys3Fvl7GTbymGO3hqJMq834shSsXCs8R8URg3mDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jGitwHHoYrCwqru07RDkgbTS87+mCYySgEcvYl88bU1G9J/H8+qFqVuRvsyX18kW6
         2kZ7jjsu6z0LlO321ki8hwUiGH/eQ0+w9tlAC/fcU9Je0zyT4IoUgLs2ISAShMx0N4
         Lx/VR+UHK5B7nwiSu9M3vbmVPLpDylapgqGAWflg=
Date:   Sun, 27 Jan 2019 15:07:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio:bmi160: add drdy interrupt support
Message-ID: <20190127150719.110b4735@archlinux>
In-Reply-To: <afe5de11-54b7-dbcf-defc-cfa6e8f121db@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
        <20190122020431.5338-2-martin@martingkelly.com>
        <20190126201756.12faa7bb@archlinux>
        <afe5de11-54b7-dbcf-defc-cfa6e8f121db@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Jan 2019 15:39:16 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> On 1/26/19 12:17 PM, Jonathan Cameron wrote:
> > On Mon, 21 Jan 2019 18:04:27 -0800
> > Martin Kelly <martin@martingkelly.com> wrote:
> >   
> >> From: Martin Kelly <martin@martingkelly.com>
> >>
> >> Add interrupt support for the data ready signal on the BMI160, which fires
> >> an interrupt whenever new accelerometer/gyroscope data is ready to read.
> >>
> >> Signed-off-by: Martin Kelly <martin@martingkelly.com>  
> > 
> > Various minor bits inline.  I would also, if possible like Daniel to
> > take a glance at this series before we apply it. I don't know this hardware
> > at all well!
> > 
> > Jonathan
> >   
...

> >> +
> >> +static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
> >> +				bool open_drain, u8 irq_mask,
> >> +				unsigned long write_usleep)
> >> +{
> >> +	int ret;
> >> +	u8 int_out_ctrl_shift;
> >> +	u8 int_latch_mask;
> >> +	u8 int_map_mask;
> >> +	u8 int_out_ctrl_mask;
> >> +	u8 int_out_ctrl_bits;
> >> +
> >> +	switch (pin) {
> >> +	case BMI160_PIN_INT1:
> >> +		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
> >> +		int_latch_mask = BMI160_INT1_LATCH_MASK;
> >> +		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
> >> +		break;
> >> +	case BMI160_PIN_INT2:
> >> +		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
> >> +		int_latch_mask = BMI160_INT2_LATCH_MASK;
> >> +		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
> >> +		break;
> >> +	}
> >> +	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
> >> +
> >> +	/*
> >> +	 * Enable the requested pin with the right settings:
> >> +	 * - Push-pull/open-drain
> >> +	 * - Active low/high
> >> +	 * - Edge/level triggered
> >> +	 */
> >> +	int_out_ctrl_bits = BMI160_OUTPUT_EN;
> >> +	if (open_drain)
> >> +		/* Default is push-pull. */
> >> +		int_out_ctrl_bits |= BMI160_OPEN_DRAIN;
> >> +	int_out_ctrl_bits |= irq_mask;
> >> +	int_out_ctrl_bits <<= int_out_ctrl_shift;
> >> +
> >> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_OUT_CTRL,
> >> +				    int_out_ctrl_mask, int_out_ctrl_bits,
> >> +				    write_usleep);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Set the pin to input mode with no latching. */
> >> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_LATCH,
> >> +				    int_latch_mask, int_latch_mask,
> >> +				    write_usleep);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Map interrupts to the requested pin. */
> >> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
> >> +				    int_map_mask, int_map_mask,
> >> +				    write_usleep);
> >> +	if (ret)
> >> +		return ret;  
> > return bmi160...  
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +int bmi160_enable_irq(struct regmap *regmap, bool enable)
> >> +{
> >> +	unsigned int enable_bit = 0;
> >> +
> >> +	if (enable)
> >> +		enable_bit = BMI160_DRDY_INT_EN;
> >> +
> >> +	return bmi160_write_conf_reg(regmap, BMI160_REG_INT_EN,
> >> +				     BMI160_DRDY_INT_EN, enable_bit,
> >> +				     BMI160_NORMAL_WRITE_USLEEP);
> >> +}
> >> +EXPORT_SYMBOL(bmi160_enable_irq);
> >> +
> >> +static bool bmi160_parse_irqname(struct device_node *of_node, int irq,
> >> +				 enum bmi160_int_pin *pin)
> >> +{
> >> +	int ret;
> >> +
> >> +	/* of_irq_get_byname returns the IRQ number if the entry is found. */
> >> +	ret = of_irq_get_byname(of_node, "INT1");
> >> +	if (ret == irq) {
> >> +		*pin = BMI160_PIN_INT1;
> >> +		return true;
> >> +	}  
> > 
> > Given both could be provided, and we are implying a preference,
> > why not just get INT1 first by name and if it's not there try for
> > INT2?  No need for this separate does the name match query.
> >   
> 
> I actually didn't mean to imply a preference; I just figured that a 
> given IRQ can have only one name, and therefore at most one of the names 
> "INT1" and "INT2" will match the passed-in IRQ. Is this a bad assumption?

I'm saying that you should express a preference. It makes
things predictable.  But not by matching the 'first' one (which is
currently what happens) but rather just asking for INT1 by name
(don't use the spi->irq at all) and use that if present.

> 
> >> +
> >> +	ret = of_irq_get_byname(of_node, "INT2");
> >> +	if (ret == irq) {
> >> +		*pin = BMI160_PIN_INT2;
> >> +		return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> 

