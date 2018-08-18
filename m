Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40349 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Aug 2018 10:16:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so4669865pgp.7
        for <linux-iio@vger.kernel.org>; Sat, 18 Aug 2018 04:09:25 -0700 (PDT)
Date: Sat, 18 Aug 2018 16:39:18 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 4/7] iio: chemical: bme680: change MSK->MASK in
 #defines
Message-ID: <20180818110918.GE24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-5-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817190319.13119-5-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 17, 2018 at 12:03:16PM -0700, David Frey wrote:
> Convert all defines to use "MASK" instead of a mix of "MSK" and "MASK"
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>

Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
Tested-by: Himanshu Jha <himanshujha199640@gmail.com>

Also, 0-day tested with build success!

Thanks


> -	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> +	                (tmp_lsb & BME680_BIT_H1_DATA_MASK);

Its here again so, perhaps better to send a new version instead.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
