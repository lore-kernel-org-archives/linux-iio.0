Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB24A3D59
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210004; cv=none; b=etn0Vcv7v4rHUfDOrlhMcJzw/v1K7zBEGWnzwySFW2faClySY3hDFmD3LRqdfhLDbwp2KyiBkAtMk7/HEGIuJcBPtB3jLraM8/Z+fHTp2qbSajNsaF+fbq3Qo0IPQtT0xpnt6dYdl4/+pwKRbKv6bryYznVFFGIQni12SG+ZlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210004; c=relaxed/simple;
	bh=s1VDAQ8sxE8CT6SU0AhQK5RG+Rx3zLPOD3QKNeiXaa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDseFvFL+kAvLrA4C5bRp0ITWK4sA5/NML96QUzM1iLLsyiWoKM6Bwgrmg8hQqH95WrokhDaMJX7L6DY8cs6/rTTHAJSEo+scOCJ1YlkKTiw/AK8QV1Quzri9bJTlBpQNy4TrQzr1hyAWWPUj3FQ7aLuQ/Rx1GMrEB9BSOipMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSrbIN5Q; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSrbIN5Q"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a169d33ef6so10708685e9.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791209992; x=1791814792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWoL59DEflmCTZ2kafhmYE0bRqDflnpDVO0eL/8FVtg=;
        b=TSrbIN5QSzQeIU2/Gdn+FRXbmQGpVDjJHz7w0yi9TiJuL8bO8AbZqg4m1csw3+6l+2
         YjF13GGAiNXD8gzTxcnfq2zK1ckFgZTFy+jsHmZc5stk4LhfNUYK5HWhqLYa5zCRuktj
         gVa9ncJcUlni8cV4vFtw3s+VgAUJOkWyH0bovAn7CJd9tTfd7/PXBiVzelFA6vFAuJ5O
         cp5rfgkBdhYibmh2DTilpaJyMUZbKWsV2LA2nozd1xdkkU0Z71itPehAFywSan+OgrMN
         lfjuBJ9rOpVJUG3uFs0IY6WtxtFmifgX7bpuwmFaXS52zbAW1971bATtgZAxo67/aimE
         uekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791209992; x=1791814792;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWoL59DEflmCTZ2kafhmYE0bRqDflnpDVO0eL/8FVtg=;
        b=UnQKNID9AvVcQGkqvTJhF74y/YXU/FvkgKsAyejTpEy3zthjsIQtFn4uw5ZGXTeecp
         xKeTzHsA48TnlqW4ZEeGIYc5YZQDYyr+LXETJD78LGmDmihLmS4q+DdNyzZo3sSXbVd5
         gaSM9kFFIhdY1nmn3euFMFzJsOJ8+IxMdvZtWT4roups3Ph9mZnFxt14vlKxSspjZOVv
         hQPFL7gWSzD/Lqw7r6wfRvOT57NAjDoC+43sqi9iQ74jhOvLOc4k8e8aNxR+oo0mDfH+
         6BWRdwEi+CiZPdFB+IJAnK52zqAQHAs3++Z/3wSZ0v81pXT0+20/8j0euzS+nuN91czm
         7C1w==
X-Forwarded-Encrypted: i=1; AKwUvBwenrJHPvWJ8GzRQFVLYzx/TftXhPyR4oxH8ztVNVc34vsnhrbK/bSc2ofUMn7Wv+qZ04Ih9cxTkMc=@vger.kernel.org
X-Gm-Message-State: AFuF++k1nx4OkGHhDWd9/fY0cfmcK946U3k6lW4iLkqqL21duSGnQFgj
	kTcuTr3SHawROKk0LVfCti/cTXVGkFzPmwWuh5dVzTgGXUAqBQCDGMtIzEMrhw==
X-Gm-Gg: AYBFou1XTROhPtbYh92UZlBsPYDlpu8OxzLpTnh3GVks8w76T8cg/4ehOjX9kY1OgG/
	30QPlvPeh8dH9mV6FfcS6pbi4KyH1LGbqXAIuSi4cJ3pyqOSZzqJ4Q5klj4Sf4ifzv4tqjqDAPp
	Qk6CHE2Ah9LAO4Q9i7vloNbKC38AfrVtBXRZFrggo0r8RbsMlx49Bx4lpmDgC8TaEXxtOTVDvou
	vvVOuCcQTgKcSnxrOoctZOLIrcXHe2eDXjsqAvxhSP83+V8dad51SAA9ZjYNgf5C3URMi/jlPlm
	Jl8i+yPgH55/mlcJfUx1kSZr07/BtgAqdXkb0OZBA9S3PaHbIRAGPly6bbhq5BtNY0UlOUWFASw
	cVzED7kFjCvMP+o3z5qMveP6d8L1uiEikxs5cOH/dOV4DYRaQ6nk9+ZiqBEcmpYkz+IO5/cU/Og
	v8frlII4nwo4h8WWbN0igrc+fHfqtRPTbsEHH5ySteuCEmuq2bwOeKConPXM8x1g7S53cFs2eHr
	Hb0G9mOCAB3LPLmmVg6nis6GEi1wLxSrr9I7w+7V91Ath/vrlx7iYYpZYkG77JGG56CD8iRvtt3
	eCDQPrJQAuAcfN/ZBwkz5pTKNPCrkTGS2/K5JBnRJ0w46gWxPAzcFdIg+k4UF7Qgo800svgu2Qw
	h5Gh+pAxsRRJBv8TKUhExoblh0N1xXdEEqx8wXbnF+/mWWCtrqtWYm0ivOIWrJmIX193SiANRqi
	6T1pvk/xrgpWREjXo=
X-Received: by 2002:a05:600c:6208:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a0278d021bmr185702835e9.22.1791209992157;
        Mon, 05 Oct 2026 07:19:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm483681815e9.11.2026.10.05.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:19:52 -0700 (PDT)
Date: Mon, 5 Oct 2026 16:19:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: temperature: tsys02d: Fix state
 desynchronization on resolution write error
Message-ID: <20261005161950.000066da@gmail.com>
In-Reply-To: <20261005132004.255462-1-salah.triki@gmail.com>
References: <20261005132004.255462-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 14:20:02 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In tsys02d_write_raw(), dev_data->res_index is updated before checking
> the return value of ms_sensors_write_resolution(). If the hardware I2C
> write operation fails, dev_data->res_index remains updated with the
> new index despite the physical sensor remaining in its previous state.
> 
> This leads to a state desynchronization where subsequent reads via
> tsys02d_read_raw() return an incorrect sampling frequency.
> 
> Fix this by handling the error path first, updating dev_data->res_index
> only on success, and using guard(mutex) to clean up locking.
> 
> This was found through manual code review.
> 
> Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
