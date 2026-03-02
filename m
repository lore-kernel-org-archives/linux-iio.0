Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488132AAA0
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468993; cv=none; b=HN9og0hC7b8r2xjHTDDQ8WsSFbzXz1jpka3MIVVmIhwkyAn85QLn5d9SVxEQ+bNFDnrQMAWuMga8Yv2nKCK3E3Ve2rR4kVh8dA9n+wQvyosj3bvqfw5aCHntkk6jC5f7GilITxBejy3ZwXHNndljH5YKTERraALe4iOtMnnkzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468993; c=relaxed/simple;
	bh=iHC3/jsZXpJKhdI5OSw+muYX37DTgSKILkeyl4flMUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHwweZfLqcUBo8o4KMECejobm/Fnx3spbEJnOX28P49NesXDEuMd/xe6iq+FfvZcZbGy9doOmx9hFPunX5uw3bGH8xaS7JZ7336cewPO4toHxaecOUMs9TNyzHwvbFA3reKbU6YsXEsV2oE/41TLD/yN9hhsW3EJcwov4At1rK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=imu64pB/; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="imu64pB/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-66ee7b9af94so2080606eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772468991; x=1773073791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZW0nGDoaKxPbtsphSFQSsDtmOgBp9+Z7W8ytSm8fwk=;
        b=imu64pB/GS3OB+29FiT+TCOZ+VtMOAluxiEyqBfyyVTBTRhcnGtY533yB3wvPXqPyv
         /Dzbf94seNbfIUcqDT7gyS5+c8AZLj9q0oA7EfjzM50LJIf+BOus4LHnjYnUuIgvwDds
         KX09Z7Fb/JQ+yUwvRt8K03bjlg2UwGm3sDxEjW44EswAVHLt+mGebMPbtwZzzuedQH0z
         lxKQiWA5DgHiVWZ2t5pSBEiTxv1SiaTPXZ1PpQ/osng3hgV2+D/BQAbkBWhINBhMOwyE
         yGdraN8i4eX5GdQdk1CITq0MwZgqIs3gLo4T+Q+ud2cv1ZJ0uxxz1ho/urncpZeIbuj7
         o1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468991; x=1773073791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZW0nGDoaKxPbtsphSFQSsDtmOgBp9+Z7W8ytSm8fwk=;
        b=Qsxwf7PTP3jKR6o8i9WGl6OfbFYagu3iS6uZVqJg9wFKaWD/VJNBRFOF4a5zZDHVyU
         ETdqu8tG1+B4/UJayfxBcAH9l7FBSabAyVintDUSJbrvn/MzMm9APj2zNL6M4rhdl9rq
         KvDctFMkxlOBWlw7YFJf1LheG9TT1fg4BUFBeXFxQiM0dS79PGml9WKypAOKCtuZTa4r
         9f/Nkr0wouyQRril4CL4DxLSKDoh/4F7Z0Umf0Jym2zW0q/7VwOq862R7LUCY7FUDH9p
         2lQU/vwmoRz8lffGpy4ECrOJHcJ6myWAXDCB3Y5+i12MZ/jDrsPEju2ZIuQfChvuNP0w
         pouQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFb0FT2svjiSf7o13MmIZPJfnxaeqn+mS1uf/VFQf9smaAyurW4ONb2QYVR22wJbPvzuEUIqY4pB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lJDpic/E+lhrhRHG7Jqy+WMzAjA3XGElh3NcflmQU1kZsP1k
	gvlrYElQ9+sjdriP8ILst7y6WwZqHgIqwJEY8gGBFWp8bdkCn0VNunaF0XB1NaWchF8=
X-Gm-Gg: ATEYQzyQ3El1uTzbCQZ0aRRnlUU5+5aIwxFMVSHSWCuWNhQWQ8uqKRXGBFNgh5rLxQR
	9QqAmxP4XOFDOln9Yhk5zBbr0QbuigUD9wq2NtmbPZae2MHAscXjrc3+AhNjjqVU8bgTV4rWZ+k
	rD1OpXl0I06QmGeyuKWDOUz/MHgx/bvjxvOWyMb5aXlOC6N72LR7qA5MydjmsYNeA/GNYfTUr1b
	nR61S1NXlRhyIjJswYmb/BS7vGGT+PIN2cf/JGs49c58aRY8zuZi21WcAvUnTf4GvCch2osPqJm
	WabCx+GVDihpK1WhIe+V/iP9u7C7/QxxBFWAtF51MZvYrWUzo03cbZ2SE9ccBKi3Suya+pFzOiF
	DqSozD/jERoDT08Pkilwn9Htfmk9nCGqzG6TLTRJ2EDN7OjjaIX7VyNuGKrbreduV4HOH0UTs+F
	D/G0bapCJIG5zQYufokFcg/+JVCm7W0U1zY2Ytz2MyNxv0Pk44bNx0KIcB1v9n02wsRd5lZqkwP
	Q==
X-Received: by 2002:a05:6820:199a:b0:679:f0ec:427d with SMTP id 006d021491bc7-679fadbf675mr7650067eaf.13.1772468991085;
        Mon, 02 Mar 2026 08:29:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2be9b8bsm9387127eaf.5.2026.03.02.08.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:29:50 -0800 (PST)
Message-ID: <5599f271-3d81-460c-b2f3-3cbd704ffbdf@baylibre.com>
Date: Mon, 2 Mar 2026 10:29:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: adc: ad799x: make rx_buf static and DMA-safe
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-2-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302130632.29144-2-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 7:06 AM, Archit Anant wrote:
> Currently, rx_buf is dynamically allocated using kmalloc() every time
> ad799x_update_scan_mode() is called. This can lead to memory leaks if
> the scan mask is updated multiple times.
> 
> Drop the dynamic allocation and replace it with a static, buffer at the
> end of the state structure using IIO_DECLARE_DMA_BUFFER_WITH_TS().
> This eliminates the allocation overhead, prevents leaks, and removes
> the need for manual kfree() on driver removal.
> 
See replies in v1 and v2. DMA-safe is not important because it is I2C.
