Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE04519B5
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467714; cv=pass; b=mj1y0rSmfZBdBvHQYlZtjQJVlwkPwGh1ledV/NryGYsGU86r2ewwMu0tel3vq55RuBv1xvjk5xRek719mRisWbln+3nUlwQ/VSZlEKiI1G96PZJ+gdAjCWPJHuEehYbOoKb3F9Yywe8XVG9xWEcKsdr/gM+a0kbQI4IIh71xmFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467714; c=relaxed/simple;
	bh=TWfzhxo7/xMmuS2MmQr5q0gKhU/gaJMPano50ie7PP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSj//KFKyOIq6XfzDbAUqNwpUnc5Wx9VbmYjdNZiDmJc9HgFAnw9UnbnOkXLEV6Y3jhqo3zSsh2EQ3f+BGT/mUhN0MTa3EQHUMkxNS9w+1OkbYnFJtc6Skmsj6i4IdUB3cUQE0XH7hEVKySA2golrZx+aU7lZcKP1NyZed8g2q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtJEZ0/5; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtJEZ0/5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a2dcede83so123335b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 10:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786467713; cv=none;
        d=google.com; s=arc-20260327;
        b=sNl5xN5Ouph7x+ErlvkRL8dF77b5f2YaGtbRILI+75Za8IBumSFe9hVDf1GYvuLEXo
         WwjnzgVgz1mO3xaAnETnFAb8DjZh984hIMObBnPbzYgWjAlcrrB5/sAJ6OHR6f2O8fDz
         jaWZ2tXtJcmwbYLBskMpa7nclPAS4NQzutiLO65Hve/fxVFILUw+51YUXhIAzYHHh8U2
         EV5rzSOC77KerlzU/KZQf8T2AkEhN/A+nuhGFwpVcBK/wFwzkWJQsI/pvU73NsnyMfKf
         93fhLgjFHuRL2PYq/jAT4QC7aSolPL+N7iQ5pHKB91AQpJRKbseFIMG1aEp7bQmdxr+p
         Ng6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TWfzhxo7/xMmuS2MmQr5q0gKhU/gaJMPano50ie7PP0=;
        fh=FeB4B0wlg7deUb4sxfVV0kfKT1tnaeYpwCbqaOlVIec=;
        b=KNHJ/aPrQql30Cz11oIx75v0Yr1AUNaya3PX+oDx1i7CUGrwvu0dWaoq7NKKzrGMgu
         mkXyzANbBCYWK7pRFFYyXIC7+Wq+Nt3tfhyHDamk4Do7qWC3foZ7x9/PtcpKQDmTZxu1
         TERjWD8/UtblVd7L5chNgTn2ljYwGCfGV/elfCarRcHTjDgjOZdVMuO7DA4mFxvT7OZs
         nKjsNCEump9uQNyNlh2c2IrIf2ZdTWysk0At7tApwEQphpjNYP7B+vSmyJhXJylhA4eC
         ljQXggYnAI1Ey3WQ4TctW6WeL0Wyi8ZxBMmuCPftIcjHsnAg06ep0AQ9v55We02ADrrG
         j3Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786467713; x=1787072513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWfzhxo7/xMmuS2MmQr5q0gKhU/gaJMPano50ie7PP0=;
        b=RtJEZ0/5OnkITtjEBqHf0h+6Crk79hhJvIu9t7ySbRKDbfFtU35rYyGynyO8YVSJUh
         k0Tto15vX39u+ey5dRL0z593lRkR0DBkmso4vYmEaC5TEF8ulV+e4atb4xARQVfA07YN
         ltqXabmwV8jJRSIpeKeGuaWTq5L4B1UvLPuVvRYQhR+DUy5SJYt7cW6SUuY+btVC3A/B
         NkwzDplBHpdsIrqbrC7BfC0hcEFWgVHP0cyb90pZHdcfuVqm6z88YiDgw9Go6KODnxZ6
         YXkI9+DtK809ylT1qRD2RwNhYir7Hyivz1qoVNfK9qXL4VDq4xpYRsCYvCA4r0wUFmRA
         YfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467713; x=1787072513;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWfzhxo7/xMmuS2MmQr5q0gKhU/gaJMPano50ie7PP0=;
        b=n3KrIHKGoEtbaGCOQUK5pcTZjjVcs0130iWrt6H64XYOmkEYwdqko3Tpe0CD277OFJ
         xTn6S7K77jsOvfHT67xDmRFGfSFHZZqjxVunpkSXCIaB0UWMIgjH8m7bJkJ9iCI5btNE
         /Hq8+62Y9IzCTAe6+KftFcREZTAioKNaw4aCdbALuNwQpIEhgs/C4pyxZwp0xzzWmAQr
         UjbjdDYZekbFwgEHARUESbKANKjJ1fhxprAynNt8FpMEqxGevJb7hCwKxfdPYWx+VYG+
         /I3Gfx0A6BNuchTqotfm5b6jXBuQKPR/oWyaROtX1FY8TCdOty8cXZxebVe1XU98Jibs
         lARg==
X-Gm-Message-State: AOJu0YwQrkeR9+ZHTZHeS7JPSfvLz7Twd++zE+ACT1Bd7b3dcValF2u+
	CAxBJKgpTfA78Ob8DDg15d4EiBkpgeV4Z3u3uIr5hQELa7Odr//TsOj78fQO1EhD89skekYtFQa
	q5qKu6Lku5v8hNuQ6co7as5UNTsbEH5k=
X-Gm-Gg: AR+sD12lFaRNjUkyaWeUvS6VYDom0vEnyM0Q/05VH0bpVXGbZ9vHiJ9CLh0mfCTcvek
	4Lv1ja0oepNefyOtHvxMjPwXS4FjGPjJ6ZjYyxw37vPFT8xvFsn4X+3f56Y6Lv+1wxrc8lq71i7
	LTjadQBLLIR9mUK3X3sldnWMH7/9jhU2bBhoBduOZzVxQ+E1yiszLKB+y+O6Db2/XzRLl1afaA/
	D3oec+sqdYoMUp7QvlfE8nMflcLvJnpP7U38LPktsQ/6AVGckIn3R21EuP61gahFF3ZEm+UoaRt
	+pW2CfvB1Z5MtcPNONU4Jf+RwZjxFFsCeg1lHjElBQ++fsw3fK9Cok3llwW1r7WVfjUAuy8QDcb
	px7ox2LKzY1gj+w==
X-Received: by 2002:a05:6a00:3306:b0:845:cd11:37e8 with SMTP id
 d2e1a72fcca58-84fa8836414mr5878515b3a.24.1786467713015; Tue, 11 Aug 2026
 10:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com> <anocR1F6uCdh4e1V@ashevche-desk.local>
In-Reply-To: <anocR1F6uCdh4e1V@ashevche-desk.local>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Tue, 11 Aug 2026 19:01:40 +0200
X-Gm-Features: AUfX_mzzdwhLUB_Ygu2ISlH2HoKNN70xUsEwlWxKIpls3MKE5UGi6bJj3xYuDf8
Message-ID: <CA+gq5JgkegYTNKD1dPcWRp9sYXoMDfa9O4=B2azROy3QuTszpw@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jorge.marques@analog.com, 
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com, 
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org, 
	sakari.ailus@linux.intel.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

> LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> A few minor comments that Jonathan hopefully may tweak whilst applying.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

thanks for review Andy

Best regards,
Jakub Szczudlo
