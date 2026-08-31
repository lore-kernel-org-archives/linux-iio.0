Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5003314A60
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167568; cv=none; b=rr4mycr65AgJryF9gO4gJZZvNFt/Sd2eEpvy1JyEMW95dsd8cbbke/JQtR7pXZb1D1ddVz0uQIIq33ObH2lYOzQ6NmYQSSDppwTrcYnbLHG7cTGMaXHh8DQM96lGb1nwk/7UrcWjHDV+/HO9IKIY5crk/CKibcQLtAuW/DVTWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167568; c=relaxed/simple;
	bh=b6eK+JTnsD5G55VIj96FsjB8Whw0kXK01d17YFng7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxM0LUzMgi/vqDJB+/Xc0ZFVJeWwSgGqnxUW64mMNjXeo/kS/rVTOUIYr51KIxO1VLilMVkGJTlz0fVDu4z2d1GF0Eca8sDpXBouLzDgZgg43SlWm3NALFSDp6R0QA1bva4lTQmvWufhwQ5ThwR+eRT/e3GERk4hVXzJliIjcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLQBAd6L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLQBAd6L"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48433fad54aso803502f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788167565; x=1788772365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNZ+b3HDjQM0tqOrcrrtH2VXmNsaU71pN0Wl2Kwd8qQ=;
        b=BLQBAd6LVx6Em+GdXHuBK7u7DZ+ibCpgwg8vPTR3MPFIPNMWXjCQyU+e8x+QCNtrxu
         FFHZMbYG88UkRi1v+6tR7tYp5otvGsS0SrmUd81mBWo5Yz4P4yAE2xC/Eryr9cTU6a+L
         FX46y2RY5Ew+fNM2+iQiFckdGNOPl6NRdVuktgcLuhFwnCGwUR5wKuD9qtVBOvKKlvau
         8SS43GofDlnguUPPpu/FPTvLnrKZ9c7SpzGAaGC7mItX16zF1tWyN+o4koqIWa1frpPo
         8SxNgwlLVI832U6+H6Qj7Dw31+e5j+TFggAdlFkuoaTHwhOOCWotsjL0OsVknCkzRpLB
         nFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167565; x=1788772365;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNZ+b3HDjQM0tqOrcrrtH2VXmNsaU71pN0Wl2Kwd8qQ=;
        b=fp1ULFsFO03mdThnrd+ffxOaPbZuInJGhybabaqwbHmvFk0dLPyHnn1D0p1evx0FbK
         sTQOZtY4yZ3cs2XkGdUHs28v0XepOi+tDGdnLg0A9nbIHdxiNOaq4IXKlwdKoKukPuUL
         tFPl1HWl1d5yXfrMRVxtsCB+G3/aHggw0zPCT4ANDgohK4DfEPiPGFeKb73qk5va904L
         gqbwQGD7BMjtnfM+syT0WuTbCzGBMZDYRDzjrzhvpJHMj4FbpB161Lh5HNTdw5mhDkwl
         SPaN8HnbBXMxe9TnMaYA8Ba5lTy2nbpdE9B/hU+tzcq4yWANVDiu3Hb8m9/11rm6LpsK
         ANiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHiyVAnekx5W+2z69Ned9WLa7Ttd1fgwbLkND0xPGJhWlOlflpyZhW7cL4KdCXGgfQ7dcqOsBZjv4=@vger.kernel.org
X-Gm-Message-State: AFuF++lbFoIbZX5k0IhGlMl1dWFPMJPqAyHTZuomkmUphfhRC2WFDoS0
	zOi2WiLC/rsClRooG3shkInVNF8h2qaZnleysLLIvurDim9pRoPF/Ycb
X-Gm-Gg: AYBFou2yO3jlIjj0B7z45VxUBrQz48ud6j2fmwngeSnI3UMk6BCPsxCGV/30TBxOToN
	utdbdI9eZ2Nhu7aePP/j4LDukusnne44C13OF2eL5GcSvenG2ZzH/01s5lfta+SZ/2bJ2534eMP
	osLKRTQAnr7jexcC1Rz1uJW7t57FRgDWL8v8mvMQ1IxmLhzRlSl0iPY98Myl04+yV+2UEW3hfIk
	KuTpgkY0vNe9Oy9RZxgRGB01g2fwU/Ofw38ubtPmVgEAH5CgqdQPwuJfr9tBzoEUpgLVkZCdsrx
	EdTHep4N+j3gbC175foYmAwqepC94qMwxKYva44M+Cq+vhV0l1ZDU7vmuL3v3ocPlecwrrYyLgI
	m3MgjYFo2BajblP1ayBtZcD0FwiwDjElv+Of7nvpmVcUZEYslxgD7NZ78oODH+C1sK+YdE3Zqag
	kBb5miadNCE87t3LzshtVGWPMiWcOGwbfBaHq0bVplZzqZVIqlfQkGi+AUXqoqLOLyypLKoAVft
	xGnM25EKq+lnZ8boPKHNT0jjhN/Z5Ut8Gt78xa2n0g2MAROx9CFBWVV51aB3md71NN5+23taZkJ
	NnqbP5GUYDsZPsfuYxM1haLV4DMRBw7TyPYlFPFzO3pTdfbVluVmnH4TmX6WunHhHD1xB/y20px
	6WEiCCWEaHOKWhEnRcfFXl/qgYszpIuVKFt63H011VNEFurxB9kOlwxDLdYA0fikVgyyNrKcn2/
	RHkuAJ
X-Received: by 2002:a05:6000:2003:b0:482:fbb5:8a74 with SMTP id ffacd0b85a97d-4843efbab4bmr2606232f8f.11.1788167564841;
        Mon, 31 Aug 2026 02:12:44 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm22268212f8f.34.2026.08.31.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:12:44 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:12:43 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: vcnl4000: use sysfs_emit() for
 near_level
Message-ID: <20260831111243.00001714@gmail.com>
In-Reply-To: <20260830185345.2209268-1-donggeunyoo.kernel@gmail.com>
References: <20260830185345.2209268-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 03:53:45 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> Use sysfs_emit() instead of sprintf() for writing to the sysfs
> output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
> limit and is the preferred helper for sysfs callbacks.
> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---

Seems fine.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
