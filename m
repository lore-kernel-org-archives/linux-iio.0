Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35689 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRORN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Aug 2018 10:17:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10-v6so4678944pgv.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Aug 2018 04:09:58 -0700 (PDT)
Date: Sat, 18 Aug 2018 16:39:51 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 5/7] iio: chemical: bme680: use GENMASK macro
Message-ID: <20180818110951.GF24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-6-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817190319.13119-6-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 17, 2018 at 12:03:17PM -0700, David Frey wrote:
> Replace hardcoded bit masks with GENMASK macro
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>

Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
Tested-by: Himanshu Jha <himanshujha199640@gmail.com>

Also, 0-day tested with build success!

Thanks

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
