Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from etezian.org ([198.101.225.253]:40081 "EHLO mail.etezian.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703Ab3KOKhV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Nov 2013 05:37:21 -0500
Date: Fri, 15 Nov 2013 11:37:16 +0100
From: Andi Shyti <andi@etezian.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH v2] iio: Add Freescale MPL3115A2 pressure / temperature
 sensor driver
Message-ID: <20131115103716.GA4134@jack.whiskey>
References: <1384285426-16191-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384285426-16191-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> I2C-controlled MEMS sensor with 20-bit pressure measurement (pascal) and
> 12-bit temperature measurement
> 
> driver only exposes basic functionality, see TODO remarks
> datasheet: http://cache.freescale.com/files/sensors/doc/data_sheet/MPL3115A2.pdf
> 
> v2:
> * store 20-bit value in 32-bit buffer element (instead of 24-bit)
> * zero buffer to prevent kernel data leak to userspace
> * fix mutex unlock in trigger handler (thanks Andi Shyti)

You're very welcome :)

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Andi Shyti <andi@etezian.org>

Look good to me as well, if you want you can add

Reviewed-by: Andi Shyti <andi@etezian.org>
