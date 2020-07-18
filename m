Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2283C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAD52076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087432;
	bh=Jspr1aXTKrKpsTmmQrZ2+E+NmopObPUbY9QwrTGThE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=h4/1g0mQOnwbiutH0lLpTM1USOss9sySg7aZqmUlUASp3WnbX7EzAFz7/WtUi07Vt
	 lJkXHaxXQ0E0WcWJsYSylW3/MgQyaW59vA1E1cKGZCoc4dqwajl1iIBbONqJuPC891
	 roZ89j06+tiuo3Jot+xC7pRExrKQfsYVK7Km0uMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPuc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPuc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:50:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0504E20684;
        Sat, 18 Jul 2020 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087431;
        bh=Jspr1aXTKrKpsTmmQrZ2+E+NmopObPUbY9QwrTGThE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWPv7oVGmV/jjlwTJyhvE79BAIeYPAPe39fes/BTm5Obp8I4wiSBv55aMJ3gdKzIL
         F2QL1VfPdqVC1NUiTKG4PeiJVFLE/AmVSktepgXbKwRfd8lYSiEkKqw11sBjosEu3Q
         chS4w1t2r3KK4qzFJHvRww3XeofjICyLnUsB5KhA=
Date:   Sat, 18 Jul 2020 16:50:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/30] iio: adc: cpcap-adc: Demote seemingly
 unintentional kerneldoc header
Message-ID: <20200718165027.09ebedf6@archlinux>
In-Reply-To: <20200717165538.3275050-16-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-16-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:23 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> None of the headers demoted here provide any descriptions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'ato_in' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_in' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'adc_ps_factor_in' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_ps_factor_in' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'ato_out' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_out' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'adc_ps_factor_out' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_ps_factor_out' not described in 'cpcap_adc_ato'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD0' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTP' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_VBUS' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD3' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BPLUS_AD4' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_CHG_ISENSE' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTI' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_USB_ID' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD8' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD9' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_LICELL' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_HV_BATTP' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSX1_AD12' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSX2_AD13' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSY1_AD14' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSY2_AD15' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTP_PI16' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTI_PI17' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_CHANNEL_NUM' not described in enum 'cpcap_adc_channel'
>  drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_IMM' not described in enum 'cpcap_adc_timing'
>  drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_IN' not described in enum 'cpcap_adc_timing'
>  drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_OUT' not described in enum 'cpcap_adc_timing'
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/cpcap-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 5086a337f4c9a..be638fcec03f6 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -82,7 +82,7 @@
>  
>  #define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
>  
> -/**
> +/*
>   * struct cpcap_adc_ato - timing settings for cpcap adc
>   *
>   * Unfortunately no cpcap documentation available, please document when
> @@ -121,7 +121,7 @@ struct cpcap_adc {
>  	bool done;
>  };
>  
> -/**
> +/*
>   * enum cpcap_adc_channel - cpcap adc channels
>   */
>  enum cpcap_adc_channel {
> @@ -152,7 +152,7 @@ enum cpcap_adc_channel {
>  	CPCAP_ADC_CHANNEL_NUM,
>  };
>  
> -/**
> +/*
>   * enum cpcap_adc_timing - cpcap adc timing options
>   *
>   * CPCAP_ADC_TIMING_IMM seems to be immediate with no timings.

