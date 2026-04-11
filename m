Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB48330D36
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904477; cv=pass; b=DMGfzYiZczyMSdAxRx/L3gGajeFBOsybru0N+KMQIemWLOBwUfc5WXk6zy9KdiYA/MXt1Isjn9EZ82n26LG1BUEdO2lAW5e9aURFOVLm4SwzTlDxtYJrx0OtvzY5y6OD8k7CzsxVkzskzvQj2vI4ssT2EV2orJAz6s2i/fdCxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904477; c=relaxed/simple;
	bh=Jaiw/CtrOM2is5N0FH5ci/nmVUYsUyzkXaonVvz2MA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1f7ujSLwl6yD7Pc2gDa+2qrOsqktrs9mXGLoOnLEhOz7QUbadZ+izCEJb68mzHCB/AL4/FNj7Ux4kmUHb/woc7tzlw9L+UnCHAzpei1tgtBAPff5jcd6moQzDVCQN7FaxSjkeHphFXkdREbwCvj70CjMYpzQstXAq8wrzHnMcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmTlB+sf; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmTlB+sf"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso33023875e9.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 03:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775904475; cv=none;
        d=google.com; s=arc-20240605;
        b=f1Qhk99YNnCCNW6B1WkbVLAJPlUQi0QJ8flMJa0/xzIlGDfF2abuZLYW4ri2QrpwrA
         xLa4vuM5GMBqKfTtGy/0M4iVcp3DGyAqDxzlNmUPnh/jnQpZBrLdjQxri3t1SwjBw4xr
         2Bwm0/apB39TAGK0XsC5kqvhQuj1xB8kpnG0XHdrC1KVgjWZyVqYj7ZeJ400rPZsjgK1
         ndI8U8xFzulZDrEFvOsD0u5H/4GTytLoeJ8MXkn4Ftsar9AHvAH5mlxSmFhzIn73+66E
         z/c0UsHx7phFeWTNx5T1p9Uu/SbKLEcL+S+e6vZ3jV9OJGuc5pr84lsibGEnjUE+Wt+/
         RfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DmNI7AJuvLxMtrmh/q5YuERSquxF+CEt7z6izdNoCV4=;
        fh=rKwJMcBfO+45iItetMFmWmguxQ+pyK5zBCtd86bviZA=;
        b=kcAxbPSfZHYfbNfGjQGjFqtvsB/nUb1OHoyhqFtAIi6Vz29fswnNPdRLiAFg60j411
         Rq57/ZpKRHwDP1g2kO2KIgqrW0mioHQB4RqW4vkuwpvc7oLpMakHcp5TkZ1g+kiccWab
         Bl/f1mpMp1bHRDlQRV9/a6N3gxaANbj+p6n7gRnKetWrRj/jeX/EfUjkDYQbBZde8OME
         lDcIl4JcxKXu4ZHap5QMagBapytyYg4ncQx5bI3GYx/x/gDJViit7Xuoq8oKXSMeiBfX
         Mm0Qk2gTTzjarAuMwlRSRtZ0Hk8TsKVasTKk4Duy6EkkQNpw7aeLTkzwlB9s5wUYrdb9
         St6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775904475; x=1776509275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DmNI7AJuvLxMtrmh/q5YuERSquxF+CEt7z6izdNoCV4=;
        b=DmTlB+sfYVjLfWJVNXXs9fR5YRbiU/ganUwxKMXc7m5ckUdHLHj7cM3GLHNj8GY/t8
         5DSSCInga90e6BiXzUGKwq1Bwqkso6AkOoM+GxvSKQR5rtcmNhi4V/Z9ntRx6DlA9/QQ
         HeS5hH+DtKrI3/ZtKzfuvpT2uKwR0H2nYS8NReByYrZdW6r5uwQvttkivVp87PGgu8IL
         0vaB+p+IsgotkBVgkZSNs4BzR01hRmeb2TzeIon4tOdj/mPYTNDCLze0tJvIGZpkATuy
         oHiHD3FwpDUVgmITSMI8yEkj/cwSazkc3nblRdO/NteX5n6ihed5rpAzdDvIO1QxjcZz
         zGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775904475; x=1776509275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmNI7AJuvLxMtrmh/q5YuERSquxF+CEt7z6izdNoCV4=;
        b=Kr+CdlQpi2KKEjwU4jxyhFu7BWM87PqYGm0jW9wVkzE4epygvRNG9QRNbWS83u19cC
         xjLQidZz3A1JBqPj9v5v+0mQCHxptmHvrLOhJbcpa7A+t2uGs1dCrnYlbloZy0M3zKzR
         1I27Gb21CE93tSe8ZCVOQB8zdpKntiGz2rBQzVuvqPGqYAGc1bv3p2ih4osGMg29vZDm
         z9tQSCs0tR5P2twTJRgNBtFHXUIxCGcN1aeH+a4zvE4Vte4QKyQ+nrMT+WL9i/2ycuOu
         Np9lbBQqrnJaKSVmWtyLOwuuuJmCEq1zzUfeinvtr6reJbGuvRFrEZXEvgA78vFOoyQA
         2ebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxqaDN4EzhN8jcSJ7nUs25xZme26vX2YGL2WymwrCYhWvIFwi4rDOoQMrjDpLGC8aehni87t9AQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHRghbOfYWXgMuhFMtl1/uYX7GVm6PZr9NE4SOsO/NLF4SpNQ
	BeWWcM19IKd6xIcu10d+QlJbF+IllGQk/L4Kn4XDzNm15r7ZmyipB6VaalnzSR45FvQw3MlaTY/
	rLX5TNH8JtpqU8zj/ZcUneuKDsrHnXPw=
X-Gm-Gg: AeBDieslwu7iYERbmblcYIap+JrSHYUzYBJqx6afEoND8TRcu1y+Mh0f1VUbFefjo38
	0K10XNyH4RXSFiARZtWPVw6/wm2tfT8nBi/5MLqzepQ1i5o/DTIZAKcwtxCWLVkqZ/nsApwPczL
	gHwmRL3Wswjftzc4J4Q6BQ03gvZnDlPa7YfBzSmH5ymDRZjNWRvpahNsgs2DomHXcz95q4Q5QWv
	DHADI5eqPX/Jv/2+12kkyXq/Ym5dNgivcJ6oD2081epbtBZL2EBZay01H2nzP0OmwjIZkCOxzIG
	JOnkrTtyb1/mSQREhcxvxQNsL0BuIzoUODXkESRyes/9HeHWPBpuxc8p4nWzLDZ8kMm/kifMO0c
	/NkkYwfkITSPyp4Hx0DYfRWBY4uDVpJYMwGJPgzOkfQTxoMa/j2QgZH92WCSHTAvT4IkmZ3CvCh
	c+aFdl
X-Received: by 2002:a05:600c:4493:b0:488:8be1:ca3a with SMTP id
 5b1f17b1804b1-488cd68d7e7mr104288475e9.15.1775904474946; Sat, 11 Apr 2026
 03:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com> <adokoNfP-Ueg4yQ7@stanley.mountain>
In-Reply-To: <adokoNfP-Ueg4yQ7@stanley.mountain>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 11 Apr 2026 12:47:42 +0200
X-Gm-Features: AQROBzAf3TqcDLwY4c3HcxKa3Ga2J1SxiGhSJttRc85RFQJIE3ePt1FJX0WP2zQ
Message-ID: <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise math
To: Dan Carpenter <error27@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Apr 2026 at 12:38, Dan Carpenter <error27@gmail.com> wrote:
> >  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
> >  {
> > -     unsigned long long freqreg = (u64)fout *
> > -                                  (u64)((u64)1L << AD9832_FREQ_BITS);
> > +     u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
>                                                            ^
> This extra i char is something I really dread as a vim user.  :P

Damn, that's embarrassing... Should I wait 24 hours before submitting a fix
even if it's this trivial? Thanks.

-- 
Kind regards

CJD
