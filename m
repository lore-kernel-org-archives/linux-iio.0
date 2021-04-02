Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B1C43461
	for <linux-iio@archiver.kernel.org>; Fri,  2 Apr 2021 09:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0E61107
	for <linux-iio@archiver.kernel.org>; Fri,  2 Apr 2021 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhDBJ1K (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJ1K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 05:27:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAF261105;
        Fri,  2 Apr 2021 09:27:07 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:27:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/32] dt-bindings:iio:dac: update
 microchip,mcp4725.yaml reference
Message-ID: <20210402102720.537daedc@jic23-huawei>
In-Reply-To: <82fb54974e8a22be15e64343260a6de39a18edda.1617279356.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <82fb54974e8a22be15e64343260a6de39a18edda.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Apr 2021 14:17:45 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 6ced946a4bba ("dt-bindings:iio:dac:microchip,mcp4725 yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/dac/mcp4725.txt
> to: Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 6ced946a4bba ("dt-bindings:iio:dac:microchip,mcp4725 yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied thanks.

Jonathan

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

