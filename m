Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE82609E3
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674784; cv=pass; b=ED0yOL8B0+ZLPfGYuX92JKbVMknKuT4eAb+hOUMWJg8T9dnIdvczWzZQVKFgztesdG1WfHJ7QphFRnClAc263SNfkTdvvZdozyyRPm4GHgRBmVXBIl8O2AryWnVvux9epC1ZxUdY2M8ONInEJRqbWNlxps0cy6VnvB0w3TvV1xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674784; c=relaxed/simple;
	bh=GeyY02fXXLqYni5DO6cTHveG2PvdWPCsfFeQ+wHiVvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuMvSgD3ZJn1YOi8f+5vTYGNOmrrzgp6NYRgayje+fI6GDtr1SX9gJBAX4HA1vbE/d9vE3FuownU51b/tMm26a/EGJXzzmhD26tvPveVRznjzc4K5Phx90Zf2dtGAkrL/to/NWi4ExF3FiRdaAE6mKvG7n3IcjezsQEeK4Zi3yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ9v2cyf; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ9v2cyf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30455f77e0eso4482536eec.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779674782; cv=none;
        d=google.com; s=arc-20240605;
        b=hoAxc/yxdGU2OKM0TBosUD6JqccNdVtdekCQIHkJq4DNd1bccuX87TofQoFSPbu6Lj
         lgs0qyqF/7IhNfAE5rlT58gn8HWOB6WvPmIviSCBSIDUlP7HHBBLUU1iJSIUsSyeeuu7
         0hAe5Ph1WqhPr0z6G8sULxJDaBTa0tgBMdwIxKCYnlhGQ1DhATNEG0PswstSIvZz5CI4
         5Mdzn/tPIPoXUWgMdk58410fdspTXGiFsMbdksQOgESsCQ3iNmbb4wAt8GzJZ0Iq0wsc
         TNZWT5anW7kU3mVVa4AldDvnTyOrUYiiMP7CH9kfPdUQTabfYlavfscEaBC2wOTPsGhB
         cSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GeyY02fXXLqYni5DO6cTHveG2PvdWPCsfFeQ+wHiVvo=;
        fh=DMmR9ORM7d7n9BYqNsVdrtDemwHS+Sz8VFTPUp389Zo=;
        b=cAm/1hnglVws/By8DwHLQeqmHcDUr6wXxE5O9q+zo6OSCvb+8IXiIXKjnWw7J/hj81
         XG5+9fsHJsb6UL8VBiqPCzZH87k0t7VAp+6ZfRA1F2P3k8bJQ7IBqaWsFV6cljOOgv9T
         6dv3Vdq/TW9nQcRnWXlIV5zf5uPCdv9fzEKWcq9s1P6SRrfdzK1hcY0nKWkbMGr2Bzu9
         QaEQesViLoz7SbRll6NXAnEpqmF+QfEx7Li8Zu6sI+YuARihWMCYginPJy8ahT3RI+Ju
         OkCcpRkBsBM+FgGmRVnxTZvNV/AyP7hwkR8GsG0gcRdCJxhbASZun2Qf57GvGdmQ5ZeI
         estA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779674782; x=1780279582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GeyY02fXXLqYni5DO6cTHveG2PvdWPCsfFeQ+wHiVvo=;
        b=hZ9v2cyfcod0bLgAV20sasR4oWfV55bAMpK1Sy5wbUZp+QX9TMOAhOlAI3o+Xlz1MA
         FmyLNEkskFnQkoNIPlzfNV814PTYGZfvEhSPP0QylnyOQauMkmLxfnQeBBJjzilHP01s
         VuKiZK/mFDi58i1wiRCYq486kUBpGO8CCwO6XysrTU2POeb3EjQy2D899odf2quVH0hq
         dnND68L9OAO/fTax+yTEtRiR67Whx3T04n939mhN8QwvLvCubY7flBE0yENjhEOtFK0T
         qydfBbBaczgWUzxLxuQ3WxCXr/5ZJMETtwpbAorJTDabPqaR4yPBrOR958zuomzHFijE
         Lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674782; x=1780279582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeyY02fXXLqYni5DO6cTHveG2PvdWPCsfFeQ+wHiVvo=;
        b=DbVk/dx9MF4Khae5yGTklrzyHr0bcP0SEsHWff6X1Xw3EQzTEw0udvzROc5EO7o+vZ
         Z3EGNf9nMdlIcEWjZW9mh1SxSP0HQZdl4T3s8au6zTxGqUXOxQ/wePHq3wf+Rmk+Oaho
         h3XT7uIraWAk33Ri84wItrW3KLzpoi+CgmW0Y5GrYjXxB92wMHZJbq+dsZREq4fqIhsg
         ZDwF96StxguZzmlgau3HB8IikR1ZYDzgOI83WTChJmX0wwkjJrwiOV0WZBY8CJWPGDF6
         3dlPsT+fZMbJksnS5zMy1TvRlAkqBORjSx/ALbqvHbZwiwMNVY+3gi38i5xATHnXdpl1
         dHOA==
X-Forwarded-Encrypted: i=1; AFNElJ+gxy/U0xc1pMNwBdidKgqqjBrPe/DzKMontX+8pSpVRHuXRYqVHEDv6iq7LnMFEITRU95Ot/2oHHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylcvn39+CFXTGi9Yli7TWur0tcM3mbUdQtXGRHuWOSmBDiCaQr
	tIPlILoRqWpI1yuLJ7MVZunO3g2txqllPKuEZGGd/N4oTU2J0u9pIEEXtS4mCLVW64/gu69v5IK
	+tHtEMYHImKE6bhLwG51KAC9cLJn1KPkus+lHcNDb7Q==
X-Gm-Gg: Acq92OFAqJ8iarloJDN/Z5sgQ1WlMR2E/0m6Gat7ymx52Wk6D/sWt7peIooOtF6f7Fb
	NLC/41Su/2uGOd/2IkPwhul+e/WS1XuTxxV3AJtZO9RoU0PhxO4IGhiKpvTVGqpCXy+fddbKK7M
	6Z3Pi7kcEUuSVGqy7e7UsWtzRmdSImVQXdqRruvAGY7yjI8z6t1goZy59UvGjjhBdrqdmxDZBg6
	jvNgEDfXGxuD/MsYdCRNdsclsb6tUCBRJJFyqULmY1Q3veVoniYBxfefKIDA3IWpPOeyMBXOFuq
	IVMdV4ILaRdYuJ+yw1Ws3qfr+ncRMofOcjuEUogwMHgsVNCaRyMqp4g6PRmTzDAJRdNnNtRC7JH
	ynktGzQ==
X-Received: by 2002:a05:7300:b214:b0:2da:7e33:9261 with SMTP id
 5a478bee46e88-3044919c02amr5953161eec.27.1779674781835; Sun, 24 May 2026
 19:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-2-kimjinseob88@gmail.com> <20260524-tidbit-shorty-a4754de1db64@spud>
In-Reply-To: <20260524-tidbit-shorty-a4754de1db64@spud>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Mon, 25 May 2026 11:06:09 +0900
X-Gm-Features: AVHnY4JjCqQC5U3akmZsfslS7rD2_33BpSSVrOHsueQkvNsMYUl96ClHBKJbwlA
Message-ID: <CALMSew+Bn6dLxueL4AdLQEkC876XUFGvp4rSjDBiAD26JiBaug@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/7] dt-bindings: iio: add Open Sensor Fusion UART device
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Most of my v1 review was ignored it seems. Please go back to v1 and
> respond to the points I made.

I missed the v1 DT binding feedback when preparing v2. I will go back to
the v1 thread and reply there before the next revision.

Jinseob
> Thanks,
> Conor.
