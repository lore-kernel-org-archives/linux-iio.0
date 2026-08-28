Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A66402B9E
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911284; cv=none; b=g760ZRKYXRo47/SGQrIus5Z8e3GOtwWOOfR1Vo+hHylDslFWhI3Gp4EuPdq3cVmkLWDPp+VN1y+zwRHDCyJu6zlwC7CGR2/bc7EmbPTxqd0IV2zEqJtyNBpQuDDMtQdcshAYfpUuDyGdZG7TnNJoM/GOq5HH7834A/i6UcZ4VKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911284; c=relaxed/simple;
	bh=orsjozxBZeT+wGghT0EHb8YkNsbbJw9UBRcSf69LwFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELuXyKnZXw6xXL0vVnulXN5HMdF3NogMhj1mHosDbbO49+wF10Dt5iuWRznvy/m49io5FH+nMftUS4mmRNGY322mTJwH95BnCqjs/KSJRxDbtExnEYYcItTBgIiURQiXLrqTLb1DLJoOdj5xC5WpvoSH6GXoNh4GdKGZoMu6CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndQWzNbl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndQWzNbl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b965570d7so4414355e9.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787911281; x=1788516081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THvdq2ntZwEYx4ps0NMR1RlHkdeyM/nQsNOsv9R8Y7Y=;
        b=ndQWzNbl8xDpxyqBUvFITfsnfre58IqnPrVQNDQf+VSqxkgPLwdltiwsHEeTu6w6By
         OAMulH/crQ0uOttcMz3kA96fYHJTECvj+nGZo4Enc/lpQzuwEP34GFFDlGsIQuyaJG0A
         kTsDMhBUUm8mhSY4l5sC4IWdi5PPU+kx2qgIFP65AMF4BgqsckjxqsLpGXeoFk8eN1pE
         Tz6FZFSyF1aFUCOcWG2eFUIKWksspWXIdO71W/S5ype73BS6u9Xj5Izju3EL7kbICjc4
         JtO2OJYNfF3cXE9MlZdy+HUCVTjYJfsHjAHE2xdO+kTVgfZfgwuLIzw320jac2oC1qIN
         vUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787911281; x=1788516081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THvdq2ntZwEYx4ps0NMR1RlHkdeyM/nQsNOsv9R8Y7Y=;
        b=dr/iQLiJ73NvrBaFkVvSMuNy0nO9QkaeBYHawJOdMc1nATFcpiNW9ERAIJcTrrhfVA
         RjB75gKQEiHhXxfD1hW8D3Lyck3IzyGQ0N+H0oyG/RBSW3OQ2li/vEREqC54Wsn3/0bx
         m7tloBrglrwtlDWOUr4VtkhnwzgDblyFsRTOMF0o3xk6YSnXEmdtMtMF/HhtF90pLmmd
         WuKWAnpD81vv6lOXzFz6IYG0KCL5fYBXQdTgJ76vYdclGtjJ9nQoyCaj6eoxrsUmMHci
         /Ic9yigPBlqQ1I9iHygVWFFNTnVIxof9vIlJ1UgE3u0OKPP0XWfXgJ+w7Ciw7yXgL7Pl
         NA/w==
X-Forwarded-Encrypted: i=1; AHgh+RrYN0e1jU9dFlQEcpigUuyM6vfrsA+oACVg0MaoU4Oy1PuQPMv/ZwFRHZb6JEFIb/jljTizXVa1BEU=@vger.kernel.org
X-Gm-Message-State: AFuF++nNDYE0XfDAcddJNz3D0jpStPuETRXVua9g8Q6sNYG6VgkRVNVt
	5C1Wl2GnxBCDJO1+EnuC6QLSC5U86dDKSe1VOidXk8xNwMqk4TLq/AQpYPvoxgb6
X-Gm-Gg: AR+sD10w9fpMQhU4LanV6CMD592dzQlraLKGqGYoY93D7ogYTIKXlRhcVtMyD7EoWE/
	XyqxoDmbSrNjaA6r73EvB8jir0+duH7EEG6G3VFYk+Ah7QaKn8GFwQSSSwFuqzM5vHFUQDruNsC
	zJuOd9PhdvkGpwDyVbFNmEEam57kVyVZuqgN8UgOsiYWUAUWEXvs+/TV+G64ykT9YhQoh34xz3z
	ZrMS5OELLgNfMQTJzfYntMi3ibfS0souleD3VxZPhODLmIBJdMphrYzvBYoCG/KLbt24GIhO6tl
	ZAH/yzwtliM4irkjyWyLvvuEmToik3tB2CSOcLBzbcqnr7oFKiRtrrTNCH8mJX3dy3hBzT0CbRU
	NJtsYBlctcjfhdBhBsCvv1tlc7kntQRjf+f0cjBNbX/A1vIg/rRiCaYE0fNqJSpGSsn0EtRwBw1
	sSHyHYnVRrAkY0bLX33F5TtHsuOPqvwAo4JYzfcurYXccba1duAmonLOvBR4fWYl+BZQBv5/MPZ
	X3U2rcbjPG9R8r56u80k4yoQM/EZNSwzIIFz+8MTpT4K8cxaBmjk6yL2VtKphxk1pRTxnfPpnw/
	UBIz/qAtu1SpIZrZ8FkBAuA1SvzqebP2CgA1ru8PAXP7AvvDWi1P1hjho2rV2gXIOYF8NMmSmNU
	UwRX+yEgMkygKuHQx4Kaf97sxL4/wR3h/MNM7+jRo7g75Y+BKxJINm+2AJ6P+a9kuCTDZsQ==
X-Received: by 2002:a05:600c:a106:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49b92df8833mr53912515e9.4.1787911280853;
        Fri, 28 Aug 2026 03:01:20 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc103dsm36740705e9.1.2026.08.28.03.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:01:20 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:01:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andy@kernel.org, dlechner@baylibre.com,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6] staging: iio: adc: ad7816: Use modern IIO attribute
 macros
Message-ID: <20260828120111.00000aab@gmail.com>
In-Reply-To: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
References: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 03:47:21 +0600
"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com> wrote:

> Replace the legacy IIO_DEVICE_ATTR() macros with the modern
> IIO_DEVICE_ATTR_RW() and IIO_DEVICE_ATTR_RO() macros.
> 
> This includes renaming driver-specific callback functions to
> standard <name>_show() and <name>_store() formats.
> 
> Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---

Also, as trivial as the requested change was, please wait at least
24 hours before resubmitting, let others review the code as well.

-- 
Kind regards,
Joshua Crofts
