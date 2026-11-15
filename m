Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714964;
	b=weW1LjC8EbVyBP6bxy7cehWwHU8aW9Sz1cm9naZ0KMUhNYgaN9JwDVfalcR5gk3XnVzG
	 T60Fj1/yTKeWoxqJapGjKTqZ6Vv4q+PhFI3QuDL67JF5yUtQ0MYs3Vt19XH/tP81+CtiW
	 Fqggi9o5jU9o1do3BMejwnDDcvfMA8uq2wQDS6Y1sJ57ViK1HPs0og1i/95OM1DK3MCZW
	 IoK1ozcPWp+k+arMjB9cxHS/CRLPjpc02PGuIskw0uLfiTpA0gbk+kOZNF5YsabZl3k4s
	 LGycCIVQ/2o9M+r1hbfrIdjKR8law+qJmuWdccFsEPGwwK9xA+opJNn1HCH263yVjvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NQEmaoC7qVxS6XvHOnYxy5RPxkM/mcRmN7qqE1HnMCM=;
	b=JgWINYk6GPBMOUZCZ0FR7x5ZSAjnchrokUXWtEX7ZbGEqpTr7Fr6uP9UimqAMghSPkdd
	 xVTvpGUBo62Ss/aISxUUJPdUtD7RZxasLu650Qo9oUIldqHmAI4GFjTdx1gQlXGabv9OZ
	 tEt3tQsWzXR4BW0JMjbpig2LB7qFFqCcH39tY7Hu7PUsbJp4czd7tfN0UxO45wRHhXAqN
	 6svhJfpnEPpMSMZOkE8oLEfb4TQqHge88sRLnkdKpV70EUDVnvlh/802POf64PAIppgzU
	 0h3zYbZqFCLuDy+ZJIKwiDqEkM7KrH/Z9P2+VLWCyweXqWv/YvJlDxiVJbHtizdLfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7JDr+ei;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3D606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 03:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B3D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7JDr+ei
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1740087c88.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 19:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714963; x=1795319763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NQEmaoC7qVxS6XvHOnYxy5RPxkM/mcRmN7qqE1HnMCM=;
        b=J7JDr+eiO+gQ3eT9qn63Yn4awr44BpD8za0ph81R/U0f/AJm+uxQacIwv3PiGwPtMS
         uzvxRdvs78I+LRdm0WSx4Q/ZrCab2qwr2KfXqmNBsNL73vjcKrQEyi88jaB1lz2ZQbGn
         9KdMx9K90VknzL3z8mwNBCn1AXB4lcEtPrHZqU2NQ56akAm0yOYaX+3FQr+zS2ZvQ9LD
         rK4EwVTB3wIfcNgPw20b4As87lP/KIdO423ia1Cffl1cPP/tieGVMBZzhGaASHao3qFb
         sc/gESnlQdFBD4YMg+5a/ByJX1gnCqRH8KFb0Lsz4idGAhGJCbudHMr25u7bE5gc3sNN
         UCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714963; x=1795319763;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQEmaoC7qVxS6XvHOnYxy5RPxkM/mcRmN7qqE1HnMCM=;
        b=zwk38GrLUJKCl4sKckQezEDNrmoX2fl5n2xLHALafBQzJC8INtfD5KWZs2/LOSPLsO
         wZ+t2ismGlOyfi/wB7BlvVVWGjdLG3s2UtZdncigyGwIV29CdgqzbL29av9RQ/z54Cgv
         0pBdPAvu2Mnwj7Pw5mHOpaCDhJrELJU7xgs96l2VM93SE/EcWmRR3uE+WPmkoNOuayTo
         u+5bsgH0en/uWzvKyjNBcfMRFnx6qO6NFWOu6mYu+OYPAjKm//+MzyzviJy154+HrTZT
         IcmjM+id4cv4LgbwdsgDRozs26g1mYuVhVNHNtZgSu1xYWj/QVc5c011US3EoaCC5Pq2
         v1DQ==
X-Forwarded-Encrypted: i=1; AL+hErEjAEAYlYb2fmQpdnT3z3k1vY+msL+PoGat/HvvOt0bBVZrgWJAspHCnstKZyoD7lb9TYBuLljmlQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xnGGuWskMW9JNOCcNjU1OLf6bXwBfMOQRt0isQbqwWSqfMeYi
	4zk+QsFkTj/b36RQ5KG62g+OBYVvjJfS288MapVbppBo8+juyVDLp9qI
X-Gm-Gg: AYBFou2J7U8dZzP3Op7Y/+ki3tgqwCAEPya0u52SkPYI64VtiV9Z701Yg+YaOaUea+c
	1EIKFgJE/NVXAGaBXAoaVbQ1tqHXF4N/fZVXFkNkV0M2AFF9c3ppWlL5lE0zrT2zj77930bUV6Q
	paU6cp8cSm5lO8jVdHG0gevEEqEKJchXusZ0lCDotS5T+Q6OcoL7Sl/RkSRL7aTpskpfyQ6v/gV
	6vRGzDKhqHrgC5gyqdhFaJm4iI4OP0tz6c/WqZZDCChVtatwRpi6O+0LSobPp+UpD9xYQiNDavs
	OwLhJWdore6P1/06NKhQniMPqShuF0Nle25h3r9l7+Y85g71CBVhSBDfMczGFrb0MvzYYGjkfeg
	G/W273p5DP2WCsuVLj6h0HpTHtO7lr7/HkfhfDRnmKPTb2RKZNAGEtzOIWJCWRSJDqfWdgKPUFn
	UmAoBuQdDpmFK71B6syZ/54JRL4KHV+HiN3N+LcGQvKBZ1YnTejpE19O9GmFFALrsvySUlA7szl
	WzhHmdzQSnsF/BQnifWPKUr4sebROgjRWj3o7fcZzwD1kckIhksidMiHK5fGPYwm41fnHv5KknC
	daL+oYiq6YabbzGHaFKPWaN2plMZVarnz2DOB2+Nkyg4CrFhVff1n5DRIZUYxj6u9a7NTcUIxN8
	IW+/dOVuKzUsN3IhdDxXtfT2pWz1I4ZZy7e50HPQjj3ToKvhgkdjBU+UC/kswQ9wPygdhOL/lns
	d3AiIN7NrBj1PArMEdcuA5SJow9KsVqXsbNoc8BS9+XtQIeLscvZeG0LJrqx/RF8k=
X-Received: by 2002:a05:7022:1401:b0:1b3:a87e:8040 with SMTP id a92af1059eb24-1b5030bb56amr6063090c88.20.1794714963419;
        Sat, 14 Nov 2026 19:56:03 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm19457554c88.2.2026.11.14.19.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 19:56:02 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Niloy Meharchandani <niloymeharchandani@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: msa311: use devm_mutex_init()
Date: Sun, 15 Nov 2026 09:25:57 +0530
Message-ID: <20261115035557.178492-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115020129.10259-1-niloymeharchandani@gmail.com>
References: <20261115020129.10259-1-niloymeharchandani@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Nov 14, 2026 at 06:01:29PM -0800, Niloy Meharchandani wrote:
> Initialize msa311->lock via devm_mutex_init() instead of mutex_init()
> in msa311_probe() and propagate any initialization error. Include
> <linux/mutex.h> explicitly.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
