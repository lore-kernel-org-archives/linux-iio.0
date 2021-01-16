Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E7FC433DB
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5F2255F
	for <linux-iio@archiver.kernel.org>; Sat, 16 Jan 2021 18:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbhAPSHK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbhAPSHK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 13:07:10 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74597224B2;
        Sat, 16 Jan 2021 18:06:28 +0000 (UTC)
Date:   Sat, 16 Jan 2021 18:06:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio:pressure:ms5637: add ms5803 support
Message-ID: <20210116180625.0b9b5dfa@archlinux>
In-Reply-To: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Jan 2021 00:11:42 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> This series adds support for the Measurement Specialities ms5803. It is
> very similar to the ms5805 but has a different PROM layout (which I
> suspect predates the ms5805 PROM layout). Also it supports less
> frequency sampling options.
> 
> After a bit of preparatory work in the ms5637 driver and its common
> library, mainly to handle the PROM layout and sample frequencies, adding
> support is trivial.
> 
> Changes in v2:
>  - Dropped "iio:pressure:ms5637: switch to probe_new" to keep the i2c_device_id
>    table.
>  - Reorder trivial-devices.yaml
LGTM. Series applied to the togreg branch of iio.git and pushed out as testing
to see if the autobuilders can find anything we missed.

thanks,

Jonathan

> 
> Alexandre Belloni (6):
>   dt-bindings: trivial-devices: reorder memsic devices
>   iio:pressure:ms5637: introduce hardware differentiation
>   iio:pressure:ms5637: limit available sample frequencies
>   iio:common:ms_sensors:ms_sensors_i2c: rework CRC calculation helper
>   iio:common:ms_sensors:ms_sensors_i2c: add support for alternative PROM
>     layout
>   iio:pressure:ms5637: add ms5803 support
> 
>  .../devicetree/bindings/trivial-devices.yaml  | 10 ++-
>  .../iio/common/ms_sensors/ms_sensors_i2c.c    | 76 ++++++++++++++----
>  .../iio/common/ms_sensors/ms_sensors_i2c.h    | 15 +++-
>  drivers/iio/pressure/ms5637.c                 | 77 +++++++++++++++----
>  4 files changed, 143 insertions(+), 35 deletions(-)
> 

