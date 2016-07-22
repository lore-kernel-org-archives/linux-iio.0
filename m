Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36709 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcGVPuc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2016 11:50:32 -0400
Received: by mail-oi0-f54.google.com with SMTP id w18so168380526oiw.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Jul 2016 08:50:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160720235620.GA2561@earth>
References: <20160720235620.GA2561@earth>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Jul 2016 17:50:25 +0200
Message-ID: <CACRpkdZbYqKO88tDjKemZfyK5tT9rvhsHhBFQcMYoK1gq01K9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] iio: magn: add a driver for AK8974
To: Sebastian Reichel <sre@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 21, 2016 at 1:56 AM, Sebastian Reichel <sre@kernel.org> wrote:

> [On N950]
> Tested-By: Sebastian Reichel <sre@kernel.org>

Thanks! If you have hints on how to scale the raw values to
Gauss, please help. (Been looking at the Mer sensorfw repo to
no avail...)

What userspace do you use on this device?

> Do you have plans to take over the axis rotation support
> from Samu Onkalo's driver? The Nokia vendor kernel had Y
> and Z axis inverted.

Oh I didn't think of adding that. IIO has a standard rotation
matrix lib and binding, used in e.g. AK8975. I'll add it and resend.

Yours,
Linus Walleij
