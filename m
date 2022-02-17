Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A794C43217
	for <linux-iio@archiver.kernel.org>; Thu, 17 Feb 2022 18:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiBQSgF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:36:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiBQSgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Feb 2022 13:36:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42024593;
        Thu, 17 Feb 2022 10:34:11 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K03Np424Mz67bZ1;
        Fri, 18 Feb 2022 02:33:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 19:34:09 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 18:34:08 +0000
Date:   Thu, 17 Feb 2022 18:34:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     chegbeli <ciprian.hegbeli@analog.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: add meter subdirectory
Message-ID: <20220217183407.00005bcb@Huawei.com>
In-Reply-To: <20220217135140.5658-2-ciprian.hegbeli@analog.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
        <20220217135140.5658-2-ciprian.hegbeli@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Feb 2022 15:51:38 +0200
chegbeli <ciprian.hegbeli@analog.com> wrote:

> For IIO devices which are designed to measure and process power
> readings.
> 
> Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>
No need for separate patch - just squash this with the driver patch.

> ---
>  drivers/iio/Kconfig        | 1 +
>  drivers/iio/Makefile       | 1 +
>  drivers/iio/meter/Kconfig  | 9 +++++++++
>  drivers/iio/meter/Makefile | 5 +++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 drivers/iio/meter/Kconfig
>  create mode 100644 drivers/iio/meter/Makefile
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b190846c3dc2..892c7f575416 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -86,6 +86,7 @@ source "drivers/iio/humidity/Kconfig"
>  source "drivers/iio/imu/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
> +source "drivers/iio/meter/Kconfig"
>  source "drivers/iio/multiplexer/Kconfig"
>  source "drivers/iio/orientation/Kconfig"
>  source "drivers/iio/test/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 3be08cdadd7e..c8afc053fccf 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -32,6 +32,7 @@ obj-y += humidity/
>  obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
> +obj-y += meter/
>  obj-y += multiplexer/
>  obj-y += orientation/
>  obj-y += position/
> diff --git a/drivers/iio/meter/Kconfig b/drivers/iio/meter/Kconfig
> new file mode 100644
> index 000000000000..d1c91eed5283
> --- /dev/null
> +++ b/drivers/iio/meter/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Energy meter drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Active energy metering"
> +
> +endmenu
> diff --git a/drivers/iio/meter/Makefile b/drivers/iio/meter/Makefile
> new file mode 100644
> index 000000000000..c27cba44fc0b
> --- /dev/null
> +++ b/drivers/iio/meter/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for enrgy metering drivers
> +#
> +# When adding new entries keep the list in alphabetical order

