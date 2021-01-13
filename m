Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1CC43381
	for <linux-iio@archiver.kernel.org>; Wed, 13 Jan 2021 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C500F233F8
	for <linux-iio@archiver.kernel.org>; Wed, 13 Jan 2021 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAMPxo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:53:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2335 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhAMPxo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jan 2021 10:53:44 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGBh36nqTz67Zr0;
        Wed, 13 Jan 2021 23:49:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 13 Jan 2021 16:53:01 +0100
Received: from localhost (10.47.78.18) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 15:53:01 +0000
Date:   Wed, 13 Jan 2021 15:52:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/24] include/linux/iio/dac/mcp4725.h: update a
 microchip,mcp4725.yaml ref
Message-ID: <20210113155222.00001fc5@Huawei.com>
In-Reply-To: <ae1bc39a6c064bbce186a720a84a4f325bc2438c.1610535350.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
        <ae1bc39a6c064bbce186a720a84a4f325bc2438c.1610535350.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.18]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Jan 2021 11:59:19 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 6ced946a4bba ("dt-bindings:iio:dac:microchip,mcp4725 yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/dac/mcp4725.txt
> to: Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

> ---
>  include/linux/iio/dac/mcp4725.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
> index e9801c8d49c0..1f7e53c506b6 100644
> --- a/include/linux/iio/dac/mcp4725.h
> +++ b/include/linux/iio/dac/mcp4725.h
> @@ -15,7 +15,7 @@
>   * @vref_buffered: Controls buffering of the external reference voltage.
>   *
>   * Vref related settings are available only on MCP4756. See
> - * Documentation/devicetree/bindings/iio/dac/mcp4725.txt for more information.
> + * Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml for more information.
>   */
>  struct mcp4725_platform_data {
>  	bool use_vref;

