Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3F30DD1D
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026203; cv=pass; b=kro+AGRwYa4K6j8V5N0rkAmaCPWARq6lhU+l/94iijlZSU5wI2Pz5X9A/qo+YFV9vPs7MWQ9G3fYX7rZNZfA33QeHbwf8EYH7knKGTgrJGD5STHoLag9t5wtcTNf3HTosQ/o7YwWstw3PbPpnaYfKAph/+sOJa+UZMsq9kuiwUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026203; c=relaxed/simple;
	bh=4PncLN0u9eM8KZuzYQxu0pYyhaO/H6+zRCVkFPMdZU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd2hGMEOqMCfidzD5zQ6mUtUkmX9IKAcIISPvo6aSwnEbS+OZh1qjTpsMhnjzIL6EoQLwUkMiZvvwCoYitCajau4kh2979+PybVVauAEp6szyB62qP+2yiWRfXgDIegeoxj4lSYBkDhinis30+o8TykZFbGW3YtyupBKKhitPXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEdVCWOr; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEdVCWOr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf7683a28so5212010f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 03:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026200; cv=none;
        d=google.com; s=arc-20240605;
        b=VCGq0dS9Ql0RbcVtK95YQ3StfnipHCIJGC5JF/CpwwGyN8RftoIqQT0zsc6vqa5pli
         ZVv1ckkcyvvvjpjteOUcccVtpHoylPHWvG6k9p6Coozm8gGtMT3x3KiYTvES2fkGb7P+
         UGTV7yueR3agkyO6O5aHsm3bKlBft7/nN4K5+moqOIb6aOVrZyTUqamsnLMYUQe3wT0g
         4RUohXjyhUmEdh7tX4j9qc7NjG6COMZ3SNc8SMDl7qQOPFh22sWnBHHHE/h601Xb+00i
         eXvX4QDxTd7EnVUn576sycpwh1E/qMIxwCcNUjQTi7oYWlfa3b6AE28JzngUspnpFGCo
         x/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+EhboazF3Dxh20Pa6QnSW4KNxsBMJSsLNBboVsVI2F0=;
        fh=r1oLGJ9UUWlsO83LJMA5R4iXzMM7caBppsJt/9Dmgic=;
        b=giXAFWMQttjupCMT8s87SL6tD807D1O1UxxmzKGEVgBx6SH22zu/6vz60o1zCV6WAe
         MbP0fExbwKmCD/xtglaIjE+SGr5Zn17I4Pc8GycwsdONg80iDNUgdlt67KqHwI3pI601
         EaLkgT351JaTaS4n6dxqGOwxSl0qIDx8x3IaA4f8wbTZc7svcBtd2YyokxCm8IpS6DUA
         RUmem82ZeDqmWNafxdqFBmsrkyIvz79KTxa9KwXg/N5iw4XgqHIdRCKe1r5PaP/pl7/P
         r/SChb2C2Y0MiRI0H5qoveBkTYgvgFMlCTidAhLipkXZ/9eVlr6nQ7E7wG63Z7Y4Lk6O
         8kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026200; x=1777631000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+EhboazF3Dxh20Pa6QnSW4KNxsBMJSsLNBboVsVI2F0=;
        b=CEdVCWOr1JTiTChCYL8Avrk5dQix0Wlj9GV0Lng4XGUHkxq2RHKyJYXTU4vin5ZQdw
         CtVly5ygfP5lI211iP87rs4BejzQfAFOopeLPdCDoh3hoDrckfWiYCeDcR3qg7NyHgFO
         oEj6lyodtX/1rpKTR0YAxmNOiAhAPTF2wciKqH8XAjTzdgnMcYIeMRc/97uxELi5AImb
         ueuUWLTJnItp7uH6y9xKt6HwYrPdKntvq/VOFZMcAXtMbe/0JuX3Ga/kU7Yc4ESNthDx
         TUB91ZGa/yNttHvKLGVnY5qwxhBe56N0/nBFd0vO0SAGAL4R3CSsQveUs2wTRNroLGaa
         Lh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026200; x=1777631000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EhboazF3Dxh20Pa6QnSW4KNxsBMJSsLNBboVsVI2F0=;
        b=bye55/3x7ZhcWIXfzffArT5aLD554CWfd2vm0QuuvtaOE4IbyWWpzypEgR9lO6g7ns
         y2Eeme52nPHF8YCCB1qhxcjeR7tKJyOGq8yfj77740xqftGjwGbyDB1qURS5iriBcQXC
         2jKFe0GPECPqmyhYCnTCFRc5olrk+ViSW+Rux0uuMkxiYtP4/oWpbLtQDMbr94bipiM7
         9PNechAEcG6z8SNUpELg8TLBtaPxFjrinu19zh9Ah5knSp8JVSDq+D5EtMvNMZWIU2cf
         lzR67Vt9hSBHVRLp1xithViV3Y9H6ret7rubbh2ClZ5jABKEsuAEoHOgmVsqiF6seSuA
         HL4g==
X-Forwarded-Encrypted: i=1; AFNElJ8075DzLcXkMSbtmnF0ff+a35rLOKChgbIeah2lcvjkWqTI+MqjajUYD4hF2hcLwvnCgmf6nazniXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGC43a8amkCW5yF9Jjie+D6Rkw/qYaNoqiRAZEkbS8+sJ52DqJ
	mTDk2Qc3wpBw8dyAjJ2NRrsL7B9hmxIMRsPGJgaE5UtjaE0OK3hk7jWfWZRIUVJULEUZKzjChBU
	ACpN99IF4vfgbbT/oIZueVVAqua494ok=
X-Gm-Gg: AeBDietDCc4pW5NDNB8cGMYepy0/QjiSVEgGGD1dLc4eB7tuWbemSUTxGEjKow2g2Uv
	iBFhaX2HxnHNETUypnL1KYvQ2yEKlBOCukvFB42NnR0f1VJUW5zZwwtCL34SCEMCpOpQja/ZsnY
	DMoMAY2Z/eK/02FdmgHK020ZqZtYk7B46VowevqbCCi0H6FoFdpDiWswiCKu7ILda2RWtOnL9w6
	ezFZAQQ9yI2vihJ1b/irEmdzF7jRRnml6njF9dlGAln/7OV6zfwS3V4IGzLoeQcyKnVLv994BEr
	rYSk4eAUtiJmoGfKYfPjm112mEArBGkems7DNz7NbEQrJudEQ6QukIYMRzT3sSWT6JAuoKUVK4a
	SGcy0UjzP/GOFCpexmEkQiizXEk1Zkl85itmFJUh4MZ6Q+n8ewr2jz01TAKlKE+KQlS2zRWNzZc
	ocFvWKbPJEZ9sZnkbv
X-Received: by 2002:a05:6000:290d:b0:441:1cf8:be9b with SMTP id
 ffacd0b85a97d-4411cf8beb9mr26611488f8f.37.1777026200004; Fri, 24 Apr 2026
 03:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <aejKKKD4JdxIzlk0@ashevche-desk.local> <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
 <aetDc7Cvb-_qkf3s@ashevche-desk.local>
In-Reply-To: <aetDc7Cvb-_qkf3s@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Apr 2026 12:23:09 +0200
X-Gm-Features: AQROBzDVtlq7ersr8jHtYZjZntgtSbIX-Zo42AU8RIbtVfBZlfSu-Xs1FwR-ftQ
Message-ID: <CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026 at 12:18, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Sorry for the delay (if you want to help, start reviewing others' patches in
> IIO mailing list, you also learn from that). Now when I got my email pipeline
> clean, I am about to start doing what's been promised.

I wasn't sure that I can just start reviewing, so good to know. No worries about
the delay.

-- 
Kind regards

CJD
