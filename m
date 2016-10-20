Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36559 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935024AbcJTRJV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 13:09:21 -0400
Received: by mail-lf0-f51.google.com with SMTP id b75so91770139lfg.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2016 10:09:20 -0700 (PDT)
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature
 approximation
To: Laxman Dewangan <ldewangan@nvidia.com>
References: <20161018193147.GA14745@vaio-ubuntu> <5808BB3D.2020201@nvidia.com>
 <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com>
 <5808E78B.4060109@nvidia.com>
Cc: linux-iio@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
From: =?UTF-8?Q?Pawe=c5=82_Jarosz?= <paweljarosz3691@gmail.com>
Message-ID: <0412f751-fb88-7b9e-8a8c-501e019de774@gmail.com>
Date: Thu, 20 Oct 2016 19:10:33 +0200
MIME-Version: 1.0
In-Reply-To: <5808E78B.4060109@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Yes please send patch to replace the 1000 with the temp1 - temp2 as 
> what you did in your original patch.
> This will fix the non-sequenced (un-equally spaced) temperature table.

replacing 1000 with (temp1 - temp2) is not enough as for example for val 
= 9 and table

<7000 8
  9000 10>

	adc_hi = gti->lookup_table[2 * i - 1];
	adc_lo = gti->lookup_table[2 * i + 1];
	temp = gti->lookup_table[2 * i];
	temp -= (val - adc_lo) * (temp1 - temp2) / (adc_hi - adc_lo);


adc_hi = 8
adc_lo = 10
temp = 9000 - (9 - 10) * (7000 - 9000) / (8 - 10)
temp = 9000 - (-1) * (-2000) / (-2)
temp = 9000 - (-1000) = 10000

and for val = 9 temp should be 8000.


