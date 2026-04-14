Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17E37DEB9
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152349; cv=pass; b=JSPYVqLGzHWECCrDzGFhBQWZvE450xy/M2/6gy0/p9AXxmxmFem0+was+wC13vrgEVgRRh3XfJQIGr9fZFFjio7KUaqr67bPveBHoQLA/41SdoQH+2cfkgJLROumNuqjNFQuOtCnXtkxufKeD4UmnlBubcj6RQRx4fTpF+iUAuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152349; c=relaxed/simple;
	bh=t7r3lxTrEjetZaLsluHhiOnddMgxjkv84nKScY6aTCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbkKNPA227jSJvhwJ12nJ995b/gk4hyvZNwj9we78p9qMbtVFBLbmwPMll4Pa6/ziZGQ3EbjHV0TLg0d7B/2djWRZDEri3Bd9iDVHUohpTPWjbQBVWrCUm2obeXLjsFP8DS9HKSK9ce9lRWDFybNSpqSuWiblojWlazq54n7B8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPiOCUA0; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPiOCUA0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso50017235e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 00:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776152347; cv=none;
        d=google.com; s=arc-20240605;
        b=PN2afoG3nfBIfM/+XIdWWy1gHTnKqISUE03wchm6uL+A7a8f6t1p683BdU2h5M+ylr
         cEzgek+x/RbHkFWdkID6rqwbQFA0Lga3Imk1+XWaiKD9uZxAV3/I7BF8InMtgre0oWLr
         JaDUkztcRwmbpvdvRao8pFRi+raqpjLSs+BJfgsGzEkEb99KxYfiz2WsuANM9lbvp5UK
         9W7jTw8yAPZ92HKU+zdFyKyyMxDxW5R7ulJuaOrjLfRQWEZJlVFraSVaDpQs4fO8j/ns
         ySpQSsW5zX43qJ3afFuoLEEttRJUZ48sJ8+C0KhsljRZh++8bEhn/NqhLC0oz1+cBgkV
         LnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IpvNRivftfD5pqJMlnLsY4bcCb88Mo52CYzLp25CDVg=;
        fh=PoTggb701i58+k83VxsBOVxRsqlvU+vBHv6Ba8wMNVE=;
        b=WrHGyfINf7var0O5ToDCEX7khSLtTj6zyqH04foRUTwU9wymcRCGWm8EN5CFkFvvFt
         UiYr4XfadP1y8YFchB41htJnGyNq4pg5q1sRcoz9GOXoBg7/7ycLvbfO9jUSzHynbkEv
         D+B8AKIC/Kl9hSJ8Agwdu0X1/3IaBUTf5w0bNB8jZZ2wyLAXdZewIE10reZfctvLCezP
         GzQHpXLM/DjO4+hd5lBjtfg+R8t+leHPW2irTpQJiqefF/zNpEd8uHMO0cZjLscX71GC
         MS18dsa23geyj/Ep8mShuEK3a/l8jrkfKj7z6d9JnIbhvUfPlcUKbn5TpbnN5HHeL6dV
         +BGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776152347; x=1776757147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IpvNRivftfD5pqJMlnLsY4bcCb88Mo52CYzLp25CDVg=;
        b=iPiOCUA05wEngPoPhsgokjnxPlc1mzezYciQKGKHtCSd3SPGsysSx7+cVHMVVvs85Q
         CgfV3g7BKqzda9+3APH9hYD3wMo0hA1nnv02e4PmFn5DFLKB+OBpBoiAiU0b+a+vX/DS
         Z57/1X3UoACxq7WOFbBW3vSCZ961VrfC3vPFeglRXSL9s2Q+8ju2stjGvgJqvfY9FDkF
         M2Jkn3tlh4oHT693lg/BX38060VUdBoYxm9mYpHE792yjNn1hso8SfKUPrCtCWUWI+z+
         YhEDlKyKiVzwasT4hrBnzdl3+e6l30/qm0k/XZVWQj/vjTz9FOqw62NWItODXsq+yoOB
         yOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776152347; x=1776757147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpvNRivftfD5pqJMlnLsY4bcCb88Mo52CYzLp25CDVg=;
        b=VqzMcI8H31h2AEwXXl01K5Wc3d9zbFc8ogD63o4efVDyaIM8iKo3L0uVzHw0TfJv4q
         UWv/J17o3/x2CWygkMJeQnasedYuavjj/QOLeSmFzauVH20SYaMwAMTmiPDhqLFx1oFx
         Rfrr9eijIGDD6QJGUJELxGUvQrQjpjSxGZe72/gKMjnZHfqLA0yIP8Hihqk2VErbdhjP
         zJoPVHS+OH/zwg9aw3vC7EDxr9GskASSnNsz7a7Qhp5J40x9ZEDC/kwrnRZdE+obVo6E
         XipVYR0MYyu+ekPWRVlgnYrMIw7UhrGdRURhkxphATR0pItAGlzW5b9X0Yv4ltXVEWml
         jvyg==
X-Forwarded-Encrypted: i=1; AFNElJ9wxsgD9Wz9PtGYwlbp2ndW/+k0+nzQVbDaxBT2CQJQU86bsmkXrAP5NpRk7foOeAY7n3RkLow+NoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0JyoUp84InBebWnAE7jnij1HZGmRi1BxQktHEHanDMzeipDl
	wH4Hkcq5q13oGwzLmGoTi3nNYB+kSykOntCiWHRJ81GbUf1Sl7FYM2yiMmz9tEQehYWiBQ5n5Tc
	1kiRFUXQGlGEFDlqhSNPtpkbZuQvrwLU=
X-Gm-Gg: AeBDiesN0R6Q/isgCNrttvhkSH2cefTmQV3hlkblZAW03VhoQfrW55wMhT31uPWsCJe
	Iv8UMI1B/t+mRR2OEacwOH7/Bywk43R93uI60f7qhUV6GF9AL/db0pbKbJhYFWfVBt9BMpI0OT3
	kpHrS/Ipwkkr5gmHeUhVGnVBvHyTfQ20XLHGN2C+W7+2OSpGHAEtIVDKaH+o5kFJA5T5g42X2Zb
	5IZjbG50VaD3ns6sICDLlVDq2wqIGqnIsbPq8DWduhUwdvlH+rqtMTrINVfLgkBY3JOeFX9VUPr
	fpUQpIAXVXj/AN2+9chQ7rJu15YxmTOc6zHgGKLz7cSIn+scXtBL+cQWYp4PBdFGJrFdRmoMtkF
	II82QkHsnu1vp4JI/vZ0VyvanYkkshX9iY2wO22t7PFbbIl7B2HNebH/w7aDJqO5OCP/uHIGSp0
	l7PaYi+Pn3zZsPJGE4
X-Received: by 2002:a05:600c:8904:b0:487:1c2:6a56 with SMTP id
 5b1f17b1804b1-488d67ec89amr167247895e9.3.1776152346459; Tue, 14 Apr 2026
 00:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com> <adokoNfP-Ueg4yQ7@stanley.mountain>
 <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com> <ad3sckiwifI5ZQYU@ashevche-desk.local>
In-Reply-To: <ad3sckiwifI5ZQYU@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 09:39:04 +0200
X-Gm-Features: AQROBzD91QkOqfIH_K3yZOcqgHtnyov5bibGxBE20z9q65h8n-2DYJYMO6uQGxw
Message-ID: <CALoEA-y4Uf+LbM8w+bMA7DdW0Pcpv7AVcbdOD9GknVu5R7TKUw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise math
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, gregkh@linuxfoundation.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 09:27, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Yes, please slow down as you also missed a tag.

Yes, I've realized that it was stupid not to wait. What is the proper
etiquette here if the
v3 patch doesn't have the reviewed-by tag? Should I do a RESEND PATCH or a v4?
I've attached the tag in a reply to the v3 cover letter but not sure
if that will do something.

Thanks for your response.

-- 
Kind regards

CJD
