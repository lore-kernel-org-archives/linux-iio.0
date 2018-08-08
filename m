Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44573 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHNOI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Aug 2018 09:14:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so909948pgp.11
        for <linux-iio@vger.kernel.org>; Wed, 08 Aug 2018 03:54:59 -0700 (PDT)
Date: Wed, 8 Aug 2018 16:24:53 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: bme680: perform cosmetic cleanup
Message-ID: <20180808105453.GB1882@himanshu-Vostro-3559>
References: <20180807200721.22033-1-dpfrey@gmail.com>
 <20180807200721.22033-2-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807200721.22033-2-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 07, 2018 at 01:07:20PM -0700, David Frey wrote:
>  * use consistent naming for masks. _MSK -> _MASK
>  * use GEN_MASK to define masks rather than hex constants
>  * consistently indent masks and values under the corresponding register
>    define
>  * use FIELD_GET instead of explicit mask and shift
>  * Join split lines in bme680_read_calib() which can fit in 80 chars
>  * Make use clamp macro
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>
> ---

This patch is fine but ideally it should be split for each
change. "One patch per change policy!"

Dan is on vacation I guess otherwise he must have poked you
before me ;)

Also, please consider making subject:

"iio: chemical: bme680: .... .. "

Once you roll a v2, I will get it tested on my sensor.

And yes, please also CC Jonathan <jic23@kernel.org> so that
it doesn't get lost.

Thanks for making the effort, David!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
