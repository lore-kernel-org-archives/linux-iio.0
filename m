Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471223DBD49
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749563; cv=none; b=E3KD/LJW5RsHOmyb5CVD2VEgmC/yy5CnVgfGla/fOQ1j6AtexU55K9sLx84KfOaSdQ+J2khYueV+EoaemQQGf+YGqhEfeTelKIs8FZDmeOQ7M8YncskCGClQgkySbUG+Y16Tsf78/lGf8yWw9dpiMghAze34gJyHldKVFRehfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749563; c=relaxed/simple;
	bh=abNN/kqFNibFqpeeX7Sc8+iZx1RJSU3/djmn15kEPGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECKTGBEDFLZ45vesVO5rFxpTXH+nTYJZX8Y2UFWyBQFLf8TnSI7fhZDhigszscuQpfZhMBuSv276LtDIMwUSFsABCLHCoyWfIPbpUzlMuu0WJv+vytZyhQzEb9o87RiIYg+V9+90XlV9OKcN8VbIJqengRdRbtryRKIDntEaizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWI5Tgns; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWI5Tgns"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so11115455e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785749554; x=1786354354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YRSnGgtZ7AscHIrA+ZyhPls/W82Qa2a03dgwWmp/mE4=;
        b=DWI5TgnsbHM9eurp/FQ6hC22cNUkO3LWv/1dBSxOA1BkiGXwiPcZ40sp7PjvDzhMLg
         mN5clHldyIWU2jbu6GRkdwunaLrR4Rv3K3FNb4xo+hXgOpVe4WKSD9oh1440YUAmcxq3
         bO4T2iG2dkjszZX/Sz9pKXCooglp/MugudjZvEOLmwNoxgkmkImPO6fiVo06VwaGxtIW
         nOAmcQZCxpvPAzKb4y1PNZTizDwGsHfbXyDBx/DUHNWRDcghkXGlIeq6G06GB9Ymh/KF
         ZERH4eQ2LLfeRzi88YV+A2fPFpbGrr34ox+kx3czuaGXi8lfugDiRSODyURG5NNohJKM
         hhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749554; x=1786354354;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRSnGgtZ7AscHIrA+ZyhPls/W82Qa2a03dgwWmp/mE4=;
        b=kMJIDHk6/KaMt2h+kCSxGE0baKVfAAlFHycYBAHlMis6/XKqbZSzpOKWoWb1krDLk6
         qST+lk3y0f6TinyzcTICuFytHt/lrowUGUmnmdLZQHUztUdFyYEXGhTOXrT5PWfAGLaE
         fQxKYcT8opaQpZtL4O0ZmrMVP4likm6OHvGRZiqDcG1aHRB4WWmAcZZ8Xio9zqRBOyzD
         B7SDlhyY8y/kJtcu3lnK6k56/fWpygcdtMIwWSkS1seDE19mGe3myzjwcw7T3n6CYwpb
         gs1eBK8HuAosulpoinqq/gqxQFSZl/B9aCO4qAV9AodnK5EuTLr7gSgHbhqfKiR75TNj
         q+Lg==
X-Forwarded-Encrypted: i=1; AHgh+RrP1UZFuUDBX/N1xfl2/91BMGpuv5R7M8WLK6EKeWkIY12Y6v65h6cISdrePUOqtZ+zk8g/Omj4lPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqUtLmVqI6QyhtYl3Myl8CRG3fHpz4bYjjRgDBIKeh29AxuQY
	ry5fEQpbJQPzm9Vtp5T9mEAnG6EKo/Qk4CZwrKDG6Ha6lWMjti2CUxUn
X-Gm-Gg: AR+sD10sa5Q8MHrDpToQ9XGqEyuNzrN8jk4Si1SmSTWfjSZeiEMp1zEYoHikcLyAE8J
	m5aV+0R3xxOmxL/00wwSSkzEX5yK+0nIicBVW9K1gXIePuBoTnTs0SyheUHJrh9jVcclqITNViO
	VW62ghrUSmH/m3Ce3PC3dhlJ26cFpc49DjfIZNztQ1hRnpznqfczFWE7qt6Dn/GaoOcj+hMwo9f
	Wt5XI9hRr1WQSX1bTyGnNRMwF4Xvoft3bZzH2+5mAjwSzfe6ohfgGtDJnFO71sljQLJpNh6yeVc
	+exRDec4YLwjyd+I4sxy/lKm/huvI+MZATu27KzmbNtdFWDG8/H/Hvq9yEVW3ibIjX+1GczOZxQ
	nHgt7DAZuMBx7RTeKzn9n6N7BkjVPLMbLVBWdn7sJ1B6q/Guig3RtKNkMRywspYwgvc35R4GaM7
	wLQOY2pkDcfHB0HiOtr7HA8caf87Li5YfjO7YeQkQXK3IVPC5uLRnk3gAAyTW5swNuQ21SqnfZ5
	DsqQdPtMacfhGwGyadWRWksMUc7bNUS3YXhUrw63gKfFDqk/TtbGCvp9DZvbc+2chJQDt/ZgTHE
	MU76r5f9ea7YsNWH+4+Z6ZtK6LhS02RcgjDsQnMmyikBtsVphv24EfXINAEDqhT1h6qRW70xwOb
	smHuGsIDzICaFGVY0Yb273+ldFCIY+7NcgLZ0x2dEVgwzPBlfZO0GeL7fctC/ATnRwF0HMapZLW
	CIfHFY+w==
X-Received: by 2002:a05:600c:e548:10b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-4980c649c63mr154714125e9.6.1785749553608;
        Mon, 03 Aug 2026 02:32:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808691014sm219556615e9.11.2026.08.03.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:32:33 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:32:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: jonathan.cameron@oss.qualcomm.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, maxwell@maxwelld.cc, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com, 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260803113231.00004302@gmail.com>
In-Reply-To: <20260728214943.29820-2-wafgo01@gmail.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260728214943.29820-2-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 23:49:40 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is cubic metres per
> second (m^3/s), following the SI convention used by the other IIO
> channel types.
> 
> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.  The new _scale attribute is
> folded into the existing shared _scale block; only the per-type _raw
> needs a fresh entry.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---

Since there's still time for additional tags (and this patch has none)

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
