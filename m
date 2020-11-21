Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572CC63798
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4602100A
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgKUSub (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:50:31 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:55772 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728244AbgKUSub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 13:50:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A4BE6837F24A;
        Sat, 21 Nov 2020 18:50:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jewel53_0b07cea27356
X-Filterd-Recvd-Size: 2305
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 18:50:29 +0000 (UTC)
Message-ID: <ee2f79f5e9237773617fbce877353817c1137246.camel@perches.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
From:   Joe Perches <joe@perches.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Date:   Sat, 21 Nov 2020 10:50:28 -0800
In-Reply-To: <20201121184305.450149-1-vilhelm.gray@gmail.com>
References: <20201121184305.450149-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-11-21 at 13:43 -0500, William Breathitt Gray wrote:
> Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
> Changes in v2:
>  - Reorder section names alphabetically
>  - Rename title to ARM/Microchip etc...
>  - Add linux-arm-kernel@lists.infradead.org as mailing list
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 913b5eb64e44..1bc3acf55ed4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2104,6 +2104,13 @@ S:	Supported
>  F:	arch/arm64/boot/dts/microchip/
>  N:	sparx5
>  
> 
> +ARM/Microchip Timer Counter Block (TCB) Capture Driver
> +F:	drivers/counter/microchip-tcb-capture.c
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-iio@vger.kernel.org
> +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> +S:	Maintained

There's a section near the top of the MAINTAINERS file that describes
the preferred order for these entries.

Ideally this should be ordered like:

ARM/Microchip Timer Counter Block (TCB) Capture Driver
M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L:	linux-iio@vger.kernel.org
S:	Maintained
F:	drivers/counter/microchip-tcb-capture.c


