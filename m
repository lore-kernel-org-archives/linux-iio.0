Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60746 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcFXVP7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 17:15:59 -0400
Date: Fri, 24 Jun 2016 23:15:27 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
	pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	marex@denx.de
Message-ID: <244763571.48608.693e1aee-e90e-40ad-a903-35b367b5972a.open-xchange@email.1und1.de>
In-Reply-To: <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 24. Juni 2016 um
> 14:09 geschrieben:
> 
> 
> Add core files for mxs-lradc MFD driver.
> 
> Note:  this patch won't compile in iio/testing without this patch:
> a8f447be8056 ("mfd: Add resource managed APIs for mfd_add_devices")
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

i tested it successfully with a i.MX23 board (without touchscreen).

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
