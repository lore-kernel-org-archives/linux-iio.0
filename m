Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3KMV7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 16:59:15 -0500
Message-ID: <5284047D.8080102@kernel.org>
Date: Wed, 13 Nov 2013 23:00:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH v2] iio: Add Freescale MPL3115A2 pressure / temperature
 sensor driver
References: <1384285426-16191-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384285426-16191-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/13 19:43, Peter Meerwald wrote:
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
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Andi Shyti <andi@etezian.org>
All looks good to me.  I'll let it sit on the list for a few days so that
everyone else had time to comment if they wish to.

Jonathan
