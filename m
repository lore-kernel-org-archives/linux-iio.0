Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58726 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbaFJWvk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jun 2014 18:51:40 -0400
From: Marek Vasut <marex@denx.de>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Subject: Re: [PATCH 1/2] iio: mxs-lradc: fix divider
Date: Wed, 11 Jun 2014 00:47:59 +0200
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	alexandre.belloni@free-electrons.com, jbe@pengutronix.de,
	hector.palacios@digi.com, fabio.estevam@freescale.com,
	lars@metafoo.de
References: <1402407695-2984-1-git-send-email-robert.hodaszi@digi.com> <1402407695-2984-2-git-send-email-robert.hodaszi@digi.com>
In-Reply-To: <1402407695-2984-2-git-send-email-robert.hodaszi@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201406110047.59372.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday, June 10, 2014 at 03:41:34 PM, Robert Hodaszi wrote:
> All channels' single measurement are happening on CH 0. So enabling /
> disabling the divider once is not enough, because it has impact on all
> channels.
> 
> Set only a flag, then check this on each measurement, and enable / disable
> the divider as required.
> 
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
