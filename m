Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7130ACF0
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284168; cv=none; b=sN8roJNEJB1T4gTKo/10pxWBsbvJT3fnspyuKCJC/vIhKoAvvBs0z9TvuFBjoIRRTDMZll59v6XK+W9tZ/RygOvYsCx/gxHGJB3W4wFeell+dhIaaT6sC7n68waprIhTZoNpOavJ0PQne6XRR7Ses6jw2/iKq4u12tbI+ptQSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284168; c=relaxed/simple;
	bh=V2/ap2M9VJRHGek7XB7bP7Tm13juoKoysJSo+wlBB6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxv7EVFf2Df7y8vPCItnbQkvGs10SISvWlLHr7U/+o4hJPSg9/xv9hyoEwfygEOdxFHkz/iczdP30plchlwHKPjmG7bRueuyXhP5rBvLLnFiIlQ2ra/Xv8rH+9Ys6NRfzaT2Y6l7Bv8lhDKW/WijRAKWgyZXRlS6tp69m0Z7CeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwM8K93g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwM8K93g"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso713958f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284165; x=1782888965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooPtcozISMyKIrQpr3Giwok2X2PHx9YjdmH/4MQuli8=;
        b=NwM8K93ghejOKERQeB8LGM2d26IJpdNmrc0lXmRyu9ZH9bx/mzCqKVNI0l8uahJTA0
         OCqY+VSM+OwWQ1xw5Ip1qEwh8xrDfq4Lorh2o0OMxFG12tOEM963C/g/rIw3bEGnmXdO
         JSyg5T2avDeWmupqWuK5w+njDl0Y6yyYws9BSkZ92Mb16l0Gz8AnG/v8socXW8dAXLPD
         q3eFNRKQknbK+7R5rv7JTmu34Vxp8oPyGcDrfb3f32Osc3tAQMLRSUPEYDUGeSj4LY/Z
         yxeDhKlksV5pqbECx21yiyleCNwO3ofFLJk9iy1empWWDk/wbB2Xda2OSBGUSvy3W79S
         I/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284165; x=1782888965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ooPtcozISMyKIrQpr3Giwok2X2PHx9YjdmH/4MQuli8=;
        b=PWMVvrVqTZHrq2cMctOVbMD/WPvLqxi+vlfb+gLvbXKUU+2gX0GRIvVW4IdiVLCEBo
         wnDEPU/cWP+EWYSuja2kOx4gp99+BbP7U29h4ZZpwkB1AmuEnfH9wNFUAIF7HLQzIS1D
         p+HAd+kgjmmauorylNY7OGIpM9TrBiF/wnCB+GslNC2LfryK0pxTDEA3ep0K5oIhhjKe
         2uZHQfeH269pLBkXEE6zyv0EdOp1BoflPINPRSHurIZ/oBix4yMUAilIaUvL0MD43nQF
         pMrLvis0kS2DkZWQxzCkq9rBp0o3DN7zS1Y3s1jnOP/+0mg0F0F0dfl723XcRdIdG1Cn
         tMww==
X-Forwarded-Encrypted: i=1; AHgh+RqR2uoMq9JkZfqEc2Pyf0Z82WizBDn7RPnWrfr3TMeRRUTB+IP9rwd6TRfoK1aPkID5zP1PmyKINb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXksrN9i7/Roga03fnCLQQcxYPAr2FO6H1xmBV328Nu3UYK4NF
	ViUD9JoD8XplNB/u7zofnOcd/EKNG6uhYYvigcJh0thgVIdppzMSdIxA
X-Gm-Gg: AfdE7cl6+CbkTRHN/Nxru5QYRl3oCefFAKyhwPhgl6xfNF3B3KMyYM6E1prnFlVARNz
	KgyKUa7EY6d5cLuxfIEQSwSqRNrinsp6z127UEYlxHVaozxFZ72tJ2pu63GM5VAVGQeMmyEhkJG
	ZdkfY/PraVF5RnUD+i5tk6i1Q4adTB2Pz8fcVuuqzB6OhwVYCxEWxn7d8aSH4Al4ePqDyQhu0ZW
	XJbzyIESgJl13jajNT9HMUlfDH4TsCIOewc10QO1ru2PE/LeyHTKYzzBhXHW1/OKC1WLmiKvbQt
	2xfa96mbwYFuCsf/91BEdr71uDLVFj1JnawtAmeH8JjTVktKRPx8a/tLcG2v56ToqkXiAsJqDvt
	QuqYw0c2nFCTw0TRqXun5PzPbM9bGwNJ3qJpKRMyXKCDlIFa3/Diq9/sl0XC6fsAuuItZZVCEx/
	cNR1meyE7x+g67a4a6YyJLwUH68PwYUEeri0rwswZxVVoAdREWyGglEEjwtf75CAzuuzB6+hB1D
	fJ85nGJsXRZjUFeWEfbSoDvaZcUI3ctFYPbJDWtm1BSO4vopYifLGfWKF2BcTryESvdtyjo/r4P
	oanVD8bSTimMFzrgwArH6hvAozUrRrCPBCRdw8UfTWmreNrh9L1VBc4=
X-Received: by 2002:adf:e001:0:10b0:461:a16c:a6c1 with SMTP id ffacd0b85a97d-46c0b5d0f94mr2041623f8f.36.1782284165149;
        Tue, 23 Jun 2026 23:56:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b7d7sm3644546f8f.31.2026.06.23.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:56:05 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:56:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Remi Buisson <remi.buisson@tdk.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Message-ID: <20260624085604.0000757d@gmail.com>
In-Reply-To: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
References: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 13:38:23 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> The I2C driver provides chip_info through both the OF match table and
> the I2C id table, but probe reads it with device_get_match_data().  That
> misses id-table driver_data for non-firmware I2C matches and can reject
> a supported device with -ENODEV.
> 
> Use i2c_get_match_data() so the id-table chip_info is used when firmware
> match data is not present.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
