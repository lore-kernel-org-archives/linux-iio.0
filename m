Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE462153D8
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028471; cv=pass; b=XleF8PWWi/5+0NLYc4YNaN34PvLCzb7DQtwl8n2xOTdtAIi+1bTXUFSM16uStqVyVsI1RIzJafquLYH4CiY77rnllLEu4b2HMQFpRYONNYHCV9jiFAwoWnHI0p18IqK7Cx0TTSmdrYbg9jow7pfk6ijj1zkxdS8xr/4DrTjQeSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028471; c=relaxed/simple;
	bh=7KsmXiuYU3lva6rjMybAth9S1VxLDxbTYiqhqCb4bJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxY3jDXzU2qE9qu0FxP1t7ri55LsUf6j2UJnuPOOweBULFRJvdrpIEoux6YcL6wopqJtdcpKH/GiQqkRkQQOpjAmz5Avh9OrbtmEg8Uy0Mbb14yjEqMAQvIlD0TA6KKBpJDm5DeoMKLERKbBOLkPCg9Gz89nRDwdP6XBx1vEz9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSB2b+Z3; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSB2b+Z3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bde9d73678so5421527b3.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 17:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778028468; cv=none;
        d=google.com; s=arc-20240605;
        b=XD1a1Re8vo5o71TYR0Gon7XGWC1avwJurdbPhx/bT7W/5gTUDALtLR3FDaWQ4JBCJK
         tTvPDE8dKfms/RWsu/KKA5NMWmttquSpKxctvciT5L6INPsLP5f5CmyXlTu1MfJnL7cj
         i67wSKPBNj153VEs8DhJpL7Uic9jmFrfM/RYh0PhZ5yXhn4hVT9IRn+W52Wvm3MEu9NK
         HR7bBy3iMu6ki4zZNsxN3KUb97APrAmDpCzO+SDN0KljBI9lUGF+MbQ8UksjfiEYCBgR
         ngoHtWHu5iZDJexIhQTbKYWXlng6Gma9YuDrabe0OAjMafuVQBpNW4t8E19dVzPi+gc3
         IvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Ku/S3D875g4S11QgE5jeWv7ySbgeXAlFjiNL1sVyM0=;
        fh=HXMStO4leeq84q73n9YvO8OBTIiis7UU3Oe7lYUfqi8=;
        b=KfQmJdkcyngzos2ZUQBCZoCC1x6zYWVVlPRLEnNIq2kqsTfcHwaNNigxHsdpKYeuA+
         QOgFvQkPWeYZWl+zTHTDFYB02XiYDBBoCvOuGrzJkISHbnlkQ9rACrnJaHeGiNW33Nox
         VEPIBsQddxKsE6gX7Nclri4ZoEEOpn40k+mD/DEdDejbIxVFYYgHYL/tV4RRRBzcaKoi
         TjtGgqaALli98OqPC6q4myU3YKGco7WMxk+Sg7uPoPKRNdImKM6e7Tq7zd6pVn3WrRQW
         tZwCb8wS27HHSsbiFlKdpo15STEP1buObCQlpCsKnhuVYNFqkZQoyQQbILoSm5y7fWui
         cW8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778028468; x=1778633268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ku/S3D875g4S11QgE5jeWv7ySbgeXAlFjiNL1sVyM0=;
        b=XSB2b+Z31z4x89WRiaY0F2HXLpIp2qaTtpfZAYgW8LeyjAYglhbiDfJhXtg8NBUGjU
         lDSMN2qiy/98L+zpw0RSzuogCTIxvSZnuz63PHjeog0ZHZgj81BYTlYz6zrVl9Hb0qGc
         KuMsWosCLkpo5+4uliBTHJfCvE3n9mPv2q/89NdCv6QKKKomd9Tw3SNUijzou0CHVhkP
         QeNkR3/+8NFZw3UTZnkAERgUHYzN/J5IUGhkBQ1ixNVfqco/iXScKxtdCUSUsJX4uQJI
         YbzJc1U6lFCNuX/on+Wk7aj0VGsRsPh8V0WENDQ+fPvPXj+6Tc4w8vNOhdAIqeB0PmQ7
         8aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028468; x=1778633268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Ku/S3D875g4S11QgE5jeWv7ySbgeXAlFjiNL1sVyM0=;
        b=S147oM/azwV4cpm3CCrMWDnu90FLJwtGXWox1nTBpKCT7qPs+837lbOJEKdVALikxV
         lqHIC9W13gi+qtUGqWQh/yx3NYvthwFqwZnUY+ukLa62au2OYUuVsP1c4+RkiZrKEOsN
         SxNCbgr5GLvpJxOph95PCAbnbexCUR0olvPTZ0sWc+uqnYPW78aw0aA3Oklz58eAWegZ
         pAiXKrn3pNHUA3HA2DVhSqQdZm0LEbt0QkR8YA0bFds8NvvezO3Yv8xiR1K8eN+5hccm
         cHw5ZAH4NRf+ofooyMyZ+wK6BUoaQdiEpmbdI1MtpqXvTztsX2oh9DtlrJ0H404wNgUQ
         bgcA==
X-Forwarded-Encrypted: i=1; AFNElJ+O8OGphG12v85ChJSahTILid9tAh4ygP8HhfMM/ycxsnb+xXXyh74gDkhjiV2R47prZIOjCerFVjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIO0yaCngGY/BtPhqU3t29mXWa2WYgOEfIt3i+iba/4By9vUv6
	B2yiyTTi8VYnvxxpm+0xOb62f1LxVTfbzNjxCudebt37zHFNPP0OVSLKK6m74B8G+fYXSMRfr02
	2gfJGC7C4VXEICV3hfND89Rpv5Hjf9IzU8IqX
X-Gm-Gg: AeBDievqkfwZNwCDktLxVPOMK+1Q6gZRb88d8YdaZaoJX0Oxh56eTXA5AGzy9D4liqJ
	yCYiaOM5hfpNxRKBinYIbzkavhqT+gVCTWHjoXUIF9YtanVVPGTIayn78XhtdrIzb8cJW+ynYeJ
	taXoGArm5xq2oZFkCa+37pW2CqwP+JPed2GdO6ykfeUkyZPEEKyi/pL+AOxxMRpyxZIGvXQZfFY
	QB9FdzbjITxtYomQWraja9CatxzZNX+x0NtbKBB7E2DnnhdZyEHi98K0cGTfCxKMX4WlYcxCjnj
	xGfxFxzFkKlKChE=
X-Received: by 2002:a05:690c:dc3:b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7bdf64539aamr13080647b3.1.1778028467739; Tue, 05 May 2026
 17:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com> <20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 19:47:36 -0500
X-Gm-Features: AVHnY4Jdx8IX78M02oK-M-nK0rVlXcKE5qMD-vvRNqU_2TXmYTJ1TBbGTfyu6_E
Message-ID: <CAKqfh0EcrDee64ioX=BnKdb2RWSH_K=UDZ-0pRs5ajzW-1G2aQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/18] iio: magnetometer: ak8975: change 'u8*' to 'u8
 *' in cast
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:46=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
> Also fix the indentation of parameters in
> i2c_smbus_read_i2c_block_data_or_emulated() function.
>
> No functional change.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
[snip]
>

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
