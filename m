Return-Path: <SRS0=djfl=QN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADEC282C2
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 12:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446D20B1F
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 12:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfBFMyO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:54:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728613AbfBFMyO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Feb 2019 07:54:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22826C5E8B4BE429EE22;
        Wed,  6 Feb 2019 20:54:10 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 20:54:05 +0800
Date:   Wed, 6 Feb 2019 12:53:54 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: gyro: add DT bindings to fxas21002
Message-ID: <20190206125354.0000214e@huawei.com>
In-Reply-To: <20190205174333.17672-2-rui.silva@linaro.org>
References: <20190205174333.17672-1-rui.silva@linaro.org>
        <20190205174333.17672-2-rui.silva@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Feb 2019 17:43:29 +0000
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add device tree bindings for the FXAS21002 gyroscope.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../bindings/iio/gyroscope/fxas2100x.txt       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> new file mode 100644
> index 000000000000..df10a60aa533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> @@ -0,0 +1,18 @@
> +* NXP FXAS2100X Gyroscope device tree bindings
> +
> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> +
> +Required properties:
> +  - compatible : should be "nxp,fxas21002"
> +  - reg : the I2C address of the sensor

Given you provide spi support that might need expanding upon...


> +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> +  - vddio-supply: phandle to the regulator that provides power to the bus.
> +
> +Example:
> +
> +fxas21002@20 {
> +	compatible = "nxp,fxas21002";
> +	reg = <0x20>;
> +	vdd-supply = <&reg_peri_3p15v>;
> +	vddio-supply = <&reg_peri_3p15v>;
> +};


