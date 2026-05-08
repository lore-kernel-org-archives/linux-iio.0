Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257F376BD9
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256177; cv=none; b=WWxxy2k9Bf7PdqK1IFzp+O5nSJP2VnnwXbEO+25q1v1Qy6vqlEsACW0MtNENDjxQYl+0mRm9+lJUVkB4Lkb99p1ilPLzqCA1SBi7C+OL/NCNLJg4eKaVDsg5UN8J0NWV7EJpgViwaDZ4dYuidUnE7jzeqhhav9yF1o4sCUGKF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256177; c=relaxed/simple;
	bh=39soWo0N4Yj6sXK2uSFvuyS6lYjiGWAqMOxp0m10AE8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XqIb7iFoq8qyOKqCskleG2XCbo+BWSADeocxx11ERRqqMkTrWGjlIeYWUv94+OL0i3ZBoT9bXQnNz+dxYFC9zSNMlOWK1Sye2dugM/bE8hqRLx+FafiCP8eynwGv49UO793YN2v7ZIKdk+fcg9AtiyEx8ev0JIErxlRGWDadAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs8krQgU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs8krQgU"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7dfcso22498807b3.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778256175; x=1778860975; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o3nVBrC6L9H/RVYpMEYGhUOr4iFE+C6Tvg94gHGLP0=;
        b=Zs8krQgUgHscF3o/4OyKTku3xKJyJHXr5Qv1ow1VbDjpOAJIpzIWX9Z7P/pRIX5HyG
         3sShfXeCOLmX4Ufhgc5wdWiy/E/DmK5MmgTW6oysjh5lu6Ga/7rB/X5O0iOvxRaMgwp7
         364znSpl9VxGFlK9tuNsZKCsVewSbrDRkzvUYQpLP7pTvYHJSlpObv2e7XrNvnurEf99
         AyUyslqPAWeh2960l0TTBeAvBV2K5lV2rLEXsRzzLP5mnhIiH6jHZyG02MfvZKrZnTsU
         kdC1xjT/S8DNcILLJsAR5zPIm+k2VGX3cE3Ffjt6VA25NDEWLUuU+4WWglAYYF2w6qM0
         749g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778256175; x=1778860975;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1o3nVBrC6L9H/RVYpMEYGhUOr4iFE+C6Tvg94gHGLP0=;
        b=XPgP7oBQeqGQ9gAXqlLEGtZ1BM8prpUiKIJq/coL7Cxp7VSOa2XBy+Cp4Iq5VUHhvA
         5ofkA1U/bY7z40u0skB8u2HJIne91g5faI4WyMlFSI0jW5airDvwITA3Dmbg5e5KH+cz
         ZDH5cd58LKJ98YPzC/JAKZS3QWlNiX0nFu0QKJaBS6vXbtMNEUcTNdZzrE4aCBpBDfD4
         SeczFbYA3k6nFh5m8SJH9RXMBGTVqO0IG8G/vOMt7cekJMvCFaZ5wh4W/yMwnFg1DT+a
         hXt+tiOCxcceXUeMyViaAksspqMD0sq4lXKTX2oYGNiLl16eYESj0xmH4RsrUp9VKcmO
         56og==
X-Forwarded-Encrypted: i=1; AFNElJ+Kw50EDZfvxOj0Ybm8RKHPFVVVf9Q03RkVv+C195zfVTZfqGbF1S2TwoEE6bsD7aH17DfmZVDrVhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+O1vFfSl2VFXzHVeP8QX+m7q1OFwicjPNQFII6AOJXxT/fZmd
	ecm0xOk9kbRxLa9ywfHnPg4f7fY5Gyvm29+hmnyHw7n/2KTL6wouHE+H
X-Gm-Gg: Acq92OGdJe+PlwsMDbP1ooCl8CQlhzXZbFlYSKdnEGixKpe9H7cg25icdmG2jArnm2u
	xXxQRgHovHAjBGPfulKPZ6iEu1nA0W93WkXhT0/0yO4GdgP0IS5z8MZnCPgdO0vP1VM1ZklWuKD
	olmWVc3E/u2iAfOO5qRySfaWX+oxRDyiKFRsFXuMEUApH9xxuHhvnYV9UZpldAjC+/m6lZRYzKc
	HAEaLPVYnin2cy0Q8+R2GN541YF+UAUtwNFnWZZoHiJB+t9hdlpOKK8VVeVFnxBKZaJ1RT9C+uf
	VcysGI5adbY3h3weXMKpgNBze92im13DA4sQnBQ0x3oEnxS6ODTXdO5wdUQcXVZMBS6lr7QK+2g
	UXc7M9ASTVenYWTMzrbsHFC6oZG2uH7rO7OXAWVVI0qlRi1APqBEDxUj0jWRiOIlaJ0sD3loqGW
	dQZg4dtJEt77LHIm/WYnf/Q9FjBanGhmTKhvrzeBmplc9M4yiG
X-Received: by 2002:a05:690c:c504:b0:7b4:6f40:635 with SMTP id 00721157ae682-7bdf5da8d8amr143542617b3.16.1778256175066;
        Fri, 08 May 2026 09:02:55 -0700 (PDT)
Received: from localhost ([208.185.137.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm107944737b3.23.2026.05.08.09.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 09:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 11:02:53 -0500
Message-Id: <DIDF7CF01QK0.38MS3JFMU6RPL@gmail.com>
Cc: <m32285159@gmail.com>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0)
 in scd30_i2c_command()
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Stepan Ionichev" <sozdayvek@gmail.com>, <jic23@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260506181533.409-1-sozdayvek@gmail.com>
 <20260507152800.9062-1-sozdayvek@gmail.com>
In-Reply-To: <20260507152800.9062-1-sozdayvek@gmail.com>

On Thu May 7, 2026 at 10:28 AM CDT, Stepan Ionichev wrote:
> scd30_i2c_command() takes an opaque "response" buffer plus its size.
> At the start of the function the code already checks if response is
> NULL (via the rsp local), but the response-decoding loop after the
> i2c transfer always dereferences rsp without re-checking. With the
> current callers in scd30_core.c this is harmless, since write
> commands pass response=3DNULL together with size=3D0 (so the loop body
> is never entered).
>
[snip]
> @@ -71,6 +71,9 @@ static int scd30_i2c_command(struct scd30_state *state,=
 enum scd30_cmd cmd, u16
>  	int i, ret;
>  	char crc;
>
> +	if (!response && size !=3D 0)
> +		return -EINVAL;
> +
>  	put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
>  	i =3D 2;
>

I guess we're still handling the cases where both response/rsp and
size are zero here below?

	if (rsp) {
		/* each two bytes are followed by a crc8 */
		size +=3D size / 2;
	} else {
		put_unaligned_be16(arg, buf + i);
		crc =3D crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
		i +=3D 2;
		buf[i] =3D crc;
		i +=3D 1;

		/* commands below don't take an argument */
		if ((cmd =3D=3D CMD_STOP_MEAS) || (cmd =3D=3D CMD_RESET))
			i -=3D 3;
	}

Should add a comment showing that this handles this case but that's
just my personal nit. Not worth forcing a v3 so

Acked-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
