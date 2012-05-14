Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55788 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429Ab2ENU0X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 May 2012 16:26:23 -0400
Received: by dady13 with SMTP id y13so6374996dad.19
        for <linux-iio@vger.kernel.org>; Mon, 14 May 2012 13:26:23 -0700 (PDT)
Date: Mon, 14 May 2012 13:26:11 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, jic23@kernel.org, nicolas.ferre@atmel.com
Subject: Re: [PATCHv5] Add ADC driver for Atmel G20, G45 and X5 boards
Message-ID: <20120514202611.GA16388@kroah.com>
References: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 11, 2012 at 03:35:31PM +0200, Maxime Ripard wrote:
> Hi Greg,
> 
> Here is a patchset adding an IIO driver for various Atmel SoCs.
> As it relies on out-of-staging-IIO, which is still in staging-next, it
> seems that you should be the one merging it.
> 
> As you can see, it got an acked-by all the maintainers involved in this
> patch, so it should be pretty good for inclusion.

All now applied, thanks.

greg k-h
