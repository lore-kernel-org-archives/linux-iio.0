Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B743B71BF
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747878; cv=none; b=MxpK9YQIZz721bu3Xn3+fEYt2sA722ZNFZVph3PjpNQGBBU+CE4BWUhZ0rQsSvV4NywPhSKf+L6hNeklQZwvk5alnNQ2cVxVZ8THiRdHzGSWaj0y/D9IOQyep8/OFf6Ck9mLW7mUOZ45xUUmbsKY/P5DRO+LCShWV9/TqY+2Z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747878; c=relaxed/simple;
	bh=dUmgHrYBrU0MbudthoWJ97jezTVWfvaTfEY+dwv4H1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwUhptMD8JYKkVrVUT0qgTmcIJrda7ZKhvBmb294+1Mt5cwtgfbazdG7s63GOy2k4Xti6xX3I6vEQliu2kj1x6x+m8cNrUwL1s7bfiFm5Qd5Le3z+RJuPCY94yAoWWq/Jq4v7S9+18Z92+xE85tYhkYWTMcLC/skFrQjQTdahbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhZ1uvSC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZ1uvSC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so2175923f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785747875; x=1786352675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JBZkcb1bi8vW7XgOsQsT4TT0Cl3XtULhwjsjA1+wxoI=;
        b=lhZ1uvSC8/M2jIEssFTWEynEoj9QQzYiIozZUCcye4Ttl7aTyuctBiEUHbmXH0wRZs
         R9XtMzqQWePJFRvr0Di3YJVv2Nj24j51fUqBcFQ9Edr7MBmA6gA4rLABdEZY+UYTy9iS
         ioz2GANzNZFRKAe3xactYA924Teq3RVl0OyDkE61U5p+80GdSGThU2n2HwaKfS4scCOS
         0dcLwU/9k5KVeGvExrYt+ldopxkN4LkH/MDxsl2QC2ZdflcCTR5tm6KVXRBwUpe7W4HV
         2WG7A60dAb3AquTBLNLsadkjAQkM4452lPqk0KYaCtJ0xoefa/PO3RGvA7D43yojnrEX
         nxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747875; x=1786352675;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBZkcb1bi8vW7XgOsQsT4TT0Cl3XtULhwjsjA1+wxoI=;
        b=aialX9mj7mCWJ+/y7ih4iTecPQS/vLejExmEZGyqTH1IVs9kMljrHwt6GsEJKQiAnG
         XdzZomLR72EZKIdULO02h/qImWGuUvwszEi3GAKXEWvQuh5QeUn6CsTi7QG/K2C7Vdj/
         64GUpSognHdpz/zetWSyQt9d2vn4aCo6Bj+5MxcvSHbVc8ds3G6X9Roa7fw3leu4Jymb
         pp03POpSWZZLUqAH5ijE0Jqa3SZw7LJGQfDDzP7JqqGSBO7FlL6GjnKShKsc2XkE74Ex
         iolqrNSeN4wsNzvjeRO2cWl0WulSzWdU03wyFzNIYVxKChwEOTA/J+on/574mi6EU1Bm
         TRNw==
X-Forwarded-Encrypted: i=1; AHgh+RqgUqI6r/pFfu+BUMdoRvDPKlh7Ih0GmllgB3a85TPJGdKxzYqIb1KiKV5sNHL2VGvj3+YWWVENsI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4OYhnf2yQLpApQQYMtTEdb1Tx97fAlcXUn/7PHqQKoPQt0Z7
	4emsxA0k8RAzv2xL3Uw+1v37U2e1JCasNpZdqgGr7t/6zjA5VplxCTjf
X-Gm-Gg: AR+sD11B6l3q8E02bksAx+K/0a1CfLDcu19445zcWaZyX6JH7VlVUzyQqsUd3Fw+x3q
	7ctG1nXu6HCWovO4regDGJmP1N30aM45A5mEoUb5QDTydYhdciKsXmy0iaet7s4DjfO/1pt5+gb
	loXXjYMXxeZx6GuEeN4jvPRnnhwsEzfjPCDtmHSHEWjsp7e3cBQVrinTzfPCsIXhYVRsSQ507Gl
	rBel19VpJbzMlLSkfSD0OHnZ2uW4kejVjXIwgxfnTK4HEplrg78xKlEDtj3LlKj76SvJgkggYxz
	VpZ/yHzeXOCrVmFVFdlzz4Iyby7SUNw+qhs4sfyFhkK42CLX66VN6WEmiTwiyfon14q2VtNr+zy
	2WUlz/5fN94o005n/+B+0QEDDTjWUz0mD6h8ZkNH9QfAjO1s+E1SEnwRpbjlLHB1hCs7+rGi+Gt
	06QcfKwy2+YH29uWdE2vsGjV4b7xc6duGH+gzj+PwxHBeLPhbVIiDEI6cgs4oePrL0xe+Y
X-Received: by 2002:a05:6000:18a6:b0:47e:9f16:c0bf with SMTP id ffacd0b85a97d-47fd72f9f77mr22391573f8f.30.1785747874632;
        Mon, 03 Aug 2026 02:04:34 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm30015993f8f.30.2026.08.03.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:04:34 -0700 (PDT)
Message-ID: <9b8c1ec9126cc1f8625cc488cdeb03de7978eaf2.camel@gmail.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Jinseob Kim <kimjinseob88@gmail.com>, Joshua Crofts	
 <joshua.crofts1@gmail.com>, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 sashiko-bot@kernel.org, Jonathan Cameron	
 <jonathan.cameron@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 10:05:45 +0100
In-Reply-To: <20260803012224.219493-1-jic23@kernel.org>
References: <20260803012224.219493-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 02:22 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>=20
> iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> to userspace if the data passed in is not a multiple of 8 bytes and the
> timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
> to ensure any extra space is cleared.
>=20
> Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_un=
aligned()")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88=
%40gmail.com
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

>=20
> v1: https://patchwork.kernel.org/project/linux-iio/patch/20260604084307.6=
40053-1-jic23@kernel.org/
>=20
> Drop the memset in favour of __GFP_ZERO.=C2=A0 (Andy)
> Thanks to Nuno who pointed out there is a self test to ensure this
> behaves as expected.
>=20
> =C2=A0drivers/iio/industrialio-buffer.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 531fc4ccc15d..4960c8377932 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -2464,7 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct ii=
o_dev *indio_dev,
> =C2=A0
> =C2=A0		bb =3D devm_krealloc(&indio_dev->dev,
> =C2=A0				=C2=A0=C2=A0 iio_dev_opaque->bounce_buffer,
> -				=C2=A0=C2=A0 indio_dev->scan_bytes, GFP_KERNEL);
> +				=C2=A0=C2=A0 indio_dev->scan_bytes,
> +				=C2=A0=C2=A0 GFP_KERNEL | __GFP_ZERO);
> =C2=A0		if (!bb)
> =C2=A0			return -ENOMEM;
> =C2=A0		iio_dev_opaque->bounce_buffer =3D bb;
