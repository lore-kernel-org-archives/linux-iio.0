Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C45310779
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369953; cv=pass; b=tvm2/HeESd6eaw5MLURbITSI9X60evufYpjiSIjTlxINdELQBeLICp3ikddiHSYVxNvUdf1b3iSItQP+iv+yYWg+guUNXLd8BVuI9a04+NudHCa/PKeZRmLEapfcD56a32gubD7cY2Q/5G+FLZUo3HXSR4nnsjZIxNMfaNQ62pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369953; c=relaxed/simple;
	bh=f2hBVzaieHHEANs+saNQHwTnQ65RICnH7LzDt9Vqukg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6UVlpyl7SUsEAFbRXcaZPOP3GhfUFzyP9NYdsQp2BTBYDjkGmnET2VwRq0yD/HgfEYXbGQO9gBgheNRas+qw5+QM3d06+2i0EEdg+ifqodcSBH5/h24IeukdIYZ2dlwzEw+cleWCWTcVxMccyNyMsqqV0uHqJAtZdaz5lyRVIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGUZ0xQ3; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGUZ0xQ3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-445795cf6f1so948359f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777369949; cv=none;
        d=google.com; s=arc-20240605;
        b=e6AixJR3hNsXmcow7uCCFbrA2xo3k/JfM0mYdpC/eRfcMw5NoflBPUZVMVbeZwB+y8
         6QiIWO6QNoKA5NyWOgADoLYLKPD3pJePAg0oQr6VZlXRWVVV3om+FoDKlEfUcxxFH5AB
         Dme1Ky/yav2tIWZyovb7wmEB4FLZm/6dYPDGd9HNBcoMzggiOurtwKWuRV4PTB2bgPVr
         +NE4zaQ7Fj9DqhvGqrW8bfK+4YRW/wGoeM5SlWx0nQAFW0Oah1qCwHEaveL8qqYBuhX1
         y19yTRAHGTekdorhiXXiXIipc3fAxj2fvhAIyi1GBm/Uax4zSnMdw/kERaO2w9Cgz/7r
         HbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jr10PnCb+3ges4uZ+KAk5OT6eq8RM3vvpi3Yvbz30DQ=;
        fh=Dg5zoWqUx76h3UPcxsppTHY72IFDoZZoazTlpye19aI=;
        b=Nmiw5gNTVOMHUahYWfsgvZ1KIeYsbmVVKtLfXJ/lXs7h8erZdpS1bBNqY18dGYGHCn
         3xfZtYSAOrauoFb5EItribeacV5sAZAP5zE7Dw0NM0hbN03ETE2+g/7NP6nfcGIFkZr9
         sNWOsUBh8Jy0iPJtB6GNe3CwpTCPDol6IemjVJyc6i+X0jlFB7D3fX22JRzeOvYd6xZh
         TLpM/W0EmTWMMU/g9nDUMYfF1AFYKWm2TSmBqXl89OBQnyixV+kebcBFa70D6f+tv4yk
         U0jHgFfcikRhTaPKQ4Mj+qBCUc2nOkWuBGCdfoUfedYeBd6fx7pyYMBlxQ1cKVkLzPgu
         voAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777369949; x=1777974749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jr10PnCb+3ges4uZ+KAk5OT6eq8RM3vvpi3Yvbz30DQ=;
        b=gGUZ0xQ3u8rZ7lGsoDMheUSurPO+6EotxpZjw1SVCT6YcYJc7gHizsIkKIMXPsY+JU
         ea6BDR8Mp49b28J8IPFHryyXB/nkXUdZRipifrKHJvc8G4z4gjn6s7X0a6CVodhPsVt9
         jjwtr4i7CSxDDiEPcc0qn0y8Rgp2ytp+XNO1awXaWws1zxm4g7wsMsRZuiwxZOKxEZjG
         rqcqTC4FpHCOrLotpWXb4u/8StLXvhhIKACeHrgKIgyxJW0ldq52GEtATvlQlgTb8Zzj
         ZzN0NUcrAaEWcM+LDSbDEBJOYOOQJk98R8mzUUySxQmQMpOMzGpLuwCS8R2a8udQbvHo
         DwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369949; x=1777974749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr10PnCb+3ges4uZ+KAk5OT6eq8RM3vvpi3Yvbz30DQ=;
        b=fCAGfcJgl3jRuFRwAJh6gI+PR5G/2bmaT1u8CJxKbjvoBZu6Xci06RsjxpZCiama6O
         GTyejFcZODn9h9vhGpxOSsvk35/0GYmLEsQUZuDGgljy52dsMph+86puSjMH0rKPFqrd
         fXb6YBsYI17ouPVq3lCVdxaiz4PXbEhD+IyiAGqsoncVS659x5zHHBc8MoNia9VUA5oa
         RV8m6j1kcDCZFNd5y+mIK86mO4bwibtCYQcsRinamnjDCGhBLFWdhZMPSZWUXz1912jt
         xjus7EndXJUUSChLc9ArECq7CMyPojKyhXdCfw1lX2WU++GkIDJIm3Kk+zxbUWpRq9Wh
         e50g==
X-Gm-Message-State: AOJu0YyQ9T0ESJ8pKfL5TH2Hvqe/b85uqLY2GM6YJaFO2D3ZzY0ZlV6P
	NhhGu60XV1VQo6RqfIs6zC2MUtN9KvRPQtwJJTeMWG1nvdalGPFef5OORivVz501jvnirfvD9XF
	SfWOEJ85yuzv5uLsM5buDOaVq7KWIZLYu1cvu
X-Gm-Gg: AeBDievp2uJt22Ys7tjkE7JkyHUahu8WlFLEWpb0Dl7YvUdk+cunVkZeoWpYzl9y2Oo
	FO/V7BSyD2j0uXmj1PSD4QdqYTYpjkXAnwP/WwE9hrLjzGvPPmDFIFqu3QizH4gV5w492eMhu2d
	Ww23Wwt1Hj1Y72vY7zVlo3aDDl+DRHZCHh1eEoxLGOS1PmmKR07u3iK9IPcFgV0Zz4ZXnV3DvSs
	Ki2nN5cs8XJRDwFZstWpZbXQep9ibfmV/e6WLsWcRsjkyGYNAjvrbpiXNPOwmACrXJSX9YsZEss
	GXmJid5W7VsOSRRQXriiqacpIfLUiu+gooUcnMQToxccTc3nqML9q1xuei6aX+50l//DJHDOuhe
	GtbKdoRN4+UjVeOMA8ESCN54AN9OsQTs1FZkn5ILZH/y2JjTnR6AJeZMv4MGRhO/7oY5j7999rR
	ns4TfiSSk6Ay0/jHPi
X-Received: by 2002:adf:fcc9:0:b0:441:1d53:cd9e with SMTP id
 ffacd0b85a97d-4464b2ace50mr2674067f8f.37.1777369949316; Tue, 28 Apr 2026
 02:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-13-andriy.shevchenko@linux.intel.com>
 <CALoEA-yjpDhTrP1Z-ZgSohjJBE8W+kBvTeeDHtcguvb4ReiV3A@mail.gmail.com> <afCCEMmu07oRV-93@ashevche-desk.local>
In-Reply-To: <afCCEMmu07oRV-93@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 11:52:18 +0200
X-Gm-Features: AVHnY4JoRHsP6ZLv5zax7R2GAprq1cjoluSEDxZNbQrc4gOyP7xiHCvXkPXD7G0
Message-ID: <CALoEA-x5S1Bwj6UN5zAurM1ADbdSCGidUf+soyDY61X_eus5Jw@mail.gmail.com>
Subject: Re: [PATCH v0 12/14] iio: magnetometer: ak8975: Unify messages with
 help of dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 11:47, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Hmm... Not sure about these. I would leave as is and do a separate change.
> (In principle I agree that messages may be improved.)

Okay, in another patch series then.

-- 
Kind regards

CJD
