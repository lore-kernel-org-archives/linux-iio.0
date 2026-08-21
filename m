Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110D495515
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321115; cv=none; b=FEDe1P4DNsCWbrWLvh5AMQrEAdqDM9xG6qYXBz12UnNF+nmoq1W6V68Jyrd7SMqnd2Vkiv6iBQaTXy6BMzrvBfHyUeqVaFP0BpyKvWSaBkBLDjNCXTxIuNXF6YRzD2LZmAMEfMIY6kX1fZg52N22uCmVeUUehVVL9AA9t7giNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321115; c=relaxed/simple;
	bh=1ULVjh6Ji+i5OTUW4fd781uZYqaAXvbl7KQky/eHKkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI3i4uD3y9g1nwnGBSBahkBuAKhqGbQl2OV4FbD+qUCGn/YZ7HtdhNEGuWHextVRB6PUlgyC+zOjV2lQCifvI72xZucehlA4VyUWC6ZLtDRGzuabXQqQ8jXypU4FU/Dwq/z2XuKKf1kMd4ygWbh4LQQ3LdwXmvKDDrm7hnYBcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPCwJs1n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPCwJs1n"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso11401295ad.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321109; x=1787925909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXfAXSIThD7u/o8Kez7ecU/tOp7+/Rd2dWDcoTTJvIc=;
        b=pPCwJs1n9hsoKfrQcqOF9yBhASblivcAA4I37DDODOs0y3WtcT+RpF9j4iwBAYnuao
         1laVbn5nvJMNaQh7BSxpgFRJJ+UqCqc3uLhO8kPhyHRTN7jreZEAUqacTL0hYv/FmaMl
         DRUkP/UDSVli2+NaMQeetRdtdrj14oMWi+AgFZ0Nk7ybx6+F7R9MMptpwxaBHWPbXjzx
         3vc53OSzX9LrOjpTcIvHwwfq3qumxHuUVcO+14qjxjRjDColTFBVF8rJCfbgD/VQkDhB
         StKEW+/RyVqs/bKlZWLV+KCfnxUocFrPnJihRURQ73c+PU1UepMVYjmCJcGUJv+bhllH
         goDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321109; x=1787925909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXfAXSIThD7u/o8Kez7ecU/tOp7+/Rd2dWDcoTTJvIc=;
        b=UGJsT6datJCtHQCGNHgk1U0DGwe2DCDsq7G4QrsZojn+o+WpHoB7KiNGuIyd3xLL2R
         vDT7Gtp/DODw0IXxEiP2dbffESKEFb9dapI4ZGyWmsFz7rz1syO6Dt4qvHWHCPJbP15t
         XMlYlztGn4sDfs2qdSiwlfd/YOrrfSR5XLT16ttm8C8Cb2N8tztdHXKB6LuiPJ7mY372
         FKi7SEBAdqX9lRrCkC+Sglcq2qa1iGm7o2ZFyow/I1DnwFjf/uSFWpgskrPj7Bnnh9dl
         PXTrWtPKJyzFEabHl7jxH9+IfZA+Tvdm0sfsyVzNmAkp6yG8b/Vt4N/o0bNQgiquXiRe
         Q8JA==
X-Forwarded-Encrypted: i=1; AHgh+RpyRbnR/ZeTmOpuF5r/b9lIGyuKl/MH1M1cuFeHblfznWgSQ6Bt2236ucBxogWdnoitOmX1mmeMJFc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/fCJ2bpG6TgnDqikEJBpVVIZRlZYFFIqOz+VM5bojRbkVUtmi
	5d6DbRnxddfh80lDokkcR3rY03jUMld1rwwCwJo8ReZo3e5/HfotI5E=
X-Gm-Gg: AR+sD12TpH3kDIjtiAdM5F0fELMqEsr9X48dbylWIN19+C4bUcs554bROo+lxI3DMYV
	/I5RbRxIQfafcZp3Rj4F1PYXYXpK1seLR4atkEyCHlCUSYlxwQxAOXv0NFlHcW5fwChvURZ0eNV
	tubUctI1vSYOVX1a8/P8lxwGOipX3c5ce9XObMI7sJDBPdnSOUldXMSKQ7NClq2ZZx98W7y+Lxd
	7acrFRNketzaBey3PtJ0/Cczs0BDg6NdrPh1xjKigdninuVAArRUuQXOJugwYdQle4gyqIA02ln
	5utuJAwIB0O1ebenfZixan/EOzgj3DZqFaauXRUhZwJtjLICCCQd6dnwXunafryp1SaWFBOZa7j
	T7R3Qfy45aiXq1yJjJhzEKEPw8jpLqY0XQIpmMOi2Lz6XToWCm+sHxAdC7wr2I0WFpPOe8UbI04
	ra4nSA/EhMp0GyOgz1wQwGrtm0K/V6TEPyCbu1dPMy8QKy3R1njL6wQw0zTt0bo9EFrZEd/KtGA
	gIAB/rGk5wv4T3qK8VJwNJoCgSCZ9MmCb78r2tia1nbvp1dn5kFVpkKpzZKRaPkVKeu
X-Received: by 2002:a17:903:1b23:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d64b036caamr145862735ad.10.1787321108063;
        Fri, 21 Aug 2026 07:05:08 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1d8sm19842045ad.52.2026.08.21.07.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:05:07 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	bleung@chromium.org,
	chrome-platform@lists.linux.dev,
	dlechner@baylibre.com,
	groeck@chromium.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	triet.hoang.dev@gmail.com
Subject: Re: [PATCH] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 14:04:50 +0000
Message-ID: <20260821140451.3969-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aohUjlM5QZ7BLob3@ashevche-desk.local>
References: <aohUjlM5QZ7BLob3@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 16:37:18 +0300, Andy Shevchenko wrote:
> There is a macro that combines DEFINE + EXPORT.

Hi Andy,

Thanks for reviewing. Should I send the v2 with the update?

> There is room on the lines to make them longer a bit.
> 
>   Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
>   and pm_sleep_ptr().
> 
>   This lets us drop the __maybe_unused annotations from the resume callbacks,
>   and reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

With the new commit that you have suggested.

BR,
Triet
