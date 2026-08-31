Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C213F9F45
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179412; cv=none; b=e8TTy5VCLV/8JT4XZaGCaiNwxI4YVgMe2DIhxVwBTigK8a43EUhZcV4owSxsIOek7dekKL0pYn/N9R682F+D/49ormAzo+IJLimPWRMe0dP9hztD8mzZ4TuK7GMsSUQtZtdAKlswrCiVumo6itOrKiJ9AEMqCsH9+rMpUE7mCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179412; c=relaxed/simple;
	bh=/E30nXNgrV4bahY3yg8DBgLw/qrOnID1ObDIyJ8RIms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exX5Fy386TZu3YeP2f5C/J0rfq43hULJEAIcvAUof4iRThrvYyIEdFyJJephngZoTyoOd7JsEp8Yp+eDpbmSp+jOv8LyIhkLhVt717Uj+v4L6ijoJEp472xO7losVK5WGd0DweJ7fiU6cMP24hNniqV0XTAgc11nP5rOgZT5AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGdDASFF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGdDASFF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3157234f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179409; x=1788784209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMXUIGCQzdMm/zkOXZYp0poF59+bnF6+Vb52UOsX088=;
        b=HGdDASFF8HgRj6bEPFgmQTKzO4Gw1s/9r/WG1SUZvgJ3CQYAZ5Qt/r870vLMFFISRH
         TejfoxvrT7TrCnAstxp2ipe7Ql9dRamML/WSWuHTTer59b1iuHQOmVo9M3HmvWYXy3OH
         pazzydzZQ935bhHOzrxEOjSDO9qXUX6bu9eAAbMTA+8oz4mQnAlkKEGtuhmkS++Ntotp
         RYhg045wFm0AApfGQieILZ1bwZikVb4tddYgMuGL9A5f4F4JajAp/voZD5WI5hbSzxol
         raCH8l6y1yyDMp5Yr0sQHzr+VqYNBx4GGSaLcS7ilpR7D3ghX6CE81GoNJ+WPdJtbq4i
         KMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179409; x=1788784209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMXUIGCQzdMm/zkOXZYp0poF59+bnF6+Vb52UOsX088=;
        b=YbQZinykW1nrw1FGNiCdFivXKG3zcuwEj118z+sVu76UduJIaayPge5xSjs9PstXZu
         nApuwf7MMFCD6S2nhEcXT5gRWF5UcLQNj7kUMqy7vVs7f33j5iZnx8CXa3HLmU1Fkeob
         lB0NVsbDaVv+bAyUZ6VXt/D8lk8qCRaZev/lV1UqFy21agRnoV1TkImEzc1WqJgUKejd
         +BACQtpZAXFGNDIOwWScIbGlpqFPy96l+XlFw6xTz8Xe3J5ScPTXGKN0U5lE3t4ZZhrP
         SJU8cAsNTbB3Pe5H0JnBlNxIiw28fgi8V8yUaxvk0M/9Pfw+GyVPRRORmIzThpFvStF9
         /P+w==
X-Forwarded-Encrypted: i=1; AHgh+RrI7e++VnY38QowFQI2VeWQC225NKas9JOcIpvKRIg5pVgwiIXmRQZZHrBg10gE6WFrO2cNtx+abts=@vger.kernel.org
X-Gm-Message-State: AFuF++nRu8qNgdD4EfVtK1MtNGs5cHgVJhjwsJeOAtIvCGFYjrrFA/y1
	tmioFHllXKv2wytR7Jj//CWdh5LgCwHVhVEZVkJ1THwoTq3U7v4oZ99E
X-Gm-Gg: AR+sD13FzFuBpD0lQ1V1cV74AcHQQdORSDGTHclNuVKyaH4sDYfiIoCQnePNPZ5yWCW
	GltOe1W7xiAhE83I9D5Sp+0//EtQ89AEYndOciVQCTN2PbiQM+qaIY3bdLG89lCbiscaOcw6EZu
	p/8b/iLOrCmHfvPwHHKejjfiRJdLSSGe1XeaF02r+pOZ6YMvqME6uwD0I8Cub0WWG99uL4KnZ6N
	ymav/5RGvMrFFrenQR8E9gyd9+00eWbeFmkOWOu3Y2rPwGVX2nbVrjDCSghxU/sZn/N/abgyFGn
	gJHEMCFthQebwN6xyB8x3yIlHJQL1nDHy1zk17hWoF9iM2g6WiqvENx/nA0yO+Ah2iksObpLfiV
	QviuV44H76XTHGr5Lt0c40ocO4gm0W+bwhnibRd13voOqgrWx4a/gMKlBtyBztON29VlmoQOWtp
	MgMj27lYpSOI9/4C/SUY4nB68jf9X9cN+h9Q27QCJ6ghkTMkr1QdNYmX3DsUwwBgxTtOBFEkYrv
	AoapsybOg/S1xyn0krA8DlsmOWCaMaLl8qD2Y78t+Qa/oOsaLx/WJEVirNUclZ2gzJIagIn2P58
	0i6qSgW7tpKQqdnFXR2NC8c/t/R4jMfsuiPSz1u5DhY5nVkRig32pZhTKcIgV/bfMEpk+Q1uLpW
	9mTTA6jZ2FIV5o2lx05mK04jGl4V+DzsplBfLdPOeOMfVJ+86jsjpDF3HyyCLCmKXuDBJ3g==
X-Received: by 2002:a05:600c:b85:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cc96ad411mr305395965e9.12.1788179406393;
        Mon, 31 Aug 2026 05:30:06 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm216176755e9.13.2026.08.31.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:30:06 -0700 (PDT)
Date: Mon, 31 Aug 2026 14:30:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: rename stale IIO_DEV_ACQUIRE_ERR reference to
 IIO_DEV_ACQUIRE_FAILED
Message-ID: <20260831143004.00007913@gmail.com>
In-Reply-To: <apVp6vRQmyPi4EQH@ashevche-desk.local>
References: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
	<apVp6vRQmyPi4EQH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 14:47:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 31, 2026 at 12:09:09PM +0200, Javier Carrasco wrote:
> > Update the kernel-doc reference left over from an earlier revision
> > of the series, before the macro was renamed to IIO_DEV_ACQUIRE_FAILED().  
> 
> I would argue that it might be good to be backported, but who reads documentation?

Only LLMs these days...

-- 
Kind regards,
Joshua Crofts
