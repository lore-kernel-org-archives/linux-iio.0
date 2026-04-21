Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3B2772D
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752215; cv=pass; b=nv1RLjpw7Dr37uFliFjtId9oE2wBVjRBWyCpeFWSFfUq21fyajHkiSUNE5wuIqPYyXrAADTIL4ZgIwz54MKii+P4fK2c9e2hjCO6fiPh5SMHzTcIIQUaHwAtwgUiXHZ4KiAMrk5c/EAmbTophj68UgrShKJdYiRThowQXDDZ224=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752215; c=relaxed/simple;
	bh=YjRvLK7Y1H0yF7fqMSUUCe5AZIgjk7aVAE7zXs9ETgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM37q5WODRra+BKSgbMiODKcNrRuWKipUA5zNTfGcz8VZDbUbds0WCTWhbOkPjKV0w/7F79ijAGbDiOwgvi8LSRRaefMyme2m2EG8mkjSzhmUlYvUCSI+sLcXb0Nc8FeZmRvDFQXa/ndnlSFKMTcunJCfgpx/BvOqvsw7sVT7Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdlLy2b0; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdlLy2b0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d70c30767so2743359f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776752212; cv=none;
        d=google.com; s=arc-20240605;
        b=kNHu8U71rxM+kD1ZnX2TxzrVwNjOM+TBo1rjrxvrZm6qpSU3Ksg/eLrwmtNks7yu5F
         vjQcmt9HWqDlBoeOshcuY5eBsXGyB0bGXZ6KNUg7KYJ3aRtlp9ejE2duPI7yImpwKvsR
         TzbeZoR+IY2lpcFuYupybd0ZtvFWyCodQUAekTs/xI4+EwvfA84blhVKB8xrVBA8kxP5
         SryFQQwHTG9NYOkzS9hnxT0i1ltvm4iBaDA7CFzIzETE2UKFHZZ7XceRtvTkVsrpWRok
         8rbqo8gihYVN3ghbiY8YjNF6J/Yq/ut3qE6DHyZJVPWLrP6vRXlikcTH7ZEfzj95D3AV
         1URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i79RqxF6yBxuKhI3cMKb1JyESjChb1a2zhhOSQYeeKc=;
        fh=zoAXak9TKtUmj65ej5lIJG5GnkLmtOX1aR+Yr23CYh4=;
        b=cRi+96/wII9Ae4On9N1a8kIXZ9mXOJfUGVrTY+zYCvkQqD3vbjiF1UkEbU4d+/6zJ5
         gxuhhB/5z81lMbDHhHyDJ06+IOd8jynsHU8KSyY7zkLU+ZVKMVWZZeR2ZbNZhelgPZ/M
         pKcaq3BnjXXzIqcPU1OfpZt+1omD1A7B5zPxHV/QA+0JR3YjqcDnlFnc09eG52Ri4i5Z
         xDodHyoCgwJxH+DEzbQqATTqE15H4IyZPdrm8/HaAF0ncYHdwR2keSwfeWs7j++Ek3NM
         g+XzQeZIxRMeWZ3Sgkf2T6izLm2nTZ4JGWtZtS9FxeJM5OipZoiJZwR6v11tCGI5NCSO
         nmuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776752212; x=1777357012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i79RqxF6yBxuKhI3cMKb1JyESjChb1a2zhhOSQYeeKc=;
        b=kdlLy2b0U3oH2n+PH+Gy/6ZwxlQi4K7ePJ+Am1hl38DVvriLH51U4/7hpTSNN9R72w
         s+Rowm8jvNyQ1up2HhZvglDazjl2Yf9Cu/n6E0BI5LxM3Tew3FCYMlQ/V2w0sOpTiQnD
         oPCv2yXrVG/TBSZqXfjkfoEn/hdp+2raJ8+t0hd3/43D+DY2yjmf+ME+ZYGnzRVAkYsG
         FpHK26oI2gfcCtxAsFUi+7UMlHoFxEx5AsLWVogLd6/vheu9ylno25qtKZK26hKpSNF9
         qdBU4hKYGNy8ajNLPuuYuJbLlZbv08QFdfX2R1QWl4/WsYgjok48HVkMf+T0o2Yytvlf
         aIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776752212; x=1777357012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i79RqxF6yBxuKhI3cMKb1JyESjChb1a2zhhOSQYeeKc=;
        b=e5sLHnFQ4ASLvMCuV9IK7VW7BOiAbcS3W6okl1rR8KUheP0X+r/mS0gOxN63C3H4NL
         eS/LONgpHnwV+NRn5Upz8NYc/uAe3Ilz78CIzXhVefBf9heMGyKt/Og+NKkyAZGXjSM0
         iPcYWBSfIaVidDlMf2aagiBem+MHgSWPOs8HT82Y1y7HqRI+pJ6RnnZTzP2rcpquC3YB
         /dpzP6XLu1t6oMKCJQwvueFnryq0IgLu2gm6rCfpaSx96PMZbwiuk0vXC6aH2owEx/LZ
         2YVHK1YYgxqoO2WH1hV3c/LXOPed3ZTfBl4lGCKACM0IaCt5Xao1hryXAy8qkLZZKIG0
         Optw==
X-Forwarded-Encrypted: i=1; AFNElJ8ek7KyppcRgNUCsIMbo74K+l+7/SAZXTfORuGKs7zlg+U+A3ZOnHcnhgk6RnNi+RaoiONxZh4DsiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2cxSBn3sCwBUDBYouSKCsL1jkXCnEnUVFAWfH5iaU5QRYA5M
	YP2unwkPiDpYQXY2IYtpYdyikH8y7sRA2/zMmwKu1RTvx/hIMjVb+iN9RUSJ6pDp3VNbGuKUCz4
	hf6vIsaAHKMJGkesXFkBW2ef8qNYR3Pw=
X-Gm-Gg: AeBDieuK0nPXaZq4d1s7F6o4Htk0ZpoX0bzvCFACmCNMSuY49SD+WcQP/wM2/uIL6zy
	9p4wBUK7vZtiI9j/0EBhGHM2R3wxQwh6/KRJ3L4S5WOUrmtybUKwIiWIXWlziqL/pM1b82mJzaT
	wbNB7lVj9MgZ3DY6bnvBgATuqzjcWvsf+xvfGbYQDshc7Y1PYwDnG5H8QYFTz9GGpX938F8znmP
	QsTVHJnzlBoGEBy5xZGaBqDublvfd7qeHn/vJQ4gGyy64MSpgbJ5p+Vnr0mz4hT2JNcMoGjYSHd
	IblrY1rKzEcHgcmzI/SmCEZoApbLnfJpd0ShB0TeMFYG7ttufg7PBMKBcfmfLLDPWOWFDYLNqVT
	s+FDoXMr1vmcno1gbO5Z787Sr2R9m+w6He0F8VbyHCbmHcqn3mxrHoqD35MF/7ug8fb8INL7yh6
	jlosaMRts6VyjljXmo+DNeqXddznA=
X-Received: by 2002:a05:6000:2d06:b0:43d:210:2b2d with SMTP id
 ffacd0b85a97d-43fe409fb42mr17524217f8f.31.1776752212149; Mon, 20 Apr 2026
 23:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-2-joshua.crofts1@gmail.com> <aeZf8_NszentI8-M@ashevche-desk.local>
In-Reply-To: <aeZf8_NszentI8-M@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Apr 2026 08:16:42 +0200
X-Gm-Features: AQROBzDxhWy31L-C-gU2UIKLwZ_NHrKIPkmaItTj4iZycDh2NIemF7kuY6lHol8
Message-ID: <CALoEA-za23QHxtjoW5gjT4c60-vPYb5v0AZV+y_odJ1TQrfafA@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: magnetometer: ak8975: header cleanup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 19:18, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Seems this implied sorting as well. As Jonathan says somewhere else
> he prefers to split sorting and IWYU patches.

Okay, I'll return it pre-sort.

-- 
Kind regards

CJD
