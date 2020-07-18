Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A2DC433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAF62070A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595084145;
	bh=kjZhliArAupsgIQRojSt1mgRcPYN3aZHfo2EkpA7vg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Syu53JDhZsrb2ns5qVbX8uKLkT+0CsrB8tYfNqFaxVY1/PDX2Lg/ia2jUJIvVCVj/
	 M2yrPun/bSIq8f9blNozcHkbJ9fnecRzIEkJlrHRPwE361LJBRJTnhEI9oUuD+ClVC
	 t3h/h50mOZKejGbzLP7iqurIyoCejmANIP2YiOBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGROzo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROzo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:55:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88D6220656;
        Sat, 18 Jul 2020 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084143;
        bh=kjZhliArAupsgIQRojSt1mgRcPYN3aZHfo2EkpA7vg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mYFSpyomkpTz4MVFl/SQ7vvPF/V54xzhpgc1ehuw3X3BY+Kr8Cz8mMK88/N0XesoP
         mgk069jE0kqOkmTlVgQ4p3eOZAGC6F9wdqHfLOUEn2+yyT+3Am7htoxWL7Hdi/444C
         o83OjwOBfSGHV0ah4NEIQNicRJTg565NQIVg/8Wo=
Date:   Sat, 18 Jul 2020 15:55:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/30] iio: dummy: iio_simple_dummy_events: Demote file
 header and supply descriptions for val2 params
Message-ID: <20200718155539.48913015@archlinux>
In-Reply-To: <20200716135928.1456727-14-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-14-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:11 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> File headers are not good candidates for kerneldoc.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dummy/iio_simple_dummy_events.c:21: warning: Incorrect use of kernel-doc format:  * iio_simple_dummy_read_event_config() - is event enabled?
>  drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'indio_dev' not described in 'iio_simple_dummy_read_event_config'
>  drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'chan' not described in 'iio_simple_dummy_read_event_config'
>  drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'type' not described in 'iio_simple_dummy_read_event_config'
>  drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'dir' not described in 'iio_simple_dummy_read_event_config'
>  drivers/iio/dummy/iio_simple_dummy_events.c:123: warning: Function parameter or member 'val2' not described in 'iio_simple_dummy_read_event_value'
>  drivers/iio/dummy/iio_simple_dummy_events.c:146: warning: Function parameter or member 'val2' not described in 'iio_simple_dummy_write_event_value'
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

J
> ---
>  drivers/iio/dummy/iio_simple_dummy_events.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
> index b3abaaca6f5ef..63a2b844be508 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_events.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_events.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (c) 2011 Jonathan Cameron
>   *
>   * Event handling elements of industrial I/O reference driver.
> @@ -107,6 +107,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
>   * @dir: direction of the vent whose value is being read
>   * @info: info type of the event whose value is being read
>   * @val: value for the event code.
> + * @val2: unused
>   *
>   * Many devices provide a large set of events of which only a subset may
>   * be enabled at a time, with value registers whose meaning changes depending
> @@ -136,6 +137,7 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
>   * @dir: direction of the vent whose value is being set
>   * @info: info type of the event whose value is being set
>   * @val: the value to be set.
> + * @val2: unused
>   */
>  int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>  				       const struct iio_chan_spec *chan,

