Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE52309AA
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674320; cv=none; b=cAqy/JwCQ7WbtPxOo6fZr+lUIMy0sRioIcllQqHdoVPMny91bZBbAhlOuiHpIUWZyn0Zp2OySKhPQjdh8VHrTW4y4cth+jIw5cQuWCmNDZhrcMqRbKxlMH4nj0wzaEhkXB21M5bSnKg9pKTl4XrWkjGsZZl0Op5sZjaeHa1seDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674320; c=relaxed/simple;
	bh=FUud0qIrxq+PQmP+DKOJ9cRWUJkFwQBvJb/k9126FCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWPi431/E8pcju/CqNXhW2BnH4P2IYT0WYpPRyo7bv3T3wdraZof3Ai2kF4kjoElLdFQxVp8AofNzi+WSU/h6/snvake6/aogSsNKmrr/fuOT3DNtPSLxK4+enlojxNd+VPklY3hokG5+UUQH3AKs1ZubtdcXFRi/IDDwO94t2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LNAxDBaY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LNAxDBaY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f84023916so2545503f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785674317; x=1786279117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FUud0qIrxq+PQmP+DKOJ9cRWUJkFwQBvJb/k9126FCI=;
        b=LNAxDBaYMl9Ye/5mcGhb3pdDamUiI2Fc7thYMpSwOCEA949ioUMdrAqcmRILtDJDlM
         1mBiA2t/iaLxqtti1/xzzNrrvHoHkGN2kTNp5NDYC7VwNyL4KDEif9l6WWzLsDf3wgLq
         REqSx17n35mPsdI3sBtvMhq1MItAEY9V97xBnvmfYOFOBdC7qaM/PqMBA96GyqMNpHjc
         LV6eSXc7qR5qNrAVZGWy5zUph1nxz+wpoujl770CVY4hOgYFE6kS152o/M05rIjBq5oi
         WNZ6vT+HW4kGwFopn5roBnrE2eGnbfkBvy0ahxKB1cMUxGNea4MDE8DAj+jxmSlcWcI4
         tzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785674317; x=1786279117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUud0qIrxq+PQmP+DKOJ9cRWUJkFwQBvJb/k9126FCI=;
        b=ngdAL5ZX6jZpoA4Ewb5+7yV4+1Dzv77zeZU0v7OicEiTR+xESt+jaBywiVeQdEvlbs
         3n7Ge3uohqxZM7GNs+J/PBEHJvyZSrRiTQ0XtFl1j2UiowqNyeg/K4sQ4rsP5FJh2BLs
         44sU5/R+WJstnq75J99Hhqir8phdMQcHECXl8ZbEASEXeMiMLJ4p836z/nC2HetYiPzH
         ApVM/KqMiekZlIuvztb52Vro4KAijJVEX6FuiXARNnBxzjJR4i6EJ+a3m+k4RfUztbnw
         YVbW+ab3mZtt33CxuGcclm4OcvIEMyf09GAlD9tjmyPojTtxDt1cpUs7yNWlSWnHHFqf
         ohxg==
X-Forwarded-Encrypted: i=1; AHgh+RqWBz7mtcNIuVMRUaSqgMSP5OzNFqN7CSBnhtZMVzl0JggQWRnrQ39IqVAS9OnIY/TcKxBuYVAoXCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjN88HlXE7jlrMYBmSw+4w6pEZYeWxMwVEwmWNqZDvPDzp+Evw
	yVpRca8vhrOyiKdrfs4Vc96fPrG0MdaZ1giq7zX7SQp+5viP3Q++p95/nncJCYn3MJU=
X-Gm-Gg: AR+sD103sDo+3e7oxOvDxh3dByzi/p7dgtXdirBJEang9POjYLm0MbSCLuPu8DbtwIT
	/DnM5VB6AkGqPXN1enegr8Jlgi0zP4ov0+4fBDla7WRwPPPbF3gWuwavX9VOCoRJ+QutmdeH8vO
	Mbeiy3yokVqBNvXgyAk7/w/9gGp208XTXfpuk29ruRB9mBWC0Bibk7HJckR9d5FQgchgywtn/xm
	v/6FFa6X9tcgM2zaePKZDeJRdJtI5koDDS3HpLlPORKttSkds/UKZcQ5JmD25hjsBLWi6A9r6h3
	CJEh4IUIdh5hbklsnvgZfpZVWLe/QRQ6BWmQWsJ594EllL4+WszVHYtYjL1tscQsuaWLkSSCLiI
	4WP6PTIOSREIekvmAsLe1zx2DZz7sJqzCY1LTvt1ARO+efuL8xMFn3TS//zZAOTDxROuf0JfD8k
	LUShnZPCWzyFVrrQayS682RGPdNsMCIKg7PGTTXH6ZVDYgSScNhE7tCGTl2hGC1zHR7A==
X-Received: by 2002:a05:6000:41c5:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-47fd72bbc06mr17510605f8f.9.1785674317371;
        Sun, 02 Aug 2026 05:38:37 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd45a0d7csm20932880f8f.35.2026.08.02.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 05:38:35 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:38:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, dakr@kernel.org, bhelgaas@google.com, mazziesaccount@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: htu21: Fix SYMBOLIC_PERMS chekcpatch
 warning
Message-ID: <am86LUUeP7FYpQTC@monoceros>
References: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l65pe66ab5ly532k"
Content-Disposition: inline
In-Reply-To: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>


--l65pe66ab5ly532k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] iio: humidity: htu21: Fix SYMBOLIC_PERMS chekcpatch
 warning
MIME-Version: 1.0

Hello,

$Subject ~= s/chekc/check/

Best regards
Uwe

--l65pe66ab5ly532k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpvOkgACgkQj4D7WH0S
/k7Nggf/f2iAO0YAqCaePzleJcYfHLcZ/pnmQl8QJ50jszqhMA3KeV7PESWbfUzw
TDpx2x+JLkfK6EGtb2wbMT9PFcQwMGgI1A00w5Vmpl9RpT6k4stJQHx45Sjzh+iy
svZjzBVIfMcTO3zwd8Gx9mBCQP/NCpgd9PRFr6GJ2SQFXP/EIsJ7vizhgabz8NQA
V0UIjgac0UKr4eO+xn0OEJLDIgdhdjF/I1D2kIsVCa47uTnA3AvPT4AhZ4ZJN1TP
3iv/9AWHluthE6ifBGzUYcRN7s1XZ1GSq8mmVHBgcqoYIRq5RTI2n0N8ceAiOUh9
A3t+hvdPhKdg37gTn2TTVWAIMioiDw==
=Vnaz
-----END PGP SIGNATURE-----

--l65pe66ab5ly532k--
