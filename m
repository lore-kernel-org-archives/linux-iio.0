Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2783 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbcGRJFA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 05:05:00 -0400
Message-ID: <578C9843.10408@nvidia.com>
Date: Mon, 18 Jul 2016 14:20:11 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Alison Schofield <amsfield22@gmail.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
References: <20160716022831.GA7636@d830.WORKGROUP>
In-Reply-To: <20160716022831.GA7636@d830.WORKGROUP>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Saturday 16 July 2016 07:58 AM, Alison Schofield wrote:
> I2C_CLASS_HWMON is for a hardware monitoring chip wanting
> auto-detection.  IIO drivers don't typically use .class.
> Remove it.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>

Agree.
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
