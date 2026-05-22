Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EC299959
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426425; cv=pass; b=ceMKKhb3ikiIDqGtzNpkkczX9+dR8QQ9+5GdGB239t4zWpZlFv05RNoEqMllTyw2qg4wW0pQfK6mDhgqJGZayBdfbtOex7FUtuZ+rNdqnVpdEq5cLb/1uJepprm0zOjHTqfRuKGPGKd/OJrFiefPcccrEZ6t8ZGkQCyWNsS6Ql0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426425; c=relaxed/simple;
	bh=f36aZbnvgPmL2vM8iZzVmwmZg5YWhnIWhqX5OZSKntY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzyuPN66nILOIfh+FXimQqRhB58RtUEEPD7q46IMN/4Q4L7x8TJdXSkMCF2LzssE8+Rj+Pft+mhGoqgKOdFnjjDReV6uO+GNBo+3RYzLlD63M0ouHS4H8dVFMH1e4HpiRn4BWfczh8VJJtG//PUBYwrA28ofcohP94JQxj5XZ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryTgEXyU; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryTgEXyU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-452169ae568so4442978f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 22:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779426423; cv=none;
        d=google.com; s=arc-20240605;
        b=WhIv4z1My0iBKKQesZ8Bvg8X73lEhtYAC0Jo9tCQaj8rmLtEZq+6kod0/hStGvB/zO
         3aOnZWCVQA5rtG/EKgG2LEKolMc5FxND9mt+lI0ePlIj9i4sZyXE7ZZ9VIQPERpIc26B
         O9uqGJ2HG/nFN7grWvcU1RjgDkWOnRViMIAQo3EZ3JLaKScbUYBd7kw6xoU38Uy+dlSn
         1uWrBi6YSrqPNYQCs9xf+wTMNWsTInayyjkh9p/PWDUc33qRBt8dJR4kTjVGjAwOW4jm
         leMKjkidatdYJ63FZ6WsQ+PKG06+VY/OgxWEjE6bfNO4TIqPBCVoawj4NHCerBaGhNd8
         aRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KHYK72KemxikmVxyF9kSlfVf0TXTgQLqDFo4QsuQZug=;
        fh=dOfPXSXe8aNIyqgcpEMgtcDJjd68W1QN3IPXMcYGcVg=;
        b=EXZ+/3nVj1gh47YI8QluNEK5Yaemrcp5OWW1OEQ7+88JXjefKN5q2CaISitT76rK0X
         okxd1oc0LCsrPOLa2tKw7sWL3NayNTS1pfT7F9ZDPO+dtnlLvwKWttQE4p2FIKDYYl59
         lyefk6GRqnI/55FeyJYxDQlEqjwuqjsDKxVEoN0snzZUTYrXFWngAO3GH3BqmQyZNOZX
         OlQP4LNPDABA/E/eM9+YzFbceU4/1BWU9CfpR5iSd6lTyYPgYSEFMGpvQBOV+mCY2fmD
         07N+Rlg/m+XjvDwlJdlXRZbhs5TTkc7Kfs2jUObLli4W9mfTAR+M5KA2WN4axEN3+Vhc
         Vd/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779426423; x=1780031223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHYK72KemxikmVxyF9kSlfVf0TXTgQLqDFo4QsuQZug=;
        b=ryTgEXyUuVb4SPRnhAAsP/Bmj2KMGKxWQdA5wJgh/AcgjO3ApXeTh3ZeoHCjp4ji+l
         2emCaROFSzib9F3jCjST1o61GUc5ndwx6JHy0wEKnqI6d2mSXwmLoP0DJ9jaaXX80lyH
         CrhLXgWF0bLAItfcFQkwkFnHGOJuZZ8IZusGRd5jy5tS98FJ549HAZHN8+W8TrbgqeKa
         4NmtoEk+UIfy7vmKZK4xy48HRFaAjqecUiSKBaW8dNd4Urxpg7wb3SRqzn4rpFtYTtpC
         y4Ylhm3Q2e79aL7DCkPOz7QOM3L/hs86aiwvSvIvlLst4qDd8/nZi8NLMbxsJRCJ5KCr
         9efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779426423; x=1780031223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHYK72KemxikmVxyF9kSlfVf0TXTgQLqDFo4QsuQZug=;
        b=Ob6KFWyYFbtmM1qvGsIsuLK7Hqlw4ofzM6pUoQW1DSwZphELPutfOJqTbuGpd5fEE9
         NYS9QUQYiHVIWKDG43BH3Y+lbBd8u9OrrE1uJTVWoHFbcKFcExvvBRQ4Rc7fQjJMhUSS
         BZmx67XNdUNUZCftKPKhT8lCBsc3AErMQuru95KJXhW418rTErBBZbJE3CR9nCtxhmRO
         0sdMtYsFGLXrIjUkuVCUfxEOdC98hK8aYdCIprNTppy7rjlBUDHiMswF3AmqjzFTpclI
         cTIMFyKgFmdF4/yIS34ds4jTe4PmnPCK7CF3h6Z2S9DYCwMnmDQ8RZ++ZYzKWZDBcr27
         JQyw==
X-Forwarded-Encrypted: i=1; AFNElJ8QlwelfilkH0O/JpwbpNlHCkNu9oK5Dy9h6A5lEwEqG91EH6u151I8+IZwVG3lQXEuhod55PVoQs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5YB2PZpGsvDwMFvhtn433yvCguxUWQnwcbgh3m+Sdn6VRYQh
	NL6aJu/kSFb0RLu2/e80MmiLLqUYnDXY06PtP/+aUyu9l7bBl/L1xPjvUq6mz9smiUyyRUIgoql
	H0PAO8EffL3PHvk23xU+7vDjIR5XsVRg=
X-Gm-Gg: Acq92OEHvbK7CVpUOP3OBo+ex+ydaGROaA+ZH1tMz+dTcPlmhmL//aeSvP6pW1m1JQr
	Z0N91Lc75GOwlSZlMUYvLinfSk34+A7a23XlVCUb4cjEj2hjf6BBlwSLhAYajNlViSCITPE8Q27
	UHzvfZiCijEfdSCqpqWFeGSm93PAtMgE8EepbNvxioUQ3MfCO3ml6b6iKNGVDPQ/ZatkBpdSHzU
	AhUBigXuWYY3T8oMyB81i9NUDUomfoPR7vxDOp24Rely2iMl7GTmJY0HNvOXAQvjU0QjRNX9b/3
	BUyhsZJA793kuqhEek68PwN53cXfxOUi6i6BgD3egrh+tUSCCkt2gzC0xddBBDIlx1nBPTqKGSN
	mjfi2DT02FNi+Pm2I3zQX8BV/VxM1/DS4O1sQoyAlEdEG6pea/X0v8qEgGIm5P8EuaWFUMmcnhF
	1aLoZ2+ZTFQkOmzKQjPvO/NMQq5TzEWXMR1IpAH37yz/McUxRh
X-Received: by 2002:a05:6000:1446:b0:45e:7415:8c4c with SMTP id
 ffacd0b85a97d-45eb38e0657mr2286888f8f.43.1779426422716; Thu, 21 May 2026
 22:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
 <20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com> <CAKqfh0GeFG7Jw8==fjve9oZ=xy4AnitzF6z84iTLtNKB4wLLHA@mail.gmail.com>
In-Reply-To: <CAKqfh0GeFG7Jw8==fjve9oZ=xy4AnitzF6z84iTLtNKB4wLLHA@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 07:06:51 +0200
X-Gm-Features: AVHnY4J1iNlvvG2sYd-8jSWb_LGpQ-OgzL2g3QSx2RGfw5Kr2KMijONhTE4NhSc
Message-ID: <CALoEA-w7mjwABNsUVGWbW8FbA6qRvwThjKVC4_85-T0k7rkn1w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] iio: light: opt3001: prefer dev_err_probe()
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 03:49, Maxwell Doose <m32285159@gmail.com> wrote:
> Ah, but all of the above don't seem like _probe() functions. I'm not
> an expert on dev_err_probe() but I'm pretty sure it's only for use (or
> at least, designed for use) in _probe() functions. Only function where
> I know it's 100% fine in is the one below.

Hi Max,

Actually if you have any functions that are *only* called in _probe(), then
it is okay to move them to dev_err_probe(), you just have to ensure
you're not calling dev_err_probe() twice - once in the function and
once at the call site.

-- 
Kind regards

CJD
