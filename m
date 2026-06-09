Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031A480336
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017966; cv=pass; b=OTGjg01D4br+CbrbOnxSZYsREmG/Vaku62Fj7hkdwgRN4+UjBlmuuM0fRUcecLHbAAX52MYbZN2eDZHyHRSCNWG4KmKQXwjjOnhyNIIxzvZdwpHtzch+vJ+boLAPZBi8Gy96JF1ckGF8pBMN0hf9bLhjVUGWEqPLOUxuc/no33w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017966; c=relaxed/simple;
	bh=X9eVTg3q4A9+w7vMed9vC45C1QriOE0tKD1LFfMbSvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZRE++izhJBfs2p5lm764RsiX/Ka4egqDGIQKmOeAnP0V8QYGkbvhsxgk2Kl9ckKzA3wg85CDKvxd06KgFe/uRxPdAXbYeFwD4C+Ah8knK+fZynOzDDR1zPNIx7a+W07TN+lwz5vT3vhzMg2u4TQjlh+G/AqHLTRfOO0VL02Uo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F61ilBoE; arc=pass smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F61ilBoE"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-69e505c7e22so1423034eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 08:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781017961; cv=none;
        d=google.com; s=arc-20240605;
        b=jX/uuz5nkx0AKuTWcXz8lGouEPXOh/U4zwD3YY1+g7a2FpAuvlQ3p7JOlVAj7jHGjt
         MWSja/AxR3vTSkfrr7XVj/zg4vcllWWyL5BjenNR+Fb1EE2CtIsGMJlkq+SSttNA7Eto
         WIMdoinZiLs/ClN8XbiHAjPRIFeFpldCFxetYPR5tr1xEwdJO6U84NKK6ruaEyG0rPA4
         lLxqghWiS+eBVuKHdeVahPT9+hNmxzIjGmJerh1mMw2QVDVU4n6MEa+VYMZLOGvHbn0L
         K4VMVXozWZDauKEoeboWItbjuzJi4jjV3ASUVlCnPUU/TQwFm1EIGGzVSCm+9or+Zd8a
         FIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X9eVTg3q4A9+w7vMed9vC45C1QriOE0tKD1LFfMbSvA=;
        fh=TXtKZ6Cevof8BP9rVfShJZGVISkG/f38x+qjUZ5MSRM=;
        b=IWkbW6nJiUS75ASLIlQs5M4qhmegh7HbKsYc/Dn2uZSaxB/Ol3OjnOqzZ47AwVVlKB
         9l2NUzV3Jf/jr/QQ5l+EifDXz/vti3FsCLmbaCBycCGvwkHy2MyVw18cj+sAwHOVx+lC
         7f7k5JkAAqAsXg1rD/iWXEAAYfiivjPzn+S3vC/tS57kePcnnO76qtvUgGu6aBC1Oi1Y
         /Kp3R4ULDtd4PQvkkIQwcKTMdUSJl+6W/y97VwXEMGzb7y3MEf8oRrQ1M98MhUksqA6i
         +n4oX18eztVqafi/MIwGlC7ohCF/j7YAY0A0eRzSRQEQnGnXz2PqC8jKiLcc7LTOwq/F
         yhbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017961; x=1781622761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X9eVTg3q4A9+w7vMed9vC45C1QriOE0tKD1LFfMbSvA=;
        b=F61ilBoEM6aGOA66mEU2uo2ybp4unvfhCiF51kx/pssJsKROTN0CQUvWYoGckxcz+9
         rEqSZo5IxXEG7DM4X455xH/SEX9w7qylVicNxoWKfmmtr6jXDlXGzwvSy2dK9mKzSSnJ
         i0VIWrdS92vYGa7k5stLbsBYNERxYw+CTZO8LydM1MC6qqoCAZ3tgcuqfipbOMjEGAFW
         6sDWNYUd5Y2hebF82YV6Y3uN1Nb5ZrMHo4hfaazWNC3iGXLHQjAW/UN9zcDVISBpNO6j
         8hy7aadWQGeYcRiVmjQ4lxCgohcsELcvk54iEuno7s/Q+SpOx97qe9BfBQz6Dls6CtI3
         3BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017961; x=1781622761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9eVTg3q4A9+w7vMed9vC45C1QriOE0tKD1LFfMbSvA=;
        b=AwReKsvA9LXU6JStb9Vp0vDILtoxO8y8vLSK24zAqrJAkwvziXCFYF0y+Y5Ofx5t5S
         TEivyR/FyIZLe0RyEU56VBB4bce1tYc9WilViBnic2NA97QiNyweFuPc3jU2fSpE8KFr
         3m0JxL3pooDzPTI2jYMMzemP24CPanUUVPuvDR3pNhqOYCnRAa8jbhWjNGbF1pTJN3ZV
         m9mrME7zvCg42KpthFahxTu1s4OxOAVF1fgfjLXTwQPOrlgDncCOBSLZVA1iBvim/CVO
         T8k1BePFKi4H4YJOKAbWRMfN5kNKyyaTv+8PkxEgFfobw3RS31Hj1eXjHIQ62A6ECt8R
         kSUw==
X-Forwarded-Encrypted: i=1; AFNElJ9Fn/zsFhvv918BVgeYx0IeXjVc5mwsUTsK5PeMRBAMeoUUw2irJdr2XAioyIDzGrgk9wSc3HLyRkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8Tu1kzI+FsSNQQclsCOa3Zc2Q8w70E71wmpQnzHyZizpkC1d
	dS5qbOhjstdAUkB+Hm0PZuXSeGlJ7CNA69eBfIBMIkuBOIXKi1JFtH1wKRAkVhhVuVR/OeY7JHj
	C7gU4gKVSvTC0JXdwOBWm5R409TlwXjI=
X-Gm-Gg: Acq92OHjGRP9AzGM51Qdgzm7CdaGicUvH/YUeFkoJUonQ2E6ig55DYpXkHbjd41+cTf
	CERUTcqPMW1nX2jhIIDx8sGgyKTdFfha4SDYPqo9ruqAuCcdQVBlSbtN43fThYm42UC41QQ3zmT
	xBlbxiJ6xQfkovJrfsjD9l9YKSwoCQTteEq52W2qI+PyTw2Ap4aBhlPiXwCSlyQC50lLSzNhIal
	lVcHuB3bXORqQ18zvOZF3lGph9Dt5fqXxvNhPt6FxAc3oDB03mQlYbJ8QWEgukYY+jw0sSH1xRf
	HboJodJ2mIk1tBSMaJTU5JVZa4B7OOZ2qIJiRuN+kQP3QTQkup+t
X-Received: by 2002:a4a:d111:0:b0:69e:2f0b:a5e2 with SMTP id
 006d021491bc7-69e68c26f7bmr8780350eaf.34.1781017961486; Tue, 09 Jun 2026
 08:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609020116.88462-1-dennylin0707@gmail.com> <aigmtZixUUgv0Y0Q@ashevche-desk.local>
In-Reply-To: <aigmtZixUUgv0Y0Q@ashevche-desk.local>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 9 Jun 2026 08:12:30 -0700
X-Gm-Features: AVVi8CdyvLsgWYgfC_wch5zgXpJlHCJN5m72XBv83vZWlfimmTWht_lImEc2HQM
Message-ID: <CAGEkeHf9c5dOMJbryGF7VW-TaJRXOrkLRs5oeRH21fv5ybCGcg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You need to slow down. The comment I gave from the previous round still
> applies. Now even more, id est the location of new header is chosen in
> suboptimal way. Always try to keep as much as possible headers sorted.

Thanks for the review.

I'll remove the blank line.

Could you suggest the preferred placement
for <linux/bitfield.h> in this include list?

Thanks,
Hungyu
