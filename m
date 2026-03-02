Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60453327C00
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431077; cv=pass; b=a0aHMyshKMf4vDZyi7dQSyt0DNSqlabtG6KF9B9kjiGmGBn1a5uqJsFVwHGz5pYC/+RGqm6H7EUmzrSQronHJWPsRFn/xV2HG/bipfwM0sA5/vwDjy8JMpvars3WvC6iOPhwGR6g7+VTFdan1L6hRyeGT5Z67e/eKWba/KwVfIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431077; c=relaxed/simple;
	bh=xixdGJFT2JnClpgA+56eovL7AXzYQa3TiH/NK3MWBPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNI5bqRrzxCKjCPivPyC30dPyk7lT+N/Ge0rnWW0DFC3PgfVaSI6ul0QFPESWT3Q0ZbPp/CgZRZaF/cAHL0qmEis1/xXF8yjFJGsNgLp7yPGQTknAaBusLRuhlxWjxEk8i+WYabJ5M0Q8wdlYnWJCroCu+i2VJWwLYtGh+vfWyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm5BbDYm; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm5BbDYm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79645fe3958so1497257b3.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 21:57:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772431069; cv=none;
        d=google.com; s=arc-20240605;
        b=lcr7ia9FoJ/qxJgBtv9An3KHc8mQnEIctXifoi4ir6fatxG7wFOXztOy2xkKZDxaPf
         m26sFwtOPCAx/EOgH3wY19T9kZ5zeWVC18/E7LpOUl/SZ3odf5DEpOHknRZmQ4XKZTk0
         1bmCj9GMBnFKyU0OPrxVRCIFXCzZumIh4+c9GdkY099ptnTYX0Os1DEgpeBzrj47ggtf
         YlgWuCntphuEamC7P0s4gyWViskGGkyC/Md93bb0vFWJZBA/EOz0YiFWLY3meZvUaY3b
         pRyKmp+y2kvMzr3a5MuPJ7mD8ArP4KAqzMWvCpO1enjJhMVP8eWJ3Vnhri+7QrOc+IKR
         lAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xqg1yp3ezOa+cMXKhER89MzTfRqHIHuZidxWAPgFhwg=;
        fh=A32gs2Oq1isylAXToT3NaskC6aZ8aWJDDVd3hFlalqs=;
        b=ccDQXeIMKFv8Z0kCjrdJahKFDNeoxkqwuMHK1XtrlPsiHYO75lGp8GXZeYtru1W0Tt
         CTC6YuP/tSj1IDZ0YNs5c2LSVesrIIEBzdyxveXlnZFM5/kwCDvD1sREXWYypNPpXOjy
         eko2FF/4dnpdnrsbTLpobdZrTNXHVu6Uoh5DNfSxZhWV208JZhXIBq9+R/d3cMzfMEN5
         Z82S3DbBm9xkq65mlDpwTTuS2got/EMBo1MwuHBfENV3FwcBeLEdQEISSWzR3dzFWlmZ
         izmpKYjn/LpAyj2fZnn6/arGSgR1eAVm89Jp7zYCZfxbw5CnRvDxfcktqkJ02mv/O46j
         9nfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772431069; x=1773035869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqg1yp3ezOa+cMXKhER89MzTfRqHIHuZidxWAPgFhwg=;
        b=hm5BbDYmOIe3X7RakBvQdy9HymlxwsbAnNGx0Fg42ZY4HU9H0mDkIB543BHRZ1ouOe
         X46ztPP/RKwgfpIKd67+9sIX3QjY68FEtAnZVJPKrRBA51iAxajsM53nFk2Y4T2aC/iD
         er6NT4zAfwoeb7rLvYxMLub+r7UUbjGnRSQTwoO5dX3penX1jj4SURaFcZRgmew73MoU
         q2RoZoQS6dCy7EMRlzVGh+r8I5upW4/gBGt8wll4fVzmk4rEfvHWGqc8+L9TMwps/aNb
         LXiyXAAEqVMk1meJ3u2sMEXzymqER1G4hdIZeA7Rq2Y+R7xszNJO6WE2bf33SHaTt2+w
         1nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431069; x=1773035869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xqg1yp3ezOa+cMXKhER89MzTfRqHIHuZidxWAPgFhwg=;
        b=Xl07D7TUCCvNK4lBViGhPIf1/sNJh5SngolsdBN71D80DmIb9n5rj4ZdFQFEnW+IF3
         DjPjMVqq5gu0BXIjoOgXKJKDS0jwssNuAaAdd+nAEnx8y42nt9NsLZzi10w/k3kSEQGp
         tS+KYdFnr6Tk1bxI1dPehy2DM6E3iS3nimzElCOQBkku7lRFWCL6rsr2nZmTHNhkXYOz
         uuDHR7rHozOknEx4mVUbedpyPg0CK3R0XKWdzZBFuEBbvJ2YPw/CccICeyc1LZd80O8W
         px8yQaUGbmndpJbs7u96CVmUsr/FOIEl5E/GPcOSx+sj+h7pX8IFX0qma6vhvmtr64Xr
         h4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWRFRY44NuhcsNHnzN6vUGIzg4gNIVnra9FtyAW0HNshqI7eX66rkn3ctQ/NjZFSK8x9mzrvG4MvvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdFnZHcy+5vutL6vPmxOtGiUWmmG/V0chjbugDkVwIRmHzLX1
	l/kCJASI35u9SdJgGWLeDflpffUKJnrqpd+yJM10M1u5XCLdzjGQXvU2Hnk6kffIB/8GdPo/16L
	mqYjrtryZvFyi5OBXpfTT4Z/X83y9DIY=
X-Gm-Gg: ATEYQzzQldLz/kjwPZ4htoTP5vNB2CCBt2iOU/qkTDu2rFR15lrlBuHIgq+nZ7oygRF
	RHZfb0xLby+U8WWzWi2TKJ/4rak1cCT0E7Ia/04MvebkStFo6kIV+lqq9NLr1xsJECuu32eMElr
	J5a1kmxkUOIl2Omt76VYDRrbfk7z0H53PWwcH/DANuRG0aLNJh9xpImNHig55ZFTDdiHUoyhihK
	rbLdLES7CTqBrY6hNdZeQUKhPFNRJV3IaoDchcxIueMu4HAyqAktkUuOieo5/1RcipZp3RKfixc
	WFoJbl/0soiSCZfE9moUXTuO951XXdteWI7YE2E1MyjxePPcSeTjWL6XOLUHZejZn9aXaNgpfj2
	2UDGaE80iVpwL1ojwvstsPLwGy6AX6Er6
X-Received: by 2002:a05:690e:2502:20b0:649:1d22:6c33 with SMTP id
 956f58d0204a3-64cc23e7217mr6201468d50.6.1772431069231; Sun, 01 Mar 2026
 21:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
 <aaFy3JVVL_nvSGsZ@smile.fi.intel.com> <CAE7dp2qN4mxJfSYXxFQY9sdLR3eQemwDOEur3QxcMU2TNBZTig@mail.gmail.com>
 <aaGt38ePGhonQRmd@ashevche-desk.local> <20260228120808.64f8299b@jic23-huawei>
In-Reply-To: <20260228120808.64f8299b@jic23-huawei>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Mon, 2 Mar 2026 09:57:38 +0400
X-Gm-Features: AaiRm51tIbCSR-8fX_YJKsNJNxqHpt8MDZzM0Yo3B5t30CIA01WIt8vsk9eeqLw
Message-ID: <CAE7dp2qjudkgc5CcQvWn5pgM_w8Rpp34FD3cvqJoiaPMKivSUg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong macro names in ADE9000_ST_ERROR
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, antoniu.miclaus@analog.com, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 4:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>Agreed.  I'm generally in favour of complete definitions of the fields in
>a register if any of them are used.  However, in this case it's a define
>of a mask covering multiple fields that we have no use for.
> So drop it for now. It can come back in a patch that uses it.
>

Thanks Jonathan ! I have removed the macro entirely and sent v2
