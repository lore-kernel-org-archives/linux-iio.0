Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2843259498
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685143; cv=none; b=ZVGSZWMgdA5hVA+W1neOEvNZw2FstxyYsLfvlTpKEjCn3nS0ZoQd/O0vNCOszYXWHBqg+bxEXxb9PQaSWFTPgoOmM6gxGS4/hB8eO+//Iq/bw9Pv9vCvfsxCcDiFy3skemPeX9vabB0xiJzUGCZurtLMMfBqbQDZPjVeFhPAwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685143; c=relaxed/simple;
	bh=Cw3BW59pzjhQ6yYtaY8oTMbMzdfEUldSAQFGv5og+Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZhWyBAt+APGL0OG9UQ2wNNk5VvTGIfK4/GWoRr2HfezaZODpHP8QV5gS4+empYL6dUnzTjKQOI3spN8gpy/dSHOuGv3Nr1WIeFlRs9rR1bP+OdMm0Vd01PXEgHO2PnvLAcojTKuMKY5o2X2QTf1ButT8o8fLj/N8mUpKe2cN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5rcpdEH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5rcpdEH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so3949963a12.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785685140; x=1786289940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1DcnFU7EismyxYSalD2E+hMXE3WVdszKjjvYYTM+tk=;
        b=U5rcpdEH0PLADr2u6M6FipdFgWteBE98gQ+0DU4QT9xdwvZI0Usvv0KyGfzaZY0a+k
         ROe4aZGbSSSW8yUIx/CpFYkkRzW3MBXmo8zUDcl1HWvvHPubFaRUVT1eBW1pJc2OiQjE
         ixRi1DGhU67raPepdyLFsGI6q59tqTTDtNhZdxfDSQ9ir6BTh0E7gJ4R1lIxOU0CG95h
         ePK/eYfPlspxBki7EH0y/FgQi+oG5Ay5poDU89/f91s5fqkcBlYISHVV1OpyW3kwPuxZ
         YjIBgpgywMRl/oDxpK7V1Kw5tcy29xOdChbxg2cr5xT7zNyXf7X2zq/8MOYeIJVmg/AO
         OVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685140; x=1786289940;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1DcnFU7EismyxYSalD2E+hMXE3WVdszKjjvYYTM+tk=;
        b=EcsGbEQz+BewWazwL8tcpAG5OCsmoPtjS74BznIuobwLjJUt9yl/zpctZZqx44ATQk
         TVyhGSJ041Z3e2Z798SnvqgpsyHXvRpGeZd1dJDpMwD5aKKbUEJzz8VWyFjHO5uaEC8E
         k3lw8/KpXgPj4oX0XhdB2l/bhepHZEAcgfR1FvhZCKBwLSg1r3LIfa6edfYCOYc/Cpaq
         ubCmjXE/lCn4uCfiOKr561hOrp/jXFmvdkaZf1COMo5v2GDzegHtb/LlI9ponD/VIwue
         DTtZRYY+WcT5EnZ1BzaHaLtDdHbNiUMv8AUPUoq+zMwspLtGksKaMN4YGycOVYLwQwmM
         U2hg==
X-Forwarded-Encrypted: i=1; AHgh+RrkDRv5LopGZhk9twASbP54iUyOtYtvDY2w7U8BwnAiryVvvg11wV1pRSfZPv7EgMB/5RlhZqitJJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFD7RzQhVBCzicgPyAYV+GcqnBso/r0mJ3Xw2ZKQ79wdNJFfC
	Y/bOMKZ73cQ0hFhxc9EEkDQfAQW4oHq5cNJyXA/pLSqBdr+2b5J7rY3d
X-Gm-Gg: AR+sD11jjfZ/Phb+mMfOfcpQJ0e3XJW48uDKi5VMUwh9v54ZP16NzD3kchy5fJizUoy
	yXW0gyV09X9sXW7H2K47dIM+8vJYwehtw+rbbFauViW6bgjK1FcBtGkk4uFiLPFCArLtsfvDRH2
	4yabValXg4CTf5h+Xc3eP2NNq0fXffat2E0DfhThZx0kkrj+GA4ZZiRTyvUtkPbPH/EnvJwePQR
	61FYPsvYVztCCSuQgg9P0I5A4L6PuoW7d6BmiTNZaFqQNJKklq1JCEN5D+C17ySt7mZrCSeX0DN
	4gQTxUReP8c1VqFsQFow+OtmzMnnz1glEAcFl+sam/WUQHO1l+TlEUHgzTKq4ggTwXWpll27SzM
	QGgiQJvNJX0BZvGKSzUeDrTozareqezMDkW/KOnK9c949tJzYVeEwZVVxocn5Hp3CaUOkhZcAzU
	Qk4cI7lJviv98/aydfoxhB3H1OWIbc20rapxxNNDSE0X34hkABXmhHRSe2kEuJv8T+A83D8fWHc
	G5qr5hDDd8hbXDAZo/gvsMFL4uiltnnFigoU3wNnF+rXKIe/5DQJgFdyz/k/8e20RUjQKfrWZ7e
	BxakxjWd9goo8jcp+isDme9reTQSUvbSRmmjIe9sVewxvoGzKkEXDc9ctyBXRsZpzUqSK/k5Fc9
	mcazEIol814dmqXMXrB3aa0iRi3mM4OawhkQR
X-Received: by 2002:a17:906:4e83:b0:c1f:5d05:34e8 with SMTP id a640c23a62f3a-c1fe80cad02mr347793066b.21.1785685139681;
        Sun, 02 Aug 2026 08:38:59 -0700 (PDT)
Received: from systembl0wer ([185.94.52.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4534fc4sm418261566b.51.2026.08.02.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:38:59 -0700 (PDT)
Date: Sun, 2 Aug 2026 17:38:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: hts221: Fix checkpatch blank line
 warning
Message-ID: <20260802173852.32b4bc52@systembl0wer>
In-Reply-To: <20260802020614.19732-1-adinata.softwareengineer@gmail.com>
References: <20260802020614.19732-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 10:06:13 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Checkpatch warning:
> 
> WARNING: Missing a blank line after declarations
> +	struct hts221_hw *hw = iio_priv(iio_dev);
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---

This seems like churn on its own, Jonathan may not apply it.

Also, I feel like just putting checkpatch warnings directly into the
commit message is bad practice. Much better if it were "Add a blank line
after variable declarations per checkpatch warning."

-- 
Kind regards,
Joshua Crofts
