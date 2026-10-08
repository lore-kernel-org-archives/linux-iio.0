Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5574156C6
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444725; cv=none; b=bWipnal6zCs0BP+GN9ykhJ0X/NJuQ7dcmiB6/cSpMaJpdP0dYi6qlLxIuCtWp39Zd/+gGO8hdcBbtSTQ/BU5oaCix1QJkPbdZZ3/8rR07ddaG7J7aqoDLakm9icWNfvzqNen+B+MUdzoYKIcphK7ME0V0DBfv+ls7sjpnJMrLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444725; c=relaxed/simple;
	bh=R1OauTk58FGLCJ/MOr79hoSoxQboPp2ENsJOfzmEyCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYrV1oJMDoS1JmxkNzFfkM0PkOy2ozwXJj/Jfh2t02JcZbrOLs1ZnPkEPP8lIh2jjAAXCW0RSyACQPpA97xLRCnRzFY6XT0lNgSDVy+DtePpfbBCwYTgBkAkm3Qne/Saq5Vore2yLQtQ2I461D+k3mTo4f/JZNgvF4NBFiM6hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWSzOQfM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWSzOQfM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so22500035e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791444707; x=1792049507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBYqwnAjN95MxzXbUBiz1fIAS5G9TFt/mqAU6tkwBvk=;
        b=HWSzOQfMqXVe/4HDYaEpM+NCxCYL45MrZw9PDtZr85zDEPSsbkPeXb6rPcPfj4v98q
         oA9J1k+JDPHi5Cp/OWqBkwxaGZUiVActhpBCz+1ywWqm6SykFTzGMJdan58uIWLdMjIk
         MrN4/Rtg7MwbMvJeGpwFMZDiqE3Sn+UVhPvTyFgeS+9GUwxsBXzuRLHxO83hbQlYP2l1
         oYbW83KXWUcQ4oFSe1QI12+3HU63lACniHlbYFkO/dR6XCf+f8JEcKq5CZ63zzyi70J5
         m8eK/0lyYFYSlj+pDwPoN9+NSg7+dpN5UtfS+10kdSoLD1rDO6wm5ouHNTsliYXA0Glw
         5Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444707; x=1792049507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBYqwnAjN95MxzXbUBiz1fIAS5G9TFt/mqAU6tkwBvk=;
        b=1gIO5A4v3eX5ctCsAAJrw190xI0V/Vf7lcWKk1KYBdGVhtH2EnaRtA/0I22q+bu5Ld
         W/PHjLtp3f2U0FLIye7QEF5o597FRMpZRNb+ed8kSRa1xAbNpCH664fHvNqfMesmpFSD
         UATLGh7JbDwJL329caMpSoZypcp8i6nLzxzlQMmFw0mjfO3dHW2rOWIQjJNXLsCYGeW4
         Ykolg57ZJqyZ0Y/Tq0+gmlVONTl7lliVCA2eCTesmtLKwUuzmeCGWR/fSPyLpjPyxQOG
         Ht6T7GRmUi4ojz36MCWzHv1MEKxmYftV+Jwky7DjagcOznvPoj7mXcWP0Am250h+dG2w
         BQnw==
X-Forwarded-Encrypted: i=1; AKwUvByfgeh40jPvzlJQkOcvftdkMsXqboYBDSw/7ZwYHK8EC8WnmiIZyxz/s5Edy6S7mXtvinoS61bWmks=@vger.kernel.org
X-Gm-Message-State: AFuF++l0Pd1sGTaYudeD9jv+cVafv4QkxgygrxSjBKvryOg/DIBrRxmE
	HD+0glrb7uwbUDtm/QmDvAb5tO0KivX2QjpHMuZKv96qNxkRVE3IxDfn
X-Gm-Gg: AYBFou0LvUwCVmlTqAUkIEAYxmg+HWCfBvHf5pEl1Cv5bD3UbsZ1wuGmIJJM4ytdgEs
	Q4heNl3no91NNbVZEmId275w+cv0QFkVu4SoYBwqENT2J2pL0gQWRPiW/82LFjdLt0ir/wwm/jN
	3EEuiwRvR+bhHmjN0gYubxJ/C+L6aZruvl6WJ0J7Gc/87TYsUlvIUve+HN4TTtggsAj4cVjtaA5
	Imz7f5AOJ3LT3Hso45naO76QeWBHsNUp79p5hbhhKSmHEOvU9Kr4dyA1uvpe6wzo8p6tWicb/6n
	DiO0rK/YWjOu52OBA2ML1Q+/jHucCqZQIqpYKodLGmF2RhmEUGut+9cZXGEEyhbNOzu0+ABxIbj
	2dlExK/d47d2ZrF+42iBc+ABE92nvdRSZ/AOVCf1nWsgbhsn3l3FoPC9Wb/01oprQvv/sZh8BGp
	SBxJ7H4Tnr1a0AOX3L4oHRm1ySAiXaeM9vTKd5bxTGQxu5yPll48gmRJtJFaM3lD4xhVOzr17yN
	rLzWS5JoT7/j/xmuPSZnW5nLIaXKOHsFS3eukEpXT3m+5Vr7kvJbX7ABsldn69rgOuf56lpgX+F
	ZdXAt/Dmon8qXwptrcjRjEKBADYY4YuaCmJv/dxe3tnHDEUNFVcAMqFpJkioz7I3YrIFbv0BP5g
	GVjWEjJX1Bh1htlnItalooPJq8y0A5blGZ5cTytnCXADqeY07cns/EyAsHdk9EyF/Vg4dXgM3iu
	15LvS169qxl+N/4qx+
X-Received: by 2002:a05:600c:3b9f:b0:4a0:2644:80db with SMTP id 5b1f17b1804b1-4a180664e4fmr81750295e9.35.1791444707089;
        Thu, 08 Oct 2026 00:31:47 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842abdb9sm47993535e9.6.2026.10.08.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:31:46 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:31:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Alexis Bouzigues via B4 Relay
 <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Cc: BouziguesAlexis@JohnDeere.com, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: select IIO_BUFFER and
 IIO_KFIFO_BUF
Message-ID: <20261008093116.000077e1@gmail.com>
In-Reply-To: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
References: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Oct 2026 09:34:16 -0500
Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org> wrote:

> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> Since the addition of FIFO watermark support, adxl345_core.c calls
> devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but the
> ADXL345 Kconfig entry does not select IIO_BUFFER and IIO_KFIFO_BUF.
> Building with CONFIG_ADXL345_I2C=y and CONFIG_IIO_BUFFER=n fails to
> link:
> 
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_irq_handler':
>   adxl345_core.c:(.text+0x145c): undefined reference to `iio_push_to_buffers'
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_core_probe':
>   adxl345_core.c:(.text+0x1db6): undefined reference to `devm_iio_kfifo_buffer_setup_ext'
> 
> Add the missing selects on the hidden ADXL345 core symbol, as done for
> ADXL367, ADXL372 and ADXL380, so both the I2C and SPI front-ends are
> covered.
> 
> Fixes: cf04212d1fe7 ("iio: accel: adxl345: add FIFO with watermark events")
> Assisted-by: LLM
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> ---

Tested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
