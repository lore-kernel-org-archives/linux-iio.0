Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86733ADB0
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703874; cv=none; b=s1xiwrId3ODh8x8WF1EKIQxLawyHYTUSKATxaQLRVlciCc7abjKUxrnFxUEFUJ5SzBGqPkhim2fASl53iJrISt5MoAJT5Dt5Bso1EeFSr+rZLVU+YxMvavhDsiQ4WTfe3vw8Zq+y5dPmKx8ovcVvQCwAbRj4uKVNp4XOc97fs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703874; c=relaxed/simple;
	bh=nvcJJRSUOa2J+QR8VtuE7j7k9G8B5Cpno8sTQYkYEPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN6f9l1cG3qVnNwu7come3mVXNcmC0TlwdLheGHHnsO19QJtXlZqBD8bGJS764npSQd3Ki8yf20r9cKH5PtdEA/eeSBwgXReNZa89eNgduAhsSrvnWvNlfFrxxljjurX9am/MS6O4F/irSsel4Mrji2Xt6GnamV4Z5NN5TlRZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl3KQxyd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl3KQxyd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so31960925e9.2
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703870; x=1789308670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9p7U9U8tA55nei6POZ9glY9rrUZkZ5+MlV33iQ8GuQ=;
        b=Nl3KQxydN/o6zglOTn5Un9ByvPh+xawTOcP4aiD6OMUny70dfoZsMLQoPMovzAqhoy
         xgQPnI+9xbf33TI2CEj96Pi9JBnmXDoeb7RohGzKP6ptvuVYBJhP1Juydam0JNT75jGq
         BDGZcZ0XJL5Ff9/d/O1lIrZr5moL5xSY8pPuVGUmxQqW+KTi1t1V9rBx35nLi0coBDiA
         Nw8BppYsY7VMWnmfL6KLs3hUV4cyNXvwhSQ7WiQQv6/a77m8dJI3Jx76+gwKMiskN5Mu
         Wm786GFVkVb0vkM0RVn8J9nL4Rqn33xdYOHVMTLil7ZVJAZid5S13F7whsUJeT3gI3yP
         bNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703870; x=1789308670;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9p7U9U8tA55nei6POZ9glY9rrUZkZ5+MlV33iQ8GuQ=;
        b=EkCWS4c8X4PdkqSnXnSZeKerSUyNVU4TjQucY/EVyBjv2q4TJazwQxMFRSn7W7Io60
         D1vPWdpO8waVMA6cCHUEXvCDUQGGCxCqRpebSPZZda+TPHpXQ9lbX76FeHYd1apM8fVX
         2wDDIbezDPRg/L3jkMfsH6ByF6WkLShZVVkTEsYEyNtAK73I9CyT08G12Puv/64e9NlR
         0E1v1cvSuQDc+FMecV2mBDGfG1xdm3lwdtNfkS3YdZs3/rLdyAPEO0eTl5NJxr1c36YP
         P6SAsf6M8KmlJS/ND57tQQcYtOkRXJt5Yn7wPRw9JK26qWa7qSgqWjiVq8iNo6LuD+Xt
         0JKA==
X-Forwarded-Encrypted: i=1; AKwUvBxfube1eRdGZg98Ou9dahCgKp4k4CMJ6kJskMJ/VUZoN7x8QJDsURIzDZukLRMy5BG/HtKYuknsbeI=@vger.kernel.org
X-Gm-Message-State: AFuF++nq97wWlBG0oslzbjylB3Kalis7jc8Qx8rKeMjolORwxLNmFFY8
	ugPi0FDMKbxM/hSPZdlaO/QmH5cSJA1eRxTI6FNYiwvzLuj++ltyPmtR
X-Gm-Gg: AYBFou1CHyAle2txdTQD8ealJx8lRhccTkrajvbGZYOjaxmpIxtfIMbNK3knC+uZyjN
	hwYY3e9Z3lBsP1uj6gIMm4gCC9e65RVJlKvrq1HpJ5dsoJff8xDttS9U/HLVhgADlEQQmGR18nB
	A84iZhjM9Ue1etr8uR8BSMO50wkrzeIgeUr3RzBWBaoeTyaEEq0J0QE/5XNCzy15VCN6ZPPxpo7
	APQmHZVc6AIBXSCWVtJsbzqGwvcCXDy8uCxnQFL1tj32f5O/2G2UUPOWNXy9VDrEGPiQaDrvHDu
	SHt+KdUYsVHhg2wsIjPOjCyquwN61MUwDPGzBta4KdpCGCMy8DC/GJkfOncMNSb77GLPw8yrjAH
	o8YYxj52j8ff4pO4E8q83HySpk0Z3tcFopUD2XKnmCZoEGtORgSzgO11P+8RXngsNB3kVGuq3Oq
	fAsgb2t7KyvfVn6Dv4zheY8QORDNtKFD+G2J9W0Jjqg0D2vf9LjedZmgs30c0eg/zCudIUBYVUc
	5VT0wZCRN4xa12H+zFBkPrLokYNQ9IU9Dh83xzfIa2LbtLAbowySA09SC8mPPwYJSCL1uBu/G/m
	cEpObyyrpV67K5OS8nIl0lGlnurfTCCyEG81/evHkUMVSPH8u+akUFwMi1letRzFU6Ap/bTj2s+
	EJHQRmSptsPCJMpG4HcoABc/MmG8Afmq//1Bsvl3V7loYCCpAqZrcSCVGGKxP02dMzAQuIfm0Fa
	S2UH4=
X-Received: by 2002:a05:600c:19d1:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49cfc6e8e05mr171160915e9.31.1788703869883;
        Sun, 06 Sep 2026 07:11:09 -0700 (PDT)
Received: from systembl0wer (78-80-112-223.customers.tmcz.cz. [78.80.112.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm330420775e9.1.2026.09.06.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:11:09 -0700 (PDT)
Date: Sun, 6 Sep 2026 16:11:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] staging: iio: adc: ad7816: Serialize SPI read
 operations
Message-ID: <20260906161105.61ac32b7@systembl0wer>
In-Reply-To: <20260906114049.32912-2-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
	<20260906114049.32912-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:48 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Add a mutex to serialize SPI read operations and prevent data corruption. Used guard(mutex) and devm_mutex_init() for safer and automatic cleanup.
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..ab80b3a889bb 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -14,6 +14,8 @@
>  #include <linux/list.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -65,7 +67,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;
> +
> +	guard(mutex)(&chip->lock);

Actually, I thought I was going crazy when this compiled, only to realize
you added the mutex in patch 2. Compiling with only this patch applied yields
10+ errors. Each patch must be atomic and cannot break the build, even if the
entire applied series compiles correctly.

Please revisit this.

-- 
Kind regards,
Joshua Crofts
