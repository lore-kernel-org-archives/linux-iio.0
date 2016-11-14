Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:57322 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936479AbcKNSrB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 13:47:01 -0500
Subject: Re: [PATCH v9 2/5] iio: adc: mxs-lradc: Add support for adc driver
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c750ee15d03f6cf1a066dda21b1973d74cf9f59f.1478071676.git.ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        harald@ccbib.org, stefan.wahren@i2se.com,
        fabio.estevam@freescale.com
From: Marek Vasut <marex@denx.de>
Message-ID: <ce65afb5-7628-af80-a43b-d73ade71c72a@denx.de>
Date: Mon, 14 Nov 2016 19:46:41 +0100
MIME-Version: 1.0
In-Reply-To: <c750ee15d03f6cf1a066dda21b1973d74cf9f59f.1478071676.git.ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/2016 08:38 AM, Ksenija Stanojevic wrote:
> Add support for sixteen-channel 12-bit resolution ADC and its functions,
> which include general-purpose ADC readings, battery voltage measurement,
> and die temperature measurement.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> ---

Shouldn't you squash this and 4/5 , in which case this would result in a
move ?

-- 
Best regards,
Marek Vasut
