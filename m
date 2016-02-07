Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53470 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcBGFzd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2016 00:55:33 -0500
Date: Sat, 6 Feb 2016 21:55:32 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
Message-ID: <20160207055532.GA18331@kroah.com>
References: <1454797403-21576-1-git-send-email-ksenija.stanojevic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454797403-21576-1-git-send-email-ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 06, 2016 at 11:23:23PM +0100, Ksenija Stanojevic wrote:
> Move mxs-lradc driver from drivers/staging/iio/adc to drivers/iio/adc.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

