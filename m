Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54701 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbaFYOLD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 10:11:03 -0400
Message-ID: <53AAD86B.6080905@roeck-us.net>
Date: Wed, 25 Jun 2014 07:10:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
CC: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 2/4 v2] hwmon: ntc_thermistor: Use the manufacturer name
 properly
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com> <1403677773-21141-3-git-send-email-ch.naveen@samsung.com>
In-Reply-To: <1403677773-21141-3-git-send-email-ch.naveen@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/24/2014 11:29 PM, Naveen Krishna Chatradhi wrote:
> Murata Manufacturing Co., Ltd is the vendor for
> NTC (Negative Temperature coefficient) based Thermistors.
> But, the driver extensively uses "NTC" as the vendor name.
>
> This patch corrects the vendor name also updates the
> compatibility strings according to the vendor-prefix.txt
>
> Note: Drivers continue to support the previous compatible strings
> but further addition of these compatible strings in device tree
> is deprecated.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Applied.

Guenter


