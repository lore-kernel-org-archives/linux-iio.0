Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60A3C108D
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812999; cv=none; b=X6LFJP4xZAlqoUJ8kmJPk8fnExkPxjCH5Vv9Pc6vJv7hNLZV3TtWIb5CQavPGHGbVjC2sk0PLn8LD8TAQWjfH7Tg0AfiKcSEljPLGTh6lin37mqbYqgWXjta1XA9B8uIgGHK2wvdDR3syEIV3MZ4kflXltOjJ4w6rSJKuh1x2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812999; c=relaxed/simple;
	bh=6QHe3gCwglIjK90q6m6GkJpBsYmYtm7uNJvBv8QiNOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddCSlFoKqIaVyfZKhswOHQHOiTsZXhGc5mTPw00Yib7fCEr59dIH+9l5YFwNVk2hmj877V1LtQFemnWAVCoV7uM5ItbD/CxvmDr4yEK+bh11mL5vn5OYein+2Yd01v8z4gpAU7pMdeQeBMOCj1/ZYy8Z+akJa1J30PbGlLqKCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPhMzjg0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPhMzjg0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2a4e013a44so277218566b.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812997; x=1792417797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4q8tx/vqsoUyoRGyu2AvHT6woUinvEI46vsxfOxlvRg=;
        b=iPhMzjg03qo3VjzKOHMnYWKB6CCotLGA25LVgnQrXXRmEaUqE7KTvQ65WdpFkCTEdP
         ef55VPVpXLCMQuMT2KZWvAWB0gsBSQpAbIupzVvAMgs7f+RxgkcWcbBazaBbYzkqy4YC
         rRn1GT22Sh3SskgRfEd8sUpI7GCA7Fp3zTuYtPaw7176tbJCY9uXoQDRgKNulyqpBDyH
         t5aLoZiIOCqi1A2wzoJx3DRQVXYt054b1UhliILxcucVCtdxkWa6cc0uNr/tprQI7Lkz
         FyLobfesX200aht6EBFa1nlkG7tCh0sjnTLByMPgYrVZ8X8Y2G79wipL1uK90jRcbkUr
         +E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812997; x=1792417797;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4q8tx/vqsoUyoRGyu2AvHT6woUinvEI46vsxfOxlvRg=;
        b=KpPZl8iXKsbBdYkoDI8DtYGoDX/PHs0eQXDPHuPIaj6k91H4+PThKulbNJrZxJB4Ii
         Yj4WdH0rSpi6zxMxeDGq6cHg6bsANXeIol1RER8QrXD0dJ0GtKVJeZPsoo1E2AfLXfvK
         l+ERdy74ScpRj43VV4oRGmKmbJKZ1aaCyEspZKThqRLlOt28xpeMG1vRbpCrdKaTfi3F
         kAa4T7KNf+g+HXV701OIO3TUATWWIYXzUdEaautRsAh18fMv1+Yftknc8Rzh2PBNJ9KD
         7OsMZQhShoeNNuz6aD/Z034wrnoh659vfBJum7ZcqLQ6QtAOFroY2iVo5tQNVi4rlwrO
         3Lkg==
X-Forwarded-Encrypted: i=1; AKwUvBwzai46rJVtfvFHgH2d2bwGZCv1gMzuUSBMUY5DdVHq1vLv39e68lXFAyyqnxUWK1/T1lg2nEgekWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzskKqBRmsKz4+8jJvKihd94CUg3kjqlavs1MditANlRhuISLP
	gjJ0/myJiiHSV6on0u8udhBQSrlaa2cM5XRhmYNlp3uE5U4+/yXvhpaX
X-Gm-Gg: AYBFou0ZcqrzuX1QijJQIKoF63r/Ul8mxV7kipaNE7167VMPp+AdAHvAFG4b7bATGGY
	3tKBOS9UeNemwwnajuAcQV7lPxR0nM+tagiORJf5mHU/smV7/kegWnR1ZhB4nSqpA26Es+G9YEF
	OzmQ/WfAxTHZBk8TlDxblnDiIM+bl/TECl9V2IDAU5YWiOAP2G43XJu/AQBotnmftO5Lln/h2u6
	4kjftFdo9qjpNJwHR79zYsUsgQwboELTOOIKxdJ/KIeD/x7+BLWk66+ySNCJbbcY73Ow9kiAuW+
	9HIbaiqk2THbvuR5PlrNyFQ9kFzN/Ox/vpaeoONeedaif+72YccYEHQdwj0mXYF3/RxVSUP0Ngr
	U6HGHRVGzl5ZQVJtrBho4/3E/j0I5hKdT1KwuWFqH3A5Cu1cVf2mlTM87Vz2rgib+BzvHzwfuZn
	G8A0HIH1z3qM3lx3GtJFU2szLQSCyBciQFFH3A64o9M9v6ZHkhK7mdgP05bepZ2YvoyQUeUkw06
	4yKpg2aZXLRXHQST71iVPXE707IAWE8tyrIxRpHPFK0gihp0uNYZ9HXPi12NPcg4qy2uFb5LMxB
	f2AaLos5pWUr+a4xEZ3Ik7QWBtmqlUR2t+0GriQs+cFGmZtNG2aeBvbDqbvNn6jhpS/septfNxj
	XotrjWxNa4vPd6BGdqPB7ClgD36j18XT1gMJN+p+3KrXXDWVbTp+Yf5sy5YBWKKw6dppG0wOGRh
	XrCeIPwVRJQfxEzbU=
X-Received: by 2002:a17:907:8d8d:b0:c26:306f:289b with SMTP id a640c23a62f3a-c31a9b0b097mr807813766b.13.1791812996554;
        Mon, 12 Oct 2026 06:49:56 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9aac6a4sm19827476f8f.28.2026.10.12.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:49:56 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:49:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Radu Sabau <radu.sabau@analog.com>, Janani
 Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: iio: ade9000: document ADE9039 support
Message-ID: <20261012154954.000075be@gmail.com>
In-Reply-To: <20261012111342.48040-5-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:13:40 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add the ADE9039 to the list of supported devices and note that, unlike the
> ADE9078 and ADE9430, it does provide the on-chip dip/swell events. Also
> document that it exposes no total reactive power attributes, since the part
> computes only fundamental reactive power.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
