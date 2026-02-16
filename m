Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F68635D
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771275913; cv=none; b=h8NL3xrLWQKvuad2N4rlu8WcqVQEAy6K5MRukqJoTQy82gm3tYUc+q8m9BkDjYWS76ajF9iLI33pAxxOQ5ihmrGYYmKWQ25zImGjzHOdB59BhFF5gwf2vnETreEm5qM7ZaSjetUzsPxxK3Lj9JfilmUngVM5GcanqqDYmFyQ8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771275913; c=relaxed/simple;
	bh=16bTghI8g75SFUs7ajAvY7HPulC84UBdO4W5k8hETE0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=CbCWqm4fq+hUv4VaI2Yf2JDJtENwLs4Uy7gt7Nl/9Qa2hbFJkUIiQR2cmAJ+sbPMgxbrgse8Fm8ZPAtLN9HC6LLXqahtq1Mhg07NIC9DMGJUKXgjMQHx+fF4pWRO2/7abwCsPwEgMEZt9xjz0cpJ65vC9W3Jpi+vgRzdkGSkysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/wjsFIA; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/wjsFIA"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad019bb5eso3172666d50.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771275912; x=1771880712; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhCGS0qsda/KF3/P+JYV5MT2QnVpNOb7NqK0shbhnsw=;
        b=Q/wjsFIAysr8+Ktqog2wCzVBbM/Zert+XPxY0B3I4zmUfgGpBXb+ll89mPUtNgVpEv
         9fjIwf0x+IUciA/t0nMbpZuxqgtYf9Iq//Ec+ZYSIHWbbHf235RXcRyjftkfisiNmfki
         aX1FAwVG9qrvWKawUQCkLiDHRqo12Z1FNJSzPyitl1tsDE8as6JbYzCki2QxxuCuvxTh
         s7bqz7Zj2PnNMCw1bSz9jQt3QmyFCf8kEvHqW925ehdO3yE0rxCJycLgEjE1uHTQMUTq
         xx5mowiTh0HlxPm9ysCfb6q3ZY6R+SEjW8QUVcCbSToEZsXeokTmQRdSU+B1m43afw/E
         Vtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771275912; x=1771880712;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhCGS0qsda/KF3/P+JYV5MT2QnVpNOb7NqK0shbhnsw=;
        b=n3UZtTE6vWScatXY8p4XPcVMkholBxNkuSWSmug4QXqYxYr4ljCOEH3I1CzrusWC0n
         qJ2WN9kUFL364b/SriEuXC0rOPYvz1RQhHpZGNuKyt5igP7ilCTyH23cyoNlEX3CC4KD
         AcsfXqYpMhov0ZlCaNwV+Jz0gVrWhrTjxsP9zMmHwS+338hRR0AWcycfacXhApz+JeVs
         KOyGX0GjPx4j+myuy+HePtE510w2ZlRfqvbfkX+9bU3L/PgGjP3Qm9U/ZjhIDFk6FpeD
         Cv2rNqRP7q56Bm6QRwZhNq0GzWKZwkBWfuCZQ6pthiMBzYmvjqnPjXVoDJItAoBGRDKF
         nLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmYD64rNKchFn+M7NfkAohwKunj9thdvMhaEDrK/iTCeqrW0txWD1kf7sdw+0uocrDBJjvue58AlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUj1K11Fh3PfX6Oj31l7osZLkGgBQNXbHoRPp8BwDSX/cxCoz
	VHLHDddtyvnFGlGWGtFYwZ09BZ0QoNnKICdx8p8NZy6lVJzhuRwnLIH/uQGeub0MxBo=
X-Gm-Gg: AZuq6aIODyy2xyzvW2CtQOnsVQyImb40OvJMJNLZETQDZrbm+lKnZQaJvfzIvIfD99S
	KdPCjFIlnuYGDijv887wN4PYgKRSw2871nh4wbbGiaBDi9uPyFJ9MKKiCdM9Pe3ey6wuLw1zRHK
	jNw3Pk3XAZoB9PNQ+hM267i86LZS6laTcrdekrEBDAv7s4QSn+LooIYO5JvOrChDL2rinapjhdo
	foYzv/1dEvs/OL4E8QG7ThPRnDw5pHv5z5HoSRncG37LhOZo1s09FZh/QJv1ig36ehHSPfQg2+d
	vgmlmDzAAuK4XsTF6aWCnO/gwEZaVocGfpVSPChsD3Z8C+BiFr1UwbQQFsHaCIlu9fQFe1LfEzG
	ST43zw8Eco9LaDosr6sF2A0FeqBuIup33CgM1bq0l93XJYHE8tCvY3sKjDDwxB6wvtuFro098Fg
	8QfSwIkiLsMxFM3WxjMiTJ0ptku0S4dSX15t4h8wnfWMNWQJAwyBsWk4U2KhOtDVA2xfjP1Shf8
	IcRz8RGlDmc3FjPxqplM51AvbvBbjEmp1GQjXTIqnXJUcCIliE=
X-Received: by 2002:a05:690c:25c2:b0:794:ed9b:8d90 with SMTP id 00721157ae682-797a0c31e63mr94823177b3.24.1771275911766;
        Mon, 16 Feb 2026 13:05:11 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e7dcsm103162257b3.8.2026.02.16.13.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 13:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 15:04:55 -0600
Message-Id: <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com>
In-Reply-To: <aZLCe_5C8e82EMGO@smile.fi.intel.com>

On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:
>
>>  	struct gp2ap020a00f_data *data =3D iio_priv(indio_dev);
>>  	int i, err =3D 0;
>
> Would you need the err assignment now?

I'm not familiar with iio_for_each_active_channel() but, if there's a
chance it could run zero times, then it'd run into if (err) with err
not being initialized?

Thanks,

ET
