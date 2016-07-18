Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57854 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcGSFgP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:15 -0400
Subject: Re: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160716022831.GA7636@d830.WORKGROUP> <578C9843.10408@nvidia.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dff1e871-de49-654f-5e9b-c9b230a35b0a@kernel.org>
Date: Mon, 18 Jul 2016 14:30:46 +0100
MIME-Version: 1.0
In-Reply-To: <578C9843.10408@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 09:50, Laxman Dewangan wrote:
> 
> On Saturday 16 July 2016 07:58 AM, Alison Schofield wrote:
>> I2C_CLASS_HWMON is for a hardware monitoring chip wanting
>> auto-detection.  IIO drivers don't typically use .class.
>> Remove it.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>
> 
> Agree.
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Any resulting ABI change from dropping it?
I don't think so, as it doesn't support detection anyway,
but best to be sure ;)

> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

