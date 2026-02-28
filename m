Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364835F617
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306574; cv=none; b=NwAjNeFeKndW6xDPZFIiNWuGDyVztWQgxuje7fGcICsIZ9Sj1wfwUMEW8xKVKTmCjY7IWBnWyHhfNtTfgKfYk0WJvtWv9bU0CwZLhwgxxGddd/xb3z9ANANgW/sDxu+KwB37HgN6QGqJHNBUIZe2xFJC3Rwb2RceIT623167HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306574; c=relaxed/simple;
	bh=4t1p4FGQXSaZ6P8vjHG5j+GAGcuCQZ24T4h/zCWQM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZydG3fWk4d72VwelnK0D5qQ95r6WvxE0eunJH3yEMryGnLgQBMSO0km73DPsU2fSt4mDOqv6kgsy85UFcWwmyt/K0beGTkNGegB++82fIiC40b0efSPmDh48ZstlNcpyVr+iMqwiKYcHNtaafJr31AKezmWkP+5xY515TQLyzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcgIyml; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcgIyml"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a84f2bf7bso3178022e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772306572; x=1772911372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4t1p4FGQXSaZ6P8vjHG5j+GAGcuCQZ24T4h/zCWQM/E=;
        b=BtcgIymldixlQc2FzR4vegKH7+dxx7aiKtgYzSU0lpploPYRFGnvSX38yCVNq94m8a
         QUYuJoZfkmUx5VNs4d3RKl5Ltq2PRn/FDcMJmAFhyT2Fu+QGvLLpm+77Or0vzNJcz9R0
         l5JpJeDAhcpSPErX97p9z/YgQ+5yzqngJvH7KYFX1HycYRtJmVEjszGH2EpCiaFzyK/V
         aiqPYtMFtz5eEtxMXWtY9jERc/K04DvVxsyL40taCTiMwOjHpyi1mYNV/QRvHk2UNF0W
         O24R2Q3MM2NWMlDfSo9/oTnhK0YW3NtXCogflRvWmZ/7sqha0QpgvizJYC6PW0W5Ib9T
         5XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306572; x=1772911372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t1p4FGQXSaZ6P8vjHG5j+GAGcuCQZ24T4h/zCWQM/E=;
        b=TPX2+vkVyZSSpq9z7SrFX+NVQOCzcsn10KFfV9C9IsUv4+nYR9Q6II9QEEfKvSJprw
         VDO7lcLpzJzIOR9uOiy5IpnyMk2d/aC+EY3CEeUh/O9Loun40elLVU8biOWbd0udJ29P
         tfitw7ER8s8M3f6oYlJzIE0cKt912y72R5D0h0OlY6O1CPtI18AasdX6TOUuCWeH+2IE
         3eA6ZaM47JAihcR7026yVsOmam5YVMJaM4uiy4VAAxb435FHb1aQ1FZ8MCiS4ewRmJEN
         zu5iXj0rg3rU3w4uv4THxMJId8Ay6LiM1mGA+gG8HQkj/jFZtM1RLeSM0k5SlvjPc2lW
         MksA==
X-Forwarded-Encrypted: i=1; AJvYcCX/OpYdF4jnyKFJpvp6QksuZq1w0eq6hMZUVlRiA7mhIVUDZ9oeRCXksdTlXVS/s9bEkj6Px3nM1EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FeQurPj80dMhS5oUsjNDE+rIfAru1ZhjedS3x95ZTPXfsS+D
	vLqODTkdhYMd3caXLymVFznc0QLFTTCWHaZ15XXDTJyjOjXMOH7vfBs9
X-Gm-Gg: ATEYQzwzKXjHdQZINbR9+1DbgI9S79ZpPT4UP+KUOd4zCiKEyiQFQZSfhvZ8wvEgpw4
	mm2KSjMRNYe1YRopSBZ0kKiXwvTZNvmc2RqG4NZ8yxM133Q7GsSBPAZa323fJkIS6NVNhqxW7xA
	DYsiRaXMcuMBpVRLW7RKAZkzc/M+AhCtfCaZJOEEtH1TKuCy8E8L4o+oHPRWyHQ4GxNUx9fYFow
	tpORiALWhONEwf9WhUnv9+j24gWMp0ZaLhyobWEXXZACZLSlsKH74JspKjYXnX7tNEi2dMBvcv/
	L0XO2mKkSsdMVHCMSZGEj5a3rSLU9DwNTUzzqslk5EF+WkNr2Jf6ee5feO3xd37dmYpcCE0gVhg
	ElXj0MwAyXTrSsFh/9CcEw5c8EZz+zpipdoHfDSHN/ptpjG46P4Er0NZ3r/CK1jSaAZ6WD3br1B
	NILZAgBfMRvxe1z7BHiCsNnUxLEhwKD5AMAaZaSse3pMIwnZRgv+1HASRpl7SxNUbfoEKTQGU=
X-Received: by 2002:a05:6122:4b08:b0:563:618f:b7e1 with SMTP id 71dfb90a1353d-56aa09e0425mr4322268e0c.4.1772306572265;
        Sat, 28 Feb 2026 11:22:52 -0800 (PST)
Received: from jpgoncalvesduosnb.jpgoncalvesduosnb ([2804:14c:490:135b:9a2e:6a9f:27b1:7cc0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a92049d05sm10800536e0c.12.2026.02.28.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:22:51 -0800 (PST)
Date: Sat, 28 Feb 2026 16:22:47 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Fix unbalanced pm reference count
 in ds1119_single_conversion()
Message-ID: <y2rmw53grslox76xcdba6gcjwwafaovnxjwvqlf7fypmg76qky@iagsf3h5cbdw>
References: <20260228-ads1119-v1-1-e16825ce34af@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-ads1119-v1-1-e16825ce34af@gmail.com>

Hello,

> Since pm_runtime_resume_and_get() automatically decrements the usage
> counter on failure, the subsequent call to pm_runtime_put_autosuspend()
> causes an unbalanced reference counter.

Reviewed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

Thanks for the fix!

The change looks correct to me, considering the auto-cleanup
implementation in pm_runtime. I need to take a proper look, but we
probably can get rid of the `pdown` label by using
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND().

Att,
João Paulo
