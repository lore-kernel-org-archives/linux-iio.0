Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B56C433F5
	for <linux-iio@archiver.kernel.org>; Sat, 11 Sep 2021 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DA861205
	for <linux-iio@archiver.kernel.org>; Sat, 11 Sep 2021 15:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhIKPKh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 11 Sep 2021 11:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhIKPKh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 11:10:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EFB4611AD;
        Sat, 11 Sep 2021 15:09:22 +0000 (UTC)
Date:   Sat, 11 Sep 2021 16:12:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210911161252.1f8b1be6@jic23-huawei>
In-Reply-To: <YToFvPooJpCpqr28@smile.fi.intel.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
        <20210909094537.218064-4-jacopo@jmondi.org>
        <YToFvPooJpCpqr28@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Sep 2021 16:01:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Sep 09, 2021 at 11:45:36AM +0200, Jacopo Mondi wrote:
> > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > IIO subsystem.  
> 
> ...
> 
> > +	/*
> > +	 * Wake up sensor by sending sensor address: START, sensor address,
> > +	 * STOP. Sensor will not ACK this byte.
> > +	 *
> > +	 * The chip enters a low power state after 15msec without  
> 
> msec --> ms (everybody understands 'ms' unit)

yup. millisiemens :)
(couldn't resist)

Context is fine either way here.

> 
> > +	 * communications or after a complete read/write sequence.
> > +	 */  
> 
> ...
> 
> > +	struct i2c_client *client = context;
> > +	union i2c_smbus_data data;
> > +
> > +	/* Discard reg address from values count. */
> > +	if (count < 1)
> > +		return -EINVAL;
> > +	count--;  
> 
> Wouldn't be more natural to decrement and then check against 0?
> 
> ...
> 
> > +	memcpy(&data.block[1], (u8 *)val_buf + 1, count);  
> 
> Not sure I understand why you need an explicit casting here.

C doesn't allow pointer arithmetic on void * (gcc has it as an extension
though so it's probably fine without the cast)



> 
> 
> ...
> 
> > +	mutex_lock(&sunrise->lock);
> > +	ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> > +	if (ret) {
> > +		mutex_unlock(&sunrise->lock);  
> 
> > +		return -EINVAL;  
> 
> Why shadowing an actual error code?
> 
> > +	}  
> 
> ...
> 
> > +			/*
> > +			 * / 10^4 to comply with IIO scale for CO2 (percentage).  
> 
> "1 / 10^4"
> 
> > +			 * The chip CO2 reading range is [400 - 5000] ppm
> > +			 * which corresponds to [0,004 - 0,5] %.
> > +			 */  
> 

