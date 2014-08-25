Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56602 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbaHYLCE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 07:02:04 -0400
Message-ID: <53FB17A6.5000008@roeck-us.net>
Date: Mon, 25 Aug 2014 04:01:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Johannes Pointner <johannes.pointner@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
References: <1472905.aEm3bdqRZp@lenovobook>
In-Reply-To: <1472905.aEm3bdqRZp@lenovobook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/25/2014 01:04 AM, Johannes Pointner wrote:
> This patch fixes the overwritten -EPROBE_DEFER return value in of_iio_channel_get_by_name.
>
> Signed-off-by: Johannes Pointner <johannes.pointner@br-automation.com>

Fixes: a2c12493ed7e ('iio: of_iio_channel_get_by_name() returns non-null pointers for error legs')

which improperly assumes that of_iio_channel_get_by_name must always
return NULL and thus now hides -EPROBE_DEFER.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

