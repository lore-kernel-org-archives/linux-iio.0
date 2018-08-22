Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37437 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVOIj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Aug 2018 10:08:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id c6-v6so709845pls.4
        for <linux-iio@vger.kernel.org>; Wed, 22 Aug 2018 03:44:17 -0700 (PDT)
Date: Wed, 22 Aug 2018 16:14:05 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Remove field value defines
Message-ID: <20180822104405.GA26015@himanshu-Vostro-3559>
References: <20180819201439.30d318c7@archlinux>
 <20180820173959.22380-1-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820173959.22380-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 20, 2018 at 10:39:59AM -0700, David Frey wrote:
> Remove BME680_RUN_GAS_EN_BIT and BME680_NB_CONV_0_VAL field value
> definitions because the fields are simply boolean and integer
> respectively.
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>
Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
Tested-by: Himanshu Jha <himanshujha199640@gmail.com>

> ---
> This patch applies on top of my "indent #defines consistently" v3 patch.
> Appologies if I should have submitted this patch in a different way.  If
> I should have submitted this differently, I would appreciate a pointer
> on what I should have done in this case.

This applies cleanly so no worries I guess.
Would have been better to send this patch as a separate thread since
thread becomes complex and its hard to find the new patch in the
nested series of replies.

> BME680_RUN_GAS_EN_BIT was indeed somewhat wrongly formatted, but the
> issue was not the indentation level, but rather that I should have
> followed immediately after BME680_RUN_GAS_MASK.  Once I moved it there,
> I realized that neither this definition nor BME680_NB_CONV_0_VAL really
> added any value and hence I removed both in this patch.

My main intention was to make it explicit that we are selected NB_CONV_0
set point, and I didn't knew about FIELD_PREP helper macro until you
pointed me out in the early review cycle.

Now, it is much appropriate.

Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
