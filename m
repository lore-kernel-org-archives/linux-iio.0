Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253823EAB0
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294580; cv=pass; b=pqytUL/cWTz8cTdUMEKtJIN0L7VjjS0nLOvaQRdJZx1Yun4ldhih4rmahPvBuJmUUj6Ibb8IH325dnT3w1u4cNPDGl7o07zq//8xc5KS818e6lFWVQIJLG2+5bZHnfR9a0MVVWYGgHIUCURsO7q7xpUwjyCm1KW8DLpKU9K7DoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294580; c=relaxed/simple;
	bh=RMQByrBiJnhgVK3Ji/kumr4mEcr78/UhRD6H04gca0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrKxyBwzDDaw9O6DJ45lAIuN7OSTE+rwxC14CMYri5hJigfmCq5HEcEGHFMGevnpCCCkZTKhlVR9G4uGEfJB6U4j8QT+hfjZgci0dYLPVJUAwKPNdfqLpAf63/fZKKVFnMuMMdjXewIaqFKgSTIQ0IlM8gEJIB6t3rh7109/pEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkuztu9t; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkuztu9t"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64b3801600fso92282d50.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 22:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773294578; cv=none;
        d=google.com; s=arc-20240605;
        b=UCnY0vPZvsiPgll17hp9uWOmXkGwaK4NvqNLBYCF1uf+M38dMXfVucP6wjt9+AFY1B
         Xmo+lOezGRpBjR28GK35VgLyw7mOjde/BfHYi0V1LmXzBxpSxCEIGAEywcOWZdhlrMMy
         ZOc/iQL0D9tzcsJAPkfQT+8D/HkT1h0hwPZakTgK6scasD0oHs+kmz0stKZzz7ZMuU3E
         5Gij8GmGCN68WjU3MO+x7D4lxDMIQuViamvP7hwhp6jSkKMIILHAu5hA36Oiv/qLzNGf
         ZkpKD2mbl4v8+DxHkygG7gvmk/adPgkJgLeBsh8x+lDBj2efzkhnR+/SwyDKC05/uA+/
         1TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMQByrBiJnhgVK3Ji/kumr4mEcr78/UhRD6H04gca0g=;
        fh=VoG358nAPzXaur2i8ePd1WXbM0Oc3aAvJGPF2l2FxzU=;
        b=TsJ7gBrQzYJ0gm0pKkrXOQ4xVcZtHRTqATY0FXt+zLVssfwwBg/N2eceagvVsOqBNq
         5e6lxQv/b6KQUqUtWju8NiOQ/wYUh/UDFSAH+Shz4KUq/fGv9jFqw40n68j93QsCZ2Eg
         BtFSuFE5ljAS4103sHH+brbg5k4t1MDETJu3dBALFQfTfjou6Y1fQXFWunfmJ7T6i0aK
         uCwIcQcPLhUOnJxxXor9m88CHAG4Xv9gAqT4BZsHSH1peMXe/zI1pEc3de/RHxsypBD/
         CLrCQTKQ9+Slzba/nHE5Qica1eEoK2HtqFi68ZWHsRyutw0r/FaWb/i/e3KMVjUE8dVI
         ovxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773294578; x=1773899378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMQByrBiJnhgVK3Ji/kumr4mEcr78/UhRD6H04gca0g=;
        b=Rkuztu9t4AMrPe4w6/MswRG8YekoweOI/yQfRaZacvd5UeLMwiHsDtSamqlanUNGzC
         N+UWeFOg0T+/xR6xcQJV2e+PbdP+fJW5DrboF32rpq1UWWZaD3UBq4PNMYgH1mQcUBEj
         Zjo8yYhqZ8AFXyCnJQ7WuWYOkm30nSfBBbp0wOA7zTUgmAORg8HuxLEU9cNiUP2DxVDs
         obYAF+5iLkqE1VnpIf0nqcYUpG1aO6+gzJPExxkl8ZbH1ESaOncDWB0j3fJneQjRSyno
         BEICQHktFPj8lNjYUd8IZQugBE7yZ14NYdkoABqRsmLWqZQbHr8gU60UgVju0JbpH28y
         E/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294578; x=1773899378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMQByrBiJnhgVK3Ji/kumr4mEcr78/UhRD6H04gca0g=;
        b=mASBMlWKROzd9YXPkStz/vbvIjMryuHb5SbMiTz0VKtZS3li3BsQjDkIkYPp/lEGX0
         yR6rChshEj6tuIOlrUxMlV+WJgWx0cG2ypTQ3W8P0nZ+BYTzaHn9VIGYYjjUK4pCCImf
         aMooekyjgFaIZ6UTCri0qSoewOc1bf4gPdPgol/9KFwC0G/hjLdZvnhoMlkLonwHfpS8
         eSJu41pRkz2i8i3anjS2Sra+sNURTb+s3s5yaJqeiyV3fB4x7JniUC5TaSNq06GdC1tr
         avWaDfKXN2JoHTeDd4zeiDFXs/Z/pDUgRJX8g9u8JQygq+NDg/D9gBTsI5CPsMoRL5Dp
         uPlA==
X-Forwarded-Encrypted: i=1; AJvYcCVOS+zjDbpbWFymNBoucmz1lv1WJI0sIaFqiMGqQFDBtDp2b34E0BiGjqRs4HSq2Y8vTXMR1UPoA5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDl/FoHK0pqqwaiHwZRCyroWpPF+S3itqhza3Wk13B7vK5YoGK
	HC31QCJCuD086EcHVMrU/K7FuRa2dwJ05Pb1LYKsUW08rFOWjhzRCcmk6HU+FtfuuQ8dxLvq/mV
	OACuiUDp0For6nU1FUC+9i/MxSOIsOkM=
X-Gm-Gg: ATEYQzzKiRn2i8iPgLBMdHGbNSR7J6IU+qJGv5o600XXxS9NX3s5SjGTfA5v8bs+D8f
	cv70KrqclNfG2ZZYfOF6LyOR/rmkt2EpzUqRgn0Iqq8LqOPRHinRvpbVbK7vk9E6TkO7d5vy0wF
	Jw63M317WcXdsQWiBy40NHBPyNxCKfWjFJ3wByXmEMfE/Ph32oOhZIagb+8WSVlhvW9910V84BK
	VrmPpJy/aOgWSfOPmsiUG6PGh/Ap/9PADn8HElhKdqEuhIIBO+b/yJ0auf6aaKNVzZQTYoQ3fHe
	FmCzp9kyerjIN9eU0p0pyuQhxGl3Wn2lwAS5Ci07BUacGSA5Z/W/s8FLcQ1gOIkLvPVbFq+QgB5
	gEwiZisczShhglCt6/QCYDg==
X-Received: by 2002:a05:690e:140e:b0:649:bbf4:1212 with SMTP id
 956f58d0204a3-64e596aeba4mr820692d50.1.1773294578554; Wed, 11 Mar 2026
 22:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311072156.35057-3-giorgitchankvetadze1997@gmail.com> <abGPhYz-5OLeYg07@ashevche-desk.local>
In-Reply-To: <abGPhYz-5OLeYg07@ashevche-desk.local>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 12 Mar 2026 09:49:27 +0400
X-Gm-Features: AaiRm50F7sDeTMXcniyDn0wXA71lWXB0OjblmzShhFnzcai_ltBpdRyCPdw2Was
Message-ID: <CAE7dp2pO+Dx654ybH47uu7FTyoNfTHaEB8ihxiMFjQYONrODhg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4130: Adjust indentation so statements start
 on tabstop
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> No need to touch this. I was against that static_assert() in the first pl=
ace,
> and still against it. In my opinion it brings no real value as I can craf=
t a
> layout that will have the same members and sizeof, but different types.
>
> In my opinion it's better to just remove it completely.
>

Hi Andy and thanks for the feedback.

I adjusted the indentation only to address the checkpatch warnings.
If the consensus is that static_assert doesn't add meaningful
guarantees and should
be removed, I'm happy to send a follow-up patch dropping it.

Thanks,
Giorgi
