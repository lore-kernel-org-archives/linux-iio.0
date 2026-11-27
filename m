Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746197;
	b=ihIrTUcQ8XDG2rzt1BeSGE96PqICFHgkimAocxGSkYVJQVzgftk8yQhujTPqGnzUErlp
	 ntcJBjBagoeUUTXFezWDsir8d5RIf6ujvjl7cgO0Xf0ywjZThoKheCicace7O+4XvVC8K
	 +fCoUAoqwYJ7Cc4Y4EPWs/4o+cifnpO5UwqD4xrERJHLq21UBemxX1jtQ1GaGU1E5fXG9
	 V+PZ5XtDrm5d556fDPGXb+5qnOom1UWha9yM9BCWnyhegt5H3e8AFHhQ7nMwIdlEWqQHr
	 41k8FkSnUJ3L+gT2GCB03jvapq+X2E209WvCSAxw91Qry/BcTArHdEGw88xE/exCmdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=Hx5DhP45Gc6LodtMts6vbsFotwIaFwhRMtG1SHCp+jI=;
	b=y+n30OU+qAJ6k0KuDJdR0kx2swpzpqaCbfGTugDZvji+3nhNtKV4qofiS5tM+XPcAmEp
	 /NDF66+8l3/V3U8SBHZU8+pxt9hIEstjzsnsQvITXyLUUmywaxn1lIzRyjmFiN8fGVi9f
	 3A3JgISC+phIU5ujeRUy3gQ6YM4ErIk15tW+N+8kU84Cgpl1zG2Gj1NKECtnFtNkhrOkQ
	 ydewo+Tkc4WQb3kok6U80O07VZp7xtFuontej5V9f3qvX5VB0bYs7rPNH8rEmi5HnMdh4
	 CDHzd36JtUg+gkGvScSE739m3UHwbwiGVLfs5J3JCYEZwQdTEIE8XyICwFiPuMnB6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dqMl5Dxa;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DA606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 02:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 378DA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dqMl5Dxa
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd69954c755so5499896a12.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 18:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746196; x=1796350996; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hx5DhP45Gc6LodtMts6vbsFotwIaFwhRMtG1SHCp+jI=;
        b=dqMl5Dxa8ui2tYtUU34qw1/s3jMe29dtE9LX8EUNNg7Q4/XoUt156/NZPFvPzJh/LW
         1/Q+VPHxZo+uGF3JdMWPljAjXNFrZjqoSs6W9b/MTnEQB1MEeMb+3Gjq+ksx3xqpmSrY
         Isvqm0slSmk3/RQL06qmRXMQ3eV9WapUUTEazQ5ojU/PXnAQVSjDbeg/q61oWyT9aZgH
         7n1C/A1dmP2Nf6SMZfjNYKeFP/cQ6n33Aw9/wpV9oObgjwdTSwFLbQIQvd5gT9y5Nejj
         WJKNeheUTSwCDXO5Vo5S8yizIvPNOLT2N0brS14f1Pc2ydcRuNPV1KGIpTIvz6lzvt5h
         o76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746196; x=1796350996;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hx5DhP45Gc6LodtMts6vbsFotwIaFwhRMtG1SHCp+jI=;
        b=xbH9Eng1jS3h5g5HDRmfnR8UildWccmY2D2ClG/rxP7/TbmZ82Vn1mVNpX/XOKi8ee
         89MTK8NsCvDLT99z7gB2HRAiWGhEMqtWrhociChJL0VaWF24zVVt0lRchNdxnNntL4Bj
         oVZbLxDaEdAqSyasIkeDOCqDZzFfOPxFptWRXril6G+89q+x/q4LmjXzhcgTeHrYdEsQ
         mKGb0ZHt9+RXN74XUbgGr3pZ+PGKF8tmSRXgNMevrduOyHtuGRGCk/gVJ9h4aUKoMqb4
         x8adlTms5CScJPGbTo+QsFFaDWiNZthyJ24ECfn3yQcRVSCh6VAfcjA5m+hzoPLPSSA/
         9mqg==
X-Forwarded-Encrypted: i=1; AL+hErFinGvYUund0pyuRK4xtcwPzCZlOis6cclNKqtzrmSWzvy3PHjkFwD92KQAwMfYyl9oqy1IeB0v13s=@vger.kernel.org
X-Gm-Message-State: APuU4Z87hY4zE/NpxNhyLtoegRUatDFcwTm/gUgKTYCEGED6ciSJBLJJ
	ssIIiNEz40PVGy3R9axTnaYxMvRbCfH1kM6f+Okg2D1p8R5rQMabBsb3
X-Gm-Gg: AZFdTZfMOcHWF7sPt3IU0PkND9hb783/SrQgY75AqXN1aCqC3GTvAfno3ZlEITIC3Nu
	c1/RDj/MjkmF/CpyLARXn7XTKB3Iq7iq7p3SWSgzlT1Nk1+JOYCf+Ih/07LPxkWjej0ZNLWDdgQ
	wphSyAjKnriZh/XhjXr2pYvcgtBgoCk44/7xRNn/mW8q5YxGwWYm5wf/Wpc4FuAUTr/+VbeZFOe
	Y9efivsR0F6xw7Pox9XRD/9tzY8Ts7RLig4gjE2XcULnEZewt7l6G+0v7WX9QLnrHSyCY9wUbls
	cNcu/A3QBF8ynBa9Iv1wm7Sm/V3zcMa282hJnSR2hK1hK0S+oggeOs06WA8x2+zRsYVcj8UP5ET
	pjDNl5huRczV2FFsF517PzCmxwiFYVod7qNTYnsOfDbiDRZvJieuE7rzl3bg2VIttf2h3ND5isN
	cbIzdfq0rk8JcQpANdeVD5fn7kiDXtmHgjVMqoyemUL6lmrS60n+zC7O7QQoODHYR11Q+xd40uS
	w8Jv5wQ0zZQ2eENFqKrZaVCYBTG6PxN5r8nIOcowM9lUwSD4BOZO90bt0CSoP27QIdO159CtZw4
	Mx/a4BmZYxL0xa4G6X4bM09aawO6I/XCChSET9eM03JoaU60KK/TjN7TKahC0It3c0gAOTSPfl4
	=
X-Received: by 2002:a05:6a20:c992:b0:3e2:3c7:7754 with SMTP id adf61e73a8af0-4014d25482emr23831723637.65.1795746196540;
        Thu, 26 Nov 2026 18:23:16 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdea2aed207sm5635547a12.11.2026.11.26.18.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:23:14 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: mt6359: fix MT6357 ISENSE/VCDT and
 MT6358 VCDT request bits
In-Reply-To: <r7Vh1EmPu-wr1NpHp23HZp7Fa0qmIAj6FTo_g8upWCKPJmnTk4kpjHxcDEjYankGVSc7WkkdWEklsFFUDQBF_XRB3GMM2XauzSsdw39czF0=@protonmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
 <20261126031013.27701-3-iasnezhkov@gmail.com> <r7Vh1EmPu-wr1NpHp23HZp7Fa0qmIAj6FTo_g8upWCKPJmnTk4kpjHxcDEjYankGVSc7WkkdWEklsFFUDQBF_XRB3GMM2XauzSsdw39czF0=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 10:23:09 +0800
Message-ID: <179574618985.4164.4856012256948069545@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Roman,

Thank you for testing and reviewing on MT6358! I will carry both tags
in v3.

Best regards,
Ilia
