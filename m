Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33647 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbcG2RwD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 13:52:03 -0400
Received: by mail-qk0-f169.google.com with SMTP id p74so97407937qka.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2016 10:52:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469713776-5062-4-git-send-email-enric.balletbo@collabora.com>
References: <1469713776-5062-1-git-send-email-enric.balletbo@collabora.com> <1469713776-5062-4-git-send-email-enric.balletbo@collabora.com>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 29 Jul 2016 10:52:01 -0700
Message-ID: <CABXOdTeUC=3rsP4aA3S7mguE6qn5dOQTov05Tz9veR_eqO+F-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] platform/chrome: Introduce a new function to check
 EC features.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Olof Johansson <olof@lixom.net>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Vincent Palatin <vpalatin@chromium.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 28, 2016 at 6:49 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
>
> Use the EC_CMD_GET_FEATURES message to check the supported features for
> each MCU.
>
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> [tomeu: adapted to changes in mainline]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> [enric: remove references to USB PD feature and do it more generic]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>
