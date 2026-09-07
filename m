Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6824779B2
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778959; cv=none; b=e4z4kSswmv2w0cwIUjiJWV6OwTEDZ3g+oKc5ESuw0b8jxM/RMiwaEU7D5kk9o4Ca51gPhxP/1KLVbPJmHJPUVN8n7c+qpOJWBwzJJwK49MPKJz9BiO9ScfMhFiMctWu1teF3sI8xb4df39dLMUXD3Uw3VXOI+6MUt11NX8ljPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778959; c=relaxed/simple;
	bh=cyNAgS+LY6NkA7zAwdAWlAf0LD7Ox1jZEAYPWX/rymc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leakmBjPbXr4SWd98KICL4PH5CrIxgz8udiI10cVevpSNDhUJGFN0+JQBu8e5kvW7x4rpYBdAX6pMU5e51JsMxFIY9jdrCAOLuUJWXwiri0p4x5hEtayFR1J3A8RSd8E4ML/XPZYKNJpk/K+6etqD06enLE2zRIPIUtsVlvPJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNI1e1Rv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNI1e1Rv"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843e9c5960so3409688f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788778955; x=1789383755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyNAgS+LY6NkA7zAwdAWlAf0LD7Ox1jZEAYPWX/rymc=;
        b=QNI1e1RvhVFJrPOS0JzMSgIwXf8xVKmc+kpVePpDmIZnaf0IaK/8ojO6m/TqlWzlaS
         tI95bf/DXhKaDgY09pF+4GAcl6yUh+WH0KXjjZpHYPdYjAxB+I/grCh/lw0QigdALGrQ
         2K96dg1HrFQ9A89xfnIwQfDpaKUvWzOOEBNNN6h5npeLsn3EChPPaoZbygbW4UnRVU+E
         e+1ASwWCIq22Gapv4o8S+ubSIMo82r9sEaDYko4c+Dr/uZpikNQh17FhY8MIijujP4j/
         2Mkj5d4fM6qbFf98T5FBH7fzhZTwsVeyZy6o97Ubj1c3aHuuk4bvP/KOjNrRbcWrQWOg
         iQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778955; x=1789383755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyNAgS+LY6NkA7zAwdAWlAf0LD7Ox1jZEAYPWX/rymc=;
        b=DIWNFQlNMEaQ37PZ/g564qYIRsXoUAQCFjuPq8GPjTsEwPLVjzd6dKJrYY7d0nsGyf
         ggBtx8/iUAQSeVRTxaQIncac06pSNIRCl01Q4q6HOf8JRKLNxTF+QngWQQvrL8REJVaV
         MgB31qTS+BY6fedkSriXCmAP3R8ym0CmkLQWv/Uqtl94FUg9RbLXGquyUrZqraTRw6CS
         Mw8WRZmwRKVykXz0gsirUj8wC6wqEQYpd39DbLItNC1BUbT2DwRL8kh6s0lUye8DHibR
         mUQGi59095sEQl4ZgEQU/WfY2sIp2wC7eX1K1rEeFAkSnO33JzUHElF10aQX1I7wMX0p
         a5dQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+8RpTO4uT8RaVNdV8psa4v++h7GC6skRxusYXUlbJ6H1W8KE+DKChxMlJHZMPNgv7tye8PQ3AxQU=@vger.kernel.org
X-Gm-Message-State: AFuF++lYD9Ph54Bu3J9yyGm5+mwM4Sd2azTWNfZ9IuyGIngxIfGkAoNV
	QIKqyiFwIw++JBSrUAZ0KaKvkCy4NL5Tk53LuIOWHlnNXVa8Jmw7lItT
X-Gm-Gg: AYBFou3LuNx5OdP2SjeKYvFOw0l74CxPsmhTlrXTkqo9xquqWAyGk36U9gymkUXcS4K
	JrddQIkTw6M3Gjlo+M64ZcjSiQdhH0J/hPtpUwBZnFQv5bnJnHTnDMNGaKuoHMLfiqj30fQCX8p
	KosU4M6RMT/lcLJ2sk1doggdp1nptcNAtW/a0wYTu/5Fh3bMS/qu/hIjeK8xaqQtc9fHga3YnMg
	KuVS+3NCijhw2Q1GEC1FcY8yii4CFmwZmfAL8CbYhI/+lknlmXJevMYaMhyHb71Yo49iif/cp7c
	MyemnqtXRNTbd5140t8fVg8X/6uPBRJnkudtSl4+yrN/NJD19D57S4t/9eyOQt0iPytQAZLhQjE
	ChdIfl4iJsJwzevjUhuS8wap/AZzymmdGZqrYquARcA0voNnyWLsm+xUHaq6TZ0WjDPRC8vXvA7
	OMdBx6SI47qe+djthBVSK5OWhu9w/LdILI++7ukILvqMi1zdyHwNawpka1wGf6n9AXT/TNf3Kiq
	i1UOw3ljPRNyZwkpeeVwfsJQWX2fpDUaocO4nRyJAPa+4cmsEoTq/g/YOgl8b8Xedl1Y+Lfckck
	OOzFmmkFrA==
X-Received: by 2002:a05:6000:4812:b0:485:8c16:5ee9 with SMTP id ffacd0b85a97d-4858c1661f7mr19695223f8f.35.1788778955023;
        Mon, 07 Sep 2026 04:02:35 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm24660979f8f.6.2026.09.07.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:02:34 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Mon,  7 Sep 2026 13:02:26 +0200
Message-ID: <20260907110226.244314-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907091938.00006748@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com> <20260906223737.206730-1-fabio.cesari@gmail.com> <20260907091938.00006748@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Mon, 7 Sep 2026 09:19:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Please don't send a new version as a reply to the previous version,
> it breaks certain tooling and workflows (b4 for example).

Understood. v3 will go out as its own thread, with links to the previous
versions in the notes below the ---.

Thanks for the heads up,

Fabio
