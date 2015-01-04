Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37895 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbADBCl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jan 2015 20:02:41 -0500
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
Date: Sun, 4 Jan 2015 01:02:58 +0100
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, fabio.estevam@freescale.com,
	alexandre.belloni@free-electrons.com, robert.hodaszi@digi.com,
	linux-iio@vger.kernel.org
References: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Message-Id: <201501040102.58496.marex@denx.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday, January 03, 2015 at 09:34:12 PM, Stefan Wahren wrote:
> Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
> from channel 8 and 9") with the removal of adc channel 9 there is
> no 1-1 mapping in the channel spec.
> 
> All hwmon channel values above 9 are accessible via there index minus
> one. So add a hidden iio channel 9 to fix this issue.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks for spotting this!

Best regards,
Marek Vasut
