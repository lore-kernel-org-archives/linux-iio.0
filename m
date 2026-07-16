Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BC3FD14D
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196920; cv=none; b=fDwp86NAPyFexvNz+SidUt61Ee7XgxbezWhcy6rTa0HARCotQF+7+QJcEkw/gKoWBpCQEVjhKXUcq3VUxNFZ1wo6JnDcwR4LUw+4CAmipoB1+N4ZWCCL5ik1N25xYJ/EaNSMeREdiZKPD6pATdjcky0dYzeu2VWGawodVGKuYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196920; c=relaxed/simple;
	bh=KA4T/Eguni6OTOF8xM2M8nNd/r+1pfu9nCM4LsWsHlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipA36ZRh36f+DPC3nesuF0IGzPPoACQUK5FT4VlhrXcGi1KkktFTKyXEEgUHJ8joFi8SgBXFiA6/Wt9nmDZ4/9wf3BR4xT3S4LhJrxLawNrPgaqTwNfNAzI78Ba1747zr8Hg1EJtRFpR0zVv786MY1pt5jhYwxzY6Iy377sEqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhylfluB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhylfluB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c12614b81c9so1188298066b.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784196917; x=1784801717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C1Bzm60tmgEnvOkVbmrlAWq0vWK3ADLcykEz+WxRyIs=;
        b=AhylfluB9kFfpQLELLpvzI4tzr/FJeHdbpGRUqHUNbN4UjhIXAbmWEtgIAh3HDjjpD
         aVSVJpfuB2SPRmqsBeexI8/LSDFLbLuZ7XX2f/rLK0xy6il6kSIqfGdcqOvQE4GhleLE
         E2rPRiCBByPaqrR0L3L/pMhBxcfhOxEVrKfVJg8YWCpyVz7TZoQR2NwWb25hMFFiQh5G
         xbOSpasU7wxUd9eC0iehp01a1GaDTlvHullQVfQLO7TQ0L/o+eA9T9N9Z+QYdpd2VZLA
         9rmPjFGYF00b2WozbOrSOODrmjY+l/vzv6MSqpRVJrqospt8jXQDMBkJkS9LUHUegm9O
         GxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196917; x=1784801717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C1Bzm60tmgEnvOkVbmrlAWq0vWK3ADLcykEz+WxRyIs=;
        b=fMTB7xjrXvkMRA068iZPf2qp0DMxbHu9wJ5LaP9+AIp3vHgXHryns1qusaQ4r8gMdN
         LvFwpY4Ewe7WB6+MtEE+NfGsGSQs5xfuTy2Au4H+MchvfmDFuXg9QK5UHytkIH5NS+j7
         5oI/gLeQnHXjncXDMBzAaAq0pPuo9IjtBfzs0zGZeXgRPkRf3pHrsxYoXHjJsBBah4Py
         DdelseuXNsMMc1x2/9JgBCGabkvRzfPNaPqHwAnOU15tBWoImp0jnxil2wnuHlGaDc6E
         pCTm7cQNv56wF9fXD0iM4jJUEFHcMB2ukVBRNbStxFKFt87EkeC1yYlEba3k03pc2dHp
         6arw==
X-Gm-Message-State: AOJu0YxQm1ddy9dQcP3md58ABKD4dpEWuBSL+x3MS7j1Zy+OZLmbaBBQ
	zvASBZ6CwPQAZWvtUSIsKVSBaQZePbiAGV5TOA4J/vmsgW3EB6edqPvX
X-Gm-Gg: AfdE7ckmOzmOrYVZP1jHyb8qQKcVx5qY41Evky/sq9o7xsZW63abjggAtsiAwsxZSwX
	XRu6nddgmyjQhXeL+g0qsx4GaRR5HIx32mDHV+wHAvMQ7fQYEZXI4j5I8Jz5d05VuWY2gpG5F9m
	Pi9EuJRu1/mQuaJDoRzQfmI2jpgV+3ezMsZAVaFcVxqFZtD/fpJktWYX6d/Gj0gitsg54yh7uH+
	17r8j29SS23fotK3KaWRR9SwQXfVpsk2Zk7w/Uz9DCGietLqrWUFkvaF1bnO5qYZpROBloOwFYS
	M29mkSOCDzB6XbeVI5miC2mj3maKzQAe9ASYMgXhJER15p0z1TAleo6xcLQ0Xt/kNbOUegUypTc
	2vOFp0LC1L0YQV3YkRkTPl0oF9m9IisBp47NDn89nHMEwb95EyuO0qNZZAsTtas9YIwrOuY7HEU
	loOnx1MsEzy9doT/5e
X-Received: by 2002:a17:907:d18:b0:c15:c117:da40 with SMTP id a640c23a62f3a-c1679307bcfmr406281366b.44.1784196915852;
        Thu, 16 Jul 2026 03:15:15 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16874a3f86sm178040466b.59.2026.07.16.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:15:14 -0700 (PDT)
Date: Thu, 16 Jul 2026 12:15:12 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <bnqn2knaom7schshki6rg42jxor2e3iipgf2s4sanv66wp63gk@6vs5q7ns3p7q>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>

On Wed, Jul 15, 2026 at 05:57:15PM -0700, Jonathan Cameron wrote:
> Resend to include linux-iio. Sorry to all who get it twice.
> 
> This came up in a recent review and I realised I have been giving incorrect
> review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> the dma safe variants only ever return either an error or the full buffer
> size.  Short accesses do not occur.
> 

Interesting! I had the same wrong assumptions! I guess the same is true
for the smbus variants?

Anyways,

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> This series (also my first upstream series prepared by poking claude)
> removes the redundant checks from all IIO drivers.
> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (22):
>   iio: adc: ltc2471: Remove redundant i2c_master_recv() length check
>   iio: adc: ti-ads7138: Remove redundant i2c_master_send() length checks
>   iio: adc: versal-sysmon: Remove redundant i2c_master_{send,recv}()
>     length checks
>   iio: chemical: scd30: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: chemical: scd4x: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: chemical: sgp30: Remove redundant i2c_master_recv() length check
>   iio: chemical: sgp40: Remove redundant i2c_master_recv() length check
>   iio: chemical: sps30: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: dac: ad5446: Remove redundant i2c_master_send() length check
>   iio: dac: ad5696: Remove redundant i2c_master_send() length check
>   iio: dac: m62332: Remove redundant i2c_master_send() length check
>   iio: dac: max517: Remove redundant i2c_master_send() length check
>   iio: dac: max5821: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: dac: mcp4725: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: dac: mcp4728: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: light: lv0104cs: Remove redundant i2c_master_{send,recv}() length
>     checks
>   iio: potentiometer: ad5110: Remove redundant i2c_master_{send,recv}()
>     length checks
>   iio: pressure: abp2030pa: Remove redundant i2c_master_{send,recv}()
>     length checks
>   iio: pressure: adp810: Remove redundant i2c_master_{send,recv}()
>     length checks
>   iio: pressure: icp10100: Remove redundant i2c_master_send() length
>     check
>   iio: pressure: mprls0025pa: Remove redundant i2c_master_{send,recv}()
>     length checks
>   iio: pressure: sdp500: Remove redundant i2c_master_recv() length check
> 
>  drivers/iio/adc/ltc2471.c              |  2 --
>  drivers/iio/adc/ti-ads7138.c           |  4 ----
>  drivers/iio/adc/versal-sysmon-i2c.c    |  6 ------
>  drivers/iio/chemical/scd30_i2c.c       |  4 ----
>  drivers/iio/chemical/scd4x.c           |  8 --------
>  drivers/iio/chemical/sgp30.c           |  2 --
>  drivers/iio/chemical/sgp40.c           |  4 ----
>  drivers/iio/chemical/sps30_i2c.c       |  4 ----
>  drivers/iio/dac/ad5446-i2c.c           |  2 --
>  drivers/iio/dac/ad5696-i2c.c           |  2 +-
>  drivers/iio/dac/m62332.c               |  2 --
>  drivers/iio/dac/max517.c               |  6 ++----
>  drivers/iio/dac/max5821.c              | 14 ++------------
>  drivers/iio/dac/mcp4725.c              | 22 ++++++----------------
>  drivers/iio/dac/mcp4728.c              | 13 +------------
>  drivers/iio/light/lv0104cs.c           |  4 ----
>  drivers/iio/potentiometer/ad5110.c     | 18 +++---------------
>  drivers/iio/pressure/abp2030pa_i2c.c   |  4 ----
>  drivers/iio/pressure/adp810.c          |  4 ----
>  drivers/iio/pressure/icp10100.c        |  2 --
>  drivers/iio/pressure/mprls0025pa_i2c.c |  4 ----
>  drivers/iio/pressure/sdp500.c          |  4 ----
>  22 files changed, 15 insertions(+), 120 deletions(-)
> 
> -- 
> 2.43.0
> 
