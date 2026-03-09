Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06D361648
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086783; cv=pass; b=fV5Tqu/gkhDXp7ldEVUOW8AfT8UnqCYPm6aU1LBVnQmXK7TvcAKUQpNhMsbFEibzhZ+eYcVqRzI1URHQpErszhLRhIQbfKhKv7+xfsafjwtDPJcaYX8bOs6HmdtzJ0R0Rde1BhJGaOP4M3u07GP7dKF31okzy9mVJkomqTw57v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086783; c=relaxed/simple;
	bh=VMFqFjkSqvjf/aBVPFQeJU4DJbYusGuHEEfWpM7qrwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNhJBE1cVVnatWLpYYlMn/OxGR3Ou/UBtSFGjbKmmUKtORSH+t2OHtf2P5s8Tvbnz+qi2OQ36txzYFAEZ3nEcI5vGrVrFZbWDojxALN67NMdH3VicivUunlRC6niMXWG5++LrV++ooVtbWDx/q16T+/tYrDpbDAvwzEtxGo8FGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwT02oL8; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwT02oL8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661be3380adso5603860a12.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 13:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773086780; cv=none;
        d=google.com; s=arc-20240605;
        b=WPRc7pUpkyTt0wzjcxFd/9RPXAkCW0dK3pM6G4PtDMUiAsyYZ4u4JEqDV+zlqw2IkN
         biSfC0fYLV9LpEC9uzK79Uj8pe+l2Z4ADhASKw4NLtKq2KL0keWw8UFy2cPP6pbsPoBA
         trl/I75o9YurCEwSZbHjZEPOfKK7oRg1TxUGJ6Qh8KDRbGVT6eNcZD01coIgCxkqsPuy
         wADiVVIcil1JACwXw5wzVzyRJRbS4HSVlhBibBLdFCwx+IAHPpcaBGWVVZgLkQhKcRgB
         egvzjmrxn/PFX8Y/636SEsv/z8GYQiIXIPnsXrScUAZes71ivN3JOJbB7UIDJxRhNr5T
         bs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMFqFjkSqvjf/aBVPFQeJU4DJbYusGuHEEfWpM7qrwQ=;
        fh=Ieb/M9HBVUNkZnoMzfsgPwEI1c2QSyGcf7vnndj54j4=;
        b=i9BfM6DK1rdRoysn9XJEdwLBRWrrjP8V3286mSBrTLINTTPBhxywIu0eiKu88nnIeZ
         t8Zdl69bMu2GHsL+K0B8GN1780Pa3enAWrViYITwEN8FS3tEojFSkkzBI+36H9FHIjPh
         j2QiKE2dYXjuitsuTzL+uapCjgefqjTQ+jlukfKWDOXuvpRyrWeMVnRk30LROtnGvagJ
         iaxGVzdCjOuUwXBW5r5Er0uB1xiO82r0nLFThuFA/qcG98BZrB3E4TUec1KNMRbN5ACa
         nbu7J2hxpM/GueBwUeCywoJ62jHcgIS9FFLuFPny/P0tSmihrrTYWHxJK8her5WEH1re
         I5JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773086780; x=1773691580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMFqFjkSqvjf/aBVPFQeJU4DJbYusGuHEEfWpM7qrwQ=;
        b=fwT02oL81IlZIrVsS56KSbVHHdXH3KpozArf9T+G7tBy4uIQ1ysm5LBEcgyPTjFPzL
         gGiXu3M17qUaPLFN1Y2Mj55fiR5JoCxyMLe0A0pREFyHuCjdqFL9tkbxleOGrDOZ9W6u
         pQqyW8X3ky57PtC7kIJTX3yMD21Klf4HZ7pOp7W1R0MVftT+Fgnc83687LwOP+Z0d6ED
         2UctYZF8D/6SkJBW7WxO3gh6CEx0NUdDanvjFC+W8EV9g5+PRW2jtY/VIozdMy3bG3hH
         99RUrk5XT90yAIsYpUvpNKs1+XaZtg5zmomLaPtijx/Gi1rUN5to5jTh1Vb3f7+y2qmD
         IgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773086780; x=1773691580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMFqFjkSqvjf/aBVPFQeJU4DJbYusGuHEEfWpM7qrwQ=;
        b=RvZ4AYGD4xjxTTgB30Fd+d5k9S7XzhybY8htDAJdRQaDYgRwzR8WKViCxYWyRqfWzc
         0KiNZjsCt7jMfpfyqMjLhoKCuJOdl680i7Gjm4ORBYYLG+rOgnNzQSziJ7lirYEQpwZb
         KWQAOSqmXT97f312dGiqf4NyDPQsER4DmW4rKBip0j+QUSuks2xqUjs50pthLHl6tl1n
         IUx5Ufrj4HcMAtoNoBWVCZfH6Dep3Tx+a9AKmyf4BRrSiXLdyrwvIOGV4ffjvkGKcZeq
         lWfxWSYpzHdgIRFCzHxOQkN7qU4ftdRBm+zyixcFDLwAbbI9wkOEd87bxFQMJiijcC71
         xCHg==
X-Forwarded-Encrypted: i=1; AJvYcCUgyxzDPpoC7jV8kDoXvcLh6EJohFvV+LfKua7sdDOiB21e19tVjAFfdftILyGnCJF7PNcDwu05Auk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtf4afSn92GuwdHicRkO+IVb1+LdkAn5l/iuqxhG2kBcz3QeJb
	1OD78NcCCR3Sp4HLfLvMnEVaiOIlxpXW3EOtvlIeld6yAOP8guZuu0MyUfSo0MFDpBG4dv7fYuo
	QQNFVLGjT0LMkR9sOYhKBZHMr6CODjQfkwQ==
X-Gm-Gg: ATEYQzxD91elHOlQAx8yWCD/taKJXhhifWCPwyg5xYximE83yzihhCHPVIH2sdBM63L
	RpaIeskaAmWMczX2mverQJxUXH1sQyHDyBOF6BNA5KRJiGoUQWwW/X2oiJgyxlue2ljleFmb/d5
	+bkf279qGBGYty8fN89nu2JDcjFjCuU06DFzAZRaYt8o0SM22/DLXNn8tEDa4yqWnVF8P8WFIre
	MDG/tB/sNV7EUPifAwc6BjuyOZjOrOhpxVMAuNuLtyrClw+LdFJOH69uVbZ4KG3CP1Cmi0udww7
	Uv/8QAuXJjL+/5H+DXPKrsvmABCwzn+RlxCpyiTSsfwV1uT+et+J3I+wipH1VJ+xx8komxFIxLd
	9ICsCETB1pANBWXlf6tdVOp8GWGE=
X-Received: by 2002:a05:6402:350d:b0:660:c1d1:d5a1 with SMTP id
 4fb4d7f45d1cf-6619d52acd5mr6553764a12.30.1773086780202; Mon, 09 Mar 2026
 13:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
 <20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com>
 <20260309193010.104159cb@jic23-huawei> <CANS1UbiJgvbbzOAbi1TM5=N-Gj-LQoOFRyBUf06qkZRY3zw+Sw@mail.gmail.com>
 <b1aa81e6-ec3f-45cd-84db-e26c465ae267@baylibre.com>
In-Reply-To: <b1aa81e6-ec3f-45cd-84db-e26c465ae267@baylibre.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Tue, 10 Mar 2026 01:36:09 +0530
X-Gm-Features: AaiRm50WoZskAI5ivS1JlNhfUtEk8ZEFIceI8Fe3h-7144nskhVNd4tNyownL4I
Message-ID: <CANS1UbgCQheK5nT-5DCtrWewpOXahUdbzAvnDCanaQBqV1P=yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: accel: sca3000: convert to guard(mutex)
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com, andy@kernel.org, 
	waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com, 
	harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com, 
	andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:33=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Waiting even longer than 24 hours is better. Not everyone has time to
> review every day. Ideally, wait 1 week between revisions. If it is someth=
ing
> urgent, it can be sooner. Converting things to guard() is certainly not
> urgent.

Yes, understood.

Thank you
