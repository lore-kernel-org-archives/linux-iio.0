Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB23E7179
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942865; cv=none; b=gI9wRwsBQp+ueH/2pllbzuwiCrmmUAIUopW2T6YQlJ+A6cOu/tAk7jft8Q6aC1c3h1aQ5Dw2TmRa4S7SmaeMJNLleTVt7ANnet8TCkksIlwszy5lC30g5pynpUWEMuPIhtKTEwuOaDM1bEEIHGEqSeXxkHJ3OAhcHWWvBnWzySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942865; c=relaxed/simple;
	bh=9FrLo67VfYF3ZpnOVkaF8Rlr709oEukF8gtE+IPKx9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pnr0w12wUCGm/Ovmr05UgoygnrzpVB7Vp+A/eGE87gD1rlBEmdOh5eEiLfvhRkvCuPEhoCNJttIVQffkwmEnRpdU2/hjzzNyKRhNK7jb+7DxKrGw3s55/Qcx0A7SOad/8o7MXYt082eMtbi4S4iqHxNTqiIdq3tB3cq4TtMT574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSZZrx9Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSZZrx9Z"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11180755e9.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942862; x=1784547662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/WYgW+KJeYAWgpC3kzeRPmTrBu/4muElQjvrWC1UWc=;
        b=ZSZZrx9Z0qsVercscfNYdU+AKk1Pe8mahzDGSsoI6Z3VdL8OqYeqnsoF/S5IIFpbjF
         /GuFxpbJzrcv3CgAuVJFmxVcgYp37bCYty1R/6PFqfw8rtVbrkbIA0t+M8WPgLE2twiI
         0eU284Yb6xMWa16QAzx/4YucsJjVssm8673FMUZYxAKZC+as72JWi/3ztEBg9v/UcANi
         IlxWTJ+BkD3EAWATdngDmSw0322sisTkLmImpdpwzodFeH1PPmdFhdZ7aCQhzulQ0581
         jTq/nkUTs5UClzZYY2z6YETTAk71JH0zxDud+pwXDXcJIPQiMDnnBj0p/gH3nJFSxpJE
         iTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942862; x=1784547662;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/WYgW+KJeYAWgpC3kzeRPmTrBu/4muElQjvrWC1UWc=;
        b=B+4zq9ATqqQNM52R6+hFMKGwQYWP7RFAENN79jWn/mt7Ljk9DFCGZYNdBpHU/bBDXk
         GK+rRlSjy+BmQUr11mndw1WkeDaoJKPQOihSqtkDGUeJzk1Q+MQEmLJej8lBMeMyL2wG
         7gi6KDSnEPnqfP2NbXBmEYoZ7fH9FO8M/Enrbp2U0nuAgsXBBslTcFOnaxDaUuh3/YCv
         jFKcR2quXLW5pokDaUuWfSAtTqbY52DWnt+poklgtAYs+2Fcv/UXZZYQzxAg2/gY9IJB
         IJXcHtLBBdtHxhfS06eCGugNhupW+ddWnGWWl29/kdFkKGSURrFLkkw56hBa0MmiA1kg
         VvAw==
X-Forwarded-Encrypted: i=1; AHgh+RotjsTTBxFA6zFUuLMraJpT0gPhxdNZE8qGPmW8dLHywFPPW+ok8LK9r8VMkSM3WeBaNhGgVjm0VS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUP6bV42HuLfxKGSWLPpkrCDXqsnlNQVdWQs/xhhUb1CzT3vJ
	lKhbzeK7cmicS5iz41bH+EBP3uqs9M0f6OdbZJFBQhVcFO4T7z0E4KWy
X-Gm-Gg: AfdE7cm8JsUs0l0hEcfrb1Ehh00voSNe/bZSxtkoEEhP70e0iOk7s/e55xCeB0vVKnS
	v5qLQ5Mj2aubyXe30+Fwz8pRLAAokJTxQYsiJAY41ORk1OXWgbYot01SVDI9AZpn4C0DQv/P3X3
	6hjqxOomPYAz5LxjV4WO2xsJSpXm4vVwsCOyKxAlDudF3pR4A5eWsp2DBmUua1SyeHWUR4dIbji
	/EVi1wxpxTJwxRIR1R/broQaIaVAZrIxauQw7BcfFYkXqh8q53g2T4Kpbn+hvr4GwAqFtp0LQj4
	HkFOQPRxYO3iFb6cUMopnZhx32H8WUfGbxKAFhG3WQvdSEfeNQk1744oEllpQwytHMV5W7PQkjd
	y8NyUKTM+7bHT+PhjHgB9o3YrcGSI9RdMSVdBdcDF0lmBGNkTP94NAkY1XQ5MDXfx4xOnVeHiSD
	HvgGb8vXV6yOvGICW20imcG8Q0U0JcbRgAusK1Hs6baMqUlGbHTojKDFOHlG3zEJVOaFTUo8pqs
	IHRyAC3Yf65W0tjq2NF/9huGyyOSdyuqqSCOCDWsEDqVjW88L3O+3q77gRkT4RUXyHD5XLLCaoL
	q6neYY7aAET8ssa0zCujxi0RwVyvKxgT6/BULyLtGb79f6Y4vTPypQJ3UNz/eWyd+on1SYRvnqX
	aOugcC19R/1f6wrWqAJ5MaEvAZSbRuWJnqQ==
X-Received: by 2002:a05:600c:46ce:b0:493:bc92:ef45 with SMTP id 5b1f17b1804b1-493f8820951mr87046575e9.24.1783942862160;
        Mon, 13 Jul 2026 04:41:02 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f49755f9sm272718035e9.8.2026.07.13.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:41:02 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:41:00 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260713134100.00006272@gmail.com>
In-Reply-To: <alTNSJODSTsPWyAF@ashevche-desk.local>
References: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
	<alTNSJODSTsPWyAF@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 14:34:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 13, 2026 at 10:31:30AM +0545, Laxman Acharya Padhya wrote:
> > hx9023s_send_cfg() copies the firmware into a counted flexible array and
> > then reads fixed offsets from the copied data before walking register/value
> > pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> > make the driver read past the copied buffer during probe-time configuration
> > loading.
> > 
> > Reject firmware images that cannot contain the fixed header, reject images
> > too large for the u16 fw_size field, and validate that the advertised
> > register count fits in the remaining payload.  
> 
> > Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file
> > parsing functionality")  
> 
> This has to be a single line.
> 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Remove my tag for the time being, I do agree with the change in principle
however this patch needs a bit more work than I expected. Happy to re-review
once everyone's comments have been addressed.

-- 
Kind regards

CJD
