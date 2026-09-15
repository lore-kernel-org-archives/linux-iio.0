Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2C3B442F
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478241; cv=none; b=TCXHC792jspDIBT5gYkRYx2PcuJ3CAgNYF7DV/xlGdj3ItDrzyLie67ieZnUYtgcRXeu+jul6QUoDx3qwFycM6aGR3Ap08aPvwO9rdxb8tHNywTOmOCA7Zhy0CDzpNi9heNUvzcWxniHcVFgjnaAPKkoHCab1rbmvAjUsnKoubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478241; c=relaxed/simple;
	bh=PeFihLQ+e3Ey/2XTvIqLp/rsmvNZcxzZ0Nn2aECEjJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l40VtQ9IT1mp28S8SzZjzP1jf95wG1LGIkRyxV90SrBDo+MnsWuEK1RqKxZGkgc4KXrefkDSCVJWBxmvoCz3Opm6y1+JdgnSazDy7fdr5R/jWTn2N0QGMRH9PCM8+ngqJa/+cnZRN9w83QHcmUDZJLpHABVa6q3VbXyKCuyHDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOSTA7Fj; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOSTA7Fj"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7db0so51981366b.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789478238; x=1790083038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ky+km9SB+CxkGYQT+Ihg9VmqJMBueSg4hZ23dJAFm7g=;
        b=GOSTA7FjuA6IIgbpZrKJy5FAYoZkHLTUMt31qVok9HDldk4keb8p6b7ZfY8bZbTszZ
         Tq1Op0auntagCHCX6yux+Z1BWZG1agy+A12HfSkGbNRD1cPaNOmRu29vx2AFxlS5cpzL
         9EiI/A0F0ftIw2KKt2AZ6JBRIpffFZDboTBdiBAaRUiJNqKdmA03Es+TktA6nT7mogkc
         QIezmgtBX6tS4bigBGLWIWFa9cuovnjnDTL/XMqVu4Iu9vnR4S5S58W9bXmTq1pOAUAu
         PntYQszC8BBba1XD1N/Vjsk2nSKadOFlut7BwETSIYARQEDxS+ja3URx6ERVIHERlfpE
         223g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478238; x=1790083038;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ky+km9SB+CxkGYQT+Ihg9VmqJMBueSg4hZ23dJAFm7g=;
        b=fK+oUy/cAlJyBKcG2ig9miIoa3/Ck2msykw3cyn4Wo5DN/mk1dgQY1H5A7ZUjO0WD6
         Ob8sZ9xDx3+o7qWJi2fRS+d8hixKVkbHcI3G73gkyzyErSAHAFbEZywike7BRPsIPQWB
         zeHBLkUvqMubBp6G61NW56zuHE4mCrC/RicNvoOIIIPk9uyuJh6FH6y5XUfvUWM4oBx7
         ZXRFvrlQZu7CE03LGJDAEuKOWpxSSPZ6A4C3/OjyoDZfpn+1gCKTHUXgCGl7b9OfcBDh
         U3ENPtCVxUEaC+vCXtTTL1fScn94/dtvTYSM4HE7oEfH2acQvI1CaqXGgJuVJVIDQb4w
         gB3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCk6uTTxcStRhm/wyB8Zq/O6iBuvKfDpS74uFjwmBfSDiZFkAzSVLPbpZFo3Ea6G0yK5RpTa8zlOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mFmBA9PPZ9NWQdrGNsmbxO+CU6HZsiG0gXiSh2p8+r4P8mcLSY
	uu/0R7GXNN08DcFBQ9dibAONJmwEufZ6fhHfIoGd3Wx2sJcK/w5GP3Sa
X-Gm-Gg: AYBFou3SRuTAJIyEy0VF6gwLRvERxxjhy5gL5nm4crYJhIDPFOgRYCAJwMP5794prrZ
	bLyHfeYnn66gbKMlkzwEaLQ112ujfxnEFLJ8QvvHm32gur4mrtMkb0xYIOtMOX3mjxPDYs0MFbl
	GcvkXXBJ8jEwJ+UchmJR4w8R0YV487yNFPkcKfB+1wXFADv6vJAJuNjGIR1qc0bMUB5qWMu1cXu
	faAmy5M+uI+WExj0/HgtjfS8MSPugKpYspSKxXdRpR2nvssz4ya2WXSdX8shlnIW024Hg0iKyXB
	dbWm4DJAEkaz4NMVvwGMyRVcG2ocP1VVqBsrC8087jJmTGcoJE809HJ20tT4dRoUz76hqk1OBAL
	+lvfcsbXURThVQDTnBkMyl+92Idggc07nk4jR1Y3nGfp0E+9UE8TJmngrH+eI8uzSWEb8z4bSX/
	RTz93VDkefY7TTvQ3EzcBjdpZv2bSQEM8pjnmwVxGk5PwcI59nna2JpUpQwJ5K3U/TsgeHOlLA9
	t1p5OpwRNvjz9t056RZOFkSNw6s+57Lfh3cA8lVlQioe+Qpgnj/vi0uf/9gn1R9aCmegyfEmsdQ
	5B2LF6C1xeRUMdEVCW/7JjbBg9oI/sESftgS4N61JOAeezW2HBOIDc5ghut20BBq3GBEFMKsIzM
	zFDVT/3M4L2EWisymREOVtI7yCracYBW7pukxSXsi3RI2r/lyCofU6mATA0ukSeSD4IA2KcYEyd
	/kGVAZ
X-Received: by 2002:a17:907:9702:b0:c29:41e1:c918 with SMTP id a640c23a62f3a-c29d7717ca5mr96666966b.1.1789478237989;
        Tue, 15 Sep 2026 06:17:17 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296608dc91sm589042266b.39.2026.09.15.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:17 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:17:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] staging: iio: adc: ad7816: Fix SPI operations
 race condition and DMA safety
Message-ID: <20260915151716.000011c9@gmail.com>
In-Reply-To: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 10:59:36 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> This series addresses separate issues in the ad7816 driver regarding
> race conditions and DMA safety across all SPI operations.
> 
> Changes in v7:
> 
>     Patch 2: Moved the mutex to the top of the ad7816_chip_info struct
>     (right after the pointers) to prevent struct padding/holes, as
>     pointed out by Andy Shevchenko. Also expanded the mutex to serialize
>     ad7816_spi_write() to prevent race conditions.
> 
>     Patch 3: Dropped the dedicated rx_buf. Switched all spi_write() and
>     spi_read() calls to use spi_write_then_read(..., NULL, 0) to safely
>     handle DMA using an internal bounce buffer, avoiding cacheline sharing,
>     as guided by Jonathan Cameron.
> 
> Changes in v6:
> 
>     Separated the alphabetical sorting of include headers into a dedicated
>     precursor patch (Patch 1).
> 
>     Kept the mutex addition strictly focused on serializing the read
>     operations without modifying the sizeof() argument (Patch 2).
> 
>     Moved the sizeof() argument fix to the DMA-safe buffer patch where
>     it logically belongs (Patch 3).
> 
> Changes in v5:
> 
>     Split the changes into separate patches for bisectability.
> 
>     Replaced stack buffer with a dedicated rx_buf aligned with
>     IIO_DMA_MINALIGN.
> 
> Abdelnasser Hussein (3):
>   staging: iio: adc: ad7816: Sort headers alphabetically
>   staging: iio: adc: ad7816: Serialize SPI operations
>   staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers
> 
>  drivers/staging/iio/adc/ad7816.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 

For the whole series:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
