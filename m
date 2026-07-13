Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06535AC03
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981080; cv=none; b=kGojWgZ5vEarUMZxg1jYKXNDBG0qKYaccF/b+6QS5CeWTGwOYbv8cvyjHUXtfBNJlcmJK3+PAkvn8xCBo3gZ/O9hhH0C5W5Woc+P1+gSwNZdBI8V6EPRoKy0FUiJRG4+pS4j12j1ScmuK0sx78KrmRa4VDuDN/hk02h434wSNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981080; c=relaxed/simple;
	bh=vuv+AiyEsiMkD63IvVbYfhBxvDOLcErhyf+JfKIMK/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:In-Reply-To:Subject:
	 From:To; b=U3HpIppeGbRYrfXFFfuHGd1swdmsCz3NN0ZdVA/WP68rqnqv4NoK1TbcntQ/CR7atdrEcW6fs6WzJZnZkLprSrRE0KhC0reLMaknGMFsGUpTzQSGpaA0dxpvHQZQoqfwHbKskY0WYZVH6mmzaeuBLWVDAiZ3jtuYJZ6gXOrB4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns1WWug3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns1WWug3"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb64085c45so2259920a34.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783981078; x=1784585878; darn=vger.kernel.org;
        h=to:from:subject:in-reply-to:message-id:date:content-type
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuv+AiyEsiMkD63IvVbYfhBxvDOLcErhyf+JfKIMK/Y=;
        b=ns1WWug3n7rKjVaKK2mOHt8Nqu8WGpPaapdYGw9hkP0XroyHMrXrAwNVD17f3H1mUO
         sTkOH9VU5dXAGTVAxj2Tmu/PN4X2yri2k9fxaLsDGuJi4YBcDLktamKqQH2k0/3HPX6W
         KUKv08xXQh47QzlbffaBOSkLMUH87EU32U8h0ZUbQBnrZdM+GGfftxIOOdtEF18dXxKz
         kxeEfMPP+XcurZ1y4sDpJ35IPi/Fs2jxxAZsjM856pjtcYftsAG6vITpE5QT5pQ6uy3+
         1LGG7+i7wjCQ10FoyD+xEYmkb93XfJbCuCcCoADKvUpdMcN2yxoyAooWhK/JegUVN5gj
         r0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981078; x=1784585878;
        h=to:from:subject:in-reply-to:message-id:date:content-type
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuv+AiyEsiMkD63IvVbYfhBxvDOLcErhyf+JfKIMK/Y=;
        b=hnZJkWD+TK7IAZ45PZu4T5SZbIS3GpJpBPCVWbgamdswGF4jNoh9p9tZRk57u7ZaN5
         TyrvzpZOHlhmF6gUqpxeE+H0VrYexdtZUE8tFXUvf1VBNbplN6SHL5HBDgSdjUmEzdLk
         6WAHWi0kyP/dsQGIIwbnA7+hS9vfT8dZkxIWwRSBlmWeCIoLNUKs2JpWKyWmG4fr3hAL
         uIzw9nC95xW9XCh/aHDqv4q2GvIB9b5ZvaHJ+gx1MyDMnTZu3+9Qf1GUa5aJNu2e4yRh
         /Sde9Y9Xdw6Vi9yRV0fyU2oxGBc65OmbD+4cYNxXe4jh1uZbaM3heMixzahwYdTPLLNU
         PTlA==
X-Gm-Message-State: AOJu0YwNiqHOdaS7tbK/8ZlnbkmeQ03qKmTgYjXviT/yMIPedwIB4GFl
	tOdTsN2voh6RWJw7cKrmHYyA3RnbAb0AR2wEJZt1LXW7rN0FRDuPxTkhVBffooVz
X-Gm-Gg: AfdE7clWTGb3L6SffXbdewSFU0MAtx0UxIAzDLS5kOwbcZHInrv8yUco7Z+YCQNW6Bc
	qZf5dAJQW3juSnrXtlLI6RnStC8hnjcly+NYg7RZnTEvN+tcH5RemG4hOq6jSyxnW/trIa4bsTO
	5hdAFXq6HIeY3ZwCPubGNYdXHo2zdyZphVdhSCA0VlpKMJ/WSgb4hKATsWWKt4p3TXM9N5lHaLw
	p16SGTp6kzNK3Z1JKZkpV+6kMiuvjMFheIgkSits5Cm/Iyqbp+EEtY2bePZBMCwYoCnkNsSXFsQ
	OuaiM6+IJmsXS2oa5JiNXJeW9K+Z5vL816n5xAZVb0ExY1v+2yyBb9Ux/+RogRZqXW98kSsfzsX
	rtlbAspa25EMF68QMPaWl6PZSdPMimJWE4dMHajnwvV6ZIRBsXOMFqcrLPwfbC+qSUTaH5PHVSY
	+w7iQneHiTmLtbarKRnIl5swSn5F8FwHSSvspwLWc=
X-Received: by 2002:a05:6830:6afb:b0:7d7:fb03:f6ba with SMTP id 46e09a7af769-7ec097bece9mr6250825a34.21.1783981078114;
        Mon, 13 Jul 2026 15:17:58 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1dce3sm13857882a34.3.2026.07.13.15.17.52
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 15:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6d0b1dbaa066a243e25c6e5fa40fecf80e36dcb25c969aee810202f11b03;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 13 Jul 2026 17:17:52 -0500
Message-Id: <DJXSIEPZMVE8.224APDLC54M00@gmail.com>
In-Reply-To: 
Subject: Email Transition
From: "Maxwell Doose" <m32285159@gmail.com>
To: <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2

--6d0b1dbaa066a243e25c6e5fa40fecf80e36dcb25c969aee810202f11b03
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi all,

Just to make sure you all know, I will be changing my email from:

<m32285159@gmail.com> to <maxwell@maxwelld.cc>

The old email will likely remain active but anything new involving me
should start going to maxwell@maxwelld.cc by the end of the upcoming 7.3
merge window. I will also be sending out mailmap and MAINTAINERS updates.

--=20
best regards,
max

--6d0b1dbaa066a243e25c6e5fa40fecf80e36dcb25c969aee810202f11b03
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCalVkEQAKCRAQghIb0dl/
if6XAX9azxZRoNE2hbXrXOTQiGN0x7ECeuiS4cmIFsYFbs9H5WBWpkepF6UuYcN3
AfqF+ycBf2GWtKeSZ/Xh/U3LjSXHvPNdRbOZm44AfT78I8y9X/B78ErORmD/x5yK
TVsN1sIO2Q==
=HDAR
-----END PGP SIGNATURE-----

--6d0b1dbaa066a243e25c6e5fa40fecf80e36dcb25c969aee810202f11b03--
