Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208915;
	b=I+o6CH1/mZFGtNl2SzVC1jkNDMCgsuwRLdLvGbzu7EU4XvP2jnN1GJ2M6RXzBm+qSQLK
	 9c1gfgqWvGrs28ZcvGYINMgS1lFcUd5a1R3eU+QemNJSJI9HXepwvgPnM1zul+TZtBFAQ
	 +OphL9gEN6ThDdlPTQRtd85WKw8TvuNytap6Kz0gbd4yvBbdzVrmWh7ZkJL5MZGQF8y0a
	 Fe4kX/fAsPmXB97G1yUIvblfplfgXpF3CpEeouMkpsL3UaOuSZMXO5yVMsu2zSlumnYcL
	 4q96Zp35l71MdWgt0ic2zXFhEb4/y3B8JFkJYkhdRVpnExp3d//mstaMf9iXVOC61cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ATNZbk8m3Z0iLvwJh9R/0PDOsfgpSkjXKD1zTTxPL4Y=;
	b=tMXoiphF9kPraKdte3MmQ4XpA7mMWYVbGpYIxF4O/qyjIzT/FhaOe2xxfNb4f+8ErAPs
	 8gR7fVk5R1U7TtUmKhrfkX5p7OquzJwtng5mwOc49rh398syuh/+EKrggGuZYOyhUlzU1
	 UkWuZ00fSSm1eRJTUOkrwSv5PA7TsYtJ/v86m1HAH2L021bHtwjrBR4jBoP61/aMIQJg/
	 N1wSm41lnM2Yjvejrr901wBCboxHGGv9iQO6nOZVmU1kSUDdQJ8CPln1AL+MNpcziW/U0
	 bA6lAemQBurvyZ7ZG+YX8J5NBzWDnTMAwR3gIyw7uVoy7ByG3Obz69STEi9VEl+fSRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1GPqjOs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E5606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 07:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2E5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1GPqjOs
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed28bac8d7so1866925ad.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 23:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208915; cv=none;
        d=google.com; s=arc-20260327;
        b=QjoEp6z+AAr8JR5Pq+6cy2bYM+vIbHyViB2dwhXH4NtY9HOel9Y60rRqqcjtUzn4DJ
         sq6gRxqZpT+YmUNKUDPpXNV94c2k7RVipwHbWiolhxWIC/dwWtjnSScHQonrckTWo9cX
         /fqFRHepRccMYLJP9AQjeH5e3s5KIh4TrX1s1yQw8Aeu9D3yWP5iqB1M/rNAnj6HN3Xm
         cMvjx2GLeyX0u+iqdXg2cRrzDCJTmlPPE8MnUl43Y7EEhD3gRxsE6rnecBRx0nxbO5VA
         QGNcr7BShVtCzEaFDcejk/gSQEFEnKD/OlJ5MhegcNbtBGcDyu8as9o7/RPWXPBnyoUx
         vFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ATNZbk8m3Z0iLvwJh9R/0PDOsfgpSkjXKD1zTTxPL4Y=;
        fh=aUHwDX/g+dFpBkhg55CuKCpSW19EaWH5NCrgBA2QE9E=;
        b=SAILUXsc5mYa60y1tG5shMO6zUqqc8RGHsH6PL7n+Y87bFH9PFw62NR+EaBX145roN
         sSpozNFf9y2CwEtu0V/UoNQM0VNEeRpZhcP6uGGdQ2FPK91adjOrPS/FIPrCOat3XVPj
         Uv88su/rPgncc8L3tO4SX6yISdGmrghM8dk02Jqwf2sZmimeVJIRBt4F+BAM8a6Ws8rK
         PFkJcGzzYlwrHpNsQqttfUtK5lU6INR7QYVYBnsNnqCwe8On3rdb07GVzFWSVycAzhfd
         4/xQmE4k6DktkO+i/GmPDYTlerKzAvNA9T0i4HqyktK90MEx0stUTzD5HG6MdLsCH8VQ
         FP3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208915; x=1794813715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATNZbk8m3Z0iLvwJh9R/0PDOsfgpSkjXKD1zTTxPL4Y=;
        b=h1GPqjOsz/tCFk6EBkO5pH/mtjgHWel9gZfd+qu8gEACM6+aVxjcC4cgB0DTaMXr5V
         X5IIbyloeJYMwGehY4hEA8S8UZoEAOF7q9bW7JjTPTbn3VBtRmaeel7qyKIrjeI5bFZO
         yuciy56WSdgN/E8qznJ7HEnuFOFSWiy9wqo5Rka6EjokAD3gg3VJUo03i57lLimHQUgI
         tJjpsnZr3QQLbOCwlmR3Fx28sNoGcM5lQyVewpABIt3+HEZ5t/GQVTgdL3mp77wkIbrq
         TlOt2eqcD/jCtPUP1U7QkPvTzZQeE8tlxS5DsVCxNm5kYT+ZJT4rKMBR5MVxeeK7OAuL
         /ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208915; x=1794813715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ATNZbk8m3Z0iLvwJh9R/0PDOsfgpSkjXKD1zTTxPL4Y=;
        b=cepfLc2wJY0Ubi5jyxlioBw6gEqEq7lncrEjNyjwoWCxQrRZmncVmdhf5HR22+H5KM
         vaekGx3F1nYhVwStlJZ3MgkbYGer4XI5GLro4ezkpepXORu77PoVQKsEOTdGnxxm+yJc
         k6mNgyhc3vGlYnGn03yKqmepa8UhOmixhpCa2YlifSi25wxEIRKiq9sRvfnnA6UOp726
         e9B1jebN8yOOT5vTMtJ480XWyPL2KicsOxn14UXg37wPS9IWl+zuFxzssZFrnwoi6FRS
         ABLqGbe9ERoG1dQVY6TyIV+bRWVThHLbuSUPwV+siFCY4PKeoNaAA+oNf3ktXcSYVFBv
         +fKw==
X-Forwarded-Encrypted: i=1; AL+hErEtVcqLqqeYYR1eElWN/OjcVXugnjNtdkaMi6vkwOzWSIfhW2ZTsoGYZJ7riWyneikZTG+AY6+KExc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B56SvsmLVjQI/RpSnIdIpm+VFF/Fyo6oFaJE7SCjIzSKzErfH
	XbOT1BgLRqtxRpfJj4jPzsL1iKVBlV/6zd1b78QnIa9/KIJcphzjjsXTAerwvVI+Ad2f2fQVSH+
	EueyJR+JfisJ9gfb40Zl8ORdxenTlk2I=
X-Gm-Gg: AYBFou21WIHwR+2GoT1Mbva5rblsDmHJUPAwCgevaeEKo9q9GG7nxDU7qbhQwClSlDl
	pKqG5Ua46DiZasJjmQEiMO27PAyD+Yg/yCaHFxPHUHQYu8xXlWDp0kT1ZKm4SM8OIKdkKq7rKcR
	sg803j5JmHy0YGEyqOxdgRqwj9DrSheogJt/7DtO85jGjR2ePOR/qqmyhWG0JQeUrFEiOEZT3q4
	EeI+GxBEplUiXagAPhf1XfIiYj8WlKA0mh08oxtxaNh6mp/iqQm/gsmdo2KcXkEorEZb0vFfCrV
	ZlmVjojkQb2vXb72lv03vW/3Bh/e8eebAx0+3QjPOwt7c9pc4+oVA59X/t2ifDIsZKku7um2OLa
	Pi++LIEO8ir254QXXHN00wJC4RrRIIaMuKLCNqrOlI8r35Ym2852er35xBT7ZG+G1ZVIcfgd9zi
	IE3gqQmUjzNzi5HP1UCA3iTXVDrEV0WXtNOnbkNPDXEly2vYkMa12LzRzV5opjQUcuiX+4ew==
X-Received: by 2002:a17:902:c40a:b0:2e5:cd0f:518f with SMTP id
 d9443c01a7336-2ed671fc98amr43058145ad.0.1794208914572; Sun, 08 Nov 2026
 23:21:54 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102100031.5573-1-phucduc.bui@gmail.com> <20261106193208.4136410-1-wbg@kernel.org>
In-Reply-To: <20261106193208.4136410-1-wbg@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 9 Nov 2026 14:21:41 +0700
X-Gm-Features: AclHuK_GvzxanApqj_qZEY7vEkrkEWr44FH_wFftNIfTWMnEUrAcqCHwPdCxRLw
Message-ID: <CAABR9nELsefCssH=KX-KX0FhvWuDO77WhrsdmChfaJyjpMhRCw@mail.gmail.com>
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to
To: William Breathitt Gray <wbg@kernel.org>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, m32285159@gmail.com, 
	nuno.sa@analog.com, sozdayvek@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi William,

> Go ahead and submit a v4 addressing the comments from Andy. Submit a
> follow-up patch as well to eliminate the ti_eqep_remove() callback as
> described in my earlier comment[^1] in this thread.
>
> [^1]: https://lore.kernel.org/all/20260604021902.891327-1-wbg@kernel.org/

Thanks. I'll send v4 and the follow-up patch soon.

Best regards,
Phuc
