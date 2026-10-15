Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753163E763E
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055515; cv=none; b=mBwIxpqvWLt3HPchDRpVK778qvPDrOtaEErR+KndwxidmCHODpCh96Ito75LZ/AFFF5/8qwE8eqhcNC/AVtHTJWSKOJIlH5IufOVm28gGeSLq9muomAYCGKDF2/ZiTYk1F9OaDtzXihhMgzzNQFITWGCkB5ZBnFc8wc3h83VaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055515; c=relaxed/simple;
	bh=wpQT+stmebXiL4mPACrNE8Fk+UMa7Okg3Oz2NpJ9XAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqchEbt2H9/t9/n/1u8BG9dfrQracYUtkdwq+4Btq1gHOHvXBLm5PboZaGbuUXoD6QR0W910pVdBeHIp0IbXPAkjtxscM93l2G2uVhZpgdJNMbEojOiKNT89Y9iBuheyk3cMDIavJdZlQN0DOS6jMmphRftBBIO6QSTzRAtpSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiD8dkO2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiD8dkO2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso8247815e9.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792055513; x=1792660313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37kUcIBmWaK8bzKMBQU/T3AglBZJLVILgXw3ivUKujU=;
        b=DiD8dkO2MPF4OxicuMtb4ck/BdVOSv+kAg1K83HlvQ7LqCa+k5BHCngM13sV3oYnZy
         OfUjAwgl8TnKdjOnyivsEJrFtiBhNSVAbidhVI9Ir6fagOpGU9ZJ/DrMDsX1I2soGQZq
         fF0jH+mZuPG8t+HrQp0VYtVaC1z8r5RtY+gGJYYD0Unqw3lh3Xp6tIoWAgr1QHpDxXld
         m6StTP+A9CPMYz60MUn7YvQ6xwxxfOk8H+35L+EvDQWKPaDJp6op4YFmzVtCJWpmz0Vy
         xPELA20XbfsEOBQHLKLioxHTtB41b8hlgNKs/ocEew2EGP+XcfO5yAbGjCrMGxBb6x6L
         MzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055513; x=1792660313;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37kUcIBmWaK8bzKMBQU/T3AglBZJLVILgXw3ivUKujU=;
        b=I9fc29uHS/PMchdKjRKQzNtTiASe+zJtvk1WMhdk34DO5AHT2XuvGw3NPKG8gU9FGJ
         BrWfjKegUglNJD0WFfgdO/SYCNEDbDNF2mvq+ljtsABzZjkpmCLyrx2MYFwE1dvd1Ryq
         ssmCSLU27ht3xb7FTWBCFNzTlpj1gH7ErzSptZ15dhSqLsThEYAHv/bADmz+IpOLEwCx
         yXmkDHlqR10EUkPubNCTpNs/kSZS04+mUWgyXAtYgRgF1hQ+mGlsTBcObPI0WqQS98tX
         17s4E+Al030CuPI+m/p1fzQ/Q47K9QMk8Pa+F9fkEIIWFTfaTm838wr+rtUuEIwsf3ZI
         QEjQ==
X-Gm-Message-State: AFq9FYLHW8d7KTiHEW8Ou3Y5wb/h/5BmVRosmu9dn/80a1SU+piHiZGH
	BZUv4G2VM2FYg+B45xwaiIzaQHCBQCe/jXsAT1hMfjYlViG25NoH0m3q
X-Gm-Gg: AYBFou3J1VLjZqBuNE2UWJHQUbB+cyRmNz0qRKSKMNGXLzCTB/4f4z4ginMybz3bXui
	EJkE08Cqcgfc937nL+l9BptytX3swwHMWVn6UPwjQr7tLddr3RQaQOB8A9nCpK4uHMjUfgRZyEW
	phcnHgE7Qv/Io1/9Su8GWdbsxR//TYZzGV3hXXWBsyZgRVgbFTAWk7LXhwma9uaWaVXXmLUiJkt
	aIwtlV9UIi0Z5Wy/urxPuQcKSzn0twkjSCS5zGCYLlrhbDa+bhNIuDQkK2g2dS1CP+H8cJCaf+g
	eV7YxaaC6jVVXao+Kv5KLMWj8TohhZjH8mCEDTEZgf25ureguuPtuUxQ2oXta+agDLwFBlphgxt
	tjC2j1lKdcrcJ+Ph4ZoRT3OQfQNgsezcwRqqfQq4kwHZ74gsJOh9DAllYwCMXbXjVME/tB9RgjZ
	6w3GtI3mIgSDbkmmIEctd1Ng2oNVTCa75XFGOde6f304SHEwgpcCD7jwAMvf+DrinFXhFcyBjXC
	Buc9gOalbAoly8UV8ovkCLD4a7/yqgy7SbPJ3UgzyleD7o6ylLseswrYuSi8yfErqukl41VQFCY
	ZZ1yu9N3/+fYE66cvMrdnI2+xDdPMW+ywCuMINxKIP0ENcp0wNY8oWXRoH11x0+9kGEm0EHeK14
	KTl5c9H1otr/hm7PWNk6ko0z3TyERCIBoY5GWVU7sgENVgJdv5gpuGvtuVwqXx03lm6QfgEsmHg
	lvazyq
X-Received: by 2002:a05:600c:4708:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-4a18e47a8a5mr401130485e9.10.1792055512163;
        Thu, 15 Oct 2026 02:11:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd67a080sm54179925e9.3.2026.10.15.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:11:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:11:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH] iio: ccs811: Deassert WAKE GPIO on error paths
Message-ID: <20261015111145.000065b3@gmail.com>
In-Reply-To: <20261014152250.8324-1-nikhilgtr@gmail.com>
References: <20261014152250.8324-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 20:52:50 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Ensure the WAKE GPIO is deasserted when status polling fails or
> the data-ready timeout expires. Early returns could leave WAKE asserted,
> preventing the sensor from returning to its low-power state and
> potentially disrupting subsequent I2C transactions.
> 
> Route error paths through a common cleanup label to ensure WAKE is
> deasserted before returning.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

Please add a Fixes tag.

...

>  	ret = i2c_smbus_read_i2c_block_data(data->client,
>  					    CCS811_ALG_RESULT_DATA, 8,
>  					    (char *)&data->buffer);
> +out:
>  	ccs811_set_wakeup(data, false);
> -

Keep the blank line.

>  	return ret;
>  }
>  


Otherwise,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
