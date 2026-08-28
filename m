Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41E4503E8
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922413; cv=none; b=CfcXMBwfwL+uCrUFDvt33+/E7vQpgUCwg3vWHJqDfwpwQ9FXrtfPMS5DawTrNrBqvVGDn/YkeNctAoOxbujOpr2I446HwSumRuXcwfCoR7fk31fCDi8DB4QGbkVM9u04QMwhQXczfuTIWDe/UzRFd+tYKdX1vmbg1aVPSqPaFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922413; c=relaxed/simple;
	bh=9HEjywerj9dI1DMv8TmODXVCvgIjH29ELxBcAtzoHqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjJZHwgKUSe2XkOvyFGziDVGs8YBdj+gYpgdLrprexCGHZ4DfNvgqRrLBMtl1KmcQx9CDi5IwpwdsQeGNpUhDjP8ESRHHautjP9s4d1fsKgq+sSnv1Cbkk3gMKK3sQxKl0pXnBsEZsbUe+6lJmRXeToDNPgOK1AX4VMtoduucHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv+FsJm2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv+FsJm2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso6334655e9.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922409; x=1788527209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OSe5hUo+anN+B3supDKWk8oyF7C/bYQ978Bx8sQdufY=;
        b=nv+FsJm2Xny0Kz2h5URMPSe+TQtqERGUG3F/y2he0ggZJClP1DOkIb20WnsmG9lxl6
         UZ0kCMBQmk88yz/ijX/7GYgZIEOCXisRbpWGCDF/TT8c+ksWVzz0iqbjRGbkjdg5PQ3l
         AfjSSO88PRIr7dPa9flydD5M0JF+5c+lTpx63DC3eW411nscK3BcpFp9fa0t6AWpfOqQ
         AkcXACFHLTCiEcWq0Tc6eUtaA+8DgpENaiQKUBsKSPY9EVEnVqAtjtlUpWgxAnKxq6ER
         9VzwcoJqkVlXOfSMwW+5ZnOwLd5DoHKzIowr5U6sTC/xVzWZmes9EfJBUv3xG1pEDMuQ
         pIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922409; x=1788527209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OSe5hUo+anN+B3supDKWk8oyF7C/bYQ978Bx8sQdufY=;
        b=sZvuQt4nNCkGANDxTJTyRtvxCU+/oNdJoCudJERgxEEfOCdSexz0M9dznvZ5qCSf30
         yDl7P80k+THHuTL3RcE7TmHsSS9KjVs7kOgYBWWaExl9ld0hqIO0Bm5ZvW5a2s+7QZLs
         LVmz459MMAj39TCNgPtKhnOCrMcQecRuEux4rjL037BW7sDX6l50wdBh/Mch68NS7rFW
         1V0IJhXocX5NhdHHhXMBgSGliRdA226DOW+oVTM91gYony8tBEres1ZJCjhaGLmDTp3I
         pN8CIILafugiRwO9hcPYwOZmA3IRLCaqi53s/tFhsmP+yApXreGiDhLpVDp/rim1AQWg
         md0g==
X-Forwarded-Encrypted: i=1; AHgh+RpD2a1FlUAxXWv18jp2KBG+mA6AoiKz986P3jDXhTOlq4UcZnTuXzkiqUNqOxAMPoZ81i+kDTMXk3I=@vger.kernel.org
X-Gm-Message-State: AFuF++lU43YeYx6BbMoHRd/FXHuoA+qOMgKUtoZr1S6bQW/h2eUpoTv3
	x3Uo3jEHNTSLere1getaE1TfbBOTo7LNaEeV5eR7JSwKNsVIvxqz9eig
X-Gm-Gg: AR+sD10IgJJcjPDqxF5yEGaIWDaf/sc+f3AbLc00Y4l1QaW+0xZ9Shf6Z+M0XQ6KXnj
	oS42n42v7LRqxYyUbN5GsvQbTqUPeLJy4kVc2BZedK4xDUnvcFw+qP4Y2VjPNe5OG8dEn7Bbd4h
	kMx3siKOFO78TXETUHgsXXmWt9+JRFJD2Yh+LvPuZ2NIw5b2sOu7U4Pof4hPz3SimjZotafW4l3
	POV5VCLRdE8+n395PfvQBCt/V324I3QWxnL5HyyCqm3HBuurX3O6oHAhLLPxspPKyt9WgVyaiR2
	r0lRK0jfqfa7mQz5W1dEz14sn8JPsrenrMWadjjHNIwUmLZNUBwELINAjgLmFq1Q9l41wVuGYth
	xLH0od1fjWd3e1rY3tWX2N3JdtR4zXas3iJiMbQE1SozCN52M23JNgSXDDCpcpDH7fP7iBtEbPZ
	LIxuB+SZ/LAPetX8p1QFm7d1UUz7LBRa0zARu1fcL4sh6qRBxUF/W3UD6I771LUsqqG21sHd8wF
	Zl+6G/R6XGBFBN4dcBOeQd87qqx3z2g6J5zmJ5t5zfz18rBuvnhLhvNknSFGBRSpAun2jJDu0Mi
	QQeRaDruJ75+wt1HmgxT0IPyiaXTnbt2jddt1f1jlHfOBeL/968BAjDyVzjjobLxOjDMcvTS76D
	HWsNQC1hoCzhyNDSVJ57aSlVr98wttcUYwUynCU6vCvczd7I6WMjnzeZuwZUwwAjlW5ZTvTo=
X-Received: by 2002:a05:600c:4715:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49b91c26a01mr97741555e9.5.1787922408578;
        Fri, 28 Aug 2026 06:06:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c7cfsm53999285e9.11.2026.08.28.06.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:06:47 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:06:44 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit
 Shah <hshah@axiado.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/2] iio: adc: Add Axiado SARADC driver
Message-ID: <20260828150644.00005d5c@gmail.com>
In-Reply-To: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
References: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 05:28:27 -0700
Petar Stepanovic <pstepanovic@axiado.com> wrote:

> This series adds support for the SAR ADC controller found on Axiado
> AX3000 and AX3005 SoCs.
> 
> A new driver is needed because this SAR ADC controller is a SoC-specific
> hardware block used on Axiado SoCs. It has its own register layout,
> channel enable handling, conversion control, and data readout sequence,
> and it does not match any existing upstream IIO ADC driver.
> 
> AX3000 provides sixteen input channels, while AX3005 provides eight
> input channels. The driver uses SoC match data to select the number of
> available channels for each compatible.
> 
> The driver supports single-shot voltage reads through the IIO subsystem
> and uses the reference voltage regulator for scale calculation.
> 
> The datasheet is not publicly available. Public high-level product
> information is available at:
> 
>   https://axiado.com/products/#AX3080
> 
> The register definitions and programming sequence used by this driver
> are based on Axiado internal SoC documentation.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---

You didn't have to send a new version, Jonathan tweaked the commit and
applied it:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=839dc31a0c6508354b18d09a9e5aa5d8f4c05860
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=205f4aeaae3148848c153a0d98a6f604b39aba7c

-- 
Kind regards,
Joshua Crofts
