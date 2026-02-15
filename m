Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8C27CB0A
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771175483; cv=none; b=t1AljgTugEjdEFBG2MVSh1FiujlgUBh69c3MaCyvjHCMdoKhIG501SjaEO9Lx2BYWAr0MdggMiOiEYi4iX8kK1jOeG5eLg9QHegVdskkIWOHnKNIwPFFArgLKcfQq+QAqsSIpEep6PNbqMLf6U0LSIO3l8QVpnX4HpILC6SpgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771175483; c=relaxed/simple;
	bh=OBDnP5x+5i6mTexdQ98mVTySg40rK+h2+jdvh89A+Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLjS0jvIKBvWsZmAYsHaraJ389UNWC+AHwgKh7r7wsmdLqGE+85sMnChct3WtCLqnZy8LopQ0AwACiYlHKW0LsHdg5v/qBB6fSsHSaYoUjOYSzTqbzgn+ljJz232HHTIgX5+zIQp02eMC3M9SY7pJAm502HOdn4ULTBRhoIj+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG7FJzcw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG7FJzcw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48068127f00so26040465e9.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771175480; x=1771780280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBDnP5x+5i6mTexdQ98mVTySg40rK+h2+jdvh89A+Xw=;
        b=aG7FJzcwXN5Uz5gg1hSQ4NA9XPSQOnwCpFbdCqXbGH5o/I/pC0915l0FKOdQ4LmnT8
         /pu/ERLgMjCVgYQtnvOw+FovBPrCQsifblVPVmgalOtowEhNpYYg+ED74EidHPp3WSMY
         gvAAcLJDHMue6yXlcf9cnzj4VcE2QzlFIVjLD+nGWa5Nrl4+ws8TOcpFmRUylv7Takm4
         YBns+90tIbaKfxnvCk9z/1f/n6NeeTvpw1nHBLjxm1l3iPMIiCD+xYirs7vfKGhvW6n1
         QqKIgMmoTzK48yDsjuQX30bASy/tC6nIlkaKa48xri2ZB4/RxoAh23edu/1kpMX53SiK
         gELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771175480; x=1771780280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OBDnP5x+5i6mTexdQ98mVTySg40rK+h2+jdvh89A+Xw=;
        b=aLxvVpiwJcNro0DU4+LnLVvo30U+iiS+OI/vsCRLXRAGAriCUE98HaOcVOK7b/TZUr
         jaKpn/2T6lF+Wydr5nqC8rYqf7CPK7gvFYM/WKBBlMkFTpQFSEEE2wKJJJf+LRqd2QRS
         AdY1B/5Vdp6+sNshBjBSQCoaD+Uuc0QNV8oGku7eQTPR3T/nTr+LgpSroPHDO3o8zSJv
         ubAcXSlf+NUnLhYt+u1JADdirRrcRyZdfavBM30yzCaLTjeNW4Yh+NX7nVgd81b/8edi
         cOTWgVYEVqiq2/DVrgf9eUSD1yqcut7QbWAzSy219ejjoS6Vi+jWeIVssn7cHipZwIn2
         Tz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp9sIkTCSqr3maXgGd5tScbuYgCiR715aJBiKtgIjwL3Im/JiEbgMmFJBiryl3nsr3jpFggjurv7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJGIcN9IjHxbtPj7Ws95tC35ivJGaEemp6WPthddNi1t/85Fw
	DcwcDFhSpWiindvfBQQ7lzoATfpAFRr/szgR2BIFU588ew5+6voBZlcZ
X-Gm-Gg: AZuq6aJI3+LAXKoF0SdQCnekChK/XfyAMuSb24twkOPzEQtZzuczVTJBe55ikH8eNVY
	DNja13BdDwvfek9uCRAPwtP+Bv08aisbntUVpT78FlZcsFnJEko254VxVbLumuYYKTLJDIl9bpf
	dcehirBXR2rvrfAj5P017lGjUEXye9UjTLneko+yN2EiCqrTk7RvNMZHIpDY7VwQoxAV4PlhxYJ
	5q3R9lFWynXFMOWO+BEjI/MSKE9G/ER6Y6NWLAmELxayRuLCbqcACFBMzrxSJb57finmeJiZu6b
	jUqatEuM+IX+g1yeYIXyX/3/oNHgZAmO7liJlV6RkYIEYI0ZjvhudlXhaggaDEe9EKMqYLT1iX9
	qH5ePHy0D/PQP6kSfrOqdSB2QBslprX6/fDoUzIBW4jWbavFo3CYf9IHFUe0fTatLGuM8u3Thtj
	JW+QYKPJnr3DJGPfBTjvLbCeY/5+zpgbp/YRtGbGt/nP7HX11trD2gx5CE4mFZBtZmhxQkecZH
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-48373a08300mr129342135e9.1.1771175479939;
        Sun, 15 Feb 2026 09:11:19 -0800 (PST)
Received: from localhost.localdomain ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d482480sm429211335e9.0.2026.02.15.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 09:11:19 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	dlechner@baylibre.com,
	lars@metafoo.de,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3 0/4] iio: accel: adxl345: Add event scaling and doc fixes
Date: Sun, 15 Feb 2026 17:11:15 +0000
Message-ID: <20260215171115.10273-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260215155720.361c797b@jic23-huawei>
References: <20260215155720.361c797b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 15 Feb 2026 15:57:00 +0000, Jonathan Cameron wrote:
> Ah. Raced with other feedback. Dropped again for now.

Understood. I will prepare a v4 addressing the feedback from David,
Andy, and Randy regarding attribute ordering, whitespace consistency,
and the missing documentation entry.

Thank you all for your time and guidance.

Best regards,
Taha
