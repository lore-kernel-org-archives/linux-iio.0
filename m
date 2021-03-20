Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16576C433DB
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D723C61967
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 14:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhCTOrP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 Mar 2021 10:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhCTOqi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:46:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FCF61967;
        Sat, 20 Mar 2021 14:46:34 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:46:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, denis.ciocca@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V3 0/2] Add support for ST magnetometer IIS2MDC
Message-ID: <20210320144631.7941083a@jic23-huawei>
In-Reply-To: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Mar 2021 06:39:00 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Changes in V3:
> 
> Reword the commit message, add "Acked-by: Rob Herring"
Applied to the togreg branch of iio.git and initially pushed out as testing
to let autobuilders see if they can find anything we missed.

Thanks,

Jonathan

> 
> LI Qingwu (2):
>   dt-bindings: iio: st,st-sensors add IIS2MDC.
>   iio:magnetometer: Add Support for ST IIS2MDC
> 
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  drivers/iio/magnetometer/st_magn.h                       | 1 +
>  drivers/iio/magnetometer/st_magn_core.c                  | 1 +
>  drivers/iio/magnetometer/st_magn_i2c.c                   | 5 +++++
>  drivers/iio/magnetometer/st_magn_spi.c                   | 5 +++++
>  5 files changed, 13 insertions(+)
> 

