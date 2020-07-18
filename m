Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F660C433E2
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB342080D
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595088121;
	bh=eAMYUyUZgeBUT/qaiLZ7N0AmHyAQozUZGMTOnbP95QQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zxhcfLBZJy+0mVmmeM0tO+9P1hHJZlcpWtpuObW4257lmsgfs4mCQzBJvjaFifIIk
	 K6Wd5krFmH83L/K2Rnoq1roFiht634xYk5Z5OuTPk4z2i4f1/9l36V91ZY7Tuvrp2s
	 TDR4Um8bOD7FIL9G7pecWxrkgYCNuOP5eIJCTWaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRQCA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRQCA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:02:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF782070E;
        Sat, 18 Jul 2020 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088120;
        bh=eAMYUyUZgeBUT/qaiLZ7N0AmHyAQozUZGMTOnbP95QQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=InamNM0xeX83vyyulwRyL4YY3OcBsZNZeViFegzX8JPc44qQAudgCVog+6jcuYFL2
         oG9h7yXEYxFhW220OSCjstj/Q4fkC4rvb1Il02gk8guLwP6YTqj1aJDBlX/7dHHzMz
         4u4qSHX1ERrzRjuGH57ay9RcjtjKJ63LPcNTz3Y0=
Date:   Sat, 18 Jul 2020 17:01:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>
Subject: Re: [PATCH 23/30] iio: adc: palmas_gpadc: Demote non-conforming
 kerneldoc header
Message-ID: <20200718170155.0d8db232@archlinux>
In-Reply-To: <20200717165538.3275050-24-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-24-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:31 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Very few of the struct attributes have been documented here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'dev' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'palmas' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_0' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_1' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'adc_info' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'conv_completion' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_data' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_data' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_enable' not described in 'palmas_gpadc'
>  drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_enable' not described in 'palmas_gpadc'
> 
> Cc: Pradeep Goudagunta <pgoudagunta@nvidia.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 46e595eb889fa..81b0a76a767e8 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -76,7 +76,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
>  	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
>  };
>  
> -/**
> +/*
>   * struct palmas_gpadc - the palmas_gpadc structure
>   * @ch0_current:	channel 0 current source setting
>   *			0: 0 uA
> @@ -94,7 +94,6 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
>   * This is the palmas_gpadc structure to store run-time information
>   * and pointers for this driver instance.
>   */
> -
>  struct palmas_gpadc {
>  	struct device			*dev;
>  	struct palmas			*palmas;

